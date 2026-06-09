# 2026-06-09

## Bilingual landing + Apple Liquid Glass + Korean/CJK support

### Landing (docs/index.html)
- Bilingual EN/KO via `data-en`/`data-ko` (+ `data-en-html`/`data-ko-html` for rich nodes). Toggle in the top bar; default from `navigator.language`; persisted in `localStorage`; `?lang=en|ko` override for shareable links. Why: one URL, instant switch, deterministic to test.
- Korean line-breaking: `html[lang="ko"]{ word-break: keep-all }` so Korean wraps at word (어절) boundaries, never mid-word (e.g. "트렌드로" stays whole). `.term pre` kept `normal` (code). Noto Sans KR loaded with Latin fallback.
- Korean copy rewritten for natural grammar (correct particles/endings, one register, no telegraphic noun-stacks).
- Redesigned to Apple Liquid Glass lane: aurora background (teal/blue/gold/peach, no purple) gives the glass something to refract; `.glass` = blur + saturate + off-white inner highlight + tinted shadow; `prefers-reduced-transparency` solid fallback. Glass highlights use off-white rgba (245,244,240), never pure white, to satisfy the pure-bw gate rule.
- Navigation: floating top glass capsule (brand + lang + GitHub) plus an Apple-style floating bottom dock (Modes/Loop/Gate/Install) with an active pill driven by an IntersectionObserver section spy (no scroll listener).

### Skill updates (Korean/CJK as a first-class concern)
- `reference/taste-core.md`: new "CJK / Korean text" section (keep-all line-break, real CJK webfont, natural copy, tighter measure, punctuation, `lang` attribute). Always loaded at Build + Critique.
- `reference/web.md`: concrete CJK CSS + bilingual toggle pattern.
- `reference/mobile.md`: CJK face + word line-breaking + longer Korean labels sizing.

### Verification
- `anti-slop-gate.mjs` on docs/index.html: PASS (caught a literal "#fff" in a CSS comment first; reworded). 
- `contrast-gate.mjs` on the new glass palette: all pairs WCAG AA (lowest 7.31).
- All 4 contract suites green. EN + KO rendered via headless Chrome and visually verified (glass, dock, word-break, natural Korean).
