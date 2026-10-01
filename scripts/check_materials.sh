#!/usr/bin/env bash
# Single quality gate for all course material.
#
#   scripts/check_materials.sh
#
# Does two things, in order:
#   1. Lint  — nbqa flake8 over every notebook in day*/ (repo-root .flake8)
#   2. Execute — every module's notebooks, top to bottom, in a clean
#      environment built from the pinned uv.lock (all modules run offline
#      on CPU — this course has no GPU/ML content).
#
# Knobs (environment variables):
#   SKIP_MODULES   space-separated module dir names to skip (none by default)
#   NB_TIMEOUT     per-notebook execution timeout in seconds (default 600)
#   CHECK_ENV      path of the scratch environment (default .check-env)
#
# Requirements: bash, uv (https://docs.astral.sh/uv/). Run from anywhere.

set -euo pipefail
cd "$(dirname "$0")/.."

CHECK_ENV="${CHECK_ENV:-.check-env}"
NB_TIMEOUT="${NB_TIMEOUT:-600}"
SKIP_MODULES="${SKIP_MODULES:-}"

NBQA="$CHECK_ENV/bin/nbqa"
JUPYTER="$CHECK_ENV/bin/jupyter"

failures=()

note()  { printf '\n\033[1;34m== %s\033[0m\n' "$*"; }
ok()    { printf '  \033[0;32mPASS\033[0m %s\n' "$*"; }
fail()  { printf '  \033[0;31mFAIL\033[0m %s\n' "$*"; failures+=("$*"); }

# ---------------------------------------------------------------------------
note "[0/2] Clean check environment ($CHECK_ENV)"
# A dedicated env so the developer's .venv is never touched and the check
# always runs against exactly what uv.lock pins.
UV_PROJECT_ENVIRONMENT="$CHECK_ENV" uv sync --frozen --quiet
ok "uv sync --frozen -> $CHECK_ENV"

# ---------------------------------------------------------------------------
note "[1/2] flake8 via nbqa (repo-root .flake8)"
lint_failed=0
day_dirs=()
for d in day*/; do [ -d "$d" ] && day_dirs+=("$d"); done
if [ "${#day_dirs[@]}" -eq 0 ]; then
    fail "no day*/ directories found"
    lint_failed=1
elif "$NBQA" flake8 "${day_dirs[@]}"; then
    ok "nbqa flake8 ${day_dirs[*]}"
else
    fail "nbqa flake8 (see output above)"
    lint_failed=1
fi

# ---------------------------------------------------------------------------
note "[2/2] Execute modules (allow_errors only for exercise notebooks)"
exec_failed=0
# Intentional placeholder/teaching-error notebooks are executed with
# allow_errors=True; everything else must run strictly (allow_errors=False).
ALLOW_PATTERNS='(exercise|background)\.ipynb$'

for module_dir in day*/module*/; do
    mod_name="$(basename "$module_dir")"
    skip=0
    for k in $SKIP_MODULES; do
        [ "$k" = "$mod_name" ] && skip=1
    done
    if [ "$skip" -eq 1 ]; then
        printf '  --skip %s (SKIP_MODULES)\n' "$mod_name"
        continue
    fi
    for nb in "$module_dir"*.ipynb; do
        [ -f "$nb" ] || continue
        if echo "$nb" | grep -Eq "$ALLOW_PATTERNS"; then
            allow="--ExecutePreprocessor.allow_errors=True"
        else
            allow="--ExecutePreprocessor.allow_errors=False"
        fi
        if "$JUPYTER" nbconvert --to notebook --execute --stdout \
                --ExecutePreprocessor.timeout="$NB_TIMEOUT" $allow \
                "$nb" > /dev/null 2>"$CHECK_ENV/nbconvert.log"; then
            ok "$nb"
        else
            fail "$nb"
            sed -n '1,15p' "$CHECK_ENV/nbconvert.log" | sed 's/^/       /'
            exec_failed=1
        fi
    done
done

# ---------------------------------------------------------------------------
note "Summary"
[ "$lint_failed" -eq 0 ] && ok "lint" || fail "lint"
[ "$exec_failed" -eq 0 ] && ok "execution" || fail "execution"
if [ "${#failures[@]}" -gt 0 ]; then
    printf '\nFailed items:\n'
    printf '  - %s\n' "${failures[@]}"
    exit 1
fi
printf '\nAll material checks passed.\n'
