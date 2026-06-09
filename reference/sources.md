# sources - install commands, sources, attribution

## Design system install

```
npm install @material/web                         # Material 3
npm install @fluentui/react-components            # Fluent (or @fluentui/web-components @fluentui/tokens)
npm install @carbon/react @carbon/styles          # Carbon
npm install @radix-ui/themes                      # Radix
npx shadcn@latest init                            # shadcn/ui
npm install @primer/css   # or @primer/react-brand # Primer
npm install @atlaskit/tokens                       # Atlassian
npm install bootstrap                              # Bootstrap 5.3
```

Shopify Polaris web components: via CDN. govuk-frontend / uswds: per their docs.

## Canonical sources

- Material: https://material-web.dev , https://m3.material.io
- Fluent: https://fluent2.microsoft.design
- Carbon: https://carbondesignsystem.com
- Radix: https://radix-ui.com
- shadcn/ui: https://ui.shadcn.com
- Primer: https://primer.style
- Atlassian: https://atlassian.design
- Apple HIG: https://developer.apple.com/design/human-interface-guidelines
- Tailwind v4: https://tailwindcss.com
- Motion: https://motion.dev , GSAP: https://gsap.com

## Asset tooling

- gpt-image-2 skill (Codex/ChatGPT subscription) - local skill, image gen/edit.
- Stitch MCP: https://stitch.withgoogle.com - UI screen generation.
- Simple Icons: https://simpleicons.org , devicon: https://devicon.dev - real brand SVG.
- Unsplash / Pexels - stock photography.

## Third-party attribution

- **taste-skill** (https://github.com/leonxlnx/taste-skill, MIT) - `taste-core.md` and `aesthetics.md` are condensed, adapted derivatives. Anti-slop rules + aesthetic families.
- **impeccable** (https://github.com/pbakaus/impeccable, Apache-2.0) - `impeccable-rules.md` distills its anti-pattern concepts; `templates/anti-slop-gate.mjs` is an independent re-implementation (no upstream code copied), built on Anthropic's frontend-design lineage.
- **stitch-landing-skill** (https://github.com/cskwork/stitch-landing-skill, MIT) - landing/Stitch flow inspiration for `assets.md` and the GH Pages landing.
- **supergoal-skill** (cskwork, MIT) - skill structure, `contrast-gate.mjs`, agent/gate/test format adapted from the sibling skill.

## Install superdesign

```
git clone <superdesign-skill-repo> ~/skills/superdesign-skill
ln -s ~/skills/superdesign-skill ~/.claude/skills/superdesign
```
Then `/superdesign <design intent>`.
