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
