---
name: app-security-audit
description: Audit web app security and production readiness — rate limiting, auth, secrets, payments, DB, logging, and LLM-specific risks. Use when asked to review, harden, or ship-check a codebase, or when a user asks "is my app production ready", "security review", "what am I missing before launch", "audit my app", or mentions Cursor, v0, Bolt, Lovable, or Replit Agent in the context of shipping.
---

# App Security & Production Readiness Audit

## Overview
Run a structured security and production-readiness audit and deliver a prioritized list of vulnerabilities, misconfigurations, and concrete fixes. Tie findings to specific files, routes, or flows.

## Workflow

### 1. Scope and context
- Identify stack (framework, auth provider, DB, hosting, payment processor).
- Ask for entry points, critical flows, and constraints (compliance, scale expectations).
- If code or config files are missing, request them.

### 2. Critical security audit
Check ship-blocking issues first — any one of these can cause real money or data loss:
- API rate limiting on all public routes (especially LLM-calling and email endpoints).
- Auth token storage (no localStorage; use HttpOnly cookies).
- Secrets exposure (no hardcoded keys in frontend bundles).
- Payment webhook signature verification (Stripe, etc.).
- Admin route authorization (role checks, not UI hiding).
- DB query pagination (no unbounded `findMany`).
- Backup and recovery strategy.
Reference: `references/security-checklist.md` for detailed checks and fix patterns.

### 3. Reliability audit
- Input validation and sanitization on all server-side handlers.
- DB indexing on foreign keys and query fields.
- Session expiry and token rotation.
- CORS policy with explicit origin allowlist.
- DB connection pooling under load.
- Structured logging with error context.
- TypeScript strict mode enabled.

### 4. Resilience audit
- Error boundaries at page and feature level.
- Env var validation at startup (fail fast).
- Async operations (emails, notifications) moved to background jobs.

### 5. Infrastructure audit
- Image storage on CDN, not server filesystem.
- Health check endpoint for monitoring and auto-scaling.

### 6. LLM-specific audit (if applicable)
- Token usage observability per user/request.
- Output schema enforcement (validate AI responses before use).
- System prompt extraction resistance.
- CAPTCHA on LLM-calling endpoints.
- Race conditions in payment + AI credit flows.

### 7. Deliverable format
Provide:
- A prioritized issue list grouped by severity with evidence.
- For each item: location, risk, fix recommendation with code snippet.
- A launch readiness verdict: Ready / Ready with caveats / Not ready.
- Quick wins vs larger refactors.
- If no issues: state that explicitly and note residual risks or untested areas.

## Severity tiers

| Tier | Label | Meaning |
|------|-------|---------|
| CRITICAL | Ship-blocking. Real money or data loss risk. Fix before any public traffic. |
| HIGH | Fix before launch or within first 48h. |
| MEDIUM | Fix in first sprint post-launch. |
| LOW | Nice to have. Won't break things, but will slow you down. |

## Output template

Issue format:
- `Title` — Severity (CRITICAL / HIGH / MEDIUM / LOW)
- `Where` — file/route/component
- `Risk` — what can go wrong + user/business impact
- `Fix` — concrete change with code snippet
- `Notes` — assumptions or constraints

## Resources
- `references/security-checklist.md` for detailed checks, fix patterns, and common stack-specific solutions.
