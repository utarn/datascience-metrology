# explanation.md — Module M2: จัดการตารางด้วย pandas

สคริปต์ภาพประกอบ + แนวทางการดำเนินช่วงสอน สำหรับผู้สอน — แต่ละหัวข้อ = หนึ่งภาพ:
แนวคิด (ไทย) → จุดประสงค์ → องค์ประกอบ → image-gen prompt (English)

**เวลา:** Day 1, 12:45–14:00 (75 นาที) — Code-Along (book) 45 นาที → exercise
ทำเอง 20 นาที → เฉลย + สรุป 10 นาที

**ข้อควรเตรียม:** ไฟล์ใน `datasets/` (gapminder, coffee_quality) ต้องอยู่ครบ —
รัน `smoke_test.py` ก่อนช่วงพักกลางวันจบ ช่วงบ่ายเริ่มที่โค้ดทันที

---

## Figure 1 — DataFrame: ตารางที่คอมพิวเตอร์เห็นด้วย

**แนวคิด:** pandas เรียกตารางว่า DataFrame — แถว = บันทึก 1 รายการ, คอลัมน์ =
คุณสมบัติ 1 อย่าง รูปร่างเดียวกับ Excel ที่ผู้เรียนคุ้นเคย แต่อยู่ในหน่วยความ
จำของคอมพิวเตอร์ จึงคำนวณหลักล้านแถวได้

**จุดประสงค์ของภาพ:** เชื่อมจาก M1 (ข้อมูลที่พิมพ์เองใน list/dict) ไปสู่ข้อมูล
จริงเป็นไฟล์ — และย้ำว่า "ตาราง" คือรูปแบบสากลที่ทุกเครื่องมือในคอร์สใช้ร่วมกัน

**องค์ประกอบภาพ:** ไฟล์กระดาษแผ่นหนึ่งถูกสแกนผ่านเครื่อง (มีลูกศร) กลายเป็น
ตารางเรืองแสงบนจอ — ตารางมีหัวคอลัมน์ชัด แถวแรกถูกไฮไลต์, มุมล่างมีป้าย
"1,704 แถว × 6 คอลัมน์"

**Image-gen prompt:**
> Flat infographic: a paper document with a grid being scanned through a
> machine, arrow pointing to the same grid now glowing on a computer screen
> as a highlighted table with clear column headers; a small badge at the
> bottom corner showing table dimensions; flat vector style, white background,
> teal-coral-slate palette, no photorealism.

---

## Figure 2 — กรองด้วยเงื่อนไข: สวิตช์ต่อแถว

**แนวคิด:** การกรองใน pandas คือการสร้าง "แถวสวิตช์" ใหม่ที่มี `True`/`False`
ต่อหนึ่งแถวของตาราง แล้วใส่เข้าไปในวงเล็บเหลี่ยม — แถวไหนสวิตช์เปิด แถวนั้น
ผ่านเข้ามา หลายเงื่อนไขต่อกันด้วย `&` (และ) กับ `|` (หรือ)

**จุดประสงค์ของภาพ:** ทำให้เห็นว่า boolean จาก M1 ไม่ได้มาเพื่อโชว์ — มันคือ
กลไกการกรองจริง และปลูกนิสัย "วงเล็บรอบแต่ละเงื่อนไข" ตั้งแต่วันแรก

**องค์ประกอบภาพ:** ตาราง 6 แถว ติดกันเป็นแนวนอนกับ "แถบสวิตช์" แนวเดียวกัน
ที่มีสวิตช์เปิด (เขียว) 2 ตัว ปิด (เทา) 4 ตัว ลูกศรพุ่งจากสวิตช์เปิดสองตัว
ไปตารางเล็กที่เหลือแค่ 2 แถว

**Image-gen prompt:**
> Flat diagram: a 6-row spreadsheet sitting next to a vertical row of toggle
> switches, two switches green/on and four grey/off, arrows from the on
> switches leading to a small result table containing only the matching 2
> rows; labels in Thai "เงื่อนไข True/False"; flat vector style, white
> background, teal-coral palette.

---

## Figure 3 — groupby: แบ่งกลุ่ม → คำนวณ → รวมกลับ

**แนวคิด:** คำถามแบบ "ค่าเฉลี่ยต่อกลุ่ม" คือการแยกตารางเป็นหลายกองตามคอลัมน์
กลุ่ม คำนวณแต่ละกอง แล้วประกอบกลับเป็นตารางสรุป groupby คือ for ลูปที่
เขียนแทนเรา — สามขั้นในคำสั่งเดียว

**จุดประสงค์ของภาพ:** ย้ำภาพจำ split-apply-combine ให้ติดตา — เพราะโมดูล
สถิติ (M4) และกราฟ (M5) จะอ่านตารางสรุปแบบนี้ต่อทันที

**องค์ประกอบภาพ:** ตารางใหญ่หนึ่งถูกแบ่งเป็นกองละสี 4 กองตามป้ายทวีป →
แต่ละกองเข้าเครื่องคำนวณเดียวกัน → ออกมาเป็นแถวสรุป 4 แถวประกอบเป็นตาราง
เล็กที่มีคอลัมน์ "กลุ่ม · จำนวน · ค่าเฉลี่ย"

**Image-gen prompt:**
> Flat diagram: one large spreadsheet splitting into four colored piles by
> group label, each pile feeding through the same small calculator machine,
> results assembling into a compact summary table with group/count/mean
> columns; split-apply-combine flow arrows; flat vector style, white
> background, teal-coral palette, Thai caption "แบ่ง คำนวณ รวมกลับ".

---

## Figure 4 — concat: ประกอบไฟล์ซ้ำ ๆ เป็นตารางเดียว

**แนวคิด:** ข้อมูลจริงแบ่งไฟล์ต่อปี/ต่อภูมิภาค — ก่อนวิเคราะห์ต้องประกอบ
`pd.concat()` วางตารางต่อท้ายกัน และที่จริง Excel ก็ผ่านประตูเดียวกันนี้
(read_excel) — จุดจบของโมดูลคือ "ไฟล์กี่ใบก็ต่อได้ ตารางเดียวจบ"

**จุดประสงค์ของภาพ:** ปิดโมดูลด้วยภาพรวมของ "ทางเข้าข้อมูล" ทั้งหมด — และ
ตั้งคำถามทิ้งท้ายว่า "ช่องว่างในตารางรวมจัดการยังไง?" ซึ่งคือประเด็นแรกของ M3

**องค์ประกอบภาพ:** ไฟล์สองใบ (ป้าย A กับ B) ต่อเข้าหากันด้วยลูกศรรูปหัว
ประจูนิ่ง กลายเป็นตารางยาวหนึ่ง มีสองสามช่องว่างสีเทาถูกวงกลมไว้ด้วยเครื่อง
หมายคำถาม — ด้านล่างมีไอคอนไฟล์ Excel เดินเข้าประตูเดียวกัน

**Image-gen prompt:**
> Flat diagram: two document cards labeled A and B joining with puzzle-style
> arrow into one long table, a few grey empty cells circled with a question
> mark; below, a small Excel file icon walking through the same gate; flat
> vector infographic, white background, teal-coral palette, Thai caption
> "ต่อไฟล์เป็นตารางเดียว".

---

## แนวทางดำเนินช่วง (instructor notes)

| นาที | กิจกรรม | จุดที่ผู้เรียนมักติด |
|---|---|---|
| 0–10 | §1 โหลด gapminder + Figure 1 — ถาม "คอลัมน์ไหนคือบันทึก คอลัมน์ไหนคือคุณสมบัติ?" | สับสน `.head()` กับ print — ย้ำว่าเซลล์สุดท้ายแสดงเอง |
| 10–22 | §2–§3 เลือกคอลัมน์ + กรอง + Figure 2 | ลืมวงเล็บรอบเงื่อนไขที่รวมด้วย `&` — ให้ลองถอดวงเล็บดู error |
| 22–30 | §4 sort_values — ทำ "5 อันดับ" สด | ลืม `ascending=False` ได้ผลน้อยสุดแทนมากสุด — ให้อ่านผลก่อนสรุป |
| 30–42 | §5 groupby + Figure 3 — เทียบกับ for จาก M1 ให้เห็น "สามขั้นในบรรทัดเดียว" | วงเล็บซ้อนของ named agg ดูน่ากลัว — ย้ำว่า copy ได้ แก้เฉพาะชื่อคอลัมน์ |
| 42–45 | §6 Excel round-trip — โชว์ว่าอ่าน/เขียน .xlsx ได้ | คนถามไฟล์ Excel ของตัวเอง — ชวนไปลองใน Mini Project |
| 45–65 | exercise.ipynb ทำเอง (เดินดูรายคน) | TODO concat ลืม `ignore_index=True` — อธิบายว่าเลขแถวซ้ำมาจากไหน |
| 65–75 | เปิด solution เทียบ + §7 สรุป + บรีฟ "ต่อไปตารางจะเริ่มสกปรก" | — |

**คำถามชวนคุย (ถ้ามีเวลาเหลือ):**

- "ตารางของคุณที่ทำงาน ถ้าต้องตอบ 'ยอดต่อเดือน' — ตอนนี้แปลงเป็นคำสั่งได้ไหม?"
  (คำตอบที่รอ: กรอง/เรียง/groupby ครบวง — นี่คือ 80% ของงาน Excel ประจำวัน)
- "ทำไมเราถึงเชื่อผล groupby ได้ล่ะ — ถ้าในตารางมีแถวซ้ำซ้อน?" (ชวนคิด — แล้ว
  ปิดท้ายว่าโมดูลถัดไปตอบข้อนี้)

**ข้อควรระวังการพูด:**

- อย่าบอกว่า pandas "แทน Excel ได้" — พูดว่า "ต่อจาก Excel" ผู้เรียนภูมิใจใน
  Excel อยู่แล้ว และ Excel จริง ๆ คือแหล่งข้อมูลหลักของงานพวกเขา
- ห้ามใช้คำ "โมเดล" กับ groupby (ADR-0002) — มันคือ "การสรุปตาราง" เท่านั้น
- อย่าลงลึก dtype/memory — เกินขอบเขตผู้เริ่มต้น รู้แค่ "คอลัมน์มีชนิด" พอ
  และคอยชี้จาก `.info()` ให้เห็น
