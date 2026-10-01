# explanation.md — Module M1: Python + ข้อมูลรอบตัวเรา

สคริปต์ภาพประกอบ + แนวทางการดำเนินช่วงสอน สำหรับผู้สอน — แต่ละหัวข้อ = หนึ่งภาพ:
แนวคิด (ไทย) → จุดประสงค์ → องค์ประกอบ → image-gen prompt (English)

**เวลา:** Day 1, 09:30–12:00 (135 นาที รวมพัก 15 นาที) — บรรยาย "ข้อมูลรอบตัวเรา"
09:30–10:30 (60 นาที, Figures 1–4) → พัก 10:30–10:45 → Code-Along (book)
10:45–11:35 (50 นาที) → exercise ทำเอง 11:35–11:50 (15 นาที) → เฉลย + สรุป
11:50–12:00 (10 นาที)

**ข้อควรเตรียม:** รัน `smoke_test.py` ก่อนเริ่มชั่วโมง — ผู้เรียนทุกคนต้องเปิด
JupyterLab ได้ก่อนพิธีใด ๆ (โมดูลนี้ไม่ใช้ไฟล์ข้อมูลภายนอก ตัวอย่างทั้งหมดสร้างใน
โน้ตบุ๊กเอง — จงใจ ให้ผู้เรียนโฟกัสภาษาไม่ใช่ชุดข้อมูล)

---

## Figure 1 — ข้อมูลอยู่รอบตัวเรา

**แนวคิด:** ทุกกิจกรรมในหน่วยงานทิ้งร่องรอยข้อมูล — ใบเสร็จ, ฟอร์มลงเวลา, แชต,
เซนเซอร์เครื่องมือ, ตาราง Excel ที่ส่งกันทางอีเมล ปัญหาไม่ใช่ "ไม่มีข้อมูล"
แต่คือ "มีมากเกินกว่าจะจัดการด้วยมือ"

**จุดประสงค์ของภาพ:** เปิดคอร์สด้วยความคุ้นเคย — ผู้เรียนเห็นชิ้นงานของตัวเอง
ในภาพ แล้วถามกลับว่า "ที่ทำงานคุณ ข้อมูลชนิดไหนไหลผ่านมือคุณทุกวัน?"

**องค์ประกอบภาพ:** คนทำงานคนหนึ่งยืนตรงกลาง รอบตัวมีไอคอนลอยเป็นวง — ใบเสร็จ,
สมุดบันทึก, จอ Excel, นาฬิกา, เครื่องมือวัด — แต่ละไอคอนปล่อยเส้นประจุตรวจเข้า
กล่องกลางชื่อ "ข้อมูล"

**Image-gen prompt:**
> Flat infographic: a person standing at the center, surrounded by a ring of
> floating everyday items — a paper receipt, a clipboard form, a spreadsheet
> screen, a clock, a measuring instrument — each emitting dotted trail lines
> flowing into a central box labeled as data; flat vector style, white
> background, teal-coral-slate palette, friendly, no photorealism.

---

## Figure 2 — รูปแบบไฟล์ข้อมูล: เนื้อเดียวกัน ห่อต่างกัน

**แนวคิด:** CSV, Excel, JSON คือตารางชุดเดียวกันในเสื้อคนละตัว — CSV เปลือย
แต่เรียบง่าย, Excel มีหน้าตาสวยแต่มีขีดจำกัด 1,048,576 แถว, JSON เหมาะกับ
ข้อมูลจากระบบออนไลน์ โมดูลถัดไปจะโหลดทั้งหมดด้วยคำสั่งเดียว

**จุดประสงค์ของภาพ:** ลดความกลัว "นามสกุลไฟล์แปลก" — สาระคือตาราง ไม่ใช่ไฟล์
และปลูกเมล็ดของโมดูล M2 ล่วงหน้า

**องค์ประกอบภาพ:** ตารางเดียวกันสามภาพ แต่งห่อต่างกัน — แผ่นกระดาษธรรมดา
(CSV), สมุดปกแข็งสีสวย (Excel), โน้ตย่อยเชือกผูก (JSON) — ลูกศรทั้งสามชี้ไป
กล่องเดียวชื่อ "ตารางข้อมูล" มุมขวาบนมีป้ายเลข 1,048,576 พร้อมไอคอนเตือน

**Image-gen prompt:**
> Flat educational infographic: one simple grid table shown three times wearing
> different "outfits" — plain paper sheet (CSV), a colorful bound notebook
> (Excel), a note bundle tied with string (JSON) — all three pointing with
> arrows to a single box labeled as a data table; small warning badge showing
> a row limit in the corner; flat vector style, white background,
> teal-coral palette.

---

## Figure 3 — เมื่อ Excel ไปต่อไม่ได้ จึงต้องมี Python

**แนวคิด:** Excel เก่งมากจนถึงจุดหนึ่ง: ไฟล์ใหญ่เกิน, คัดลอกสูตรข้ามไฟล์ยิ่งผิด,
ทำมือทุกเดือนยิ่งช้า จุดนั้นแหละที่ Python เข้ามา — เขียนสูตรครั้งเดียว ใช้ซ้ำ
กับข้อมูลกี่ไฟล์ก็ได้

**จุดประสงค์ของภาพ:** ให้ผู้เรียน (ซึ่งใช้ Excel มาทั้งชีวิต) เห็นว่าเราไม่ได้มา
ทิ้งของเก่า แต่ต่อของเก่าด้วยของใหม่ — และคำตอบของ "ทำซ้ำได้" คือสิ่งที่คอร์ส
นี้ฝึกตลอดสองวัน

**องค์ประกอบภาพ:** ทางเดินสองสายแยกจากจุดเดียว — สายบน (มือ+คอมพิวเตอร์ Excel)
ตันที่กำแพงไฟล์ใหญ่, สายล่าง (มือ+หน้าจอโค้ด) ต่อไปได้ยาวผ่านไฟล์ซ้อนกันหลาย
ใบ ปลายทางเดียวกันชื่อ "รายงาน"

**Image-gen prompt:**
> Flat diagram: two roads diverging from one starting point — the upper road
> with a spreadsheet icon blocked by a wall of stacked documents, the lower
> road with a code editor icon continuing past many stacked files toward a
> shared destination labeled as a report; flat vector style, white background,
> teal-coral palette, encouraging tone.

---

## Figure 4 — แผนที่ Code-Along: จากศูนย์ถึงรายงาน

**แนวคิด:** 75 นาทีถัดไปเดินเป็นเส้นตรง 8 สถานี — ตัวแปร → ชนิดข้อมูล →
f-string → list → dict → for → if/def → Path ทุกขั้นคือโค้ดที่ผู้เรียน copy
แล้วรันตาม ไม่มีขั้นไหนต้องเขียนจากหน้าว่าง

**จุดประสงค์ของภาพ:** ให้ผู้เรียนเห็นว่าเส้นทางสั้นและชัด — และเก็บภาพนี้ไว้
ใช้เป็น "แผนที่ย้อนกลับ" เวลาหลงระหว่างทาง

**องค์ประกอบภาพ:** เส้นทางไต่ระดับ 8 สถานี เหมือนรถไฟฟ้า แต่ละสถานีมีไอคอน
และชื่อขั้นตอนสั้น ๆ สถานีสุดท้ายเป็นสถานีปลายทาง "รายงาน"

**Image-gen prompt:**
> Flat metro-map style diagram: a single route line with 8 stations, each
> station a rounded node with a simple icon (box for variable, tags for types,
> speech bubble for text formatting, list, directory, loop arrows, decision
> diamond, folder) and the final station larger and highlighted as the
> terminus; flat vector style, white background, teal-coral palette, no
> photorealism.

---

## แนวทางดำเนินช่วง (instructor notes)

| นาที | กิจกรรม | จุดที่ผู้เรียนมักติด |
|---|---|---|
| 09:30–09:40 | เปิดคอร์ส + Figure 1 — ถามกลับ "ข้อมูลของคุณอยู่รอบตัวแบบไหน?" | — |
| 09:40–10:10 | Figures 2–3 — CSV/Excel/JSON + ขีดจำกัด Excel + ทำไม Python | คิดว่าต้อง "เลิกใช้ Excel" — ย้ำว่าต่อยอด ไม่ใช่แทนที่ |
| 10:10–10:30 | Figure 4 แผนที่ Code-Along + เปิด Notebook พร้อมกันทั้งห้อง | บางคนเปิด JupyterLab ไม่ขึ้น — ให้ช่วยกันก่อนขึ้นโค้ด |
| 10:30–10:45 | พัก | — |
| 10:45–11:35 | Code-Along (book) §1–§8 ตามลำดับ — หยุดเช็คความเร็วหลัง §5 | ลืมวงเล็บ/คำพูด → TypeError ทุกเซลล์ ย้ำ "อ่าน error ก่อนโทษตัวเอง" |
| 11:35–11:50 | exercise.ipynb ทำเอง (เดินดูรายคน) | TODO แรกคนลังเลสัญลักษณ์ `...` — อธิบายว่ามันคือ "ช่องว่างที่รันไม่ผ่านจนกว่าจะเติม" |
| 11:50–12:00 | เปิด solution เทียบ + สรุป + บรีฟ "พักกลางวันแล้วเจอตารางจริง" | — |

**คำถามชวนคุย (ถ้ามีเวลาเหลือ):**

- "ในงานคุณ ขั้นตอนไหนที่ทำซ้ำทุกเดือนแบบเดียวกันเป๊ะ?" (คำตอบที่รอ: ขั้นนั้นแหละ
  ที่ควรกลายเป็นโค้ด — ปูทาง M7 automation)
- "ถ้าเพื่อนร่วมงานส่งไฟล์ Excel มาให้คุณรวมกับไฟล์อื่นทุกสัปดาห์ คุณจะจัดระเบียบ
  มันยังไงให้ 'เครื่องทำแทนได้'?" (ปูแนวคิดข้อมูลมีรูปแบบคงที่)

**ข้อควรระวังการพูด:**

- ผู้เรียนไม่เคยเขียนโปรแกรม — ทุกศัพท์ต้องมีอุปมา: ตัวแปร = กล่องติดป้าย,
  list = แถวหน้าเคาน์เตอร์, dict = ตู้ล็อกเกอร์มีป้ายชื่อ
- ห้ามพูดถึง Machine Learning หรือ AI ในช่วงนี้ (ADR-0002) — ถ้าถาม ให้ตอบว่า
  "พื้นฐานวันนี้คือแรงทั้งหมดที่ต้องใช้ในคอร์สนี้ สิ่งที่ต่อยอดไกลกว่านั้น
  มีคอร์สถัดไปรออยู่"
- อย่าเร่งผ่าน §2 ชนิดข้อมูล — ความเข้าใจ `str` กับ `float` ต่างกันคือรากของ
  ปัญหา "ข้อมูลสกปรก" ที่ M3 จะจับต่อ
