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

# 2026-06-10 (later) - landing page restaged via /superdesign REDESIGN

Goal: push docs/index.html to the glass-family ceiling as the skill's own showcase, dogfooding the full loop (vault at `.superdesign/landing/`).

## Why each change

- **Family kept, dials raised** (glass, VAR 8 / MOT 7 / DEN 4): "improve + maximum stylization" one day after the Liquid Glass commit reads as intensify-the-brand, not replace it. Assumption logged in the brief; family ceiling instead of switching to high-end avoids mixing families.
- **Trend pulse from snapshot**: WebSearch errored this session; snapshot is dated 2026-06 (current month), so treated as current and noted in trend-pulse.md.
- **Terminal font fix**: Newsreader (a serif) was the terminal face; swapped to JetBrains Mono. Newsreader now does display contrast words, step/stat numerals only - one coherent type system.
- **Kinetic hero**: staged entrance + serif gradient contrast words; KO override drops italic (Hangul has no italic tradition, Newsreader has no Hangul glyphs) and uses bold Noto Sans KR with the same gradient.
- **Authentic data over decoration**: stats strip (6 modes / 5 families / 9 detectors / 2 gates, all countable in repo), marquee of real detector ids, gate section shows this page's own preflight output with an honest "table trimmed" note.
- **Depth stack**: generated backdrop art (gpt-image-2, tier 1 of the asset chain) over animated CSS aurora with `onerror` self-removal, vignette for text contrast, feTurbulence grain film. First gen attempt failed (stream disconnect, exit 5); retried.
- **A11y wins**: focus-visible outlines added, loop steps h4 -> h3 (no skipped heading level), pill touch targets enlarged, every new motion behind prefers-reduced-motion, marquee duplicate aria-hidden + static-wrap fallback.
- **Preserved**: anchors, dock/topbar structure, EN/KO toggle + voice, title/meta SEO, gold accent, CJK keep-all, GitHub links.

## Verified

- `bash preflight-gate.sh .superdesign/landing docs/index.html` -> ANTI-SLOP PASS, CONTRAST PASS (25 pairs enumerated incl. worst-case bright-backdrop composite, lowest 5.65:1), PREFLIGHT PASS. Re-run green after critique fixes.
- HTML tag balance checked with a python html.parser script: OK.
