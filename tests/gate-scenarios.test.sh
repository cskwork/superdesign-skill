#!/usr/bin/env bash
# /superdesign - gate scenario suite. Exercises anti-slop-gate.mjs, contrast-gate.mjs, and
# preflight-gate.sh. Every case asserts BOTH the exit code AND a substring of the output, so a
# pass needs two independent signals (guards against silently-wrong gates and fabricated output).
#
# Usage: bash tests/gate-scenarios.test.sh   (exit 0 only if all cases pass; run from repo root)

SKILL_DIR="$(cd "$(dirname "$0")/.." && pwd)"
T="$(mktemp -d)"
trap 'rm -rf "$T"' EXIT
PASS=0; FAIL=0

ASLOP="$SKILL_DIR/templates/anti-slop-gate.mjs"
CGATE="$SKILL_DIR/templates/contrast-gate.mjs"
PFGATE="$SKILL_DIR/templates/preflight-gate.sh"

# run_case <label> <expected-exit> <expected-substr|-> <cmd...>
run_case() {
  local label="$1" exp="$2" substr="$3"; shift 3
  local out rc
  out="$("$@" 2>&1)"; rc=$?
  local ok=1
  [ "$rc" = "$exp" ] || ok=0
  if [ "$substr" != "-" ]; then echo "$out" | grep -qF "$substr" || ok=0; fi
  if [ "$ok" = 1 ]; then PASS=$((PASS+1)); echo "  ok  $label";
  else FAIL=$((FAIL+1)); echo "FAIL  $label (rc=$rc exp=$exp; wanted substr: $substr)"; fi
}

# --- fixtures ---
# Clean surface (no slop). Off-white bg, off-black text, deliberate green accent, calm easing.
cat > "$T/clean.html" <<'EOF'
<!doctype html><html><head><style>
:root{--bg:#faf9f6;--ink:#1f2123;--accent:#1f6f5c}
body{font-family:Geist,system-ui;background:var(--bg);color:var(--ink)}
.btn{background:var(--accent);color:#f7f7f5;transition:transform .3s cubic-bezier(.16,1,.3,1)}
.card{box-shadow:0 2px 8px rgba(31,33,35,.08)}
</style></head><body><h1>Build calm software</h1><p>Ship with intent.</p></body></html>
EOF

# Slop surface: em-dash, AI-purple, Inter default, bounce easing, pure black, placeholder name, filler verb, scroll listener.
cat > "$T/slop.html" <<'EOF'
<!doctype html><html><head><style>
body{font-family:Inter,sans-serif;background:#ffffff;color:#000000}
.cta{background:#8b5cf6;transition:all .4s cubic-bezier(.68,-0.55,.27,1.55)}
.card{box-shadow:0 10px 30px rgba(0,0,0,0.5)}
</style></head><body>
<h1>Unleash next-gen synergy — seamless and bold</h1>
<p>Trusted by John Doe at Acme.</p>
<script>window.addEventListener('scroll',()=>{document.body.dataset.y=window.scrollY})</script>
</body></html>
EOF

# taste-ok suppression: Inter but justified on the same line.
cat > "$T/inter-ok.html" <<'EOF'
<style>body{font-family:Inter,sans-serif} /* taste-ok: Inter neutral public-sector read */</style>
<h1>Calm</h1>
EOF

# contrast pairs
echo '[{"el":"body","fg":"#2f3133","bg":"#faf9f6","size":"body"},{"el":"cta","fg":"#f7f7f5","bg":"#1f6f5c","size":"normal"}]' > "$T/pass.json"
echo '[{"el":"muted","fg":"#9a9a9a","bg":"#ffffff","size":"normal"}]' > "$T/fail.json"
printf 'not json' > "$T/bad.json"

echo "== anti-slop-gate =="
run_case "clean surface -> PASS exit 0"        0 "ANTI-SLOP GATE: PASS"  node "$ASLOP" "$T/clean.html"
run_case "slop: em-dash detected -> exit 1"    1 "em-dash"               node "$ASLOP" "$T/slop.html"
run_case "slop: ai-purple detected -> exit 1"  1 "ai-purple"             node "$ASLOP" "$T/slop.html"
run_case "slop: inter-default detected"        1 "inter-default"         node "$ASLOP" "$T/slop.html"
run_case "slop: bounce-easing detected"        1 "bounce-easing"         node "$ASLOP" "$T/slop.html"
run_case "slop: pure-bw detected"              1 "pure-bw"               node "$ASLOP" "$T/slop.html"
run_case "slop: placeholder-name detected"     1 "placeholder-name"      node "$ASLOP" "$T/slop.html"
run_case "slop: filler-verb detected"          1 "filler-verb"           node "$ASLOP" "$T/slop.html"
run_case "slop: scroll-listener detected"      1 "scroll-listener"       node "$ASLOP" "$T/slop.html"
run_case "taste-ok suppresses inter -> PASS"   0 "ANTI-SLOP GATE: PASS"  node "$ASLOP" "$T/inter-ok.html"
run_case "no args -> usage exit 2"             2 "usage"                 node "$ASLOP"

echo "== contrast-gate =="
run_case "passing pairs -> exit 0"             0 "CONTRAST GATE PASS"    node "$CGATE" "$T/pass.json"
run_case "sub-AA pair -> FAIL exit 1"          1 "below threshold"       node "$CGATE" "$T/fail.json"
run_case "bad json -> exit 2"                  2 "cannot read/parse"     node "$CGATE" "$T/bad.json"
run_case "missing arg -> exit 2"               2 "usage"                 node "$CGATE"

echo "== preflight-gate =="
V="$T/vault"; mkdir -p "$V"; cp "$T/clean.html" "$V/index.html"
run_case "no vault arg -> usage exit 2"        2 "usage"                 bash "$PFGATE"
run_case "missing claims.md -> blocked"        1 "claims.md missing"     bash "$PFGATE" "$V"
printf '# claims\n- surface\n' > "$V/claims.md"
run_case "claims without dials -> blocked"     1 "does not declare dials" bash "$PFGATE" "$V"
printf '# claims\nDESIGN_VARIANCE 6 / MOTION_INTENSITY 3 / VISUAL_DENSITY 3\n' > "$V/claims.md"
run_case "missing contrast-pairs -> blocked"   1 "contrast-pairs.json missing" bash "$PFGATE" "$V"
cp "$T/pass.json" "$V/contrast-pairs.json"
run_case "full clean vault -> PREFLIGHT PASS"  0 "PREFLIGHT PASS"        bash "$PFGATE" "$V"
cp "$T/slop.html" "$V/index.html"
run_case "slop in vault -> blocked"            1 "anti-slop violations"  bash "$PFGATE" "$V"

echo "== render-gate =="
RGATE="$SKILL_DIR/templates/render-gate.sh"
RV="$T/rvault"; mkdir -p "$RV/render"
run_case "no vault arg -> usage exit 2"        2 "usage"                  bash "$RGATE"
run_case "missing claims.md -> blocked"        1 "claims.md missing"      bash "$RGATE" "$RV"
# claims with no Render block
printf '# claims\n## surface\n- Mode: CREATE\n' > "$RV/claims.md"
run_case "no Render block -> blocked"          1 "no '## Render' block"   bash "$RGATE" "$RV"
# Render block names a non-playwright-cli driver
printf '# claims\n## surface\n## Render\n- Tool: headless-chrome\n- Console: clean\n' > "$RV/claims.md"
run_case "wrong driver -> blocked"             1 "not playwright-cli"     bash "$RGATE" "$RV"
# correct driver but no screenshot under render/
printf '# claims\n## surface\n## Render\n- Tool: playwright-cli\n- Console: clean\n' > "$RV/claims.md"
run_case "no screenshot -> blocked"            1 "no screenshot"          bash "$RGATE" "$RV"
# add a screenshot but console attests errors
: > "$RV/render/desktop.png"
printf '# claims\n## surface\n## Render\n- Tool: playwright-cli\n- Console: 2 errors (TypeError)\n' > "$RV/claims.md"
run_case "console not clean -> blocked"        1 "not attested clean"     bash "$RGATE" "$RV"
# full clean evidence -> PASS (warnings allowed; '0 errors' / 'clean' accepted)
printf '# claims\n## surface\n## Render\n- Tool: playwright-cli\n- Console: clean (1 warning ignored)\n' > "$RV/claims.md"
run_case "full render evidence -> RENDER PASS" 0 "RENDER GATE PASS"       bash "$RGATE" "$RV"

echo
printf "  RESULT: %d passed, %d failed\n" "$PASS" "$FAIL"
echo
[ "$FAIL" = 0 ]
