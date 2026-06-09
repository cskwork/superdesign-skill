# web - web medium

Load at Build when medium = web. Pairs with `taste-core.md`.

## Stack (default)

- React or Next.js. Prefer Server Components; isolate interactivity in leaf `"use client"`.
- Tailwind v4 (`@tailwindcss/postcss` or Vite plugin, not the old plugin). Plain HTML + Tailwind CDN OK for single-file landing/demo.
- Motion from `motion/react` (`framer-motion` is legacy alias). GSAP + ScrollTrigger for pin/scrub only. Three.js for 3D, lazy-loaded.
- Fonts: `next/font` or self-hosted `@font-face` with `font-display: swap`. No production Google Fonts `<link>` (CDN OK for a throwaway single-file demo).
- Icons: one family (Phosphor/HugeIcons/Radix/Tabler). Check `package.json` before importing; give the install command if missing.

## Layout

- `max-w-[1400px] mx-auto` or `max-w-7xl`. `min-h-[100dvh]`, never `h-screen`. CSS Grid over flex percentage math. Standard breakpoints; mobile collapse explicit per section below 768px.
- State: local `useState`/`useReducer`; global only to avoid deep prop drilling. Continuous values (mouse/scroll/physics) via Motion values, never React state.
- CJK/Korean (see `taste-core.md`): scope `html[lang="ko"]{ word-break: keep-all }` so words never split mid-line; load Pretendard or Noto Sans KR with a Latin face first; set `<html lang>`. For a bilingual page, swap text via `data-en`/`data-ko` + a toggle (persist in `localStorage`, default from `navigator.language`, allow `?lang=` override).

## Perf

Animate `transform`/`opacity` only. Reserve image/font space (priority/preload hero). Documented z-index scale. CWV: LCP <2.5s, INP <200ms, CLS <0.1. Grain/noise on fixed `pointer-events-none` pseudo-element.

## Single-file landing (lightweight path)

When the ask is one self-contained page (demo, GH Pages, quick landing): one `index.html`, Tailwind CDN, system-safe variable font or one webfont, real/generated images, `.nojekyll` if GH Pages. Still passes `anti-slop-gate.mjs` + contrast gate.
