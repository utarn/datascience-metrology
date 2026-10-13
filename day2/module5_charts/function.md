# function.md — Module M5: ฟังก์ชันที่ใช้ในโมดูลนี้ (เฉพาะฟังก์ชันใหม่)

ไว้เปิดคู่กับ `book.ipynb` ขณะทำ `exercise.ipynb` — จัดกลุ่มกลุ่มละ 1–3 ฟังก์ชัน
พร้อม prompt สำหรับสร้างภาพประกอบ (ภาพอยู่ที่ `figures/` ของโมดูล)

> **กฎของไฟล์นี้:** ระบุเฉพาะฟังก์ชันที่**เพิ่งเจอครั้งแรกในโมดูลนี้** —
> ฟังก์ชันที่ M1–M4 สอนไปแล้วไม่ซ้ำที่นี่ ผู้เรียนต้องจำจากโมดูลก่อนหน้าให้ได้
> (ถ้าลืม ย้อนไปดู `function.md` ของโมดูลนั้น)

**สมมติว่าจำได้จาก M1–M4 แล้ว (ใช้ใน book แต่ไม่อธิบายซ้ำ):**
`pd.read_csv()` · `.shape` · เลือกคอลัมน์ · กรอง boolean mask ·
`.groupby().agg()` · `.plot.hist()` + `alpha` + `ax.legend()` ·
`ax.set_title()` · `plt.subplots()` + `plt.show()` · `.loc[mask, "col"]` ·
`.plot.barh()` · f-string · `pathlib.Path`

---

## กลุ่มที่ 1 — จุดกระจาย: `ax.scatter()`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `ax.scatter(x, y, s=..., alpha=..., color=...)` | วาดจุดกระจาย — ตัวเลข × ตัวเลข ตอบคำถาม "สัมพันธ์กันไหม" · `s` = ขนาดจุด · `alpha` = ความทึบ |

```python
ax.scatter(penguins["flipper_length_mm"], penguins["body_mass_g"],
           s=18, alpha=0.6, color="#457b9d")
```

**ภาพ:** `figures/m5-g1-scatter.png`

> Prompt: `Flat instructional diagram, white background. Left: a 6x4
> spreadsheet with two columns highlighted (x column blue, y column coral).
> Arrow right labeled "scatter(x, y)". Right: a scatter plot of the same
> points trending upward to the right, axes labeled. Thai caption "ตัวเลข
> x ตัวเลข = จุด". Minimal, rounded rectangles, no photorealism.`

---

## กลุ่มที่ 2 — วนคู่ชื่อ–ค่า: `dict.items()` + for สองตัวแปร

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `d.items()` | มอง dict เป็นคู่ (key, value) ไล่ทีละคู่ได้ |
| `for key, value in d.items():` | แตกคู่เข้าสองตัวแปรในลูปเดียว — ชื่อกลุ่มกับสีที่จะใช้ |

```python
colors = {"Adelie": "#e07a5f", "Gentoo": "#457b9d"}
for species_name, color in colors.items():
    print(species_name, color)
```

**ภาพ:** `figures/m5-g2-items.png`

> Prompt: `Flat instructional diagram, white background. Left: a small
> dictionary as two-column table (species name / color swatch), three rows.
> An unrolling arrow labeled "for name, color in .items()" pointing right.
> Right: three loop iterations shown as three small stacked cards each
> carrying one name and its color swatch. Thai caption "หนึ่งรอบ = หนึ่งคู่".
> Minimal, no photorealism.`

---

## กลุ่มที่ 3 — แท่งแนวตั้ง: `.plot.bar()`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `.plot.bar(ax=...)` | วาดกราฟแท่งแนวตั้งจาก Series/ตารางสรุป — เปรียบเทียบกลุ่ม (ต่างจาก barh ที่ M3 สอน: เหมือนกันแค่หมุน 90°) |

```python
means = penguins.groupby("species")["body_mass_g"].mean()
means.plot.bar(ax=ax)
```

**ภาพ:** `figures/m5-g3-bar.png`

> Prompt: `Flat instructional diagram, white background. Left: a 3-row
> summary table (group name + mean value). Arrow right labeled "plot.bar()".
> Right: a vertical bar chart with three bars of clearly different heights,
> y-axis starting at zero, labels under bars. Thai caption "เทียบกลุ่ม =
> แท่ง". Minimal, no photorealism.`

---

## กลุ่มที่ 4 — เส้นตามเวลา: `.plot.line()` + `ax.plot()`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `df.plot.line(x=..., y=..., ax=...)` | วาดเส้นจากคอลัมน์ของ DataFrame — ใช้กับข้อมูลตามเวลา |
| `ax.plot(x, y, label=...)` | วาดเส้นจากค่า x/y แยกกัน — ใช้วนหลายเส้นลงแกนเดียวกัน |

```python
th = gapminder[gapminder["country"] == "Thailand"]
th.plot.line(x="year", y="lifeExp", ax=ax)
ax.plot(one["year"], one["lifeExp"], label="Japan")
```

**ภาพ:** `figures/m5-g4-line.png`

> Prompt: `Flat instructional diagram, white background. Left: a small time
> table (year rows, value column). Arrow right labeled "plot.line". Right:
> a line chart with two lines in different colors rising across a year axis,
> a legend in the corner. Thai caption "เวลา = เส้น". Minimal, no
> photorealism.`

---

## กลุ่มที่ 5 — ป้ายแกน: `ax.set_xlabel()` + `ax.set_ylabel()`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `ax.set_xlabel(ข้อความ)` | ติดป้ายแกนนอน — **ต้องมีหน่วย** เช่น "น้ำหนัก (กรัม)" |
| `ax.set_ylabel(ข้อความ)` | ติดป้ายแกนตั้ง ตามหลักเดียวกัน |

```python
ax.set_xlabel("ความยาวปีก (มม.)")
ax.set_ylabel("น้ำหนัก (กรัม)")
```

**ภาพ:** `figures/m5-g5-labels.png`

> Prompt: `Flat instructional diagram, white background. A scatter plot in
> the center with callout arrows pointing to its x-axis label and y-axis
> label, each callout card showing the label text with a unit in
> parentheses highlighted yellow; a crossed-out version in the corner shows
> an unlabeled axis with a small warning icon. Thai caption "ไม่มีหน่วย =
> ไม่มีความหมาย". Minimal, no photorealism.`

---

## กลุ่มที่ 6 — หลายแผง + ส่งออก: `plt.subplots(1, 2)` + `plt.savefig()`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `plt.subplots(nrows, ncols, figsize=...)` | สร้างหลายแผงในรูปเดียว — ได้กลุ่มแกน `axes` ชี้ทีละแผงด้วย `axes[0]`, `axes[1]` |
| `plt.savefig(ไฟล์, dpi=..., bbox_inches="tight")` | บันทึกรูปปัจจุบันเป็นไฟล์ PNG — แนบลงรายงานได้ |

```python
fig, axes = plt.subplots(1, 2, figsize=(10, 3.2))
means.plot.bar(ax=axes[0])
plt.savefig("my_chart.png", dpi=150, bbox_inches="tight")
```

**ภาพ:** `figures/m5-g6-subplots-savefig.png`

> Prompt: `Flat instructional diagram, white background. Left: one wide
> frame containing two side-by-side chart panels labeled [0] and [1].
> Arrow right labeled "savefig()". Right: the same two-panel figure being
> exported into a PNG file icon with a down-arrow. Thai caption "ภาพเดียว
> สองแผง -> ไฟล์เดียว". Minimal, no photorealism.`

---

*หมายเหตุ: ภาพทั้ง 6 ยังไม่ถูกสร้าง — ผู้จัดทำสื่อใช้ prompt ข้างบนสร้างภาพ
แล้ววางไฟล์ตามชื่อที่ระบุใน `figures/` ของโมดูลนี้*
