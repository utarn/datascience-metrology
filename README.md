# Data Skills with Python — สื่อการเรียน

หลักสูตรฝึกอบรม 2 วัน (09:00–17:00, 12 ชม.) สำหรับผู้เริ่มต้น ไม่ต้องมีพื้นฐานเขียนโปรแกรม —
**จัดการข้อมูลจริง ตั้งแต่ไฟล์ดิบถึงรายงาน**: EDA, สถิติพรรณนา, กราฟที่สื่อสารได้,
และพยากรณ์แบบไม่ใช้ ML (trend line / moving average + กับดัก extrapolation)

หลักสูตรนี้เป็น **foundations ที่ต่อเนื่องไปคอร์ส "Machine Learning for Advanced
Metrology Research" 3 วัน** ([utarn/ml-metrology](https://github.com/utarn/ml-metrology)) —
ไม่มีการสอน Machine Learning ทุกประเภทในหลักสูตรนี้ (ดู `docs/adr/0002-no-ml-foundations-course.md`)

## ภาพรวมหลักสูตร 2 วัน

| วัน | โมดูล |
|---|---|
| **Day 1** — เขียนโปรแกรมกับข้อมูลเป็น | M1 Python + ข้อมูลรอบตัวเรา · M2 จัดการตารางด้วย pandas · M3 ข้อมูลไม่สะอาด |
| **Day 2** — จากข้อมูล สู่ความเข้าใจ สู่การมองไปข้างหน้า | M4 สถิติที่ใช้ได้จริง · M5 กราฟที่สื่อสารได้ (ย่อ) · M6 พยากรณ์อย่างง่าย · M7 ทำงานอัตโนมัติ (ย่อ) · M8 Mini Project + นำเสนอ + What's next |

แนวทางการสอน: **Code-Along** — ผู้เรียนคัดลอก/รันโค้ดต้นแบบทีละขั้น ไม่เขียนจากหน้าว่าง
โฟกัสการแปลผลมากกว่าไวยากรณ์

## โครงสร้างต่อโมดูล

| โฟลเดอร์ | โมดูล |
|---|---|
| `day1/module1_python_primer/` | M1 — ข้อมูลรอบตัวเรา (รูปแบบไฟล์, ขีดจำกัด Excel) + Python จากศูนย์ |
| `day1/module2_pandas_tables/` | M2 — จัดการตารางด้วย pandas: โหลด กรอง เรียง groupby รวมหลายไฟล์ |
| `day1/module3_dirty_data/` | M3 — ข้อมูลไม่สะอาด: ค่าว่าง สะกดไม่ตรง วันที่แปลก ไฟล์ซ้ำซ้อน |
| `day2/module4_statistics/` | M4 — สถิติที่ใช้ได้จริง: ค่าเฉลี่ย การกระจาย percentile "ค่าเฉลี่ยหลอกเรา" |
| `day2/module5_charts/` | M5 — กราฟที่สื่อสารได้: เลือกกราฟให้ตรงคำถาม พล็อตด้วย matplotlib |
| `day2/module6_simple_forecasting/` | M6 — พยากรณ์อย่างง่าย: trend line, moving average, กับดัก extrapolation (ไม่มี ML) |
| `day2/module7_automation/` | M7 — ทำงานซ้ำให้เป็นอัตโนมัติ: batch processing, รายงานจาก template |
| `day2/module8_mini_project/` | M8 — Mini Project "ถ้าเป็นอีก 3 เดือนข้างหน้า" + นำเสนอ + What's next |

ในแต่ละโมดูล: `book.ipynb` = สื่อประกอบการสอน · `exercise.ipynb` = **แบบฝึกหัดที่คุณทำ**
(เติมช่อง `# TODO`) · `explanation.md` = สคริปต์ภาพประกอบ · ส่วนไฟล์เฉลย
(`solution.ipynb`) ผู้สอนจะเปิดเผยในห้อง **หลังจบช่วงแล็บนั้น ๆ**

## ติดตั้ง (ทำครั้งเดียวก่อนวันแรก)

**Windows:** ดับเบิลคลิก `setup.ps1` (หรือคลิกขวา → Run with PowerShell) — ติดตั้งทุกอย่างให้อัตโนมัติ

**macOS / มี `uv` อยู่แล้ว:**

```bash
uv sync
uv run python smoke_test.py   # ต้องขึ้นว่า PASS
```

**ไม่มี `uv` เลย:** `pip install -r requirements-offline.txt` แล้วรัน `python smoke_test.py`

สภาพแวดล้อม pin ไว้สองทาง (pandas stack — ไม่มี scikit-learn/ML ตาม ADR-0002):

- **`requirements-offline.txt`** — เครื่องผู้เรียน CPU, ใช้ offline · ติดตั้งผ่าน `uv sync` (ไฟล์ `pyproject.toml` ใช้ pin ชุดเดียวกัน) หรือ pip ด้วยไฟล์นี้

## ตรวจคุณภาพสื่อ (ผู้ดูแล repo)

```bash
scripts/check_materials.sh
```

ตรวจทุกอย่างในคำสั่งเดียว: flake8 ทุก notebook (ผ่าน nbqa) + execute โน้ตบุ๊กของทุกโมดูล
ใน env สะอาดจาก `uv.lock` — ทุกโมดูลรัน offline ได้ทั้งหมด (คอร์สนี้ไม่มีโมดูล GPU)

## ก่อนวันอบรม — checklist

- [ ] **เครื่องทดสอบ** — ลองตั้งแต่เครื่องจริง 1 เครื่องของห้อง: `setup.ps1` → `smoke_test.py` ต้องขึ้น PASS → เปิด `uv run jupyter lab` ได้
- [ ] **เครื่องผู้สอน** — รัน `scripts/check_materials.sh` ผ่านก่อนวันสอน
- [ ] **ชุดข้อมูล** — อยู่ใน `datasets/` พร้อม citation ครบ (ดู `datasets/README.md`)
- [ ] **Internet ในห้อง** — ไม่จำเป็นระหว่างสอน (ทุกอย่าง offline ได้) แต่มีไว้ช่วยผู้เรียนที่ติดตั้งไม่เสร็จ

## เปิดโน้ตบุ๊ก

```bash
uv run jupyter lab
```

(หรือ `jupyter lab` จาก environment ที่ติดตั้งแล้ว) — รันเซลล์ตามลำดับจากบนลงล่างด้วย Shift+Enter

## ข้อมูล

ทุกชุดข้อมูลอยู่ใน `datasets/` พร้อมที่มาและ license — ดู `datasets/README.md`
และ citation ที่เซลล์แรกของทุกโน้ตบุ๊กที่ใช้งาน

## การส่งงาน

- **แล็บ (M1–M7):** ทำใน `exercise.ipynb` — ผู้สอนเช็คความคืบหน้าในห้อง ไม่ต้องส่งไฟล์
- **Mini Project (M8):** นำเสนอในห้องวันที่ 2 + ส่งโน้ตบุ๊กผ่าน LMS ภายใน 1 สัปดาห์
