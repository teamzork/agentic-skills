---
name: product-image-maker
description: Create marketing/product images (README hero banners, OG/social cards, landing-page heroes, app-store graphics) that look like they belong to the product — designed from the app's own UI design system, generated as 5 distinct concept options to choose from, then rendered to pixel-exact PNGs. Use when asked for a hero image, README banner, social/OG card, product screenshot graphic, or any on-brand marketing visual for an app.
---

# Product Image Maker

## Overview
Produce on-brand marketing imagery for a product by mining the app's real design system, mocking up several **conceptually distinct** directions as self-contained HTML, rendering them to pixel-exact PNGs, and letting the human pick before you refine and ship the winner.

The output looks like it came from the product's own universe — not a generic "AI banner." That fidelity comes from extracting the app's actual fonts, palette, shape language, and signature components, then reusing them.

**Core loop:** extract the brand → generate 5 distinct concepts → render all → human picks one → accuracy-refine → place & embed → clean up.

## Principles
- **On-brand, never generic.** Pull the app's *real* tokens (fonts, colors, radii, shadows, component shapes). Avoid AI-slop tells: Inter/Roboto defaults, purple-on-white gradients, stock-photo vibes, lorem ipsum.
- **Concept diversity, not recolors.** The 5 options must be different *ideas* (see `references/marketing-angles.md`), not the same layout in five hues. Span at least 3 angle families.
- **One-glance comprehension.** A viewer should grasp what the product does in ~2 seconds. Headline + one supporting idea. Resist cramming.
- **Pixel-exact + retina.** Build at the exact target dimensions and render at 2× scale so text stays crisp. See `references/rendering-and-sizes.md`.
- **Accuracy is a gate, not a nicety.** Wrong product name, mismatched locale in faux UI copy, or invented claims will ship if you don't check. Confirm the real product name with the human — never invent one.
- **Leave the repo clean.** Commit only the final asset and the doc edit. Mockup HTML, the chooser, and throwaway PNGs are scratch — delete them.

## Workflow

### 1. Extract the design system
Before designing anything, learn the app's visual language. Read the actual source, don't guess:
- **Stylesheets / tokens** — global CSS, Tailwind config, theme files, design-token files.
- Capture into a short brand kit you reuse across all 5 mockups:
  - **Fonts** — display/heading face + body face (and weights). Note the Google Fonts or @font-face source.
  - **Palette** — background, ink/text, primary accent, secondary, success/badge colors. Keep the dominant-color + sharp-accent ratio the app uses.
  - **Shape language** — border radii, border weights, signature shadow treatment (e.g. hard offset shadows vs soft blur).
  - **Signature components** — the cards, buttons, badges, pills the app is recognizable by. These are what make a mockup read as "from this app."
- If the app has real screens, screenshot one for reference so your faux UI matches proportions.

### 2. Pick 5 distinct concepts
Choose five marketing angles from `references/marketing-angles.md`, spanning different families (e.g. product-hero, how-it-works flow, before/after, bento, big-claim). For each, decide the single message it carries. Match the angle to the product: process products suit flow/loop; transformation products suit before/after; feature-rich products suit bento.

### 3. Build each as self-contained HTML
One `.html` file per concept, at the exact target size (default GitHub/OG hero = **1200×630**; see size table). Rules:
- Inline all CSS. Load the app's fonts via `<link>` (Google Fonts) or `@font-face`.
- Set the body/stage to exactly W×H, `overflow: hidden`, no scrollbars.
- Reuse the extracted tokens and rebuild the signature components faithfully.
- Where the concept shows the product (a faux app card), make the UI copy real and correct — see the accuracy gate in step 6.

### 4. Render all to PNG
Render each HTML to a PNG at 2× device scale using whatever headless browser is available (Playwright MCP, headless Chrome CLI, or a Puppeteer/Playwright script). **Wait for `document.fonts.ready` before capturing** — screenshotting before webfonts load produces a fallback-font render. Full recipes and the pitfalls in `references/rendering-and-sizes.md`.

### 5. Present options to the human
Show all 5 renders for selection — either a `index.html` chooser that tiles them, or serve the folder locally and share the renders. Ask which they prefer. Don't pre-pick; the human chooses.

### 6. Refine the winner (accuracy gate)
On the chosen concept, run every check before shipping:
- **Product name** — exactly the real name. If unconfirmed, ask. Never ship a placeholder or invented brand.
- **Locale/language consistency** — any faux UI copy is in the right language and dialect (e.g. don't put Spanish copy in a Brazilian-Portuguese product).
- **No placeholders** — no lorem ipsum, no "Feature one / Feature two."
- **Claims are true** — features and numbers reflect the real product.
- **Legibility** — readable at the size it'll actually display (README images render ~½ their pixel width).
Fix, then re-render.

### 7. Place, embed, and clean up
- Move the final PNG into the repo's asset location (`docs/assets/` or `assets/` — follow the repo's convention).
- Embed it with **descriptive alt text** (README image, OG `<meta>`, etc.).
- Delete scratch: mockup HTML, the chooser, loose/temporary PNGs, any temp server, any browser-tool artifacts.
- Stage only the final asset + the doc change. Verify nothing else (no secrets, no scratch dir) is staged before committing.

## Common pitfalls
- **Fallback-font renders** — capturing before fonts load. Always await font readiness.
- **Soft/blurry text** — rendering at 1× instead of 2×.
- **Wrong dimensions** — OG/social platforms crop hard; use the exact spec size (`references/rendering-and-sizes.md`).
- **Invented brand name** — confirm the real product name with the human; a stand-in name will get shipped if you let it.
- **Locale drift** in faux UI copy — easy to miss, embarrassing in public.
- **Scratch committed** — leaving mockup HTML or a stray PNG in the repo. Commit only the final asset.

## Resources
- `references/marketing-angles.md` — catalog of concept directions with layout sketches and when each shines.
- `references/rendering-and-sizes.md` — target sizes for each platform and headless-render recipes (Playwright MCP, headless Chrome, Puppeteer) with retina/font-loading guidance.
