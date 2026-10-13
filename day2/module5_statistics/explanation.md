# explanation.md — Module M5: สถิติที่ใช้ได้จริง

สคริปต์ภาพประกอบ + แนวทางการดำเนินช่วงสอน สำหรับผู้สอน — แต่ละหัวข้อ = หนึ่งภาพ:
แนวคิด (ไทย) → จุดประสงค์ → องค์ประกอบ → image-gen prompt (English)

**เวลา:** Day 2, 09:00–10:15 (75 นาที) — บรรยายสั้น 8 นาที → แล็บร่วมกัน (book) 37 นาที →
exercise ทำเอง 22 นาที → เฉลย + สรุป 8 นาที

**ข้อควรเตรียม:** `datasets/palmer_penguins/` และ `datasets/rice_price_105/` ต้องอยู่ครบ —
รัน `smoke_test.py` ก่อนเริ่มชั่วโมง · นี่คือชั่วโมงแรกของ Day 2 — เปิดด้วยการเชื่อม Day 1:
"เมื่อวานเราทำข้อมูลสะอาดและวาดกราฟ เช้านี้ข้อมูลสะอาดนั้นคุ้มค่าแล้ว"

---

## Figure 1 — สองคำถามของสถิติ

**แนวคิด:** สถิติเชิงพรรณนาไม่ใช่การคำนวณ แต่คือการตอบสองคำถาม: ค่าทั่วไปอยู่ตรงไหน
และกระจายกว้างแค่ไหน

**จุดประสงค์ของภาพ:** ให้ผู้เรียนถือ "กรอบคิด" ตลอดโมดูล — ทุกเครื่องมือที่จะเจอ
แผนเข้าคำถามใดคำถามหนึ่งเสมอ

**องค์ประกอบภาพ:** ก้อนจุดข้อมูลกลุ่มใหญ่ (หลายร้อยจุด) ถูกย่อด้วยลูกศรสองเส้น
ไปยังตัวเลขสองกลุ่ม: "ค่ากลาง" (จุดกึ่งกลางมีวงแหวน) และ "การกระจาย" (เส้นช่วง
กางออกจากจุดกึ่งกลาง)

**Image-gen prompt:**
> Educational infographic: a large cloud of small dots on the left, two arrows
> fanning out to two result cards on the right — one card shows a highlighted
> center dot labeled as central value, one shows a horizontal range band around
> a center dot labeled as spread; flat vector style, white background,
> teal-coral-slate palette, no text labels beyond the two cards.

---

## Figure 2 — mean โดนลาก, median ยืนนิ่ง

**แนวคิด:** ค่าสุดขอบ (outlier) ลาก mean ได้ แต่ median ขยับแค่ตำแหน่ง — เหตุผล
ที่ข้อมูลเงิน/ราคา/เวลารอต้องดู median ก่อน

**จุดประสงค์ของภาพ:** ทำให้ "เห็นภาพ" กลไกการลาก — ไม่ใช่จำกฎแบบตายตัว
เมื่อผู้เรียนเห็นคนรวยตัวเดียวดันค่าเฉลี่ยลอยขึ้น พวกเขาจะเลือกถูกเองตลอดไป

**องค์ประกอบภาพ:** แถวคนยืน 7 คน ความสูงต่างกันตามเงินเดือน คนขวาสุดสูงเกินจอ
เส้นประสองเส้น: เส้น mean ลอยสูงเหนือหัวทุกคน (มีลูกศรถูกดึงโดยคนสูง)
เส้น median อยู่หัวคนกลางตัวจริง

**Image-gen prompt:**
> Seven simple human figures standing in a row, heights proportional to
> salary, the rightmost figure extremely tall; two dashed horizontal lines —
> one labeled "mean" floating above all heads with an arrow pulled toward the
> tall figure, one labeled "median" aligned with the middle figure's head;
> flat vector style, white background, teal-coral palette, friendly.

---

## Figure 3 — mean เท่ากัน คนละโลก

**แนวคิด:** ค่ากลางเดียวไม่พอ — สองชุดข้อมูลเฉลี่ยเท่ากันแต่กระจายต่างกันคือ
สองเรื่องเล่าที่ต่างกันโดยสิ้นเชิง

**จุดประสงค์ของภาพ:** ปลูกนิสัย "ถามการกระจายควบคู่กับค่ากลาง" — ต่อยอดตรง
ไปที่การรายงาน "± std" หรือ "ช่วงกลาง 50%" ในงานจริง

**องค์ประกอบภาพ:** กราฟจุดสองแผงคู่กัน แนวระดับเส้นเฉลี่ยเท่ากันพอดี —
แผงซ้ายจุดแน่นรอบเส้น แผงขวาจุดกระจายกว้างมาก ป้ายบนหัวแผงเท่ากันว่า
"เฉลี่ย 30 นาที" แต่ความหมายต่างกัน

**Image-gen prompt:**
> Two side-by-side dot plots sharing the same horizontal mean line height:
> left panel has dots tightly clustered around the line, right panel has dots
> widely scattered far above and below it; identical titles; flat vector
> infographic, white background, teal-coral palette, minimal.

---

## Figure 4 — สองยอดที่ค่าเฉลี่ยซ่อนไว้

**แนวคิด:** เมื่อข้อมูลมีสองกลุ่มซ้อน (bimodal) ค่าเฉลี่ยรวมตกอยู่ร่องกลาง —
ไม่ตรงกับตัวจริงตัวไหนเลย ต้องแยกกลุ่มก่อนพูด

**จุดประสงค์ของภาพ:** นี่คือ "ปั๊มช็อต" ของโมดูล — ใช้ภาพนี้กลับมาอ้างทุกครั้ง
ที่ผู้เรียนจะเอา mean รวมไปพูดตอนแบบฝึกปิดท้าย (ท้าย M7)

**องค์ประกอบภาพ:** histogram รูปสองยอด มีเส้นตั้ง "ค่าเฉลี่ยรวม" ตกอยู่ร่อง
กลางระหว่างยอด (มีเครื่องหมายคำถาม) เมื่อแยกสองสีออกเห็นภูเขาลูกเดียวสองลูก
แยกกันชัด

**Image-gen prompt:**
> Split infographic: top shows a bimodal histogram (two clear peaks) with a
> vertical mean line falling into the valley between peaks marked with a
> question mark; bottom shows the same data split into two translucent
> overlapping single-peak histograms in different colors; flat vector style,
> white background, teal-coral palette.

---

## แนวทางดำเนินช่วง (instructor notes)

| นาที | กิจกรรม | จุดที่ผู้เรียนมักติด |
|---|---|---|
| 0–8 | บรรยาย §1 + Figure 1 — เชื่อมจาก Day 1: "ข้อมูลสะอาดแล้ว ทำอะไรต่อ" | — |
| 8–20 | §2 describe + mean/median — หยุดหลังตัวอย่างเงินเดือนให้ผู้เรียนทาย mean ก่อนรัน | สับสน 50% ใน describe กับ "50% ของค่า" — ย้ำว่าคือตำแหน่ง |
| 20–32 | §3 std/IQR — ใช้เรื่องทีมซ่อมเครื่องให้เห็นภาพก่อนตัวเลข | std หน่วยอะไร — ตอบ: หน่วยเดียวกับข้อมูล (กรัม) |
| 32–45 | §4 groupby + §5 histogram/bimodal — จุดพีคของโมดูล | สับสน `.loc[mask, col]` — ชี้ว่าเหมือนกรอง+เลือกคอลัมน์ที่ทำแล้ว รวมเป็นคำสั่งเดียว |
| 45–53 | §6 โบนัสไทยราคาข้าว — ชวนคุย "กฎ median เสมอจริงไหม" | — |
| 53–67 | exercise.ipynb ทำเอง (เดินดูรายคน) | ลืมวงเล็บ list ใน `.quantile([0.25, 0.75])` |
| 67–75 | เปิด solution เทียบ + เช็คลิสต์ §7 + บรีฟ M6 | — |

**คำถามชวนคุย (ถ้ามีเวลาเหลือ):**

- "ถ้าต้องรายงานราคาข้าวเดือนนี้ให้สวนสัญญาขายหน้า — จะใช้ mean หรือ median
  และแนบอะไรไปด้วย" (คำตอบที่รอ: median + ช่วง + หน่วย + จำนวนเดือนที่คิดจาก)
- "histogram สองยอดแบบนี้ถ้าเกิดกับค่าแก้ไขเครื่องมือในหน่วยงานผู้เรียน —
  คิดว่าอะไรแบ่งสองยอด" (ไม่มีคำตอบผิด — โจทย์คือการถามกลับข้อมูล)

**ข้อควรระวังการพูด:** ห้ามให้ผู้เรียนกลัวตัวเลข — ย้ำว่าทั้งโมดูลใช้คำสั่งไม่เกิน
10 ตัว และส่วนที่ "ยาก" จริงคือการเลือกให้ตรงคำถาม ไม่ใช่การคำนวณ
(การคำนวณให้ pandas ทำ) และอย่าพูดคำว่า "normal distribution" —
ใช้ "รูปทรงคล้ายกระดิ่ง" พอ สำหรับระดับผู้เริ่มต้นนี้
