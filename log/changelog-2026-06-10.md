# 2026-06-10 - intent-workflow hardening + terse pass

Goal: make every intent-based mode turnkey for an agent, close accuracy gaps, keep SKILL.md agent-terse.

## Why each change

- **Vault defined** (SKILL.md, agents/designer.md, agents/design-critic.md, README*): `preflight-gate.sh` always required a vault with `claims.md` + `contrast-pairs.json`, but no doc said where it lives or who creates it - agents only discovered it when the gate failed. Default `.superdesign/<surface>/`, created at step 1.
- **Mode tie-breaks** (SKILL.md): compound intents ("critique and fix", "explore then build", tokens+page, asset-inside-build) had no routing rule; agents could pick the wrong mode or stall. One-paragraph deterministic tie-break.
- **Mode contract table** (SKILL.md + Done-when lines in reference/critique|explore|design-system|redesign|assets.md): only CREATE had a crisp exit criterion. Every mode now has deliverable + verified-by, so no-build modes end deterministically.
- **Verify loop cap** (SKILL.md): critique->fix had no stop condition; capped at 3 cycles, then honest report. Prevents infinite gate loops.
- **Non-interactive fallback** (SKILL.md hard stops, reference/design-brief.md): the one-question ask gate blocked autonomous runs forever. Now: conservative read + assumption logged in the brief, proceed. Interactive behavior unchanged.
- **Trend pulse reuse** (SKILL.md, reference/trend-research.md): same-kind pulse <=30 days old is reusable (noted), saving a WebSearch round per surface without going stale.
- **Gate discovery widened** (templates/preflight-gate.sh): auto-discovery only scanned html/css/jsx/tsx, so slop in .js/.ts/.svelte/.vue/.astro silently passed. Added those extensions; excluded node_modules/dist/build/.next. Strictly stricter - no failing surface becomes passing.
- **Terse pass** (SKILL.md): removed the No-build modes bullet section (now redundant with the mode table + mode contract), merged duplicated role-orchestration prose. Agent token budget, not style.

## Verified

- `tests/*.test.sh`: 74/74 pass after all edits (asset-fallback 7, gate-scenarios 21, mode-routing 13, reference-links 33).
- Smoke test: vault with slop in `src/App.vue` -> PREFLIGHT FAIL (ai-purple, filler-verb); `node_modules/lib.js` with `#000` ignored; cleaned .vue -> PREFLIGHT PASS exit 0.
