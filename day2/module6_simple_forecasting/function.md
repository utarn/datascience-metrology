# function.md — Module M6: ฟังก์ชันที่ใช้ในโมดูลนี้ (เฉพาะฟังก์ชันใหม่)

ไว้เปิดคู่กับ `book.ipynb` ขณะทำ `exercise.ipynb` — จัดกลุ่มกลุ่มละ 1–3 ฟังก์ชัน
พร้อม prompt สำหรับสร้างภาพประกอบ (ภาพอยู่ที่ `figures/` ของโมดูล)

> **กฎของไฟล์นี้:** ระบุเฉพาะฟังก์ชันที่**เพิ่งเจอครั้งแรกในโมดูลนี้** —
> ฟังก์ชันที่ M1–M5 สอนไปแล้วไม่ซ้ำที่นี่ ผู้เรียนต้องจำจากโมดูลก่อนหน้าให้ได้
> (ถ้าลืม ย้อนไปดู `function.md` ของโมดูลนั้น)

**สมมติว่าจำได้จาก M1–M5 แล้ว (ใช้ใน book แต่ไม่อธิบายซ้ำ):**
`pd.read_csv(skiprows=...)` · `pd.to_datetime(col, format=..., errors=...)` ·
`.iloc[ช่วง]` · กรอง boolean mask · `.groupby().agg()`/`groupby()["col"].sum()` ·
`.mean()`/`.median()`/`.std()` · `ax.plot(x, y, label=...)` ·
`.plot.line(x=, y=)` · `ax.legend()` · `ax.set_xlabel/set_ylabel` ·
`plt.subplots()` · f-string · `pathlib.Path`

---

## กลุ่มที่ 1 — เฉลี่ยเลื่อน: `.rolling(n).mean()`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `.rolling(n)` | มองย้อน n จุดจากตำแหน่งปัจจุบัน (หน้าต่างเลื่อน) |
| `.rolling(n).mean()` | เฉลี่ยค่าในหน้าต่าง — กรองเสียงรบกวนให้เห็นทิศทาง (จุดแรก ๆ ไม่ครบ n ค่า → `NaN`) |

```python
co2["ma12"] = co2["average"].rolling(12).mean()
```

**ภาพ:** `figures/m6-g1-rolling.png`

> Prompt: `Flat instructional diagram, white background. A jagged noisy time
> series of small dots; a sliding window rectangle covering 7 consecutive
> dots with a thick smooth line drawn at the window center showing the
> averaged value; the window shown again shifted a few steps right with the
> smooth line extended. Thai caption "หน้าต่างเลื่อน = เส้นเรียบ". Minimal,
> rounded rectangles, no photorealism.`
> เขียนคำอธิบายสั้นๆ ที่เข้าใจง่ายสำหรับแต่ละฟังก์ชัน พร้อมตัวอย่างการเรียกใช้ และอธิบายพารามิเตอร์ที่ใช้ในฟังก์ชันนั้น ๆ ให้ชัดเจน พร้อมคำอธิบายภาพประกอบ (image prompt) สำหรับสร้างภาพประกอบการสอนแบบ infographic style (flat vector, plain white background, muted colors, clean sans-serif labels, no photorealism, no 3D, no gradients)

---

## กลุ่มที่ 2 — เส้นตรงพอดีข้อมูล: `np.polyfit()` + `np.polyval()`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `np.polyfit(x, y, 1)` | หาสมการเส้นตรง `y = a + b·x` ที่พอดีข้อมูลมากที่สุด — ได้ `b` (ความชัน) กับ `a` (ตัดแกน) |
| `np.polyval([b, a], x)` | คำนวณค่า y ตามสมการ — ใช้วาดเส้น/ทำนายจุดใหม่ |

```python
slope, intercept = np.polyfit(co2["decimal"], co2["average"], 1)
trend = np.polyval([slope, intercept], co2["decimal"])
```

**ภาพ:** `figures/m6-g2-polyfit.png`

> Prompt: `Flat instructional diagram, white background. A scatter of dots
> trending upward with a straight red line passing through them; three thin
> ghost lines (slightly different angles) faded out around it showing other
> candidate fits; a callout card next to the best line showing "y = a + b*x"
> with the slope term highlighted. Thai caption "เส้นตรงที่พอดีที่สุด".
> Minimal, no photorealism.`
> เขียนคำอธิบายสั้นๆ ที่เข้าใจง่ายสำหรับแต่ละฟังก์ชัน พร้อมตัวอย่างการเรียกใช้ และอธิบายพารามิเตอร์ที่ใช้ในฟังก์ชันนั้น ๆ ให้ชัดเจน พร้อมคำอธิบายภาพประกอบ (image prompt) สำหรับสร้างภาพประกอบการสอนแบบ infographic style (flat vector, plain white background, muted colors, clean sans-serif labels, no photorealism, no 3D, no gradients)

---

## กลุ่มที่ 3 — สร้างวันที่: `pd.to_datetime(dict)` + `pd.date_range()`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `pd.to_datetime(dict(year=..., month=..., day=1))` | ประกอบวันที่จากคอลัมน์แยก (year, month) — ได้ datetime จริง ๆ |
| `pd.date_range(เริ่ม, periods=n, freq="MS")` | สร้างลำดับวันที่ n จุดติดกันทุกเดือนต้นเดือน — ใช้เมื่อไฟล์ไม่มีคอลัมน์วันที่เลย |

```python
co2["date"] = pd.to_datetime(
    dict(year=co2["year"], month=co2["month"], day=1))
air["month"] = pd.date_range("1949-01", periods=len(air), freq="MS")
```

**ภาพ:** `figures/m6-g3-dates.png`

> Prompt: `Flat instructional diagram, white background, two panels side by
> side. Left panel: two columns (year, month) merging through an arrow
> labeled "to_datetime(dict)" into one column of calendar icons. Right
> panel: a single starting calendar icon with a dotted chain of evenly
> spaced calendar icons extending right labeled "date_range, one per month".
> Thai captions "ประกอบ" and "ออกแบบลำดับ". Minimal, no photorealism.`
> เขียนคำอธิบายสั้นๆ ที่เข้าใจง่ายสำหรับแต่ละฟังก์ชัน พร้อมตัวอย่างการเรียกใช้ และอธิบายพารามิเตอร์ที่ใช้ในฟังก์ชันนั้น ๆ ให้ชัดเจน พร้อมคำอธิบายภาพประกอบ (image prompt) สำหรับสร้างภาพประกอบการสอนแบบ infographic style (flat vector, plain white background, muted colors, clean sans-serif labels, no photorealism, no 3D, no gradients)

---

## กลุ่มที่ 4 — เลื่อนเวลาและเลือกช่วงชื่อ: `.shift()` + `.loc[a:b]`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `.shift(12)` | ดันค่าทั้งคอลัมน์ลงไป 12 แถว — แถวบนว่าง → ใช้ทำ "ค่าปีก่อนเดือนเดียวกัน" |
| `.loc[a:b]` | เลือกช่วงตามชื่อ label (ไม่ใช่ตำแหน่งเหมือน `.iloc`) — ครบทั้งปลายสองข้าง |

```python
air["naive"] = air["value"].shift(12)     # ปีก่อนเดือนเดียวกัน
history = yearly.loc[2015:2019]           # ปี 2015 ถึง 2019 เท่านั้น
```

**ภาพ:** `figures/m6-g4-shift.png`

> Prompt: `Flat instructional diagram, white background. A 10-row table of
> monthly values; an arrow showing the whole column pushed down by 3 rows,
> the top 3 cells now empty grey (NaN), values re-aligned against their
> earlier positions; a second small panel showing a year column with rows
> 2015 to 2019 highlighted as a selected block labeled "loc[2015:2019]".
> Thai caption "ดันลง 12 แถว = ค่าปีก่อน". Minimal, no photorealism.`
> เขียนคำอธิบายสั้นๆ ที่เข้าใจง่ายสำหรับแต่ละฟังก์ชัน พร้อมตัวอย่างการเรียกใช้ และอธิบายพารามิเตอร์ที่ใช้ในฟังก์ชันนั้น ๆ ให้ชัดเจน พร้อมคำอธิบายภาพประกอบ (image prompt) สำหรับสร้างภาพประกอบการสอนแบบ infographic style (flat vector, plain white background, muted colors, clean sans-serif labels, no photorealism, no 3D, no gradients)

---

## กลุ่มที่ 5 — ระยะห่างเฉลี่ย: `.abs()` + แบบแผน MAE

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `.abs()` | ตัดเครื่องหมายลบ — ระยะห่างไม่มีลบ |
| `(จริง - ทำนาย).abs().mean()` | **MAE** — พลาดเฉลี่ยกี่หน่วย ตัวเลขเดียวที่ตอบ "เชื่อได้แค่ไหน" |

```python
mae = (test["value"] - pred).abs().mean()
print(f"พลาดเฉลี่ย {mae:.1f} ppm")
```

**ภาพ:** `figures/m6-g5-mae.png`

> Prompt: `Flat instructional diagram, white background. A line chart with
> actual points and a forecast line; four short vertical error bars between
> the line and the points, each labeled with its size; an arrow from the
> bars to a summary card showing "MAE = เฉลี่ยความยาวแท่ง" with a single
> representative bar length. Thai caption "พลาดเฉลี่ยกี่หน่วย". Minimal,
> no photorealism.`
> เขียนคำอธิบายสั้นๆ ที่เข้าใจง่ายสำหรับแต่ละฟังก์ชัน พร้อมตัวอย่างการเรียกใช้ และอธิบายพารามิเตอร์ที่ใช้ในฟังก์ชันนั้น ๆ ให้ชัดเจน พร้อมคำอธิบายภาพประกอบ (image prompt) สำหรับสร้างภาพประกอบการสอนแบบ infographic style (flat vector, plain white background, muted colors, clean sans-serif labels, no photorealism, no 3D, no gradients)

---

*หมายเหตุ: ภาพทั้ง 5 ยังไม่ถูกสร้าง — ผู้จัดทำสื่อใช้ prompt ข้างบนสร้างภาพ
แล้ววางไฟล์ตามชื่อที่ระบุใน `figures/` ของโมดูลนี้*
