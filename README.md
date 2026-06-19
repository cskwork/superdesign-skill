**English** | [한국어](README.ko.md)

# superdesign

A master web/mobile designer as a Claude Code skill. Read the intent, pulse current trends, route to the aesthetic that fits, and ship elegant UI that passes a deterministic anti-slop gate and a rendered-verification gate. Asset and trend tooling is self-contained and portable - works without Stitch, gpt-image-2, or web search, degrading gracefully. Rendered verification is the one hard dependency: build modes render the surface with `playwright-cli` (the only render driver); if it cannot be installed, the skill stops and asks rather than faking a check.

Landing page: https://cskwork.github.io/superdesign-skill

## What it adds over a plain design prompt

- **Intent-driven routing.** Classifies the design job into one of six modes and picks the medium + aesthetic family that fit, instead of one default house style.
- **Trend-aware, not trend-chasing.** A live `WebSearch` trend pulse (with a dated offline snapshot fallback) keeps output current, but only trends that serve the brief are applied. The trend read is recorded with its date.
- **Anti-slop is enforced, not eyeballed.** A deterministic detector (`templates/anti-slop-gate.mjs`) plus a WCAG contrast gate scan the built source, and a render gate (`templates/render-gate.sh`) proves the surface was actually rendered with `playwright-cli` (hero fit, no overflow, console clean) - not eyeballed from a code block. The designer never self-approves.
- **Engaging by intent.** When the brief names a primary action (sign up / buy / book), `reference/engagement.md` applies mechanism-backed 2026 conversion craft - useful loading/empty/error states, real-data social proof, outcome-led CTA copy - while editorial and portfolio briefs are left alone.
- **Graceful fallback.** Missing asset/trend tools degrade to documented placeholders and the baked snapshot, never faked assets or invented data.

## Principles

- Elegance is the baseline, not padding.
- Read the intent first; design to the brief, never a default template.
- Trend-aware is not trend-chasing; record the trend read, dated.
- Anti-slop is enforced by gates; the surface is rendered with playwright-cli, never eyeballed; the designer never self-approves.
- Asset/trend tooling is self-contained with graceful fallback; rendered verification hard-requires playwright-cli (stop and ask, never fake it); never fake assets or data.
- Hard stops: external publish or destructive steps need explicit consent.

## Modes

| Mode | For |
|---|---|
| CREATE | a new UI / landing / app / screen from scratch |
| REDESIGN | modernize / improve an existing UI (audit-first) |
| SYSTEM | design tokens / palette / type / theme only |
| CRITIQUE | review / audit a design (runs the detectors, no build) |
| EXPLORE | divergent directions / moodboard, commit to none |
| ASSET | one image / icon / illustration / SVG / logo via the fallback chain |

Medium (web vs mobile/native) is decided in the loop: `reference/web.md` or `reference/mobile.md`.

## Default loop (CREATE / REDESIGN)

1. **Read** the brief; state it in one line.
2. **Trend pulse** - search current trends (snapshot fallback), record dated.
3. **Direction** - set dials, pick one system / family / lane, pick the medium.
4. **Build** to `reference/taste-core.md` + the chosen family/medium; source assets via the chain.
5. **Critique** (independent) - run `templates/preflight-gate.sh` on the source, render the surface with `playwright-cli` and run `templates/render-gate.sh`; log every violation.
6. **Verify** - fix, re-run both gates until green, report with output.

## Examples

```
/superdesign a calm landing page for a developer-tools startup
/superdesign redesign this admin dashboard to feel less generic
/superdesign a design system: tokens for a fintech app, light + dark
/superdesign critique this page  (paste code / URL / screenshot)
/superdesign explore 3 directions for a portfolio
/superdesign a hero illustration for an AI note-taking app
```

## The gates

```bash
# scan any built UI source for the machine-checkable AI tells
node templates/anti-slop-gate.mjs path/to/index.html

# WCAG contrast on the enumerated text/bg pairs
node templates/contrast-gate.mjs contrast-pairs.json

# full static pre-flight on a surface vault (claims + anti-slop + contrast)
bash templates/preflight-gate.sh <vault-dir> path/to/index.html

# rendered-verification gate: the surface was rendered with playwright-cli (Tool line + screenshot + clean console)
bash templates/render-gate.sh <vault-dir>
```

A vault is the per-surface work dir (default `.superdesign/<surface>/`) holding `claims.md`, `contrast-pairs.json`, and a `render/` dir of screenshots; start `claims.md` + `contrast-pairs.json` from `templates/`. The static gate scans source; the render gate confirms the Critic actually painted the page with `playwright-cli` - the only sanctioned render driver, no fallback.

Per-line escape hatch: a line containing `taste-ok` suppresses the detector for a deliberate, justified choice (e.g. a neutral Inter read).

## Install

```bash
git clone <superdesign-skill-repo> ~/skills/superdesign-skill
ln -s ~/skills/superdesign-skill ~/.claude/skills/superdesign
```

Then `/superdesign <design intent>` in Claude Code.

## Test

```bash
bash tests/gate-scenarios.test.sh
bash tests/reference-links-contract.test.sh
bash tests/mode-routing-contract.test.sh
bash tests/asset-fallback-contract.test.sh
```

## Credits

Builds on the sibling [supergoal-skill](https://github.com/cskwork/supergoal-skill) (structure, contrast gate). Anti-slop rules adapt [taste-skill](https://github.com/leonxlnx/taste-skill) (MIT); anti-pattern concepts distill [impeccable](https://github.com/pbakaus/impeccable) (Apache-2.0, no code copied); asset/landing flow draws on [stitch-landing-skill](https://github.com/cskwork/stitch-landing-skill) (MIT). Full attribution in `reference/sources.md`. License: MIT.
