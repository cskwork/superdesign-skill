#!/usr/bin/env bash
# Skill contract: SKILL.md declares all six design modes and frontmatter is well-formed.
#
# Usage: bash tests/mode-routing-contract.test.sh

SKILL_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SKILL="$SKILL_DIR/SKILL.md"
PASS=0; FAIL=0

check() { # <label> <substr>
  if grep -qF "$2" "$SKILL"; then PASS=$((PASS+1)); echo "  ok  $1";
  else FAIL=$((FAIL+1)); echo "FAIL  $1 (missing: $2)"; fi
}

# frontmatter
check "frontmatter name is superdesign" "name: superdesign"
head -1 "$SKILL" | grep -qF -- "---" && { PASS=$((PASS+1)); echo "  ok  frontmatter opens with ---"; } || { FAIL=$((FAIL+1)); echo "FAIL  frontmatter must open with ---"; }

# six modes
for m in CREATE REDESIGN SYSTEM CRITIQUE EXPLORE ASSET; do
  check "mode declared: $m" "$m"
done

# the three dials, exact names
for d in DESIGN_VARIANCE MOTION_INTENSITY VISUAL_DENSITY; do
  check "dial present: $d" "$d"
done

# loop + gate references
check "default loop present" "Default loop"
check "preflight gate wired" "templates/preflight-gate.sh"

echo
printf "  RESULT: %d passed, %d failed\n" "$PASS" "$FAIL"
[ "$FAIL" = 0 ]
