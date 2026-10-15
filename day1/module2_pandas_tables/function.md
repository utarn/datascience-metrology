# function.md — Module M2: ฟังก์ชันที่ใช้ในโมดูลนี้ (เฉพาะฟังก์ชันใหม่)

ไว้เปิดคู่กับ `book.ipynb` ขณะทำ `exercise.ipynb` — จัดกลุ่มกลุ่มละ 1–3 ฟังก์ชัน
พร้อม prompt สำหรับสร้างภาพประกอบ (ภาพอยู่ที่ `figures/` ของโมดูล)

> **กฎของไฟล์นี้:** ระบุเฉพาะฟังก์ชันที่**เพิ่งเจอครั้งแรกในโมดูลนี้** —
> ฟังก์ชันที่ M1 สอนไปแล้วไม่ซ้ำที่นี่ ผู้เรียนต้องจำจากโมดูลก่อนหน้าให้ได้
> (ถ้าลืม ย้อนไปดู `function.md` ของโมดูลนั้น)

**สมมติว่าจำได้จาก M1 แล้ว (ใช้ใน book แต่ไม่อธิบายซ้ำ):**
`print()` · ตัวแปร + ชนิดข้อมูล 4 ชนิด · f-string (รวม `:,` / `.1f`) ·
`list` + `len()` + ชี้ตำแหน่ง + `.append()` + `sum()` · `dict` · `for` สะสม
ค่า · `if`/`else` · `def` + `return` · `round()` · `pathlib.Path`
(ฟังก์ชันช่วย `repo_root()` เป็น boilerplate ให้ copy ได้ ไม่ต้องจำ)

---

## กลุ่มที่ 1 — เปิดไฟล์ตาราง: `pd.read_csv()`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `pd.read_csv(ที่อยู่ไฟล์)` | อ่านไฟล์ CSV กลายเป็นตาราง (DataFrame) — รับ `Path` จาก M1 ตรง ๆ |

```python
import pandas as pd

gap = pd.read_csv(DATA / "gapminder" / "gapminderDataFiveYear.csv")
```

**ภาพ:** `figures/m2-g1-read-csv.png`

> Prompt: `Flat instructional diagram, white background. Left: a CSV file
> card with visible comma-separated text lines. An arrow labeled
> "pd.read_csv()" pointing right. Right: the same data rendered as a neat
> grid table with highlighted header row. Thai caption "ไฟล์ข้อความ ->
> ตารางที่คำนวณได้". Soft pastel colors, rounded rectangles, minimal, no
> photorealism.`
> เขียนคำอธิบายสั้นๆ ที่เข้าใจง่ายสำหรับแต่ละฟังก์ชัน พร้อมตัวอย่างการเรียกใช้ และอธิบายพารามิเตอร์ที่ใช้ในฟังก์ชันนั้น ๆ ให้ชัดเจน พร้อมคำอธิบายภาพประกอบ (image prompt) สำหรับสร้างภาพประกอบการสอนแบบ infographic style (flat vector, plain white background, muted colors, clean sans-serif labels, no photorealism, no 3D, no gradients)

---

## กลุ่มที่ 2 — ตรวจตาราง: `.head()` + `.shape` + `.info()`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `.head()` | แสดง 5 แถวแรก — เปิดฝาตารางดูก่อนเสมอ |
| `.shape` | มิติตาราง (จำนวนแถว, จำนวนคอลัมน์) — เป็นคุณสมบัติ ไม่ใช่คำสั่ง (ไม่มีวงเล็บ) |
| `.info()` | สรุปทุกคอลัมน์: ชื่อ · จำนวนค่าที่ไม่ว่าง · ชนิดข้อมูล |

```python
gap.head()
gap.shape        # (1704, 6)
gap.info()
```

**ภาพ:** `figures/m2-g2-inspect.png`

> Prompt: `Flat instructional diagram, white background. Center: one grid
> table. Three arrows to three result cards: a small 5-row preview labeled
> "head()", a text badge "1704 x 6" labeled "shape", and a vertical list of
> column summaries labeled "info()". Thai captions "แถวแรก" "มิติตาราง"
> "ทุกคอลัมน์". Minimal, no photorealism.`
> เขียนคำอธิบายสั้นๆ ที่เข้าใจง่ายสำหรับแต่ละฟังก์ชัน พร้อมตัวอย่างการเรียกใช้ และอธิบายพารามิเตอร์ที่ใช้ในฟังก์ชันนั้น ๆ ให้ชัดเจน พร้อมคำอธิบายภาพประกอบ (image prompt) สำหรับสร้างภาพประกอบการสอนแบบ infographic style (flat vector, plain white background, muted colors, clean sans-serif labels, no photorealism, no 3D, no gradients)

---

## กลุ่มที่ 3 — เลือกและสร้างคอลัมน์: `df["col"]` / `df[["a", "b"]]`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `df["col"]` | ดึงคอลัมน์เดียว — ได้ Series (วงเล็บเดียว) |
| `df[["a", "b"]]` | ดึงหลายคอลัมน์ — ได้ DataFrame (**วงเล็บซ้อน** ข้างในคือ list) |
| `df["new"] = ...` | สร้างคอลัมน์ใหม่จากคอลัมน์เดิม เหมือนสร้างตัวแปร |

```python
gap[["country", "year", "lifeExp"]].head()
gap["gdp_total"] = gap["gdpPercap"] * gap["pop"]
```

**ภาพ:** `figures/m2-g3-columns.png`

> Prompt: `Flat instructional diagram, white background. A wide table on the
> left; two arrows: one taking a single highlighted column labeled
> 'df["col"]' to a thin single strip (Series), one taking two highlighted
> columns labeled 'df[["a","b"]]' to a small two-column table (DataFrame).
> Below, an empty new column being filled by a formula arrow. Thai captions.
> Minimal, no photorealism.`
> เขียนคำอธิบายสั้นๆ ที่เข้าใจง่ายสำหรับแต่ละฟังก์ชัน พร้อมตัวอย่างการเรียกใช้ และอธิบายพารามิเตอร์ที่ใช้ในฟังก์ชันนั้น ๆ ให้ชัดเจน พร้อมคำอธิบายภาพประกอบ (image prompt) สำหรับสร้างภาพประกอบการสอนแบบ infographic style (flat vector, plain white background, muted colors, clean sans-serif labels, no photorealism, no 3D, no gradients)

---

## กลุ่มที่ 4 — กรองแถวด้วยเงื่อนไข: mask + `&` / `|`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `df["col"] == ค่า` | เงื่อนไข: ได้ True/False ต่อแถว (ยังมี `>`, `<`, `>=`, `!=`) |
| `df[mask]` | ใส่เงื่อนไขในวงเล็บเหลี่ยม — เหลือเฉพาะแถวที่ `True` |
| `(เงื่อนไข) & (เงื่อนไข)` / `\|` | รวมหลายเงื่อนไข: และ / หรือ — **วงเล็บห้ามลืม** |

```python
mask = gap["year"] == 2007
gap_2007 = gap[mask]
rich = gap[(gap["year"] == 2007) & (gap["lifeExp"] > 75)]
```

**ภาพ:** `figures/m2-g4-filter.png`

> Prompt: `Flat instructional diagram, white background. A 6-row table beside
> a column of toggle switches (two green True, four grey False), arrows from
> the green switches to a small result table with only 2 rows. A second
> mini-scene showing two conditions joined by "&" each wrapped in round
> brackets. Thai caption "สวิตช์ต่อแถว — เปิดเท่านั้นที่ผ่าน". Minimal,
> no photorealism.`
> เขียนคำอธิบายสั้นๆ ที่เข้าใจง่ายสำหรับแต่ละฟังก์ชัน พร้อมตัวอย่างการเรียกใช้ และอธิบายพารามิเตอร์ที่ใช้ในฟังก์ชันนั้น ๆ ให้ชัดเจน พร้อมคำอธิบายภาพประกอบ (image prompt) สำหรับสร้างภาพประกอบการสอนแบบ infographic style (flat vector, plain white background, muted colors, clean sans-serif labels, no photorealism, no 3D, no gradients)

---

## กลุ่มที่ 5 — จัดอันดับ: `.sort_values()`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `.sort_values(col, ascending=...)` | เรียงแถวตามคอลัมน์ — `ascending=False` = มากไปน้อย |

```python
rich_2007.sort_values("gdpPercap", ascending=False).head()
```

**ภาพ:** `figures/m2-g5-sort.png`

> Prompt: `Flat instructional diagram, white background. Left: a table with
> rows in messy order, a numeric column highlighted. Arrow right labeled
> "sort_values(ascending=False)". Right: same table sorted descending, top
> row highlighted as the maximum, with a small "1st" medal icon. Thai
> caption "จัดอันดับในบรรทัดเดียว". Minimal, no photorealism.`
> เขียนคำอธิบายสั้นๆ ที่เข้าใจง่ายสำหรับแต่ละฟังก์ชัน พร้อมตัวอย่างการเรียกใช้ และอธิบายพารามิเตอร์ที่ใช้ในฟังก์ชันนั้น ๆ ให้ชัดเจน พร้อมคำอธิบายภาพประกอบ (image prompt) สำหรับสร้างภาพประกอบการสอนแบบ infographic style (flat vector, plain white background, muted colors, clean sans-serif labels, no photorealism, no 3D, no gradients)

---

## กลุ่มที่ 6 — สรุปต่อกลุ่ม: `.groupby()` + `.agg()`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `.groupby(col)` | แบ่งแถวเป็นกลุ่มตามค่าคอลัมน์ (แบ่งกลุ่ม) |
| `.agg(ชื่อ=("col", "mean"))` | คำนวณต่อกลุ่มแล้วรวมกลับเป็นตารางสรุป — `"mean"`/`"size"`/`"max"`/`"min"`/`"sum"` |

```python
gap_2007.groupby("continent").agg(
    n_countries=("country", "size"),
    mean_life=("lifeExp", "mean"),
)
```

**ภาพ:** `figures/m2-g6-groupby.png`

> Prompt: `Flat diagram: one big spreadsheet splitting into four colored
> piles by group label, each pile through the same calculator machine,
> results reassembled into a small summary table with group/count/mean
> columns. Thai caption "แบ่งกลุ่ม คำนวณ รวมกลับ". Minimal, no photorealism.`
> เขียนคำอธิบายสั้นๆ ที่เข้าใจง่ายสำหรับแต่ละฟังก์ชัน พร้อมตัวอย่างการเรียกใช้ และอธิบายพารามิเตอร์ที่ใช้ในฟังก์ชันนั้น ๆ ให้ชัดเจน พร้อมคำอธิบายภาพประกอบ (image prompt) สำหรับสร้างภาพประกอบการสอนแบบ infographic style (flat vector, plain white background, muted colors, clean sans-serif labels, no photorealism, no 3D, no gradients)

---

## กลุ่มที่ 7 — รวมหลายไฟล์: `pd.concat()`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `pd.concat([df_a, df_b], ignore_index=True)` | วางตารางต่อแถวท้ายกัน — `ignore_index=True` ทำเลขแถวใหม่ไม่ซ้ำ |

```python
coffee = pd.concat([arabica, robusta], ignore_index=True)
```

**ภาพ:** `figures/m2-g7-concat.png`

> Prompt: `Flat diagram: two stacked tables (labeled A on top, B below) being
> joined by a downward arrow into one long table with fresh row numbers on
> the left edge highlighted; a few grey empty cells in some columns circled
> with a question mark. Thai caption "ต่อท้ายกัน แล้วเลขแถวใหม่". Minimal,
> no photorealism.`
> เขียนคำอธิบายสั้นๆ ที่เข้าใจง่ายสำหรับแต่ละฟังก์ชัน พร้อมตัวอย่างการเรียกใช้ และอธิบายพารามิเตอร์ที่ใช้ในฟังก์ชันนั้น ๆ ให้ชัดเจน พร้อมคำอธิบายภาพประกอบ (image prompt) สำหรับสร้างภาพประกอบการสอนแบบ infographic style (flat vector, plain white background, muted colors, clean sans-serif labels, no photorealism, no 3D, no gradients)

---

## กลุ่มที่ 8 — Excel เข้า-ออก: `pd.read_excel()` + `.to_excel()`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `pd.read_excel(ที่อยู่ไฟล์)` | อ่านไฟล์ `.xlsx` เป็น DataFrame (ผ่าน openpyxl) |
| `df.to_excel(ที่อยู่ไฟล์, index=False)` | บันทึก DataFrame ออกเป็นไฟล์ Excel |

```python
top10.to_excel(xlsx, index=False)
back = pd.read_excel(xlsx)
```

**ภาพ:** `figures/m2-g8-excel.png`

> Prompt: `Flat diagram: two doors side by side labeled "in" and "out"; a
> green Excel file icon walking in through one door becoming a table, and a
> table walking out the other door becoming an Excel file icon. Thai caption
> "Excel เข้าออกประตูเดียวกับ CSV". Minimal, no photorealism.`
> เขียนคำอธิบายสั้นๆ ที่เข้าใจง่ายสำหรับแต่ละฟังก์ชัน พร้อมตัวอย่างการเรียกใช้ และอธิบายพารามิเตอร์ที่ใช้ในฟังก์ชันนั้น ๆ ให้ชัดเจน พร้อมคำอธิบายภาพประกอบ (image prompt) สำหรับสร้างภาพประกอบการสอนแบบ infographic style (flat vector, plain white background, muted colors, clean sans-serif labels, no photorealism, no 3D, no gradients)

---

*หมายเหตุ: ภาพทั้ง 8 ยังไม่ถูกสร้าง — ผู้จัดทำสื่อใช้ prompt ข้างบนสร้างภาพ
แล้ววางไฟล์ตามชื่อที่ระบุใน `figures/` ของโมดูลนี้*

*ฟังก์ชันที่โมดูลถัดไป (M3) จะนำเสนอเป็น "ของใหม่" — `np.nan` · `.replace()`
· `.isna()` · `.dropna()` · `.fillna()` · `.value_counts()` · `.melt()` ·
`pd.to_datetime()` ฯลฯ — M2 จึงไม่ใช้ใน book เพื่อคงกฎ "ใหม่ครั้งแรกที่โมดูล
ของมัน"*
