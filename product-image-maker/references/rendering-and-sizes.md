# Rendering & Sizes

How to turn a mockup HTML into a pixel-exact PNG, and what dimensions each destination expects.

## Target sizes

Build the HTML stage at exactly these pixel dimensions (then render at 2× scale — see below).

| Destination | Size (px) | Notes |
| --- | --- | --- |
| GitHub README hero / Open Graph | **1200 × 630** | The default. Also the OG/`og:image` standard; works for LinkedIn, Slack, Discord unfurls. |
| X / Twitter `summary_large_image` | 1200 × 675 | 16:9. 1200×630 also accepted (slight crop). |
| Square social (Instagram feed) | 1080 × 1080 | 1:1. |
| Instagram / story (portrait) | 1080 × 1350 (4:5) or 1080 × 1920 (9:16) | Vertical. |
| Landing-page hero (in-page) | match the design's container width | Often 1440 or 1600 wide; height per design. |
| App Store screenshot (6.7" iPhone) | 1290 × 2796 | Portrait; check current store specs before shipping. |
| Favicon/logo source | 512 × 512 or 1024 × 1024 | Square master to downscale from. |

Safe-zone tip: OG/social platforms crop edges and overlay UI. Keep critical content and text within ~90% of the canvas, away from the outer ~60px.

## Retina / crispness
Render at **2× device scale** so text and edges stay sharp when displayed. The HTML is sized at 1× target (e.g. 1200×630); the renderer captures at deviceScaleFactor 2, producing a 2400×1260 PNG that displays crisply at 1200px. README and OG consumers display images well below their pixel width, so the extra resolution is what keeps them from looking soft.

## Font loading — the #1 pitfall
Webfonts load asynchronously. If you screenshot before they're ready, you capture the **fallback font** and the whole look is wrong. Always wait for fonts before capture:
- In a script: `await page.evaluate(() => document.fonts.ready)` then a short settle delay.
- Inline guard: add `<script>document.fonts.ready.then(()=>document.body.dataset.fontsReady='1')</script>` and wait for that attribute.
- Using `file://`, Google Fonts `<link>` still needs network access; if offline, embed fonts via base64 `@font-face` or install them locally.

Also set the stage exactly: `html,body{margin:0}` and a stage element at exactly W×H with `overflow:hidden` so no scrollbar steals pixels.

## Render recipes

### A. Playwright MCP (if available in the agent's tools)
1. `browser_resize` to the target W×H.
2. `browser_navigate` to `file:///abs/path/mockup.html` (or a local `http://` server).
3. Wait for fonts (navigate triggers load; give it a moment or check `document.fonts.ready` via an evaluate call).
4. `browser_take_screenshot` → save PNG.
Repeat per concept. To present options, navigate to a chooser `index.html` that tiles all five.

### B. Headless Chrome / Chromium CLI
```bash
chrome --headless=new --hide-scrollbars --force-device-scale-factor=2 \
  --window-size=1200,630 \
  --screenshot=hero.png \
  "file:///abs/path/mockup.html"
```
(Use `google-chrome`, `chromium`, or the full macOS path
`/Applications/Google Chrome.app/Contents/MacOS/Google Chrome`.)
Caveat: the CLI gives limited control over font-ready timing. If you get fallback-font renders, embed fonts via `@font-face` base64 or switch to recipe C.

### C. Puppeteer / Playwright script (most control)
```js
// node screenshot.mjs  (npm i playwright)
import { chromium } from 'playwright';
const W = 1200, H = 630;
const browser = await chromium.launch();
const page = await browser.newPage({
  viewport: { width: W, height: H },
  deviceScaleFactor: 2,
});
await page.goto('file://' + process.argv[2]); // abs path to .html
await page.evaluate(() => document.fonts.ready);
await page.waitForTimeout(150);               // settle layout/animations
await page.screenshot({ path: process.argv[3], clip: { x: 0, y: 0, width: W, height: H } });
await browser.close();
```
```bash
node screenshot.mjs /abs/path/mockup.html /abs/path/out.png
```

### Serving locally vs file://
- `file://` is simplest and works for self-contained HTML with CDN fonts.
- Serve a folder (`python3 -m http.server` or any static server) when you want a chooser page linking multiple mockups, or when relative asset paths matter. Stop the server during cleanup.

## Cleanup checklist (after the winner ships)
- [ ] Final PNG moved to the repo asset dir and embedded.
- [ ] Mockup `.html` files and chooser `index.html` deleted.
- [ ] Loose/temporary PNGs (renders that weren't chosen) deleted.
- [ ] Local server stopped; headless browser closed; tool artifacts removed.
- [ ] Only the final asset + doc edit staged for commit.
