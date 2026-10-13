# คัดเลือกรูปจากงานวิจัยสำหรับแบบฝึกปิดท้าย reproduce-a-figure (research ticket #19)

**Date:** 2026-10-13 · **Branch:** `research/closing-figure-candidates` · **Ticket:** [#19 คัดเลือกรูปจากงานวิจัยสำหรับแบบฝึกปิดท้าย reproduce-a-figure](https://github.com/utarn/datascience-metrology/issues/19) · **Parent map:** [#16](https://github.com/utarn/datascience-metrology/issues/16)

**สิ่งที่ประเมิน:** candidate 4 รายการของ "รูปในงานวิจัยที่ผู้เริ่มต้นสร้างซ้ำได้ด้วย pandas + matplotlib ภายใน 20–30 นาที" เพื่อใช้เป็นแบบฝึกปิดท้ายฝังในโมดูล automation (M7) ตามมติแผนที่ #16 (ยกเลิก M8 Mini Project → แบบฝึกปิดท้ายเบา 20–30 น.)

**ข้อจำกัดที่ใช้ตัดสิน (ตามตั๋ว):** ใช้ชุดข้อมูลที่มีใน repo (`datasets/`) หรือชุดสำรองที่ตรวจแล้วใน #18 · ไม่มี ML ทุกประเภท (ADR-0002 — สถิติพรรณนา/การนับ/การเรียงลำดับเท่านั้น) · เหมาะผู้เรียนที่จบ 7 โมดูล (pandas, matplotlib, สถิติพื้นฐาน) · citation ตรวจสอบได้

**วิธีตรวจวันนี้:** ค้นหาด้วย Bright Data CLI (`bdata search` / `bdata scrape`) — หน้าบทความ PLoS ONE ของ Gorman et al. 2014 (อ่าน caption รูปทั้ง 5 จริง), R-manual หน้า ToothGrowth, ผลค้นหา Series G ของ Box & Jenkins · ดาวน์โหลด **PDF ของ Anscombe (1973) ฉบับเต็ม** มาอ่านรูปและตารางจากตัว paper โดยตรง (primary source) · ตรวจ DOI ของ Crampton (1947) ผ่าน Crossref API (PubMed ถูก Bright Data บล็อก .gov จึงใช้ Crossref)

---

## 1) สรุปเปรียบเทียบ candidate 4 รายการ

เกณฑ์หลักของตั๋ว: **ความง่ายของรูป** · **คุณค่าการสอน** (สอดคล้อง arc ของคอร์ส: clean data → describe → visualize → question trends) · **ความชัดเจนของ citation** — และเพิ่มเกณฑ์ตัดสินที่เด่นสุดจากการตรวจจริง: **"รูปนั้นเป็นรูปในงานวิจัยจริง ๆ หรือเป็นเพียงรูป 'แบบ' งานวิจัย"**

| Candidate | รูปเป็นรูปในงานวิจัยจริง? | ข้อมูล | ไม่ใช้ ML | ความง่าย | คุณค่าการสอน | Citation | ผล |
|---|---|---|---|---|---|---|---|
| (a) **Anscombe 4-panel scatter** (Anscombe 1973) | ✅ **ใช่ — Figures 1–4 ของ paper เอง** (ตรวจจาก PDF ฉบับเต็ม) | 44 แถว — ยังไม่อยู่ใน repo, commit CSV ~2 KB ได้ (seaborn **ไม่**ได้ติดตั้งใน env ของคอร์ส) | ✅ | ✅ ง่ายมาก | ✅ สูงสุด — สรุปตัวเลขตรวจยืนยันกับค่าที่ paper พิมพ์ได้เป๊ะ | ✅ DOI 10.1080/00031305.1973.10478966, JSTOR 2682899 | 🥇 **แนะนำ** |
| (b) Penguins "culmen vs flipper scatter by species" (แบบ Gorman et al. 2014) | ❌ **ไม่ใช่** — รูปจริง 5 รูปของ paper คือแผนที่ 2 รูป + isotope plot 3 รูป (ข้อมูล δ13C/δ15N ไม่อยู่ใน penguins.csv ของ repo) | 344 แถว อยู่ใน repo | ✅ scatter พรรณนาเท่านั้น | ✅ ง่าย | 🔶 ดี (ใช้ประโยชน์จาก M4/M5 ซ้ำ) แต่ซ้ำกับ M4 | ✅ DOI 10.1371/journal.pone.0090081 | 🥈 รอง 1 |
| (c) AirPassengers line plot (Box & Jenkins 1976, Series G) | ✅ ใช่ — book วาด Series G เอง (แต่เป็นตำรา ไม่ใช่ paper วารสาร; ข้อมูลดั้งเดิมจาก Brown 1963) | 144 แถว **อยู่ใน repo แล้ว** (`datasets/air_passengers/`) | ✅ | ✅ ง่ายสุด (line plot เดี่ยว) | 🔶 ดี — ทบทวน trend + seasonality จาก M6 แต่เรียบเกินเป็น capstone เดี่ยว | 🔶 Box & Jenkins (1976) หน้า 531 — ตำรา + ข้อมูลต้นทาง Brown (1963) | 🥉 รอง 2 |
| (d) ToothGrowth boxplots (Crampton 1947) | ❌ **ไม่ใช่** — boxplot canonical เป็น visualization ยุคหลัง (McNeil 1977 / ฝึก R) ไม่ใช่รูปใน paper ปี 1947 | 60 แถว — ยังไม่อยู่ใน repo | ✅ | ✅ ง่าย | 🔶 ดี (boxplot เทียบกลุ่ม) | 🔶 ซับซ้อน 3 ชั้น: R อ้าง Source = **Bliss (1952)**, Crampton (1947) เป็นแค่ Reference | ✗ ตก |

---

## 2) ผลตรวจราย candidate

### (a) Anscombe's quartet — 4-panel scatter (Anscombe 1973)

- **Paper:** Anscombe, F.J. (1973). "Graphs in Statistical Analysis." *The American Statistician* 27(1):17–21. DOI 10.1080/00031305.1973.10478966 · JSTOR 2682899 — **ตรวจแล้วจากตัว PDF ฉบับเต็มวันนี้** (สำเนา mirror มหาวิทยาลัยฮิบรู, 6 หน้า)
- **สิ่งที่ตรวจเห็นจากตัว paper:**
  - **Table หน้า 19** พิมพ์ครบทั้ง 4 ชุด × 11 คู่ (x, y) — "Four data sets, each comprising 11 (x, y) pairs" (x ของชุด 1–3 เหมือนกัน ชุด 4 มี x ต่างหน้า 8,8,…,19)
  - **Figures 1–4 (หน้า 19–20)** เป็น scatter แยก 4 แผง: Fig 1 = ชุด 1 กับเส้น fitted y = 3 + 0.5x · Fig 2 = ชุด 2 กับเส้นโค้งมน · Fig 3 = ชุด 3 กับเส้นเดียวกับ Fig 1 · Fig 4 = ชุด 4 กับเส้นเดียวกัน — **หมายเหตุเชิงซื่อสัตย์: ต้นฉบับวาดแยก 4 รูป ไม่ได้วาด 2×2 grid** (grid 2×2 เป็น layout ยุคหลัง) — แบบฝึกควรระบุใน caption ว่า "reproduce Figures 1–4, จัดเป็น 2×2 ตามธรรมเนียมยุคหลัง"
  - **paper พิมพ์สถิติสรุปไว้เป๊ะ ๆ** ใช้เป็น answer key ของแบบฝึก: n = 11 · x̄ = 9.0 · ȳ = 7.5 · regression line y = 3 + 0.5x (b₁ = 0.5) · Σ(x − x̄)² = 110.0 · regression SS = 27.50 (1 d.f.) · residual SS = 13.75 (9 d.f.) · SE(b₁) = 0.118 · R² = 0.667 — ผู้เรียน **คำนวณด้วย pandas แล้วเทียบกับตัวเลขที่ paper พิมพ์ปี 1973 ได้ทันที** (แบบฝึกตรวจตัวเองได้)
- **ข้อมูล/offline:** 44 แถว ~2 KB — ต้อง commit CSV ลง `datasets/` (แก้จุดอ่อนของมติ #18: **seaborn ไม่ได้อยู่ใน env ของคอร์ส** — `requirements-offline.txt`/`pyproject.toml` มีแค่ pandas + matplotlib + numpy เท่านั้น การโหลดผ่าน `sns.load_dataset` ใช้ไม่ได้จริง; CSV เล็กมากจึงไม่กระทบขนาด repo)
- **ไม่ใช้ ML:** สุทธิสถิติพรรณนา + scatter + เส้นตรง y = 3 + 0.5x (เส้นพอดีในฐานะสถิติ ตาม ADR-0002)
- **เวลา 20–30 น.:** โหลด CSV → `groupby("dataset")` → ตารางสรุปสถิติ → `plt.subplots(2, 2)` scatter 4 แผง (+ เส้น y=3+0.5x เลือกได้) → save PNG + CSV สรุป — พอดีระดับผู้จบ 7 โมดูล และเป็น **งาน automation แท้**: สคริปต์เดียวสร้างรูป + รายงานได้ deterministic ทุกครั้ง
- **การสอน:** ปิดคอร์สด้วยสาร "ตัวเลขสรุปเหมือนกันทุกตัว แต่กราฟบอกความจริงต่างกัน" — ย้ำ arc คลาน data → describe → visualize → ตั้งคำถามกับ trend และยังเป็น bookend กับ M1 primer ที่ #18 เสนอใช้ชุดเดียวกัน

### (b) Palmer Penguins — scatter "แบบ" Gorman et al. 2014

- **Paper:** Gorman, Williams & Fraser (2014), PLoS ONE 9(3):e90081, DOI 10.1371/journal.pone.0090081 — **scrape หน้าบทความ PLoS วันนี้ อ่าน caption รูปครบทั้ง 5:**
  - Fig 1 = แผนที่ระบบนิเวศคาบสมุทร Palmer · Fig 2 = แผนที่พื้นที่ศึกษา PAL-LTER + sea ice · **Fig 3 = Adélie δ13C/δ15N isotope (ค่าเฉลี่ย ±1 SE แยกเพศ/ปี, n=127/128) · Fig 4 = chinstrap isotope (n=53) · Fig 5 = gentoo isotope (n=115)**
- **ข้อเท็จจริงตัดสิน:** scatter culmen/flipper สีแยก species ที่เป็น "ภาพจำ" ของชุดข้อมูลนี้ **ไม่มีอยู่ใน paper** — เป็น visualization ยุคหลังของแพ็กเกจ palmerpenguins (Horst et al.) / EDA ชุมชน และรูปจริงของ paper ต้องใช้ข้อมูล isotope ที่**ไม่มี**ใน `penguins.csv` ของ repo (คอลัมน์มีแค่ species, island, bill_length/depth, flipper, body_mass, sex, year)
- นอกจากนี้การวิเคราะห์ morphometrics ใน paper ใช้ "predictive models of sex" (discriminant) — อยู่ติดขอบ ML ตามจิตวิญญาณ ADR-0002 (แม้ scatter พรรณนาที่จะฝึกจริงไม่ใช้)
- **ผล:** ข้อมูลอยู่ใน repo และ scatter ง่ายจริง แต่ไม่ผ่านโจทย์หลัก "reproduce **รูปในงานวิจัย**" — เหมาะเป็นสื่อ M4 เดิมอยู่แล้ว จึงซ้ำกับที่ผู้เรียนเคยทำใน M4/M5

### (c) AirPassengers line plot (Box & Jenkins 1976 — Series G)

- **ตรวจแล้ววันนี้:** Series G = "International Airline Passengers: Monthly Totals, January 1949–December 1960" — TIBCO docs อ้าง "Box and Jenkins, 1976, page 531, Series G" · บทใน Springer (Palgrave) ยืนยัน "Figure 7.1 Series G from Box and Jenkins (1970): international airline passengers (in thousands), monthly, 1949–1960, originally provided by Brown (1963)" — ตำราวาดชุดนี้เองจริง
- **ข้อมูลอยู่ใน repo แล้ว** (`datasets/air_passengers/AirPassengers.csv`, 144 แถว, ตรวจแล้วใน #18) — ผู้เรียนวาด line plot 144 จุด เห็น trend + ฤดูกาล ด้วย `plt.plot` อย่างเดียว
- **จุดอ่อน:** (ก) citation เป็นตำรา ไม่ใช่ paper วารสาร และข้อมูลต้นทางเป็น Brown (1963) — อธิบายได้แต่ยาวกว่า Anscombe (ข) รูปง่ายเกิน — เสร็จใน 5–10 นาที เบากว่า capstone 20–30 น. ถ้าใช้ตัวเดียว (ควรมีส่วนสรุปสถิติ/seasonal มาเสริมจึงเต็มเวลา) (ค) ซ้ำบทบาทกับ M6 โดยตรง — ผู้เรียนเพิ่งเจอชุดนี้ในโมดูลก่อนหน้า แบบฝึกปิดจะไม่รู้สึก "ใหม่"
- **ผล:** รอง 2 — เหมาะเป็น warm-up ของแบบฝึกถ้าอยากได้ 2 ระดับความยาก

### (d) ToothGrowth boxplots (Crampton 1947)

- **Paper:** Crampton, E.W. (1947). *The Journal of Nutrition* 33(5):491–504 — **ยืนยัน DOI ผ่าน Crossref API วันนี้: 10.1093/jn/33.5.491** (PubMed ถูกบล็อก จึงใช้ Crossref)
- **จุดเปลี่ยนจากมติ #18 (สำคัญ):** scrape หน้า R-manual วันนี้พบว่า **Source ของ ToothGrowth ใน R คือ Bliss, C.I. (1952), *The Statistics of Bioassay* — ไม่ใช่ Crampton** (Crampton อยู่ในหัวข้อ References เท่านั้น) และ boxplot `len ~ supp + dose` ที่ทุกคนคุ้นเคยมาจาก McNeil (1977) *Interactive Data Analysis* / ฝึกปฏิบัติ R ยุคหลัง — **ไม่มี boxplot ใน paper ปี 1947** (boxplot เป็นเทคนิค Tukey ยุค 1970s ภายหลัง paper)
- **ผล:** citation เป็นสายโซ่ 3 ชั้น (Crampton 1947 → Bliss 1952 → R/McNeil 1977) อ่อนที่สุดในกลุ่ม ข้อมูลยังไม่อยู่ใน repo (60 แถว ต้อง commit เพิ่ม) และไม่ผ่านโจทย์ "รูปในงานวิจัย" เช่นเดียวกับ (b) — ตก

### พิจารณาแล้วไม่เสนอ

- **Gapminder** (life expectancy vs GDP scatter) — ชุด institutional ไม่ใช่ paper (ยืนยันแล้วใน #18) จึงไม่มี citation ของงานวิจัยให้อ้าง
- **Iris** (Fisher 1936) — paper + license ผ่าน แต่ #18 ตัดสินไปแล้วว่า overused/น่าเบื่อกว่า Penguins เก็บไว้ fallback สุดท้ายเท่านั้น

---

## 3) คำแนะนำ (recommendation)

**แนะนำ (a) Anscombe's quartet — 4-panel scatter + ตารางสรุปสถิติ (Anscombe 1973)** เป็นแบบฝึกปิดท้าย reproduce-a-figure ของ M7 เหตุผล:

1. **เป็น candidate เดียวที่ "รูปที่จะ reproduce" เป็นรูปในงานวิจัยจริงแบบพจน์** — Figures 1–4 ของ paper (ตรวจจาก PDF ฉบับเต็ม) ขณะที่ (b) และ (d) เป็นรูป "แบบ" งานวิจัยเท่านั้น และ (c) เป็นตำรา
2. **แบบฝึกตรวจตัวเองได้ (self-verifying):** paper พิมพ์สถิติสรุปไว้ครบ (x̄ = 9.0, ȳ = 7.5, b₁ = 0.5, SE = 0.118, R² = 0.667 ฯลฯ) — ผู้เรียนเทียบผล `describe()` ของตัวเองกับปี 1973 ได้ทันที เหมาะกับ automation module ที่ deliverable คือสคริปต์สร้างรูป + รายงานแบบ deterministic
3. **ไม่ใช้ ML สนิท** และง่ายพอให้เสร็จใน 20–30 น. แต่ยังฝึกครบ: read CSV → groupby → describe → subplots 2×2 → savefig
4. **คุณค่าการสอนปิดคอร์สสูงสุด:** สารเดียวกับ arc ทั้งคอร์ส ("อย่าเชื่อแค่ตัวเลข ให้วาดกราฟ") และ bookend กับ M1 primer ที่ใช้ชุดเดียวกันตามมติ #18
5. **ราคาถูกที่สุดในการเตรียม:** CSV 44 แถว ~2 KB commit ครั้งเดียว (ต้องแก้มติ #18 นิดเดียว: แจกจ่ายผ่าน **CSV commit** ไม่ใช่ seaborn เพราะ seaborn ไม่อยู่ใน env ของคอร์ส)

**Runner-ups:** (c) AirPassengers — ข้อมูลอยู่ใน repo แล้ว วาดง่ายสุด เหมาะเป็น warm-up/ทางเลือก B แต่ซ้ำ M6 และ citation เป็นตำรา · (b) Penguins — ข้อมูลดีแต่ scatter ยอดนิยมไม่ใช่รูปใน paper และซ้ำ M4/M5 · (d) ToothGrowth — citation โซ่ 3 ชั้น ตก

**ข้อเสนอต่อยอด (ไม่บังคับ):** ให้ (c) เป็น warm-up 5 นาทีแรกของแบบฝึกเดียวกันได้ ถ้าอยากได้ความหลากหลายของรูป (line plot → scatter) โดยไม่เพิ่มชุดข้อมูล

---

## 4) แหล่งอ้างอิงที่ตรวจวันนี้

- **Anscombe (1973) PDF ฉบับเต็ม** (mirror มหาวิทยาลัยฮิบรู: pluto.huji.ac.il/~mszucker/REGR/anscombe.pdf — เนื้อหาตรง JSTOR 2682899): Table หน้า 19, Figures 1–4 หน้า 19–20, สถิติสรุปพิมพ์ในเนื้อหา
- **PLoS ONE — Gorman et al. 2014** (journals.plos.org, DOI 10.1371/journal.pone.0090081): captions Figures 1–5 ครบ
- **Crossref API**: DOI 10.1093/jn/33.5.491 = Crampton (1947), J Nutr 33(5):491–504
- **R-manual** (stat.ethz.ch, หน้า ToothGrowth): Source = Bliss (1952); References = Crampton (1947), McNeil (1977)
- ผลค้นหา Series G: TIBCO docs ("Box and Jenkins, 1976, page 531, Series G") · บท Springer/Palgrave 10.1057/9781137291264_7 ("Figure 7.1 Series G from Box and Jenkins (1970)… originally provided by Brown (1963)") · CRAN fma/airpass
- สภาพแวดล้อมคอร์ส: `pyproject.toml` / `requirements-offline.txt` — pandas + matplotlib + numpy เท่านั้น (**ไม่มี seaborn**, ยืนยันจาก uv.lock ด้วย)
