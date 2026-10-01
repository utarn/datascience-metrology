# function.md — Module M3: ฟังก์ชันที่ใช้ในโมดูลนี้ (เฉพาะฟังก์ชันใหม่)

ไว้เปิดคู่กับ `book.ipynb` ขณะทำ `exercise.ipynb` — จัดกลุ่มกลุ่มละ 1–3 ฟังก์ชัน
พร้อม prompt สำหรับสร้างภาพประกอบ (ภาพอยู่ที่ `figures/` ของโมดูล)

> **กฎของไฟล์นี้:** ระบุเฉพาะฟังก์ชันที่**เพิ่งเจอครั้งแรกในโมดูลนี้** —
> ฟังก์ชันที่ M1–M2 สอนไปแล้วไม่ซ้ำที่นี่ ผู้เรียนต้องจำจากโมดูลก่อนหน้าให้ได้
> (ถ้าลืม ย้อนไปดู `function.md` ของโมดูลนั้น)

**สมมติว่าจำได้จาก M1–M2 แล้ว (ใช้ใน book แต่ไม่อธิบายซ้ำ):**
`pd.read_csv()` · `.head()` · `.shape` · เลือกคอลัมน์ `df["col"]` /
`df[["a", "b"]]` · กรองด้วยเงื่อนไข boolean · `.sort_values()` ·
`.groupby().agg()` · f-string · `pathlib.Path`

---

## กลุ่มที่ 1 — ค่าว่างมาตรฐาน: `np.nan` + `.replace()`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `np.nan` | ค่าว่างมาตรฐานของ numpy/pandas ("Not a Number") — ไม่ใช่ข้อความว่าง |
| `.replace(old, new)` | เปลี่ยนค่าในตาราง เช่นค่าปลอม `"?"` → `NaN` |

```python
adult = adult.replace("?", np.nan)   # "?" ทั้งตารางกลายเป็นค่าว่างจริง
```

**ภาพ:** `figures/m3-g1-replace-nan.png`

> Prompt: `Flat instructional diagram, white background, beginner data-science
> style. Left: small 5x4 spreadsheet table, three cells contain a red question
> mark symbol "?". A thick arrow pointing right labeled "replace("?", np.nan)".
> Right: the same table but the question-mark cells are now empty grey cells
> labeled "NaN". Soft pastel colors, rounded rectangles, Thai labels above the
> tables reading "ก่อน" and "หลัง". Clean, minimal, no photorealism.`

---

## กลุ่มที่ 2 — ตรวจค่าว่าง: `.isna()` + `.sum()` / `.mean()`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `.isna()` | ตารางค่าความจริง: ช่องไหนว่าง → `True` |
| `.isna().sum()` | นับจำนวนค่าว่างต่อคอลัมน์ |
| `.isna().mean()` | สัดส่วนค่าว่างต่อคอลัมน์ (0.0–1.0) |

```python
adult.isna().sum()     # คอลัมน์ไหนหายกี่แถว
adult.isna().mean()    # หายกี่เปอร์เซ็นต์
```

**ภาพ:** `figures/m3-g2-isna.png`

> Prompt: `Flat instructional diagram, white background. Center: a 5x4
> spreadsheet where two cells are highlighted light grey (missing values).
> Below it, two small result bars: one labeled "isna().sum()" showing a
> one-row table of counts (e.g. 0, 0, 2, 0), one labeled "isna().mean()"
> showing percentages (e.g. 0%, 0%, 40%, 0%). Arrows from the table down to
> each result. Minimal, rounded rectangles, Thai labels, no photorealism.`

---

## กลุ่มที่ 3 — ตัดแถวค่าหาย: `.dropna()`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `.dropna(subset=[...])` | ตัด**แถว**ที่คอลัมน์ที่ระบุมีค่าว่างทิ้งทั้งแถว |

```python
adult_drop = adult.dropna(subset=["workclass", "occupation"])
```

**ภาพ:** `figures/m3-g3-dropna.png`

> Prompt: `Flat instructional diagram, white background. Left: 6-row
> spreadsheet, rows 2 and 5 have a grey empty cell in the "workclass" column,
> those two rows tinted light red with a small scissors icon. Arrow to the
> right labeled "dropna(subset=[...])". Right: same table with only 4 rows,
> the kept rows tinted light green. Thai caption "ตัดทิ้ง = เสียข้อมูลบางส่วน".
> Minimal, no photorealism.`

---

## กลุ่มที่ 4 — เติมค่าว่าง: `.mode()` + `.fillna()`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `.mode()` | ค่าที่พบบ่อยที่สุดของคอลัมน์ |
| `.fillna(value)` | เติมช่องว่างด้วยค่าที่กำหนด |

```python
adult_fill["workclass"] = adult_fill["workclass"].fillna(
    adult_fill["workclass"].mode()[0])   # เติมด้วยค่าที่พบบ่อยสุด
```

**ภาพ:** `figures/m3-g4-fillna.png`

> Prompt: `Flat instructional diagram, white background. Left: 5-row
> spreadsheet with 2 grey empty cells in a column "workclass". Above it, a
> small bar chart showing one bar clearly tallest labeled "mode() = Private".
> Arrow to the right labeled "fillna(mode)". Right: same table, the empty
> cells now filled with the text "Private" highlighted yellow. Thai caption
> "เติม = สร้างสมมติฐาน". Minimal, no photorealism.`

---

## กลุ่มที่ 5 — ข้อความกลายเป็นตัวเลข: `.str.extract()` + `.astype()`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `.str.extract(pattern)` | สกัดข้อความที่ตรง regular expression ออกมาเป็นคอลัมน์ใหม่ |
| `.astype(type)` | แปลงชนิดข้อมูลคอลัมน์ เช่น ข้อความ → ตัวเลข `float` |

```python
coffee["altitude_m"] = (
    coffee["Altitude"].astype("string")
    .str.extract(r"(\d+\.?\d*)").astype(float)   # "1450 msnm" -> 1450.0
)
```

**ภาพ:** `figures/m3-g5-extract.png`

> Prompt: `Flat instructional diagram, white background. A single column of
> text values: "1450 msnm", "1000 meters", "1200 - 1500", "900 m". Each value
> has the numeric part highlighted in blue and the unit part greyed out.
> Arrow right labeled "str.extract + astype(float)". Result: a column of
> plain numbers 1450.0, 1000.0, 1200.0, 900.0. Thai caption "ข้อความ ->
> ตัวเลข". Minimal, no photorealism.`

---

## กลุ่มที่ 6 — นับหมวดหมู่: `.value_counts()`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `.value_counts()` | นับจำนวนแถวต่อค่าที่ไม่ซ้ำ เรียงจากมากไปน้อย — ใช้หา "พี่น้องสะกดเพี้ยน" |

```python
vc = coffee["Variety"].value_counts()
vc[vc < 15]   # กลุ่มเล็ก ๆ ที่ซ่อนคนสะกดเพี้ยน
```

**ภาพ:** `figures/m3-g6-value-counts.png`

> Prompt: `Flat instructional diagram, white background. Left: one column of
> category text values (coffee variety names, with near-duplicate spellings
> like "Colombia" and "V. Colombia" highlighted in orange). Arrow right
> labeled "value_counts()". Right: a horizontal bar chart of counts per
> unique name, the near-duplicates' bars both small and circled in orange.
> Thai caption "ค่าเดียวกันหรือคนละค่า?". Minimal, no photorealism.`

---

## กลุ่มที่ 7 — แถวซ้ำ: `.duplicated()` + `.drop_duplicates()`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `.duplicated(subset=...)` | ตารางความจริง: แถวไหนซ้ำกับแถวก่อนหน้า → `True` |
| `.drop_duplicates(subset=...)` | ลบแถวซ้ำ เหลือแถวแรกของแต่ละกลุ่ม |

```python
dupes = coffee.duplicated(subset=content_cols, keep=False)
coffee = coffee.drop_duplicates(subset=content_cols, keep="first")
```

**ภาพ:** `figures/m3-g7-duplicates.png`

> Prompt: `Flat instructional diagram, white background. Left: 6-row
> spreadsheet where rows 3 and 5 are identical copies of row 1 (same content,
> different row id), tinted light orange with a small "copy" icon. Arrow
> right labeled "drop_duplicates(keep=first)". Right: 4-row table, one copy
> kept (green), duplicates gone. Thai caption "เก็บไว้ 1 แถว". Minimal, no
> photorealism.`

---

## กลุ่มที่ 8 — แกะตารางกว้าง: `.melt()`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `.melt(id_vars=..., var_name=..., value_name=...)` | แปลงตารางกว้าง (1 คอลัมน์ต่อจุดวัด) เป็นตารางยาว (1 แถวต่อการวัด) |

```python
long = data.melt(id_vars=data.columns[0],
                 var_name="date_raw", value_name="pm25")
```

**ภาพ:** `figures/m3-g8-melt.png`

> Prompt: `Flat instructional diagram, white background. Left: a wide
> spreadsheet, first column "Date", then 5 columns of station codes
> ("54T", "27T", ...) each holding one number per row. A folding arrow
> animation-style sweep to the right labeled "melt()". Right: a tall narrow
> 3-column table: Date | station | pm25, with many rows (same dates repeated,
> one row per station). Thai caption "กว้าง -> ยาว". Minimal, no photorealism.`

---

## กลุ่มที่ 9 — ข้อความกลายเป็นวันที่: `pd.to_datetime()`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `pd.to_datetime(col, format=..., errors="coerce")` | แปลงข้อความเป็นวันที่จริงตาม `format` ที่กำหนด; `errors="coerce"` = วันที่แปลกกลายเป็น `NaT` แทนการพังทั้งโปรแกรม |

```python
long["date"] = pd.to_datetime(
    long["date_raw"], format="%m/%d/%Y", errors="coerce")
```

**ภาพ:** `figures/m3-g9-to-datetime.png`

> Prompt: `Flat instructional diagram, white background. Left: column of
> text strings "1/5/2554", "1/6/2554", "note", "1/8/2554" (format M/D/YYYY).
> Arrow right labeled "pd.to_datetime(format=..., errors=coerce)". Right:
> column of calendar icons with dates "2011-01-05", "2011-01-06", one cell
> greyed with "NaT" and a small warning icon, "2011-01-08". Thai caption
> "วันที่แปลก ไม่พัง แต่ถูกทำเครื่องหมาย". Minimal, no photorealism.`

---

## กลุ่มที่ 10 — กราฟแรกด้วย Matplotlib: `plt.subplots()` + `.plot.barh()`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `plt.subplots(figsize=...)` | สร้างพื้นที่วาดกราฟ (figure + axes) |
| `series.plot.barh(ax=...)` | วาดกราฟแท่งแนวนอนจาก Series |
| `plt.show()` | แสดงกราฟออกจอ |

```python
fig, ax = plt.subplots(figsize=(7, 2.6))
miss.plot.barh(ax=ax, color="#e07a5f")
ax.set_title("สัดส่วนค่าหายต่อคอลัมน์")
plt.show()
```

**ภาพ:** `figures/m3-g10-matplotlib.png`

> Prompt: `Flat instructional diagram, white background. Left: a small
> one-row table of proportions (column names + fractions). Arrow right
> labeled "plot.barh()". Right: a horizontal bar chart with 3 bars of
> different lengths, one bar much longer than the others, title text on top,
> x-axis label below. Thai caption "สัดส่วนค่าหาย". Minimal, no photorealism.`

---

*หมายเหตุ: ภาพทั้ง 10 ยังไม่ถูกสร้าง — ผู้จัดทำสื่อใช้ prompt ข้างบนสร้างภาพ
แล้ววางไฟล์ตามชื่อที่ระบุใน `figures/` ของโมดูลนี้*
