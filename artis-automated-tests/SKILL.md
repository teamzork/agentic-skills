---
name: artis-automated-tests
description: Comprehensive guidance for authoring, updating, and validating automated tests for the Artis web application (Astro + pnpm monorepo). Use when adding or refactoring integration tests (Vitest), E2E tests (Playwright), or test utilities for API routes, business logic, content workflows, and admin/site UI flows.
---

# Artis Automated Tests

## Overview

Use this skill to plan, write, and verify automated tests in the Artis repo with the project's conventions, tooling, and testing philosophy. Prioritize integration tests for critical paths, add E2E tests for end-to-end flows, and keep tests isolated and deterministic.

## Workflow

1. Identify the change surface (API route, business logic, UI flow, or shared utility).
2. Choose the smallest test type that covers risk (integration first; E2E for critical user flows).
3. Locate existing test helpers and patterns; reuse utilities before creating new ones.
4. Write tests with isolated fixtures and explicit assertions.
5. Run the narrowest test command that proves correctness; expand only if needed.
6. Check coverage expectations for new features (target >= 30% for added functionality).

## Decide the Test Type

- Prefer **integration tests (Vitest)** for API routes, data processing, and business logic.
- Use **E2E tests (Playwright)** for critical admin/site flows that cross multiple layers.
- Add or update **test helpers** when repeated setup appears in 2+ tests.

## Repo-Specific Constraints

- Follow the testing philosophy: integration tests first, focus critical paths, and use the 30% coverage target for new features.
- Use the established test structure under `packages/admin/test/` and `packages/site/` E2E directories.
- Use `memfs` for filesystem mocking and `mock-astro.ts` helpers for Astro APIContext.
- Keep tests isolated; avoid hidden shared state or ordering dependencies.
- Use relative imports and keep imports grouped at the top of files.

## Implementation Checklist

- Reproduce the change with an existing test; add new tests only where gaps exist.
- Assert on visible outcomes (response status/body, file writes, UI text) rather than internals.
- Cover error paths for critical APIs (bad input, missing files, auth failure).
- Prefer table-driven tests for multiple inputs.
- Keep fixtures small and explicit; create helpers only when repeated.

## Commands

- Run lint before building: `pnpm lint`.
- Integration tests: `pnpm test` (root) or `pnpm test` within `packages/admin/`.
- E2E tests: `pnpm test:e2e` (root) or within `packages/admin/` or `packages/site/`.
- Full suite: `pnpm test:all` when changes span both integration and E2E.
- Do not run builds automatically; suggest `pnpm build` when needed.

## Reference Patterns

Use `references/test-recipes.md` for detailed patterns and examples for:
- Astro API route integration tests
- File-based content workflows with memfs
- Playwright E2E flows and selectors
- Common assertion patterns and fixtures

## Resources

- references/ : Detailed test recipes and patterns.
