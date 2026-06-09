---
name: superdesign
description: Master web/mobile designer - read intent, pulse current trends, route to the right aesthetic, ship elegant UI past a deterministic anti-slop gate. Use for "/superdesign", "design X", "make this beautiful", "landing page", "redesign UI", "design system / tokens", "critique this design", "explore directions", "generate image / icon / logo".
---

# /superdesign - intent-driven elegance

Intent -> trend-aware direction that fits -> elegant UI -> verified against a deterministic anti-slop gate. One-line CSS tweak: skip this skill, edit directly.

## Core principles

- Elegance is baseline, not padding. Polished = correct, not extra credit.
- Read intent first. Design to the brief (kind, audience, brand, constraints), never to a default template.
- Trend-aware != trend-chasing. Apply only trends that serve the intent. Record the trend read, dated.
- Anti-slop enforced, not eyeballed. Every surface passes `anti-slop-gate.mjs` + contrast gate. Designer never self-approves.
- Diverse by intent. Route to the aesthetic family + medium that fit; no single house style.
- Self-contained + graceful fallback. Works without Stitch/gpt-image-2/WebSearch; missing tools -> documented placeholder + baked snapshot, never faked assets or invented data.
- Verify vs ground truth. Run gates, honor reduced-motion + WCAG AA, report what passed with command output.
- Hard stops. External publish (deploy/push/post) or destructive steps need explicit consent; ambiguous brief blocks build.

## Mode (classify the design intent, state it in one line)

| Signal | Mode | Approach |
|---|---|---|
| new UI / landing / app / screen from scratch | CREATE | default loop |
| redesign / modernize / improve / refresh existing UI | REDESIGN | audit-first (`reference/redesign.md`) |
| tokens / palette / type / theme / design system only | SYSTEM | `reference/design-system.md` |
| critique / audit / review (no build) | CRITIQUE | review-only, run detectors (`reference/critique.md`) |
| explore / moodboard / directions / "what style" | EXPLORE | divergent, trend-heavy, no commit (`reference/explore.md`) |
| image / icon / illustration / SVG / logo (asset only) | ASSET | fallback chain (`reference/assets.md`) |

Medium (web vs mobile/native) is orthogonal - decide in the loop, load `reference/web.md` or `reference/mobile.md`.

## Default loop (CREATE / REDESIGN) - role-separated

Author-independent roles (own agent when orchestrated; inline, switch role with a fresh re-read). One Designer per surface; scaffolding may fan out, look-and-feel stays deep-and-narrow.

1. **Read (brief).** Infer kind, audience, vibe, references, brand, quiet constraints (a11y/regulation override aesthetics). State: `Reading this as: <kind> for <audience>, <vibe> language, leaning <system or family>.` Two reads diverge -> ask ONE question; else do not ask. (`reference/design-brief.md`)
2. **Trend pulse.** `WebSearch` current trend lane by default; on failure use `reference/trend-snapshot.md` (dated) and warn it may be stale. Keep only intent-serving trends. Record dated in `trend-pulse.md`. (`reference/trend-research.md`)
3. **Direction.** Set dials `DESIGN_VARIANCE` / `MOTION_INTENSITY` / `VISUAL_DENSITY`. Pick official design system OR one aesthetic family (`reference/aesthetics.md`) OR one trend lane - never mix. Pick medium, load `web.md` or `mobile.md`.
4. **Build (Designer).** Implement to `reference/taste-core.md` (always authority) + chosen family/medium. Assets via `reference/assets.md`. Enforce anti-default + reduced-motion + computed contrast. No self-approval; append `claims.md` per surface. (`agents/designer.md`)
5. **Critique (independent; no design edits).** Re-read `taste-core.md` + `impeccable-rules.md`. Run `templates/preflight-gate.sh` (-> `anti-slop-gate.mjs` + `contrast-gate.mjs`). Log every violation. (`agents/design-critic.md`)
6. **Verify.** Fix each violation, smallest change; re-run gate until green. Report passes with output. Fresh violation loops critique -> fix; stop on green.

Roles -> personas: build=`agents/designer.md`, critique=`agents/design-critic.md`, trends=`agents/trend-scout.md`, assets=`agents/asset-producer.md`.

## No-build modes

- **CRITIQUE** - review existing design (code/screenshot/URL) vs `taste-core.md` + `impeccable-rules.md`, run detectors on source, output findings. No change. `reference/critique.md`.
- **EXPLORE** - 2-4 divergent directions (trend lane + dials + family) with rationale + reference imagery; commit to none. `reference/explore.md`.
- **SYSTEM** - tokens (color/type/spacing/radius/motion) + light/dark theming, no full page. `reference/design-system.md`.
- **ASSET** - one asset via fallback chain (`gpt-image-2` -> Stitch -> real web image/SVG -> placeholder; SVG: icon lib -> generated mark -> hand-rolled last). `reference/assets.md`.

## Reference map (load only what the phase needs)

| Read | When |
|---|---|
| `reference/design-brief.md` | Read: infer brief, one-line read, single question |
| `reference/trend-research.md` | Trend pulse: search, evaluate, record |
| `reference/trend-snapshot.md` | Trend pulse fallback: dated offline snapshot + refresh |
| `reference/taste-core.md` | Build + Critique: always-on anti-slop visual authority |
| `reference/aesthetics.md` | Direction: pick <=1 aesthetic family (selection map) |
| `reference/impeccable-rules.md` | Critique: anti-pattern guardrails behind the detector |
| `reference/web.md` | Build: web stack + layout |
| `reference/mobile.md` | Build: mobile/native (iOS HIG, Material 3, RN/SwiftUI/Compose) |
| `reference/assets.md` | Build / ASSET: image + SVG fallback chain |
| `reference/redesign.md` | REDESIGN: audit-first protocol |
| `reference/design-system.md` | SYSTEM: tokens, scales, theming |
| `reference/critique.md` | CRITIQUE: review-only flow |
| `reference/explore.md` | EXPLORE: divergent directions |
| `reference/sources.md` | Install commands, sources, attribution |

## Final checklist

- [ ] Mode + medium stated; brief read one line; trends pulsed + dated (or snapshot fallback disclosed)
- [ ] One accent, one type system, one radius, one theme strategy; dials declared
- [ ] Real/generated assets (no div-mockups); reduced-motion + WCAG AA honored
- [ ] `templates/preflight-gate.sh` green (anti-slop + contrast), output reported
- [ ] Smallest change for intent; surrounding style matched; no unrequested rewrites
- [ ] Any external publish / destructive step had explicit consent
