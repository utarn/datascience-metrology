# setup.ps1 — one-click environment setup for the Data Skills with Python course.
# Run from the repo root in PowerShell:
#   powershell -ExecutionPolicy ByPass -File .\setup.ps1
#
# What it does:
#   1. Installs uv (pinned version) if missing
#   2. Installs CPython 3.14 via uv
#   3. Syncs the pinned environment from uv.lock (exact versions, same on every machine)
#   4. Registers the Jupyter kernel "datascience-course"
#   5. Runs smoke_test.py and reports ผ่าน (PASS) / ไม่ผ่าน (FAIL)
#
# Offline fallback (restricted lab network):
#   On a machine WITH internet:  uv cache prune; uv sync; copy %LOCALAPPDATA%\uv\cache to USB
#   On the lab machine:          set UV_CACHE_DIR to the copied cache, then: uv sync --offline
#   (step-by-step อยู่ในโน้ตบุ๊กโมดูล M1)

$ErrorActionPreference = "Stop"
$UvVersion = "0.12.20"  # pinned installer version for reproducibility

Write-Host "== Data Skills with Python: environment setup ==" -ForegroundColor Cyan

# --- 1. Install uv if missing ---
$uvCmd = Get-Command uv -ErrorAction SilentlyContinue
if (-not $uvCmd) {
    Write-Host "[1/5] Installing uv $UvVersion..."
    powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/$UvVersion/install.ps1 | iex"
    # refresh PATH for this session
    $env:Path = "$env:USERPROFILE\.local\bin;$env:Path"
    $uvCmd = Get-Command uv -ErrorAction SilentlyContinue
    if (-not $uvCmd) { throw "uv install failed - not found on PATH after install." }
} else {
    Write-Host "[1/5] uv already installed: $(uv --version)"
}

# --- 2. Install CPython 3.14 via uv ---
Write-Host "[2/5] Installing CPython 3.14 (via uv)..."
uv python install 3.14

# --- 3. Sync the pinned environment from uv.lock ---
Write-Host "[3/5] Syncing pinned environment (uv sync --frozen)..."
uv sync --frozen
if ($LASTEXITCODE -ne 0) { throw "uv sync failed (exit $LASTEXITCODE)." }

# --- 4. Register the Jupyter kernel ---
Write-Host "[4/5] Registering Jupyter kernel 'datascience-course'..."
uv run python -m ipykernel install --user --name datascience-course --display-name "Python (datascience-course)"

# --- 5. Smoke test ---
Write-Host "[5/5] Running smoke test..."
uv run python smoke_test.py
if ($LASTEXITCODE -ne 0) {
    Write-Host "ไม่ผ่าน (FAIL) — see the errors above. Setup did not complete." -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "สำเร็จ! Environment ready. เปิดด้วย:  uv run jupyter lab" -ForegroundColor Green
