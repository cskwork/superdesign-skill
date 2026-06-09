# critique - CRITIQUE mode

Review an existing design. No design change. Output a findings report.

## Input

Code (HTML/JSX/CSS), a screenshot, or a URL. For a URL, fetch the rendered source; for a screenshot, eyeball against the checklists (the gate needs source to scan).

## Run

1. **Detector (deterministic)**: run `templates/anti-slop-gate.mjs <source>` and `templates/contrast-gate.mjs <pairs.json>` (enumerate text/bg pairs from the CSS). Gate failures are blocking findings.
2. **Taste pass**: check against `taste-core.md` pre-flight (hero fit, eyebrow count, split-header, zigzag, one accent/radius/theme, real images, copy).
3. **impeccable quality pass**: `impeccable-rules.md` judgment checks (padding, touch targets, heading levels, card overuse, dated easing).

## Report

Findings by severity (blocking gate fails first, then HIGH/MEDIUM), each with file:line (or region) + a concrete fix. End with: overall verdict + the single highest-leverage change. Do not edit the design - hand the report back.

Done when: report delivered with verdict + highest-leverage change; the design untouched.
