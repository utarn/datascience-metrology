# explanation.md — Module M3: ข้อมูลไม่สะอาด

สคริปต์ภาพประกอบ + แนวทางการดำเนินช่วงสอน สำหรับผู้สอน — แต่ละหัวข้อ = หนึ่งภาพ:
แนวคิด (ไทย) → จุดประสงค์ → องค์ประกอบ → image-gen prompt (English)

**เวลา:** Day 1, 14:45–16:30 (105 นาที) — บรรยายสั้น 10 นาที → แล็บร่วมกัน (book) 55 นาที →
exercise ทำเอง 30 นาที → เฉลย + สรุป 10 นาที

**ข้อควรเตรียม:** ไฟล์ใน `datasets/` (adult, coffee_quality, pcd_pm25_legacy) ต้องอยู่ครบ —
รัน `smoke_test.py` ก่อนเริ่มชั่วโมง

---

## Figure 1 — ข้อมูลสกปรก 4 หน้า

**แนวคิด:** ข้อมูลจริงแทบไม่เคยสะอาด — 4 ปัญหาหลักที่โครงสร้างมาจากไฟล์จริงในแล็บนี้ทั้งหมด

**จุดประสงค์ของภาพ:** ให้ผู้เรียนมี "แผนที่" ของโมดูลก่อนลงโค้ด — ทุกปัญหาจะถูกเจอใน 45 นาทีถัดไป

**องค์ประกอบภาพ:** ตาราง Excel หนึ่งใบ เจาะสี่รูปที่มีสัญลักษณ์ต่างกัน: ช่องว่างปริศนา (ค่าว่าง),
ตัวอักษร `?` (ค่าปลอม), ปฏิทินฉีกขาด (วันที่แปลก), แถวโคลนซ้อนกัน (ซ้ำซ้อน)

**Image-gen prompt:**
> Educational infographic: one large spreadsheet grid with four highlighted problem zones,
> each marked with a distinct icon — an empty puzzle piece (missing values), a red question
> mark (fake values like "?"), a torn calendar page (malformed dates), and two identical
> stacked rows (duplicates); flat vector style, white background, teal-coral-slate palette,
> no text labels.
> เขียนคำอธิบายสั้นๆ ที่เข้าใจง่ายสำหรับแต่ละฟังก์ชัน พร้อมตัวอย่างการเรียกใช้ และอธิบายพารามิเตอร์ที่ใช้ในฟังก์ชันนั้น ๆ ให้ชัดเจน พร้อมคำอธิบายภาพประกอบ (image prompt) สำหรับสร้างภาพประกอบการสอนแบบ infographic style (flat vector, plain white background, muted colors, clean sans-serif labels, no photorealism, no 3D, no gradients)

---

## Figure 2 — ค่าปลอม `?` กลายเป็น NaN

**แนวคิด:** ค่าหายมักไม่ได้ว่างเปล่า — มันแต่งตัวเป็น `?` / `N/A` / `-999` ต้องเปลี่ยนให้เป็น
`NaN` มาตรฐานก่อน เครื่องมือของ pandas ถึงจะจับได้

**จุดประสงค์ของภาพ:** ย้ำว่า `replace("?", np.nan)` ไม่ใช่พิธีกรรม แต่คือการ "เปิดเผย" ค่าหาย
ให้ระบบมองเห็น — แล้ว `isna().sum()` จะเป็นไม้บรรทัดวัดขนาดปัญหา

**องค์ประกอบภาพ:** แถวข้อมูลมีช่อง `?` สีแดง → ลูกศรผ่านกล่อง "replace" → ช่องว่างลอย
(NaN) สีเทา → ลูกศรไปแถบสถิติแท่งเฉลี่ยค่าหายต่อคอลัมน์

**Image-gen prompt:**
> Pipeline diagram: a table row where one cell contains a red question mark, arrow through a
> box labeled "replace" to the same cell shown as an empty floating gray gap (NaN), then
> arrow to a small horizontal bar chart showing missing-value percentages per column; flat
> vector infographic, white background, teal-coral palette.
> เขียนคำอธิบายสั้นๆ ที่เข้าใจง่ายสำหรับแต่ละฟังก์ชัน พร้อมตัวอย่างการเรียกใช้ และอธิบายพารามิเตอร์ที่ใช้ในฟังก์ชันนั้น ๆ ให้ชัดเจน พร้อมคำอธิบายภาพประกอบ (image prompt) สำหรับสร้างภาพประกอบการสอนแบบ infographic style (flat vector, plain white background, muted colors, clean sans-serif labels, no photorealism, no 3D, no gradients)

---

## Figure 3 — หน่วยปนในคอลัมน์เดียว

**แนวคิด:** คนกรอกข้อมูลไม่ได้ตกลงหน่วยเดียวกัน — `1450 msnm`, `1000 meters`, `1200 - 1500`
อยู่คอลัมน์เดียว ทำให้ pandas เก็บเป็นข้อความทั้งคอลัมน์ คำนวณไม่ได้

**จุดประสงค์ของภาพ:** ให้เห็นว่า regex extract (`str.extract`) คือ "ตะแกรง" ที่กรองเอา
ตัวเลขออกจากข้อความ — และย้ำข้อจำกัด (ช่วงเราใช้ค่าต่ำ = สมมติฐานที่ต้องเปิดเผย)

**องค์ประกอบภาพ:** กล่องข้อความหลากหลายรูปแบบที่ความสูง → ตะแกรงมีลาย `(\d+)` → ตัวเลข
สะอาดตกลงในแท่งวัด ส่วนตัวอักษร/หน่วยค้างอยู่บนตะแกรง

**Image-gen prompt:**
> Diagram: assorted text snippets like "1450 msnm", "1000 meters", "1200 - 1500" falling
> into a sieve/funnel labeled with a regex pattern; clean bare numbers fall through into a
> measuring column while text fragments stay caught on top; flat vector style, white
> background, teal-coral palette, friendly technical look.
> เขียนคำอธิบายสั้นๆ ที่เข้าใจง่ายสำหรับแต่ละฟังก์ชัน พร้อมตัวอย่างการเรียกใช้ และอธิบายพารามิเตอร์ที่ใช้ในฟังก์ชันนั้น ๆ ให้ชัดเจน พร้อมคำอธิบายภาพประกอบ (image prompt) สำหรับสร้างภาพประกอบการสอนแบบ infographic style (flat vector, plain white background, muted colors, clean sans-serif labels, no photorealism, no 3D, no gradients)

---

## Figure 4 — ไฟล์ไทยเก่า: TIS-620 + pivot header

**แนวคิด:** ไฟล์จากหน่วยงานไทยยุคก่อน UTF-8 มาพร้อมสองชั้นของสกปรก: encoding (TIS-620) และ
รูปทรง pivot (วันที่เป็นคอลัมน์) — อ่านให้ผ่านสองชั้นนี้ก่อนถึงจะวิเคราะห์ได้

**จุดประสงค์ของภาพ:** สรุปสอง "กุญแจ" ที่ต้องใช้: `encoding="tis-620"` เปิดประตูแรก (ข้อความไทย
อ่านออก), `melt` + `to_datetime` แกะประตูสอง (รูปทรง + วันที่)

**องค์ประกอบภาพ:** ประตูสองบานต่อกัน — บานแรกป้าย "TIS-620" มีตัวหนังสือไทยเบลอกลายเป็นชัด,
บานสองป้าย "melt + date" มีตารางกว้าง (วันที่เป็นหัวคอลัมน์) หมุนกลายเป็นตารางยาว

**Image-gen prompt:**
> Two-door pipeline: first door labeled "TIS-620" with blurry Thai text above becoming
> crisp Thai text after the door; second door labeled "melt" where a wide calendar-style
> table pivots into a long two-column table; flat vector infographic, white background,
> teal-coral palette.
> เขียนคำอธิบายสั้นๆ ที่เข้าใจง่ายสำหรับแต่ละฟังก์ชัน พร้อมตัวอย่างการเรียกใช้ และอธิบายพารามิเตอร์ที่ใช้ในฟังก์ชันนั้น ๆ ให้ชัดเจน พร้อมคำอธิบายภาพประกอบ (image prompt) สำหรับสร้างภาพประกอบการสอนแบบ infographic style (flat vector, plain white background, muted colors, clean sans-serif labels, no photorealism, no 3D, no gradients)

---

## แนวทางดำเนินช่วง (instructor notes)

| นาที | กิจกรรม | จุดที่ผู้เรียนมักติด |
|---|---|---|
| 0–10 | บรรยาย §1 + Figure 1 — ถามกลับ "ไฟล์งานของคุณเจอปัญหาไหนบ่อยสุด?" | — |
| 10–30 | §2 Adult ร่วมกัน (book) — หยุดหลัง `replace("?", nan)` | ลืม `skipinitialspace=True` → ชื่อคอลัมน์ติดช่องว่าง |
| 30–55 | §3 Coffee — ให้ผู้เรียนลองเดากลุ่มที่ควรรวมก่อนเปิดเฉลย mapping | ตกใจกับ regex — ย้ำว่า copy ได้ ไม่ต้องเขียนเอง |
| 55–75 | §4 PCD ไทย — ช่วงนี้คนไทย "ผูกพัน" ที่สุด ให้เวลา decode ด้วยตัวเองก่อน | เห็น UnicodeDecodeError แล้วคิดว่าไฟล์เสีย — ย้ำว่าไฟล์ปกติ แค่ encoding ต่าง |
| 75–95 | exercise.ipynb ทำเอง (เดินดูรายคน) | สับสน melt — ให้ดู book §4 ประกอบ |
| 95–105 | เปิด solution เทียบ + เช็คลิสต์ §5 + บรีฟ "ข้อมูลสะอาดชุดนี้บ่ายนี้ไปวาดกราฟ (M4) — พรุ่งนี้ค่อยหาสถิติ (M5)" | — |

**คำถามชวนคุย (ถ้ามีเวลาเหลือ):**

- "การเติม mode แทนการตัดทิ้ง กรณีไหนที่เป็นภัย?" (คำตอบที่รอ: เมื่อคำถามวิเคราะห์ผูกกับ
  สัดส่วนของกลุ่มที่เราเติม — สถิติจะเอนไปทางกลุ่มนั้น)
- "ถ้าต้องส่งตารางที่เพิ่งทำให้สะอาดให้เพื่อนร่วมทีม ต้องแนบอะไรไปด้วย?" (สิ่งที่เราแก้/
  สมมติฐานที่ตั้ง — ปูทางไปเรื่อง reproducibility ของคอร์ส ML)

**ข้อควรระวังการพูด:** อย่าพูดว่า "clean data" เหมือนสถานะสมบูรณ์แบบ — พูดว่า
"สะอาดพอสำหรับคำถามที่เราจะตอบ" เพื่อปูแนวคิด data quality ต่อ context ที่คอร์ส ML จะต่อยอด
