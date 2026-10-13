# function.md — Module M7: ฟังก์ชันที่ใช้ในโมดูลนี้ (เฉพาะฟังก์ชันใหม่)

ไว้เปิดคู่กับ `book.ipynb` ขณะทำ `exercise.ipynb` — จัดกลุ่มกลุ่มละ 1–3 ฟังก์ชัน
พร้อม prompt สำหรับสร้างภาพประกอบ (ภาพอยู่ที่ `figures/` ของโมดูล)

> **กฎของไฟล์นี้:** ระบุเฉพาะฟังก์ชันที่**เพิ่งเจอครั้งแรกในโมดูลนี้** —
> ฟังก์ชันที่ M1–M6 สอนไปแล้วไม่ซ้ำที่นี่ ผู้เรียนต้องจำจากโมดูลก่อนหน้าให้ได้
> (ถ้าลืม ย้อนไปดู `function.md` ของโมดูลนั้น)

**สมมติว่าจำได้จาก M1–M6 แล้ว (ใช้ใน book แต่ไม่อธิบายซ้ำ):**
`for` + f-string (ตั้งชื่อไฟล์) · `pathlib.Path` + `p / "ชื่อ"` ·
`pd.read_csv()`/`pd.read_excel()` · `.groupby().agg()` · `pd.concat() ·
`.to_excel()` · `plt.savefig()` · `.loc[mask, "col"]` · `.value_counts()` ·
`.plot.hist()`/`ax.plot()` · `pd.to_datetime()`

---

## กลุ่มที่ 1 — ชิ้นส่วนของวันที่: `.dt`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `df["date"].dt.month` | ดึงเดือน (1–12) จากคอลัมน์ datetime — ใช้ groupby รายเดือนได้ทันที |
| `df["date"].dt.year` | ดึงปี — แบบเดียวกันกับ `.dt.day`, `.dt.weekday` |

```python
pm25["month"] = pm25["date"].dt.month
```

**ภาพ:** `figures/m7-g1-dt.png`

> Prompt: `Flat instructional diagram, white background. A column of
> calendar icons each labeled with a full date; an arrow right labeled
> "dt.month" pointing to a column of month numbers (1, 1, 2, 2, 3...);
> a second faded arrow labeled "dt.year / dt.day" fanning out to ghost
> columns. Thai caption "วันที่ แตกออกได้". Minimal, rounded rectangles,
> no photorealism.`

---

## กลุ่มที่ 2 — วนกลุ่ม: `for ชื่อ, กลุ่ม in df.groupby(col)`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `for code, group in df.groupby(col):` | `groupby` ให้**คู่ทั้งคู่**ทีละกลุ่ม: ชื่อกลุ่ม + แถวของกลุ่มนั้น — รากฐานของงานอัตโนมัติทุกชนิด |

```python
for code, group in pm25.groupby("station_code"):
    summary = group.groupby("month").agg(...)
```

**ภาพ:** `figures/m7-g2-loop-groups.png`

> Prompt: `Flat instructional diagram, white background. Left: a wide
> spreadsheet with a station column colored by three distinct groups. A
> conveyor-style arrow labeled "for code, group in groupby" feeding three
> separate small tables on the right, each tagged with its station code
> badge. Thai caption "หนึ่งรอบ = หนึ่งกลุ่มครบแถว". Minimal, no
> photorealism.`

---

## กลุ่มที่ 3 — เขียนออกและสร้างโฟลเดอร์: `.to_csv()` + `.mkdir()`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `df.to_csv(ไฟล์, index=False)` | เขียนตารางออกเป็นไฟล์ CSV — `index=False` = ไม่เขียนเลขแถวไปด้วย |
| `dir.mkdir(exist_ok=True)` | สร้างโฟลเดอร์ถ้ายังไม่มี (มีแล้วไม่พัง) — ทำก่อนเขียนไฟล์เสมอ |

```python
outputs = Path("outputs")
outputs.mkdir(exist_ok=True)
summary.to_csv(outputs / f"station_{code}.csv")
```

**ภาพ:** `figures/m7-g3-to-csv.png`

> Prompt: `Flat instructional diagram, white background. Left: a small
> summary table. Arrow right through a small folder icon labeled "mkdir"
> into a folder containing three CSV file icons, each with a filename badge
> showing a different station code. Thai caption "หนึ่งกลุ่ม = หนึ่งไฟล์".
> Minimal, no photorealism.`

---

## กลุ่มที่ 4 — หาไฟล์: `Path.glob()` + `sorted()`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `Path.glob("station_*.csv")` | ทำรายการไฟล์ที่ตรงแพทเทิร์น (`*` = ชื่ออะไรก็ได้) ในโฟลเดอร์นั้น |
| `sorted(...)` | เรียงรายการที่ได้ให้ชัดเจนเสมอ — ลำดับของ glob เดิมไม่การันตี |

```python
for path in sorted(outputs.glob("station_*.csv")):
    one = pd.read_csv(path)
```

**ภาพ:** `figures/m7-g4-glob.png`

> Prompt: `Flat instructional diagram, white background. A folder icon
> containing many mixed files (CSV, PNG, notes); a flashlight beam with the
> pattern "station_*.csv" selecting only three matching CSV files, sliding
> out into a numbered queue labeled "sorted". Thai caption "กรองไฟล์ตามชื่อ
> แล้วเรียงทีละไฟล์". Minimal, no photorealism.`

---

## กลุ่มที่ 5 — แกะชื่อไฟล์: `.stem` + `.removeprefix()`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `path.stem` | ชื่อไฟล์ไม่รวมนามสกุล (`station_02T.csv` → `station_02T`) |
| `.removeprefix("station_")` | ตัดคำนำหน้าทิ้ง → `02T` — เอาข้อมูลที่ซ่อนในชื่อไฟล์กลับมาเป็นคอลัมน์ |

```python
one["station"] = path.stem.removeprefix("station_")
```

**ภาพ:** `figures/m7-g5-stem.png`

> Prompt: `Flat instructional diagram, white background. A single file icon
> labeled "station_02T.csv" split in three annotated parts: the body
> "station_02T" labeled stem, the suffix ".csv" greyed out, and after an
> arrow the cleaned badge "02T" highlighted yellow. Thai caption "ชื่อไฟล์
> ก็คือข้อมูล". Minimal, no photorealism.`

---

*หมายเหตุ: ภาพทั้ง 5 ยังไม่ถูกสร้าง — ผู้จัดทำสื่อใช้ prompt ข้างบนสร้างภาพ
แล้ววางไฟล์ตามชื่อที่ระบุใน `figures/` ของโมดูลนี้*
