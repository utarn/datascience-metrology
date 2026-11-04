# ตั้งค่า Python Development Environment บน Windows

ติดตั้งเครื่องมือทั้งหมดผ่าน `winget` (ใช้ PowerShell)

## 1. อัปเดต winget ก่อน

```powershell
winget source update
```

## 2. ติดตั้งเครื่องมือหลัก

```powershell
# Git
winget install --id Git.Git -e

# Python 3.14
winget install --id Python.Python.3.14 -e

# uv (latest)
winget install --id astral-sh.uv -e

# PowerShell 7
winget install --id Microsoft.PowerShell -e

# VS Code
winget install --id Microsoft.VisualStudioCode -e
```

`pip` และ `venv` มาพร้อมกับ Python อยู่แล้ว ไม่ต้องติดตั้งแยก

> ถ้า `winget` ไม่รู้จัก id ให้ค้นหาก่อนด้วย `winget search python`

## 3. ตรวจสอบการติดตั้ง

ปิดแล้วเปิด terminal ใหม่ (เพื่อให้ PATH อัปเดต) จากนั้น

```powershell
python --version      # Python 3.14.x
uv --version          # uv x.y.z
pwsh --version        # PowerShell 7.x
code --version
```

## 4. อัปเกรด pip และสร้าง virtual environment

```powershell
python -m pip install --upgrade pip
python -m venv .venv
.\.venv\Scripts\Activate.ps1
```

ถ้า Activate ไม่ได้ เพราะ Execution Policy ให้อนุญาตก่อนหนึ่งครั้ง

```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
```

## 5. ทางเลือก: ใช้ uv จัดการ environment

```powershell
# สร้าง venv ด้วย Python 3.14
uv venv .venv --python 3.14
.\.venv\Scripts\Activate.ps1

# ติดตั้งแพ็กเกจ (เร็วและ deterministic กว่า pip)
uv pip install numpy pandas matplotlib jupyter
uv pip install -r requirements-offline.txt
```

สำหรับ repo นี้สามารถใช้สคริปต์สำเร็จรูปได้ โดยรันจาก root ของ repo

```powershell
powershell -ExecutionPolicy ByPass -File .\setup.ps1
```

## 6. ติดตั้ง VS Code Extensions (รายการเดียวกับเครื่องนี้)

```powershell
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension ms-python.debugpy
code --install-extension ms-python.vscode-python-envs
code --install-extension ms-python.black-formatter
code --install-extension ms-python.flake8
code --install-extension ms-toolsai.jupyter
code --install-extension ms-toolsai.jupyter-keymap
code --install-extension ms-toolsai.jupyter-renderers
code --install-extension ms-toolsai.vscode-jupyter-cell-tags
code --install-extension ms-toolsai.vscode-jupyter-slideshow
code --install-extension kevinrose.vsc-python-indent
code --install-extension mgesbert.python-path
```

หรือติดตั้งทั้งหมดในครั้งเดียว

```powershell
$extensions = @(
  "ms-python.python"
  "ms-python.vscode-pylance"
  "ms-python.debugpy"
  "ms-python.vscode-python-envs"
  "ms-python.black-formatter"
  "ms-python.flake8"
  "ms-toolsai.jupyter"
  "ms-toolsai.jupyter-keymap"
  "ms-toolsai.jupyter-renderers"
  "ms-toolsai.vscode-jupyter-cell-tags"
  "ms-toolsai.jupyter-slideshow"
  "kevinrose.vsc-python-indent"
  "mgesbert.python-path"
)
$extensions | ForEach-Object { code --install-extension $_ }
```

ตรวจสอบรายการที่ติดตั้งแล้ว

```powershell
code --list-extensions | Select-String -Pattern "python|jupyter"
```

## 7. เลือก Interpreter ใน VS Code

`Ctrl+Shift+P` → `Python: Select Interpreter` → เลือก `.\.venv\Scripts\python.exe`

## สรุปคำสั่งทั้งหมด (แบบรวบรัด)

```powershell
winget source update
winget install --id Python.Python.3.14 -e
winget install --id astral-sh.uv -e
winget install --id Microsoft.PowerShell -e
winget install --id Microsoft.VisualStudioCode -e

python -m pip install --upgrade pip
uv venv .venv --python 3.14
.\.venv\Scripts\Activate.ps1

code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension ms-toolsai.jupyter
```
