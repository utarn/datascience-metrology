# function.md — Module M1: ฟังก์ชันที่ใช้ในโมดูลนี้ (จากศูนย์ — ทุกอย่างใหม่)

ไว้เปิดคู่กับ `book.ipynb` ขณะทำ `exercise.ipynb` — จัดกลุ่มกลุ่มละ 1–3 ฟังก์ชัน
พร้อม prompt สำหรับสร้างภาพประกอบ (ภาพอยู่ที่ `figures/` ของโมดูล)

> **กฎของไฟล์นี้:** M1 คือโมดูลแรกสุดของคอร์ส — ทุกฟังก์ชันที่นี่คือ **ฐานของ
> ทั้งหลักสูตร** โมดูลถัด ๆ ไป (M2–M7) ถือว่าผู้เรียน "จำได้" ทุกอย่างในไฟล์นี้
> และจะไม่อธิบายซ้ำ — ถ้าผู้เรียนลืม ให้ย้อนกลับมาที่ไฟล์นี้เสมอ

**ไม่มีสมมติฐานก่อนเริ่ม** — ผู้เรียนไม่จำเป็นต้องมีพื้นฐานเขียนโปรแกรม

---

## กลุ่มที่ 1 — เก็บค่า: `print()` + ตัวแปร

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `print(x)` | แสดงค่าออกจอ — คำสั่งแรกที่ทุกคนต้องรู้ |
| `x = ค่า` | สร้าง**ตัวแปร**: กล่องติดป้ายชื่อเก็บค่าไว้ใช้ซ้ำ |

```python
name = "นักวิเคราะห์"
print(name)
```

**ภาพ:** `figures/m1-g1-print-variable.png`

> Prompt: `Flat instructional diagram, white background. Left: a labeled box
> with a name tag containing the number 50, an arrow pointing right labeled
> "print". Right: the same number displayed large on a small screen. Thai
> labels "ตัวแปร" above the box and "แสดงผล" above the screen. Soft pastel
> colors, rounded rectangles, minimal, no photorealism.`
> เขียนคำอธิบายสั้นๆ ที่เข้าใจง่ายสำหรับแต่ละฟังก์ชัน พร้อมตัวอย่างการเรียกใช้ และอธิบายพารามิเตอร์ที่ใช้ในฟังก์ชันนั้น ๆ ให้ชัดเจน พร้อมคำอธิบายภาพประกอบ (image prompt) สำหรับสร้างภาพประกอบการสอนแบบ infographic style (flat vector, plain white background, muted colors, clean sans-serif labels, no photorealism, no 3D, no gradients)

---

## กลุ่มที่ 2 — ชนิดข้อมูล: `int` · `float` · `str` · `bool` + `type()`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `int` | จำนวนนับ เช่น `42` |
| `float` | ตัวเลขมีทศนิยม เช่น `45.5` |
| `str` | ข้อความ ต้องมีเครื่องหมายคำพูด เช่น `"ข้าวผัด"` |
| `bool` | `True` / `False` — คำตอบใช่/ไม่ ใช้กรองข้อมูลในโมดูลถัดไป |
| `type(x)` | ถามว่าค่านี้ชนิดอะไร |

```python
price = 45.5
print(type(price))    # <class 'float'>
```

**ภาพ:** `figures/m1-g2-types.png`

> Prompt: `Flat instructional diagram, white background. Four small labeled
> containers in a row, each holding one sample value: a whole-number card
> (int), a decimal card (float), a text quote card (str), a two-way toggle
> switch (bool). Below, a magnifying glass labeled "type()" hovering over
> one container showing its type name. Thai captions above each container.
> Minimal, rounded rectangles, no photorealism.`
> เขียนคำอธิบายสั้นๆ ที่เข้าใจง่ายสำหรับแต่ละฟังก์ชัน พร้อมตัวอย่างการเรียกใช้ และอธิบายพารามิเตอร์ที่ใช้ในฟังก์ชันนั้น ๆ ให้ชัดเจน พร้อมคำอธิบายภาพประกอบ (image prompt) สำหรับสร้างภาพประกอบการสอนแบบ infographic style (flat vector, plain white background, muted colors, clean sans-serif labels, no photorealism, no 3D, no gradients)

---

## กลุ่มที่ 3 — ฝังค่าในข้อความ: f-string

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `f"...{x}..."` | ใส่ค่าตัวแปร/ผลคำนวณลงในข้อความตรง ๆ |
| `{x:,}` `{x:.1f}` | จัดรูปในตัว: ใส่คอมมา · ทศนิยม 1 ตำแหน่ง |

```python
total = 360
print(f"รวม {total:,} บาท เฉลี่ย {total / 5:.1f} บาท/วัน")
```

**ภาพ:** `figures/m1-g3-fstring.png`

> Prompt: `Flat instructional diagram, white background. Left: two separate
> cards, one with text placeholder "รวม ___ บาท" and one small card with the
> number 360, joined by an arrow labeled "f-string". Right: one combined
> sentence card "รวม 360 บาท" with the number highlighted yellow. Minimal,
> Thai labels, no photorealism.`
> เขียนคำอธิบายสั้นๆ ที่เข้าใจง่ายสำหรับแต่ละฟังก์ชัน พร้อมตัวอย่างการเรียกใช้ และอธิบายพารามิเตอร์ที่ใช้ในฟังก์ชันนั้น ๆ ให้ชัดเจน พร้อมคำอธิบายภาพประกอบ (image prompt) สำหรับสร้างภาพประกอบการสอนแบบ infographic style (flat vector, plain white background, muted colors, clean sans-serif labels, no photorealism, no 3D, no gradients)

---

## กลุ่มที่ 4 — รายการเรียงลำดับ: `list` + `len()` + ชี้ตำแหน่ง + `.append()` + `sum()`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `[a, b, c]` | สร้าง list — รายการเรียงลำดับ |
| `len(lst)` | นับว่ามีกี่รายการ |
| `lst[0]` / `lst[-1]` | ชี้รายการแรก/สุดท้าย — **นับตำแหน่งเริ่มที่ 0** |
| `lst[1:4]` | ชี้ช่วง ตำแหน่ง 1 ถึง 3 |
| `lst.append(x)` | เพิ่มรายการใหม่ท้าย list |
| `sum(lst)` / `max()` / `min()` | ผลรวม · ค่ามากสุด · ค่าน้อยสุด |

```python
lunch = [45, 60, 50, 120, 40]
lunch.append(65)
print(len(lunch), sum(lunch), lunch[-1])
```

**ภาพ:** `figures/m1-g4-list.png`

> Prompt: `Flat instructional diagram, white background. A horizontal row of
> 5 numbered boxes (positions labeled 0-4 below each, with a small note
> "เริ่มนับที่ 0") containing different coin values; a small arrow adding one
> new box at the end labeled "append"; below, a calculator icon labeled
> "sum()". Thai labels. Minimal, no photorealism.`
> เขียนคำอธิบายสั้นๆ ที่เข้าใจง่ายสำหรับแต่ละฟังก์ชัน พร้อมตัวอย่างการเรียกใช้ และอธิบายพารามิเตอร์ที่ใช้ในฟังก์ชันนั้น ๆ ให้ชัดเจน พร้อมคำอธิบายภาพประกอบ (image prompt) สำหรับสร้างภาพประกอบการสอนแบบ infographic style (flat vector, plain white background, muted colors, clean sans-serif labels, no photorealism, no 3D, no gradients)

---

## กลุ่มที่ 5 — เก็บแบบมีป้ายชื่อ: `dict`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `{"key": value, ...}` | สร้าง dict — จับคู่ชื่อ → ค่า (ตู้ล็อกเกอร์มีป้าย) |
| `d["key"]` | ดึงค่าด้วยชื่อ |
| `d["key"] = v` | เพิ่ม/แก้คู่ใหม่ |
| `"key" in d` | เช็คว่ามีชื่อนี้อยู่ไหม — เช็คก่อนดึง ไม่แล้วพัง |

```python
menu = {"ข้าวผัดกะเพรา": 50, "ข้าวมันไก่": 60}
print(menu["ข้าวมันไก่"])
```

**ภาพ:** `figures/m1-g5-dict.png`

> Prompt: `Flat instructional diagram, white background. A small locker with
> three labeled drawers, each drawer label is a food name and inside each
> drawer a price tag; a hand arrow pointing to one drawer labeled with the
> key in brackets. Thai caption "หยิบด้วยชื่อ ไม่ใช่ตำแหน่ง". Minimal,
> rounded rectangles, no photorealism.`
> เขียนคำอธิบายสั้นๆ ที่เข้าใจง่ายสำหรับแต่ละฟังก์ชัน พร้อมตัวอย่างการเรียกใช้ และอธิบายพารามิเตอร์ที่ใช้ในฟังก์ชันนั้น ๆ ให้ชัดเจน พร้อมคำอธิบายภาพประกอบ (image prompt) สำหรับสร้างภาพประกอบการสอนแบบ infographic style (flat vector, plain white background, muted colors, clean sans-serif labels, no photorealism, no 3D, no gradients)

---

## กลุ่มที่ 6 — ทำซ้ำ: `for` + การสะสมค่า + `round()`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `for x in lst:` | วนทำงานทีละค่าในรายการ |
| `total = total + x` | สะสมค่าในลูป (ผลรวมทำมือ) |
| `round(x, n)` | ปัดทศนิยม n ตำแหน่ง |

```python
total = 0
for cost in lunch:
    total = total + cost
print(round(total / len(lunch), 1))
```

**ภาพ:** `figures/m1-g6-for.png`

> Prompt: `Flat instructional diagram, white background. A conveyor belt with
> 5 coin cards moving through one fixed machine box labeled "for"; the
> machine holds an accumulating jar that visibly fills up; final arrow to a
> display showing the total. Thai caption "บอกสูตรครั้งเดียว วนเองทุกค่า".
> Minimal, no photorealism.`
> เขียนคำอธิบายสั้นๆ ที่เข้าใจง่ายสำหรับแต่ละฟังก์ชัน พร้อมตัวอย่างการเรียกใช้ และอธิบายพารามิเตอร์ที่ใช้ในฟังก์ชันนั้น ๆ ให้ชัดเจน พร้อมคำอธิบายภาพประกอบ (image prompt) สำหรับสร้างภาพประกอบการสอนแบบ infographic style (flat vector, plain white background, muted colors, clean sans-serif labels, no photorealism, no 3D, no gradients)

---

## กลุ่มที่ 7 — ตัดสินใจและสร้างเครื่องมือ: `if` / `else` + `def`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `if เงื่อนไข:` / `else:` | เงื่อนไขจริง → ทางหนึ่ง ไม่จริง → อีกทาง |
| `def ชื่อ(พารามิเตอร์):` | ห่อคำสั่งชุดหนึ่งเป็นเครื่องมือมีชื่อ เรียกใช้ซ้ำได้ |
| `return ค่า` | ให้ฟังก์ชันคืนผลลัพธ์ออกมาใช้ต่อ |

```python
def status(total, budget):
    if total > budget:
        return "เกินงบ"
    return "ยังเหลือ"

print(status(360, 300))
```

**ภาพ:** `figures/m1-g7-if-def.png`

> Prompt: `Flat instructional diagram, white background. Left: a fork in a
> path with a diamond signpost labeled with a condition, one path green
> (true) one path grey (false). Right: the same idea as a labeled machine
> box with two input slots and one output slot labeled "def" with an arrow
> returning a result card. Thai captions "เงื่อนไข" and "เครื่องมือของเรา".
> Minimal, no photorealism.`
> เขียนคำอธิบายสั้นๆ ที่เข้าใจง่ายสำหรับแต่ละฟังก์ชัน พร้อมตัวอย่างการเรียกใช้ และอธิบายพารามิเตอร์ที่ใช้ในฟังก์ชันนั้น ๆ ให้ชัดเจน พร้อมคำอธิบายภาพประกอบ (image prompt) สำหรับสร้างภาพประกอบการสอนแบบ infographic style (flat vector, plain white background, muted colors, clean sans-serif labels, no photorealism, no 3D, no gradients)

---

## กลุ่มที่ 8 — ที่อยู่ของไฟล์: `pathlib.Path`

| ฟังก์ชัน | ทำอะไร |
|---|---|
| `Path("โฟลเดอร์/ไฟล์")` | สร้าง "ที่อยู่ไฟล์" ใช้ได้ทั้ง Windows และ macOS |
| `Path.cwd()` | ที่อยู่ของโฟลเดอร์ที่กำลังทำงานอยู่ |
| `p / "ชื่อ"` | ต่อที่อยู่เข้าไปข้างใน (เครื่องหมาย `/` เชื่อมเส้นทาง) |

```python
from pathlib import Path

data_dir = Path.cwd() / "datasets"
print(data_dir.exists())
```

**ภาพ:** `figures/m1-g8-path.png`

> Prompt: `Flat instructional diagram, white background. A folder tree: one
> big folder with two nested folders inside, one highlighted; a signpost
> arrow path labeled with slashes connecting folder names; a small checkmark
> badge labeled "exists()". Thai caption "ที่อยู่ไฟล์แบบสากล Windows ก็ได้
> macOS ก็ได้". Minimal, no photorealism.`
> เขียนคำอธิบายสั้นๆ ที่เข้าใจง่ายสำหรับแต่ละฟังก์ชัน พร้อมตัวอย่างการเรียกใช้ และอธิบายพารามิเตอร์ที่ใช้ในฟังก์ชันนั้น ๆ ให้ชัดเจน พร้อมคำอธิบายภาพประกอบ (image prompt) สำหรับสร้างภาพประกอบการสอนแบบ infographic style (flat vector, plain white background, muted colors, clean sans-serif labels, no photorealism, no 3D, no gradients)

---

*หมายเหตุ: ภาพทั้ง 8 ยังไม่ถูกสร้าง — ผู้จัดทำสื่อใช้ prompt ข้างบนสร้างภาพ
แล้ววางไฟล์ตามชื่อที่ระบุใน `figures/` ของโมดูลนี้*

*ไฟล์นี้คือฐานของทั้งหลักสูตร: โมดูลถัดไปอ้างถึงกลุ่มข้างบนว่า "จำได้แล้ว"
และจะระบุเฉพาะฟังก์ชันใหม่ใน `function.md` ของโมดูลตัวเอง*
