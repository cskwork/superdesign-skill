# 2026-06-20 - playwright-cli render gate + 2026 engagement craft

Goal: make rendered verification real (not eyeballed), with `playwright-cli` as the single render
driver, and add mechanism-backed 2026 conversion/UX craft so output is more engaging - without
breaking the skill's anti-slop, role-separation, or self-contained ethos.

Driven by a 9-agent analysis workflow (4 parallel readers -> synthesis -> 3 adversarial lenses ->
final spec). Two forks were the user's call: keep the engagement layer (the adversarial pass wanted to
cut it as scope creep) and use a supergoal-style hard stop (over the spec's softer disclosed-skip).

## Why each change

- **Rendered verification was missing entirely** (new `templates/render-gate.sh`, new
  `reference/playwright-cli.md`, `agents/design-critic.md`, `SKILL.md`): the skill only ever scanned
  static source (`anti-slop-gate.mjs` + `contrast-gate.mjs`). Hero-fit, overflow, CTA-wrap,
  console-clean were prose "eyeball" checks the loop never actually rendered. The Critic now renders
  every built surface with `playwright-cli`, writes a `## Render` block (Tool line, screenshots,
  `Console: clean`), and `render-gate.sh` is the machine-checkable exit. Ported from supergoal's
  `qa-gate.sh` + `reference/playwright-cli.md`, scoped to static surfaces (no network/auth/tab flows).
- **Hard stop, not disclosed-skip** (decision; `SKILL.md` principle 6, `reference/playwright-cli.md`,
  `agents/design-critic.md`): `playwright-cli` is the only sanctioned render driver and there is no
  skip path - if it cannot be installed, the Critic STOPs and asks the user. Rejected the workflow's
  disclosed-skip (write "Render SKIPPED", proceed UNVERIFIED) because the user wanted parity with
  supergoal ("as main and one only"). Rejected a headless-Chrome fallback because it reopens the
  silent-render hole the gate exists to close. Principle 6 was rescoped: asset/trend/search tooling
  still degrades gracefully (self-contained promise intact); rendered verification is the one hard
  dependency. README EN+KO updated so the offline-portability claim is no longer absolute.
- **Sibling gate, not an extension of preflight** (decision): `preflight-gate.sh` is pure Node static
  scanning; `render-gate.sh` needs a browser. Kept them separate so a browserless static scan never
  couples to a renderer. The loop runs both; the Critic's GATE requires both exit 0.
- **Gate scope = evidence + driver + console; measuring `render-gate.mjs` deferred** (decision):
  the gate checks the `## Render` block, a `Tool: playwright-cli` line, a screenshot per framing, and a
  clean-console attestation - the proven `qa-gate.sh` shape. A script that re-measures the rendered DOM
  (overflow/CLS numbers) is brittle and was deferred. Residual-trust limit: v1 trusts the Critic's
  attestation like supergoal does; a planted artifact could pass. Noted here as the known v1 boundary.
- **Console rule made deterministic** (decision; `render-gate.sh`, `reference/playwright-cli.md`):
  "console clean" = zero lines beginning `error`/`uncaught`/`unhandled`; warnings allowed; the Critic
  attests `Console: clean` (or `0 errors`). The gate accepts `clean` / `\b0 errors\b` / `\bno errors\b`
  and rejects anything else, so `Console: 2 errors` fails and `Console: clean (1 warning)` passes.
- **Engagement craft as one new file, intent-gated** (new `reference/engagement.md`; wired via
  `SKILL.md` reference map + Build step + Final checklist, `agents/designer.md`, `agents/design-critic.md`,
  `reference/design-brief.md`, `reference/critique.md`): every rule is a build mechanism with the slop
  it replaces (conversion hierarchy, single-stat hero, outcome-led CTA + friction-reducer, skeleton +
  optimistic UI, real-data social proof beside the CTA, micro-interaction feedback, motion-guides-
  attention, progressive disclosure, WCAG 2.2). Rejected scattering these into always-on
  `taste-core.md` (the adversarial "scope/slop" lens flagged bloat + forcing conversion onto editorial
  briefs). Instead it loads only when the Design Read names a primary action; a new `Primary action`
  inference in `design-brief.md` gates it; the Critic runs a non-blocking engagement judgment pass
  (HIGH/MEDIUM findings, never a deterministic gate rule, because engagement is contextual).
- **Universal techniques in their medium file, not engagement.md** (`reference/web.md`,
  `reference/mobile.md`): native CSS scroll-driven animations + the View Transitions API are now the
  Baseline-2026 default for reveals/transitions in `web.md` (off-main-thread, protects INP, reinforces
  the existing manual-scroll-listener ban), ahead of JS Motion. Thumb-zone primary actions + sticky
  thumb-zone CTA + bottom sheets + haptics-as-feedback + an honest gesture vocabulary went into
  `mobile.md`. `trend-snapshot.md` gained a cross-cutting engagement line so the offline fallback also
  carries the conversion mechanisms.
- **Attribution + install** (`reference/sources.md`): added `playwright-cli` (@playwright/cli,
  Apache-2.0) install + the supergoal port attribution.
- **`grep -qiF` portability fix** (`templates/render-gate.sh` authored with `-qiE`; pre-existing
  `tests/asset-fallback-contract.test.sh` changed `-qiF` -> `-qiE`): MSYS2 grep 3.0 on Windows aborts
  (core dumped) on `grep -qiF`. The asset-fallback test was already hitting this on Windows (passes on
  Linux CI). Both substring sets are ERE-safe, so `-qiE` fixes Windows and stays green on Linux.

## Verified

- All four suites green on Windows (Git Bash, MSYS2 grep 3.0): `gate-scenarios` 28 (+7 render-gate),
  `reference-links-contract` 38, `mode-routing-contract` 13, `asset-fallback-contract` 7. Total 86, 0
  failed (was 74 before this change).
- New render-gate cases assert exit code AND output substring: usage rc2; missing claims rc1; no
  `## Render` block rc1; non-playwright-cli driver rc1; no screenshot rc1; console attests errors rc1;
  full evidence (Tool + screenshot + clean console, warnings allowed) rc0 `RENDER GATE PASS`.
- Root-caused the `grep -qiF` abort by reproducing it directly (`printf ... | grep -qiF` core dumps;
  `grep -qiE` and `grep -iE` do not) and confirmed bash 5.2.12 / grep 3.0 (msys).
- Not run: a live `playwright-cli` browser render - the driver is not installed on this machine, which
  is exactly the hard-stop path (a real run STOPs and asks the user). Gate logic verified deterministically
  via the suite above.

# 2026-06-20 - data-dense business app (dashboard/admin) capability

Goal: close the skill's known weakness on business dashboards / admin panels / internal tools. The five
aesthetic families and `engagement.md` were all marketing/landing-oriented; the dials baseline (8/6/4)
and the hero-centric layout rules actively pushed AWAY from the density a data app needs. Added a
density-first capability grounded in how the best-regarded dashboards are actually built.

Driven by a 7-agent research workflow: 4 parallel web-research lenses (real-world products, OSS GitHub
repos, libraries/techniques, UX + 2026 trends + anti-patterns) -> synthesis (ranked Top 10 + techniques
inventory + gap analysis) -> draft -> an adversarial critique pass (gate-compatibility, contract safety,
fabricated-claim check, voice match). The critique returned APPROVE_WITH_FIXES with no CRITICAL issues;
all 7 patch `old_string`s were verified verbatim-unique and the gate/contract scans passed before apply.

## Why each change

- **New `reference/dashboard.md` application overlay** (loaded at Build like `engagement.md`, NOT a new
  mode or aesthetic family): density-first dials `VAR 3-5 / MOT 2-3 / DEN 6-8` overriding the landing
  `8/6/4` baseline; app shell (icon-rail sidebar + breadcrumb topbar + `cmdk` command palette) replacing
  the hero; data tables at scale (TanStack Table / AG Grid / MUI X, virtualization past ~50 rows,
  tabular-nums, density tiers); chart-library selection by data scale (Recharts/Tremor -> Nivo/visx ->
  ECharts/uPlot) with colorblind-safe status color + WCAG 1.4.1 data-table fallback; KPI/stat-card
  anatomy with delta-vs-baseline; per-widget skeleton / empty-as-onboarding / error-recovery / freshness
  states; dark-first elevation by lightness not shadow; enterprise-system guidance (Carbon/Ant/Fluent/
  Cloudscape, never mixed); a dashboard anti-pattern ban list; embedded-AI-panel states.
- **`taste-core.md` dials row** (the load-bearing fix): added
  `dashboard / data-dense business app / admin / internal tool | 3-5 | 2-3 | 6-8`. The read-table
  previously topped out at DEN 4-5, so the dials themselves steered away from density.
- **Routing wired at every discovery point**: `aesthetics.md` selection-map row (flagged in prose as an
  application overlay, not a 6th family); `trend-snapshot.md` upgraded the "dashboards-lite" footnote to
  a dedicated Data-dense lane; `SKILL.md` Build step 4 now branches to `dashboard.md` (mirroring the
  `engagement.md` clause - this is the wiring that makes the file load), plus a Reference-map row and a
  Final-checklist line; `sources.md` gained dashboard kit/table/chart install commands + canonical URLs.
- **READMEs (EN + KO)**: added a "built for data-dense apps too" principle bullet so the capability is
  discoverable, citing the grounding products (Linear/Stripe/Vercel/Datadog, shadcn/Carbon).

## Decisions / rejected alternatives

- **Overlay, not a new mode or a 4th dial.** `mode-routing-contract.test.sh` greps for exactly the 6
  modes + 3 dial names; a new mode/dial would either break the contract or bloat it. Dashboards are a
  KIND within CREATE/REDESIGN with medium orthogonal - the `engagement.md` precedent fit exactly.
- **No new gate rules; `anti-slop-gate.mjs` untouched.** Every recommendation is already gate-compatible
  (off-black not pure `#000`, neutral + one non-purple accent, no Inter-default, no bounce easing, no
  scroll listeners, ASCII). Data-app slop (KPI overload, chartjunk, color-only status, table slop,
  marketing-hero-on-a-console) is contextual - a Critic judgment finding like engagement, not a
  deterministic machine check.
- **Kept the full chart/table/design-system catalog** (critique flagged it as long) because the user's
  ask was explicitly to make the skill stronger and to surface the libraries/skills used; the content is
  keyword-dense and install commands live in `sources.md`.

## Verified

- All four suites green on Windows (Git Bash): `gate-scenarios` 28, `reference-links-contract` 40
  (was 38; +2 from `reference/dashboard.md` existence + orphan-listed checks), `mode-routing-contract` 13,
  `asset-fallback-contract` 7. Total 88, 0 failed.
- Pre-apply byte scan of `dashboard.md` and every patch `new_string`: zero em/en-dash (U+2013/U+2014),
  zero AI-purple hex/Tailwind tokens, no `font-family: Inter` default. The `#000`/`#fff` literals in
  `dashboard.md` are documentation prose mirroring `taste-core.md`; the gate never scans `reference/*.md`.
- Not run: a live dashboard build + render. This change is skill content (references/routing/docs), not
  runtime code; the existing render-gate path is unchanged.
