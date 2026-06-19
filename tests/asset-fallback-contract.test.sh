#!/usr/bin/env bash
# Skill contract: the asset chain documents an ordered, graceful fallback ending in a placeholder
# (never faked assets) - so missing tools degrade instead of breaking the design.
#
# Usage: bash tests/asset-fallback-contract.test.sh

SKILL_DIR="$(cd "$(dirname "$0")/.." && pwd)"
A="$SKILL_DIR/reference/assets.md"
PASS=0; FAIL=0

check() { # <label> <substr> <file>
  # -qiE (not -qiF): MSYS2 grep 3.0 aborts on -qiF; the substrings here are ERE-safe (words/hyphens).
  if grep -qiE "$2" "$3"; then PASS=$((PASS+1)); echo "  ok  $1";
  else FAIL=$((FAIL+1)); echo "FAIL  $1 (missing: $2)"; fi
}

[ -f "$A" ] || { echo "FAIL  reference/assets.md not found"; exit 1; }

# ordered chain tiers present
check "tier: gpt-image-2" "gpt-image-2" "$A"
check "tier: Stitch" "Stitch" "$A"
check "tier: real web image" "web image" "$A"
check "tier: documented placeholder" "placeholder" "$A"
# graceful degradation + honesty
check "graceful fallback wording" "fallback" "$A"
check "never fake assets" "never" "$A"
# SVG sub-chain
check "svg: icon library" "icon library" "$A"

echo
printf "  RESULT: %d passed, %d failed\n" "$PASS" "$FAIL"
[ "$FAIL" = 0 ]
