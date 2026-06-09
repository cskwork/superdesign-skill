#!/usr/bin/env bash
# Skill self-integrity: every reference/agents/templates path mentioned in SKILL.md must exist.
# A dangling link means a phase tries to load a file that is not there.
#
# Usage: bash tests/reference-links-contract.test.sh  (exit 0 only if all referenced files exist)

SKILL_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SKILL="$SKILL_DIR/SKILL.md"
PASS=0; FAIL=0

[ -f "$SKILL" ] || { echo "FAIL  SKILL.md not found"; exit 1; }

# Pull backtick-quoted paths like `reference/foo.md`, `agents/bar.md`, `templates/baz.sh`.
paths="$(grep -oE '(reference|agents|templates)/[A-Za-z0-9._-]+\.(md|mjs|sh|json)' "$SKILL" | sort -u)"
[ -n "$paths" ] || { echo "FAIL  no reference paths found in SKILL.md (parser broke?)"; exit 1; }

while IFS= read -r p; do
  if [ -f "$SKILL_DIR/$p" ]; then PASS=$((PASS+1)); echo "  ok  $p";
  else FAIL=$((FAIL+1)); echo "FAIL  missing: $p"; fi
done <<< "$paths"

# Every reference/*.md and agents/*.md on disk should be referenced somewhere (no orphans in SKILL.md's map).
echo "-- orphan check (reference/ listed in SKILL.md) --"
for f in "$SKILL_DIR"/reference/*.md; do
  base="reference/$(basename "$f")"
  if grep -qF "$base" "$SKILL"; then PASS=$((PASS+1)); echo "  ok  listed $base";
  else FAIL=$((FAIL+1)); echo "FAIL  orphan (not in SKILL.md): $base"; fi
done

echo
printf "  RESULT: %d passed, %d failed\n" "$PASS" "$FAIL"
[ "$FAIL" = 0 ]
