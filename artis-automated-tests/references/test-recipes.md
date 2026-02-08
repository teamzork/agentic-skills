# Artis Test Recipes

## Table of Contents
- Integration test setup
- Astro API route tests
- File-based content tests (memfs)
- Admin UI flows (Playwright)
- Assertions and fixtures

## Integration Test Setup

- Use Vitest with the existing helpers in `packages/admin/test/helpers/`.
- Prefer `mock-astro.ts` for APIContext creation.
- Use `memfs` for filesystem behavior to keep tests isolated.

## Astro API Route Tests

Use this pattern when testing `packages/admin/src/pages/api/*` routes.

```ts
import { describe, it, expect } from "vitest";
import handler from "../path/to/route";
import { createApiContext } from "../helpers/mock-astro";

it("returns success for valid payload", async () => {
  const request = new Request("http://localhost/api/foo", {
    method: "POST",
    body: JSON.stringify({ name: "Example" }),
  });
  const context = createApiContext({ request });

  const response = await handler(context);

  expect(response.status).toBe(200);
  const data = await response.json();
  expect(data.ok).toBe(true);
});
```

## File-Based Content Tests (memfs)

Use memfs helpers to simulate content stored in `user-data/`.

```ts
import { describe, it, expect } from "vitest";
import { vol } from "memfs";
import { readUserData } from "../helpers/test-utils";

it("loads settings from user-data", async () => {
  vol.fromJSON({
    "/repo/user-data/settings.yaml": "siteTitle: Example",
  });

  const settings = await readUserData("settings.yaml");
  expect(settings.siteTitle).toBe("Example");
});
```

## Admin UI Flows (Playwright)

Use for high-value admin flows that cross multiple layers.

```ts
import { test, expect } from "@playwright/test";

test("admin can update settings", async ({ page }) => {
  await page.goto("/admin/settings");
  await page.getByLabel("Site title").fill("New Title");
  await page.getByRole("button", { name: "Save" }).click();
  await expect(page.getByText("Saved")).toBeVisible();
});
```

## Assertions and Fixtures

- Assert on observable outputs: response codes, JSON payloads, UI text, file writes.
- Cover error paths for critical APIs (invalid input, missing files, auth).
- Keep fixtures minimal; prefer inline JSON/YAML in tests.
- Factor helpers only after repetition.
