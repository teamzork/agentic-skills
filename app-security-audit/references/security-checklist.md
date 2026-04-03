# Security & Production Readiness Checklist

Detailed checks and fix patterns organized by severity. Each item includes the risk scenario and a stack-specific fix for Next.js / TypeScript / Vercel / Supabase projects.

---

## CRITICAL

### C1 — No rate limiting on API routes
- **Risk**: Surprise $300–$2000+ bills (OpenAI proxy, Vercel functions, DB connections).
- **Fix**: Use `@upstash/ratelimit` with Redis, or `next-rate-limit`. Apply to all `/api` routes, especially any that call LLMs or send emails.
- **Bonus**: Add proof-of-work or CAPTCHA on any open endpoint that calls an LLM.

### C2 — Auth tokens in localStorage
- **Risk**: XSS steals tokens. Attacker gets persistent session.
- **Fix**: Use HttpOnly + Secure + SameSite=Strict cookies. If using JWTs, store in memory only; use short-lived access tokens + HttpOnly refresh tokens.

### C3 — Hardcoded API keys in frontend
- **Risk**: Keys scraped from bundle = immediate compromise.
- **Fix**: All secrets in `.env.local` / Vercel env vars, server-side only. Never prefix with `NEXT_PUBLIC_` unless truly public. Audit with `grep -r "sk-" ./` or similar.

### C4 — Stripe webhooks without signature verification
- **Risk**: Fake "payment succeeded" events = revenue loss.
- **Fix**: Always verify `stripe.webhooks.constructEvent(body, sig, process.env.STRIPE_WEBHOOK_SECRET)`. Use raw body, not parsed JSON.

### C5 — No pagination on DB queries
- **Risk**: One user with 10k rows causes OOM or 30s timeout.
- **Fix**: Never do `findMany({})` without `take` + `cursor`. Use cursor-based pagination for infinite scroll, offset for simple lists.

### C6 — Admin routes without role checks
- **Risk**: Any authenticated user accesses admin. Classic horizontal privilege escalation.
- **Fix**: Middleware-level role check on all `/admin/*` and `/api/admin/*` routes. Don't rely on UI hiding alone.

### C7 — No backup strategy
- **Risk**: Data loss = game over for a user-data product.
- **Fix**: Enable Supabase PITR (Point-in-Time Recovery) or set up automated pg_dump to S3. Verify restore process actually works.

---

## HIGH

### H1 — No input sanitization on forms
- **Risk**: Prompt injection, HTML/JS injection in user-generated content, command injection.
- **Fix**: Validate + sanitize all user input server-side. Use `zod` for schema validation. For HTML content, use `DOMPurify`. Never interpolate raw user input into prompts.

### H2 — No database indexing
- **Risk**: Fine at 100 rows, unusable at 2000+.
- **Fix**: Add indexes on all foreign keys and any field used in `WHERE`, `ORDER BY`, or `JOIN`. In Prisma: `@@index([fieldName])`. Run `EXPLAIN ANALYZE` on slow queries.

### H3 — Sessions that never expire
- **Risk**: Stolen refresh tokens = forever access.
- **Fix**: Set session expiry (7–30 days max). Implement refresh token rotation. Invalidate on password change.

### H4 — Password reset links that don't expire
- **Risk**: Email leak months later = account takeover.
- **Fix**: Expire reset tokens after 15–60 minutes. Single-use only. Hash tokens before storing.

### H5 — No CORS policy
- **Risk**: Cross-origin requests accepted from anywhere.
- **Fix**: Set explicit `Access-Control-Allow-Origin` with an allowlist. In Next.js, configure in `next.config.ts` or middleware.

### H6 — No DB connection pooling
- **Risk**: Traffic spike → connection exhaustion → crash.
- **Fix**: Use PgBouncer (Supabase has it built-in, use the pooler URL). For Prisma, set `connection_limit` in the datasource URL.

### H7 — No logging in production
- **Risk**: "It broke, no idea why."
- **Fix**: Use `pino` or `winston`. Log all API errors with request context. Send to Axiom, Logtail, or Sentry. At minimum: log 5xx responses with stack traces.

### H8 — No TypeScript strict mode
- **Risk**: Loose typing allows subtle logic errors that slip through code review.
- **Fix**: `strict: true` in `tsconfig.json`. No `any` without comment justification. Run `tsc --noEmit` in CI.

---

## MEDIUM

### M1 — No error boundaries in React/Next.js
- **Risk**: One unhandled error = white screen of death.
- **Fix**: Wrap page-level and feature-level components in `<ErrorBoundary>`. Use `error.tsx` in Next.js App Router for route-level handling.

### M2 — No env var validation at startup
- **Risk**: Silent production failures from missing config.
- **Fix**: Use `zod` to parse and validate `process.env` at startup. Fail fast with a clear error message if required vars are missing. Library: `@t3-oss/env-nextjs`.

### M3 — Emails sent synchronously
- **Risk**: One slow/failed email provider call hangs your request.
- **Fix**: Fire-and-forget or queue email sends. Use background jobs (Inngest, Trigger.dev, QStash) for anything non-critical.

---

## LOW

### L1 — Images uploaded directly to server, no CDN
- **Risk**: Storage costs, slow load times, no image optimization.
- **Fix**: Upload to S3/R2/Supabase Storage. Serve via Cloudflare or `next/image` with a CDN origin.

### L2 — No health check endpoint
- **Risk**: Monitoring and auto-scaling can't verify app liveness.
- **Fix**: Add `GET /api/health` returning `{ status: 'ok', timestamp }`. Check DB connectivity in the response.

---

## LLM-Specific Checks

### AI1 — No LLM cost observability
- Track token usage per user/request. Use LangSmith, Helicone, or custom logging.

### AI2 — No output schema enforcement
- Validate AI JSON responses with `zod` before using them. Never trust raw LLM output in business logic.

### AI3 — System prompt extraction vulnerability
- Test if users can leak your system prompt via injection. Use structural separators and output filtering.

### AI4 — No CAPTCHA on LLM-calling endpoints
- Open endpoints that invoke LLMs are abuse magnets. Add Turnstile (Cloudflare) or hCaptcha.

### AI5 — Race conditions in async flows
- Common in payment + subscription + AI credit systems. Use DB-level locks or idempotency keys.

---

## Quick Reference: Common Stack Fixes

| Issue | Next.js / TS Fix |
|-------|-----------------|
| Rate limiting | `@upstash/ratelimit` + Redis |
| Auth tokens | `iron-session` or NextAuth with DB sessions |
| Input validation | `zod` server-side in all API route handlers |
| Env validation | `@t3-oss/env-nextjs` |
| Error boundaries | `error.tsx` + custom `<ErrorBoundary>` component |
| DB pooling | Supabase pooler URL + Prisma `connection_limit` |
| Background jobs | Inngest or Trigger.dev |
| Logging | `pino` → Axiom or Logtail |
| Image CDN | Cloudflare R2 + `next/image` |
| Stripe webhooks | `stripe.webhooks.constructEvent` with raw body |
