# function.md — Module M5: ฟังก์ชันที่ใช้ในโมดูลนี้ (เฉพาะฟังก์ชันใหม่)

ไว้เปิดคู่กับ `book.ipynb` ขณะทำ `exercise.ipynb` — จัดกลุ่มกลุ่มละ 1–3 ฟังก์ชัน
พร้อม prompt สำหรับสร้างภาพประกอบ (ภาพอยู่ที่ `figures/` ของโมดูล)

> **กฎของไฟล์นี้:** ระบุเฉพาะฟังก์ชันที่**เพิ่งเจอครั้งแรกในโมดูลนี้** —
> ฟังก์ชันที่ M1–M4 สอนไปแล้วไม่ซ้ำที่นี่ ผู้เรียนต้องจำจากโมดูลก่อนหน้าให้ได้
> (ถ้าลืม ย้อนไปดู `function.md` ของโมดูลนั้น)

**สมมติว่าจำได้จาก M1–M4 แล้ว (ใช้ใน book แต่ไม่อธิบายซ้ำ):**
`pd.read_csv()` · `.head()` · `.shape` · เลือกคอลัมน์ `df["col"]` ·
กรองด้วยเงื่อนไข boolean · `.sort_values()` · `.groupby().agg()` (mean/size/
max/min/sum) · f-string · `pathlib.Path` · `np.nan` + `.replace()` ·
`.isna()` · `.dropna(subset=...)` · `.fillna()` · `.value_counts()` ·
`pd.to_datetime()` · `plt.subplots()` + `.plot.barh()` + `plt.show()` +
`ax.set_title()` · `alpha` + `ax.legend()` (จากกราฟ M4)

---

## กลุ่มที่ 1 — สรุปทุกอย่างในคำสั่งเดียว: `.describe()`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `.describe()` | สรุปสถิติมาตรฐานของคอลัมน์ตัวเลข: count · mean · std · min · 25% · 50% · 75% · max |

```python
penguins["body_mass_g"].describe()
```

**ภาพ:** `figures/m5-g1-describe.png`

> Prompt: `Flat instructional diagram, white background. Left: a tall
> spreadsheet column of 12 numeric values. Arrow right labeled "describe()".
> Right: a compact summary card listing rows: count, mean, std, min, 25%,
> 50%, 75%, max with small sample numbers. The 50% row highlighted yellow.
> Minimal, rounded rectangles, Thai labels, no photorealism.`

---

## กลุ่มที่ 2 — ค่ากลาง: `.mean()` + `.median()` + `pd.Series()`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `.mean()` | ค่าเฉลี่ย — ผลรวม ÷ จำนวน (โดนค่าสุดขอบลากได้) |
| `.median()` | ค่ากลาง — เรียงแล้วหยิบตัวกลาง (ทนต่อค่าสุดขอบ) |
| `pd.Series([...])` | แปลง list เป็น Series เพื่อใช้เครื่องมือ pandas กับตัวเลขมือทำ |

```python
sal = pd.Series([25_000, 30_000, 250_000])
print(f"mean = {sal.mean():,.0f}, median = {sal.median():,.0f}")
```

**ภาพ:** `figures/m5-g2-median.png`

> Prompt: `Flat instructional diagram, white background. Seven vertical bars
> of people standing in a line by salary height, six similar medium heights
> and one person far taller on the right. Two arrows: one labeled "mean"
> pointing to a horizontal dashed line floating high above most heads, one
> labeled "median" pointing to the dashed line at the middle person's head.
> Thai caption "ค่าเฉลี่ยโดนลาก / ค่ากลางอยู่กับที่". Minimal, no
> photorealism.`

---

## กลุ่มที่ 3 — การกระจาย: `.std()` + `.quantile()` + IQR

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `.std()` | ความกระจายมาตรฐาน — ระยะเฉลี่ยที่ค่าหลุดจาก mean (หน่วยเดียวกับข้อมูล) |
| `.quantile([0.25, 0.75])` | ค่าที่ตำแหน่ง 25% / 75% ของข้อมูลเรียงแล้ว |

```python
mass = penguins["body_mass_g"]
q1, q3 = mass.quantile([0.25, 0.75])
iqr = q3 - q1   # ช่วงกลาง 50% ของข้อมูล
```

**ภาพ:** `figures/m5-g3-iqr.png`

> Prompt: `Flat instructional diagram, white background. A horizontal number
> line with 12 dots spread across it, the middle 50% of dots inside a
> shaded rounded box labeled "IQR", the outer dots outside the box, small
> end markers labeled "min" and "max". An arrow labeled "std" pointing from
> the center dot outward to a mid-range dot. Thai caption "กลาง 50%".
> Minimal, no photorealism.`

---

## กลุ่มที่ 4 — เลือกแถว + คอลัมน์พร้อมกัน: `.loc[แถว, คอลัมน์]`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `.loc[mask, "col"]` | เลือกแถวตามเงื่อนไข mask และคอลัมน์ที่ต้องการ ในคำสั่งเดียว (แทนสองขั้น `df[mask]["col"]`) |

```python
penguins.loc[penguins["sex"] == "male", "body_mass_g"]
```

**ภาพ:** `figures/m5-g4-loc.png`

> Prompt: `Flat instructional diagram, white background. A 6x4 spreadsheet,
> two rows tinted light blue (matching a condition). Two arrows from the
> selection: one arrow to the left edge labeled "rows (mask)", one arrow to
> the top labeled "column (col)", converging to a small highlighted column
> segment of just the two tinted rows. Thai caption "แถว + คอลัมน์
> พร้อมกัน". Minimal, no photorealism.`

---

## กลุ่มที่ 5 — รูปทรงข้อมูล: `.plot.hist()`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `.plot.hist(bins=n, ax=...)` | วาด histogram — แบ่งค่าเป็น n ถัง นับจำนวนต่อถัง |

```python
fig, ax = plt.subplots(figsize=(7, 3))
penguins["body_mass_g"].plot.hist(bins=30, ax=ax)
penguins.loc[mask, "body_mass_g"].plot.hist(
    bins=30, alpha=0.55, ax=ax, label="female")
ax.legend()
plt.show()
```

**ภาพ:** `figures/m5-g5-hist.png`

> Prompt: `Flat instructional diagram, white background. Left: a histogram
> with a clear two-peak shape drawn as connected bars. Arrow right labeled
> "แยกตามกลุ่ม". Right: the same histogram split into two translucent
> overlapping histograms in coral and blue (alpha blending visible), each
> single-peaked, with a small legend box. Thai caption "สองยอด =
> กลุ่มซ่อนอยู่". Minimal, no photorealism.`

---

## กลุ่มที่ 6 — สถิติเป็นชื่อของการรวม: `"median"` / `"std"` ใน `.agg()`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `.agg(median_g=("col", "median"))` | ใช้ชื่อสถิติใหม่ใน groupby — ชุดเดิมมี mean/size/max/min/sum เพิ่ม median/std ได้ทันที |

```python
penguins.groupby("species").agg(
    median_g=("body_mass_g", "median"),
    std_g=("body_mass_g", "std"),
)
```

**ภาพ:** `figures/m5-g6-agg-names.png`

> Prompt: `Flat instructional diagram, white background. Left: a small
> summary table grouped into three species rows. Arrow right labeled
> "agg(median, std)". Right: same table with two new columns appended, the
> new column headers highlighted: "median_g" and "std_g". Thai caption
> "สถิติใหม่ ชุดเดิม". Minimal, no photorealism.`

---

*หมายเหตุ: ภาพทั้ง 6 ยังไม่ถูกสร้าง — ผู้จัดทำสื่อใช้ prompt ข้างบนสร้างภาพ
แล้ววางไฟล์ตามชื่อที่ระบุใน `figures/` ของโมดูลนี้*
