---
name: daniel-testing-approach
description: Opinionated testing approach for API and business logic in apps that use a route -> controller -> service architecture. Use this skill whenever writing, planning, or reviewing tests for API endpoints, backend services, or business logic. Triggers on any test-writing task involving controllers, services, routes, Prisma/data access mocking, or backend behavior validation. Also use when the user asks "what should I test?" or "how should I test this?" for backend code.
---

# Daniel Testing Approach

## Philosophy

Test outcomes, not implementation. The goal is to verify that services return correct results given proper inputs and mocked dependencies — nothing more. Avoid testing framework plumbing, thin wrappers, or internal details that don't represent meaningful behavior.

## Architecture: Route -> Controller -> Service

Split API endpoints into three layers. Each layer has a different testing expectation:

### Routes
Thin wrappers that use `createApiHandler` or equivalent framework glue. They wire middleware, parse params, and call controllers. **Do not test routes** — they are plumbing. If a route breaks, a service test or manual smoke test will catch it.

### Controllers
Orchestrate inputs and user context, then delegate to services. They're thin by design. **Do not test controllers** — the logic worth testing lives in services. If a controller has complex branching, that logic should be extracted into a service.

### Services
Pure, testable business logic. **This is where all tests should live.** Services take explicit inputs, call data access layers, and return results. They are deterministic when dependencies are mocked.

## What to Test

Focus tests on service-layer behaviors:

- **Access validation outcomes** — does the function reject unauthorized callers correctly?
- **Null and edge-case short-circuits** — does it handle missing data, empty arrays, boundary values?
- **Result parsing and transformation** — given a known DB response shape, does it return the right structure?
- **Conditional logic branches** — when a flag is set or a threshold is crossed, does behavior change?
- **Error scenarios** — when a dependency throws or returns unexpected data, does the service handle it?

**Example — good test:**
```
Given a mocked Prisma response with 3 active users and 1 deactivated user,
when getActiveUsers() is called,
then it returns only the 3 active users.
```

## What NOT to Test

- **Routes** — thin wrappers; test services instead.
- **Controllers** — orchestration glue; if there's logic here, move it to a service.
- **API integration** — don't make real HTTP calls or test endpoint wiring.
- **SQL strings or query syntax** — mock Prisma at the function level; never assert on generated SQL.
- **String concatenation or `.trim()` behavior** — trivial operations covered by the language runtime.
- **Framework defaults** — if auth is required by default, don't write a test proving it. Only test where you've explicitly configured something different.

## Mocking Data Access

Mock `@/lib/prisma` (or your data access layer) in every service test. Fully stub the response to simulate the scenario you care about.

- Return realistic shapes that match your Prisma models.
- Simulate edge cases by returning empty arrays, nulls, or intentional mismatches.
- Never assert on what SQL was generated — assert on what the service did with the data it received.

**Example:**
```typescript
// Good: stub the response, test the outcome
prismaMock.user.findMany.mockResolvedValue([
  { id: 1, name: "Alice", role: "admin" },
  { id: 2, name: "Bob", role: "viewer" },
]);
const result = await getUsersByRole("admin");
expect(result).toEqual([{ id: 1, name: "Alice", role: "admin" }]);

// Bad: asserting on the query itself
expect(prismaMock.user.findMany).toHaveBeenCalledWith({
  where: { role: "admin" }  // This tests implementation, not behavior
});
```

## Auth and Roles

When testing auth/role restrictions:

- Only configure roles in tests where the restriction actually matters — where you're testing that a specific role is required or denied.
- Don't duplicate default auth behavior in tests. If every endpoint requires auth by default, you don't need a test proving that for each service.
- Focus role tests on the boundaries: "admin can do X, viewer cannot" rather than "auth is required."
