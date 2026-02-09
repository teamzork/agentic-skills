---
name: saas-launch-architect
description: Analyze a SaaS codebase to produce a multi-threaded launch and GTM strategy that bridges Thread A (building) and Thread B (selling). Use when asked for ICP/value prop inference from code, launch validation plans, go-to-market strategy, manifesto/positioning, or multi-stage SaaS launch guidance.
---

# SaaS Launch Architect (Multi-Threaded)

## Overview
Bridge coding and go-to-market by auditing the codebase for who it serves and the urgent problem it solves, then output a staged launch plan. Avoid linear launches and the "one more feature" trap.

## Workflow

### Phase 1: Value Prop Audit (Thread A → Thread B)
1. Analyze data models for "who":
   - Scan schemas and types (SQL/Prisma/TypeScript) for roles, org hierarchy, permissions, and plan tiers.
   - Infer the ICP based on complexity (enterprise RBAC vs prosumer, single-user vs team).
2. Analyze core logic for "problem":
   - Identify the most complex or central business logic; treat it as the urgent problem solved.
   - Flag features that appear nice-to-have or bloat.
3. Draft a value proposition:
   - Format: "We help [Inferred Who] solve [Inferred Problem] by [Core Functionality]."

### Phase 2: Validation (0–10 Customers)
1. Write a trust-network outreach message:
   - Target the founder's existing network.
   - Ask for a paid early tester commitment (e.g., $100) to validate seriousness.
2. Gate progression:
   - Advise not to move to Stage 2 until 10 paying customers are secured via manual outreach.
   - If self-serve checkout exists, recommend gating behind "Request Access" to force conversations.

### Phase 3: Consistency & Manifesto
1. Generate a 3-point manifesto:
   - Identify 10x advantages: speed to value, transformation (input → output), and differentiators.
2. Define the "Broadway Show":
   - Propose a weekly content cadence derived from the product domain.

### Phase 4: Scale
1. Capture demand (the 3%):
   - Identify high-intent keywords tied to the exact technical solution.
2. Create demand (the 97%):
   - Identify broader problem-awareness topics and map them to manifesto points.

## Output Format

### 1. Technical "Who & Why" Audit
- **Inferred ICP:** ...
- **Core Problem Solved:** ...
- **Feature Trap Warning:** ...

### 2. The Validation Plan (Stage 1)
- **Proposed Value Prop:** ...
- **Network Outreach Template:** ...

### 3. The Manifesto Draft (Stage 2)
- **Transformation:** ...
- **The 10x Advantage:** ...

### 4. Roadmap to Scale (Stage 3)
- **Ready for Scale?** Yes/No (based on ICP clarity)
- **Dual-Flank Topics:** Intent keywords vs education topics

*Source references: TK Kader, "Go-To-Market Launch Plan For A New SaaS Product"*
