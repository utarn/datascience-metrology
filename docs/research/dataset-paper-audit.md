# Dataset paper-dataset audit สำหรับโครงสร้างใหม่ 7 โมดูล (research ticket #18)

**Date:** 2026-10-13 · **Branch:** `research/dataset-paper-audit` · **Ticket:** [#18 ตรวจชุดข้อมูล 9 ชุดตามเกณฑ์ paper-dataset รายโมดูล](https://github.com/utarn/datascience-metrology/issues/18) · **Parent map:** [#16](https://github.com/utarn/datascience-metrology/issues/16)

**สิ่งที่ตรวจ:** ชุดข้อมูลทั้งหมดใน `datasets/` (9 ชุดหลักจาก commit `52f6f19` + ไฟล์แบบฝึก legacy TIS-620 ที่เพิ่มตามมา = 10 รายการ) — ตรวจซ้ำ citation + license กับแหล่งจริง แล้วจัดผลรายโมดูลตามโครงสร้างใหม่ 7 โมดูล (day1 = Python primer · pandas · ข้อมูลไม่สะอาด · กราฟ / day2 = สถิติ · พยากรณ์แบบไม่ใช้ ML · automation + แบบฝึกปิดท้าย reproduce-a-figure)

**วิธีตรวจวันนี้:** ค้นหาด้วย Bright Data CLI (`bdata search` / `bdata scrape`) — PLoS ONE article page, UCI Adult dataset page, GitHub coffee repo, CKAN API ของ pcd.gdcatalog.go.th + data.go.th, และค้นหา citation ของชุดสำรอง (Anscombe, Crampton, mtcars) · ยกเว้น gml.noaa.gov ที่ Bright Data บล็อกโดเมน .gov จึงใช้ `curl` ตรง (อ่านข้อความอ้างอิงจากหน้า gl_data.html จริง) · การตรวจครั้งแรกทั้งหมด (2026-10-01) อยู่ใน `docs/research/dataset-candidates.md` §Appendix

---

## 1) ผลตรวจ citation + license รายชุด

สรุป: **citation และ license ใน `datasets/README.md` ถูกต้องทั้งหมด** มีข้อสังเกตเล็ก 3 ข้อ (§4)

| ชุด | Citation ตรวจแล้ว | License ตรวจแล้ว | ประเภท |
|---|---|---|---|
| `palmer_penguins/` | ✅ Gorman KB, Williams TD, Fraser WR (2014) PLoS ONE 9(3):e90081, DOI 10.1371/journal.pone.0090081 — ยืนยันจากหน้าบทความ PLoS จริง (published 2014-03-05) | ✅ CC0-1.0 | **paper-published** (peer-reviewed paper) |
| `air_passengers/` | ✅ Box, G.E.P. & Jenkins, G.M. (1976), *Time Series Analysis: Forecasting and Control*, Holden-Day — ไฟล์ผ่าน Rdatasets (144 แถว ตรวจครั้งแรก 2026-10-01) | ⚠️ "แจกต่อได้ตามธรรมเนียม Rdatasets" — ไม่มี license เป็นทางการของตัวข้อมูล แต่อ้างตำราได้ | **paper-published** (ตำราวิชาการ) |
| `adult/` | ⚠️ ใกล้เคียง: หน้า UCI อ้าง "**Becker, B. & Kohavi, R.** (1996)" — README เขียน "Kohavi & Becker" (สลับลำดับ) · DOI 10.24432/C5XW20 ถูกต้อง | ✅ CC BY 4.0 (ยืนยันจากหน้า UCI วันนี้) | **paper-published** (dataset publication มี DOI — นับตามตัวอย่างในตั๋ว) |
| `coffee_quality/` | ✅ LeDoux, J. (2018), GitHub repo jldbc/coffee-quality-database (data © Coffee Quality Institute) | ✅ MIT (ยืนยันจากหน้า repo วันนี้: "MIT license") + เครดิต CQI | **paper-published** (ตามตั๋วนับ; หมายเหตุ: เป็นโปรเจกต์ digitize บน GitHub ไม่ใช่ peer-reviewed paper) |
| `noaa_co2/` | ✅ Lan, X., Tans, P. & Thoning, K.W. — ยืนยันจากหน้า gml.noaa.gov/ccgg/trends/gl_data.html วันนี้: **Version 2026-10**, DOI 10.15138/9N0H-ZH07 (README เขียน Version 2026-09 ตรงกับไฟล์ที่ commit — ดู §4) | ✅ ใช้ฟรีต้องใส่เครดิต (US Government) | หน่วยงาน (ไม่ใช่ paper — ตามที่ตั๋วกำหนดไว้แล้ว) |
| `pcd_pm25_2025/` | ✅ กรมควบคุมมลพิษ, pcd.gdcatalog.go.th — CKAN API วันนี้: license_title = "Open Data Common" | ✅ | หน่วยงานรัฐไทย |
| `pcd_pm25_legacy/` | ✅ PCD ปี 2556 (ไฟล์ TIS-620, resource-path URL แก้แล้วตาม commit `ac9ade1`) — "Open Data Common" | ✅ | หน่วยงานรัฐไทย (แบบฝึกไฟล์สกปรก ไม่ใช่ชุดวิเคราะห์) |
| `tourist_arrivals/` | ✅ สำนักงานปลัดกระทรวงการท่องเที่ยวและกีฬา, data.go.th — CKAN API วันนี้: license_title = "**Creative Commons Attributions**" (สะกดตาม CKAN จริง) | ✅ | หน่วยงานรัฐไทย |
| `rice_price_105/` | ✅ สำนักงานเศรษฐกิจการเกษตร — data.go.th CKAN: dataset "ราคาข้าวเปลือกเจ้าหอมมะลิ 105 ที่เกษตรกรขายได้", license_title = "Open Data Common" | ✅ | หน่วยงานรัฐไทย |
| `gapminder/` | ✅ Gapminder Foundation, 5-year excerpt 1952–2007, CC BY 4.0 (ตรวจครั้งแรก 2026-10-01 ผ่าน vega datapackage) | ✅ | หน่วยงาน/มูลนิธิ (ไม่ใช่ paper) |

---

## 2) ผลรายโมดูลตามโครงสร้างใหม่ 7 โมดูล

การแมปใช้การมอบหมายเดิมใน `datasets/README.md` (เลขโมดูลเก่า M2–M6) ปรับตามโครงสร้างใหม่: กราฟย้ายขึ้นเป็น M4 ของวัน 1 (เดิม M5 วัน 2) · สถิติเดิม M4 กลายเป็น M5 · พยากรณ์เดิม M6 คงเดิม · automation เดิม M7 กลายเป็นโมดูลปิด M7 + แบบฝึก reproduce-a-figure (~20–30 น.) · M8 Mini Project ยกเลิก

| โมดูล (ใหม่) | ชุดที่ใช้ | paper-published? | ผล |
|---|---|---|---|
| M1 Python primer | — (ยังไม่มีชุดระบุใน README) | — | 🔶 **ช่องว่างเชิงนุ่ม** — โมดูล primer ใช้ตัวอย่างเล็กในตัวก็ได้ แต่ถ้าจะให้ครบเกณฑ์ ให้แนะนำ Anscombe's quartet (ดู §3) หรือ slice เล็กจาก penguins ที่มีใน repo แล้ว |
| M2 pandas ตาราง | `adult` | ✅ UCI Adult (Becker & Kohavi 1996, DOI) | ✅ ผ่าน |
| M3 ข้อมูลไม่สะอาด | `adult` · `coffee_quality` · `pcd_pm25_legacy` (แบบฝึก) · `pcd_pm25_2025` (หยิบส่วน) | ✅ Adult + Coffee สองชุด | ✅ ผ่าน |
| M4 กราฟ (ย้ายขึ้นวัน 1) | `palmer_penguins` · `gapminder` · `rice_price_105` (โบนัสไทย) | ✅ Penguins (Gorman et al. 2014) | ✅ ผ่าน |
| M5 สถิติ | `palmer_penguins` · `gapminder` · `rice_price_105` (โบนัสไทย) | ✅ Penguins | ✅ ผ่าน |
| M6 พยากรณ์แบบไม่ใช้ ML | `noaa_co2` · `air_passengers` · `pcd_pm25_2025` · `tourist_arrivals` (climax กับดัก extrapolation) | ✅ AirPassengers (Box & Jenkins 1976) | ✅ ผ่าน |
| M7 automation (โมดูลปิด + reproduce-a-figure) | — (ยังไม่มีชุดระบุใน README) | — | 🔴 **ช่องว่างจริง** — เดิม automation ไม่ได้ผูกชุดข้อมูล เมื่อกลายเป็นโมดูลปิดพร้อมแบบฝึก reproduce-a-figure ต้องเลือกชุดให้รูปที่จะ reproduce มาจากงานวิจัยได้ |

**สรุปผล:** 5/7 โมดูลผ่านเกณฑ์ paper-dataset อยู่แล้ว · M7 ขาดจริง (ยังไม่มีชุดผูก) · M1 ขาดเชิงนุ่ม (ยังไม่มีชุดระบุ — อาจตีความว่า primer ไม่ใช้ชุดข้อมูลจริงก็ได้ แต่ควรตัดสินใจชัด)

---

## 3) ชุดสำรองสำหรับช่องว่าง (offline · license โอเค · ไม่ใช้ ML · เหมาะผู้เริ่มต้น · มาจากงานวิจัยจริง)

### 3.1 แนะนำหลัก: Anscombe's quartet → ใช้ได้ทั้ง M1 และ M7 (ปิดช่องว่างพร้อมกัน)

- **Paper:** Anscombe, F.J. (1973). "Graphs in Statistical Analysis." *The American Statistician* 27(1):17–21. DOI 10.1080/00031305.1973.10478966 (JSTOR 10.2307/2682899) — ตรวจแล้ววันนี้ (ผลค้นหา + Semantic Scholar + Wikipedia ตรงกันทุกจุด)
- **ขนาด/รูปร่าง:** 4 ตาราง × 11 แถว (44 จุด) — เล็กมาก พิมพ์ลงสไลด์ได้ทั้งตาราง
- **ทำไมเหมาะ M7 โดยเฉพาะ:** แบบฝึก reproduce-a-figure ของ M7 จะ "reproduce รูปจาก paper จริง" ได้เป๊ะ — Anscombe (1973) วาด 4 แผง scatter ที่สถิติเหมือนกันทุกตัวแต่รูปต่างกัน ซึ่ง (ก) เป็นภาพปิดท้ายที่สื่อ "อย่าเชื่อแค่ตัวเลข ต้องดูกราฟ" (ข) ไม่ใช้ ML สิ้นเชิง (ค) เขียน script สร้าง 4 แผง + สรุปสถิติอัตโนมัติได้ใน 20–30 นาทีพอดี
- **ทำไมเหมาะ M1 ด้วย:** ตาราง 11 แถวเหมาะฝึก print/loop/list พื้นฐาน — และเป็น "ชุดเดียวกับที่เจอชั่วโมงแรก กลับมาสคริปต์รายงานชั่วโมงสุดท้าย" เป็น bookend ของหลักสูตร
- **Offline:** มีใน seaborn (`sns.load_dataset("anscombe")`, license BSD-3) และ statsmodels — ไม่ต้องโหลดไฟล์ใหม่; สำเนา CSV 44 แถว commit ได้ < 2 KB
- **License:** ข้อมูลตีพิมพ์ในวารสาร ASA (1973); การแจกจ่ายผ่าน seaborn/R datasets เป็นธรรมเนียมปฏิบัติ — อ้าง Anscombe (1973) เป็นหลักเหมือนที่ทำกับ AirPassengers (อ้าง Box & Jenkins)

### 3.2 สำรองรอง: ToothGrowth → ถ้าต้องการชุดสถิติ/กราฟเพิ่ม

- **Paper:** Crampton, E.W. (1947). "The growth of the odontoblasts of the incisor tooth as a criterion of the vitamin C intake of the guinea pig." *The Journal of Nutrition* 33(5):491–504 — ตรวจแล้ววันนี้ (R-manual และหลายแหล่งอ้างตรงกัน)
- **ขนาด:** 60 แถว × 3 คอลัมน์ (len, supp, dose) — เหมาะ boxplot/เปรียบเทียบกลุ่ม/สถิติพรรณนา ไม่ใช้ ML
- **Offline:** มีใน R `datasets` (GPL-3); CSV 60 แถว commit ได้ ~1 KB

### 3.3 สำรองที่สาม: mtcars → ถ้าต้องการตารางใหญ่ขึ้นสำหรับ pandas/สถิติ

- **Paper:** Henderson, H.V. & Velleman, P.F. (1981). "Building Multiple Regression Models Interactively." *Biometrics* 37(2):391–411 — ตรวจแล้ววันนี้ (ScienceOpen + RDatasets อ้างตรงกัน)
- **ขนาด:** 32 แถว × 11 คอลัมน์ · อยู่ใน R `datasets` · ไม่ใช้ ML ก็สอน correlation/กลุ่มเครื่องยนต์ได้

**ไม่เสนอ:** Iris (Fisher 1936) — มี paper จริงและ license สะอาด แต่แพ็กเกจเดิมเคยประเมินแล้วว่า overused และน่าเบื่อกว่า Penguins; เก็บไว้เป็น fallback สุดท้ายเท่านั้น (ยืนยันไว้แล้วใน `dataset-candidates.md`: CC BY 4.0, DOI 10.24432/C56C76)

---

## 4) ข้อสังเกต/สิ่งที่ควรแก้ใน `datasets/README.md` (เล็กน้อย)

1. **Adult:** ลำดับชื่อผู้อุทธรณ์ — หน้า UCI ระบุ "**Becker, B. & Kohavi, R.** (1996)" ขณะที่ README เขียน "Kohavi & Becker (1996)" (และ BibTeX ใน `dataset-candidates.md` ใช้ Kohavi ก่อน) — ทั้งสองรูปแบบถูกอ้างวนกันในเว็บ แต่ตามหน้า UCI วันนี้ให้เขียน Becker & Kohavi หรือใส่หมายเหตุว่ารูปแบบสลับพบทั่วไป
2. **NOAA CO₂:** หน้า gml.noaa.gov ตอนนี้อ้าง **Version 2026-10** (ขยับจาก 2026-09 เมื่อตรวจครั้งแรก 1 ต.ค.) — README ที่เขียน 2026-09 ยังตรงกับไฟล์ที่ commit (ข้อมูลถึง 2026-06); เวลา refresh ชุดข้อมูลให้ยกเลข version ตาม แต่ DOI (10.15138/9N0H-ZH07) และรายชื่อผู้แต่ง (Lan, Tans & Thoning) ไม่เปลี่ยน
3. **Coffee:** README ระบุ "MIT (repo) — ให้เครดิต CQI ด้วย" ถูกต้องครบแล้ว — ยืนยันซ้ำว่า repo ยังเป็น MIT วันนี้; ห้ามสับสนกับเคลม "CC BY-NC-SA" ที่แพร่ในเว็บ (ธง do-not-cite ไว้แล้วใน `dataset-candidates.md`)

ไม่พบ citation หรือ license ที่ผิดพลาดร้ายแรง — ทุกชุดอ้างอิง + license ได้จริงตามเกณฑ์แผนที่

---

## 5) คำแนะนำ (recommendation list)

1. **M7 automation:** ผูก Anscombe's quartet เป็นชุดของแบบฝึก reproduce-a-figure — script สร้าง 4 แผง + ตารางสรุปสถิติจาก paper ปี 1973 โดยตรง (paper-published, 44 แถว, ไม่ใช้ ML, แจกจ่ายผ่าน seaborn ได้ offline)
2. **M1 Python primer:** ใช้ Anscombe ชุดเดียวกันเป็นตัวอย่างตารางเล็กชั่วโมงแรก (หรือถ้าตัดสินใจว่า primer ไม่ใช้ชุดข้อมูลจริง ให้บันทึกมติไว้ในแผนที่ว่าเกณฑ์ไม่ใช้กับ M1)
3. **เติมแถว Anscombe ลง `datasets/README.md` + BibTeX ลง `dataset-candidates.md`** เมื่อผ่านมติ (ตั๋วถัดไปในแผนที่)
4. แก้ลำดับชื่อ Becker/Kohavi ใน README ตามหน้า UCI (เล็กน้อย)
5. ชุดไทยทั้ง 3 (ข้าวหอมมะลิ 105 · PM2.5 PCD · นักท่องเที่ยว) คงบทบาทเดิม 100% — ยืนยันแล้วว่า license บน CKAN ยังระบุชัด ("Open Data Common" / "Creative Commons Attributions") วันนี้
6. หลังผูกชุดแล้ว โครงสร้างใหม่ 7 โมดูลจะผ่านเกณฑ์ paper-dataset **ครบทุกโมดูล**

**แหล่งอ้างอิงที่ตรวจวันนี้:** PLoS ONE (Gorman et al. 2014) · UCI Adult dataset page · github.com/jldbc/coffee-quality-database · gml.noaa.gov/ccgg/trends/gl_data.html · CKAN API pcd.gdcatalog.go.th + data.go.th · Semantic Scholar/Wikipedia (Anscombe 1973) · R-manual (ToothGrowth/Crampton 1947) · ScienceOpen (Henderson & Velleman 1981)
