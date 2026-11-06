# setup.ps1 — one-click environment setup for the Data Skills with Python course.
# Run from the repo root in PowerShell:
#   powershell -ExecutionPolicy ByPass -File .\setup.ps1
#
# What it does:
#   1. Installs uv (pinned version) if missing, or upgrades an old one
#   2. Installs CPython 3.14 via uv
#      (on Windows ARM64, installs the x86_64 build — see PYTHON.md — because
#       pyarrow publishes no win_arm64 wheel, so a native ARM64 install would
#       try to compile pyarrow from source and fail without a full MSVC setup)
#   3. Syncs the pinned environment from uv.lock (exact versions, same on every machine)
#   4. Registers the Jupyter kernel "datascience-course"
#   5. Runs smoke_test.py and reports ผ่าน (PASS) / ไม่ผ่าน (FAIL)
#
# Offline fallback (restricted lab network):
#   On a machine WITH internet:  uv cache prune; uv sync; copy %LOCALAPPDATA%\uv\cache to USB
#   On the lab machine:          set UV_CACHE_DIR to the copied cache, then: uv sync --offline
#   (step-by-step อยู่ในโน้ตบุ๊กโมดูล M1)

$ErrorActionPreference = "Stop"
$UvVersion = "0.13.7"  # pinned installer version for reproducibility
# uv >= 0.12.23 is required on Windows ARM64: it fixed installing win_amd64
# wheels for an emulated x86_64 interpreter instead of building from source.
$UvMinVersion = "0.12.23"

Write-Host "== Data Skills with Python: environment setup ==" -ForegroundColor Cyan

# --- 1. Install uv if missing or too old ---
$uvCmd = Get-Command uv -ErrorAction SilentlyContinue
$needsUvInstall = $true
if ($uvCmd) {
    $uvVersion = ((uv --version) -split '\s+')[1]
    try {
        $needsUvInstall = [version]$uvVersion -lt [version]$UvMinVersion
    } catch {
        $needsUvInstall = $false  # unparseable version — assume it is fine
    }
    if ($needsUvInstall) {
        Write-Host "[1/5] uv $uvVersion is older than $UvMinVersion — upgrading to $UvVersion..."
    } else {
        Write-Host "[1/5] uv already installed: $(uv --version)"
    }
}

if ($needsUvInstall) {
    Write-Host "[1/5] Installing uv $UvVersion..."
    powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/$UvVersion/install.ps1 | iex"
    # refresh PATH for this session
    $env:Path = "$env:USERPROFILE\.local\bin;$env:Path"
    $uvCmd = Get-Command uv -ErrorAction SilentlyContinue
    if (-not $uvCmd) { throw "uv install failed - not found on PATH after install." }
}

# --- 2. Install CPython 3.14 via uv ---
# Windows on ARM64: force the emulated x86_64 build. pyarrow (a hard dependency
# of pandas 3) has no win_arm64 wheel, so a native ARM64 interpreter would try
# to build pyarrow from source. uv 0.13+ prefers native ARM64 by default, hence
# the explicit arch request (and UV_PYTHON_ARCH for any later uv commands).
$isWindowsArm64 = $env:PROCESSOR_ARCHITECTURE -eq "ARM64" -or $env:PROCESSOR_ARCHITEW6432 -eq "ARM64"
if ($isWindowsArm64) {
    Write-Host "[2/5] Windows on ARM64 detected — installing x86_64 CPython 3.14 (pyarrow has no win_arm64 wheel)..."
    $env:UV_PYTHON_ARCH = "x86_64"
    $pythonRequest = "cpython-3.14-windows-x86_64"
} else {
    Write-Host "[2/5] Installing CPython 3.14 (via uv)..."
    $pythonRequest = "3.14"
}
uv python install $pythonRequest

# --- 3. Sync the pinned environment from uv.lock ---
Write-Host "[3/5] Syncing pinned environment (uv sync --frozen)..."
uv sync --frozen --python $pythonRequest
if ($LASTEXITCODE -ne 0) { throw "uv sync failed (exit $LASTEXITCODE)." }

# On ARM64, verify uv actually chose the emulated x86_64 interpreter.
if ($isWindowsArm64) {
    $machine = (uv run python -c "import platform; print(platform.machine())").Trim()
    if ($machine -ne "AMD64") {
        throw "Expected an x86_64 (AMD64) Python on Windows ARM64, got '$machine'. See PYTHON.md section 5."
    }
}

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
