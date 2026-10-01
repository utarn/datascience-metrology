# Shared datasets

Public datasets used across the course, downloaded and committed so every notebook runs offline.
Citations must be repeated in the first markdown cell of every notebook that uses a dataset
(see `docs/research/dataset-candidates.md` for the full research, BibTeX, and verification log).

| File | Used in | Source | License |
|---|---|---|---|
| `adult/` | M2, M3 | UCI Adult (income) — Kohavi & Becker (1996), UCI ML Repository, DOI 10.24432/C5XW20 — https://archive.ics.uci.edu/dataset/2/adult | CC BY 4.0 |
| `coffee_quality/` | M3 | Coffee Quality Database — LeDoux, J. (2018), https://github.com/jldbc/coffee-quality-database (data © Coffee Quality Institute) | MIT (repo) — ให้เครดิต CQI ด้วย |
| `noaa_co2/` | M6 | NOAA GML globally-averaged CO₂ monthly — Lan, X., Tans, P. & Thoning, K.W. (2026), Version 2026-09, DOI 10.15138/9N0H-ZH07 — https://gml.noaa.gov/ccgg/trends/gl_data.html | ใช้ฟรี **ต้องใส่เครดิต** (US Government product) |
| `air_passengers/` | M6 | AirPassengers (Box & Jenkins 1976 classic) — ไฟล์ผ่าน Rdatasets, https://raw.githubusercontent.com/vincentarelbundock/Rdatasets/master/csv/datasets/AirPassengers.csv | แจกต่อได้ตามธรรมเนียมของ Rdatasets — อ้าง Box & Jenkins (1976) |
| `pcd_pm25_2025/` | M3, M6 | PCD Air4Thai PM2.5 รายวัน ปี 2568 — กรมควบคุมมลพิษ, pcd.gdcatalog.go.th | Open Data Common |
| `tourist_arrivals/` | M6 (climax กับดัก extrapolation) | International Tourist Arrivals to Thailand — สำนักงานปลัดกระทรวงการท่องเที่ยวและกีฬา, data.go.th | Creative Commons Attribution |
| `palmer_penguins/` | M4, M5 | Palmer Penguins — Gorman, Williams & Fraser (2014), PLoS ONE 9(3):e90081 (package: Horst et al. 2020, doi:10.5281/zenodo.3960218) | CC0-1.0 |
| `gapminder/` | M5 | Gapminder Foundation — Life expectancy, GDP per capita & population (excerpt 1952–2007), https://www.gapminder.org/free-material/ | CC BY 4.0 |
| `rice_price_105/` | M4/M5 (โบนัสไทย) | ราคาข้าวเปลือกหอมมะลิ 105 รายเดือน — สำนักงานเศรษฐกิจการเกษตร, data.go.th (datastore resource `d9f8ed5c-6072-4ac0-a717-a30850216a39`) | Open Data Common |
| `pcd_pm25_legacy/` | M3 (แบบฝึกไฟล์สกปรก: TIS-620) | PCD ข้อมูล PM2.5 กทม. ปี 2554 — pcd.gdcatalog.go.th | Open Data Common |

**รวม ~7.8 MB — ทุกโน้ตบุ๊กรัน offline ได้**

## ชุดที่ "ไม่ commit" — ดาวน์โหลดเองตอนใช้

| ชุด | เหตุผล | วิธีได้ไฟล์ |
|---|---|---|
| tips (244 บิล+ทิป) | ที่มาจริงคือตำรา Bryant & Smith (1995) — ไม่มี license แจกต่อชัดเจน; ไฟล์เดิมมาจาก repo `mwaskom/seaborn-data` **ที่ไม่มี license** | ใช้ในห้องได้ — ดึงจาก `https://raw.githubusercontent.com/mwaskom/seaborn-data/master/tips.csv` และ **อ้าง Bryant & Smith 1995 เท่านั้น ห้ามอ้าง repo** |
| NYC 311 (slice) | ไม่มี license field ระบุ (NYC Open Data Terms of Use) | สั่ง slice ผ่าน Socrata API — ดู `docs/research/dataset-candidates.md` |

## Notes

- `pcd_pm25_2025/pm25_daily_2025_15stations.csv` คือ **extract 15 สถานี** (กทม. 12 + เชียงใหม่ 2 + หาดใหญ่ 1, 365 วัน, 5,475 rows) จากไฟล์เต็ม 8.5 MB (105 สถานี) — ไฟล์เต็ม**ไม่ commit** ดึงใหม่ได้ด้วย `scripts/download_datasets.sh` (ตัวกรอง: `station_code ∈ {02T,03T,05T,10T,11T,12T,50T,52T,53T,54T,59T,61T,35T,36T,44T}`)
- `tourist_arrivals/` เก็บทั้ง JSON ดิบ (ตามแหล่ง) และ CSV แปลงแล้ว — รวมทุกประเทศ: 29.9M (2015) → 39.2M (2019) → **7.3M (2020)** → 6.5M (2023; ปีสุดท้ายดูสมบูรณ์ไม่เต็ม เทียบตัวเลขทางการ ~28M — ใส่ caveat บนสไลด์)
- `noaa_co2/co2_mm_gl.csv` มี comment header 38 บรรทัด — อ่านด้วย `pd.read_csv(..., skiprows=38)`
- `adult/` เก็บ `adult.data` (32,561×15, ไม่มี header, ค่าหายเป็น `?`), `adult.test` (16,281 แถว, แถวแรกเป็นขยะ + label มีจุดท้าย), `adult.names` (schema) — ความสกปรกทั้งหมดนี้คือสื่อการสอน อย่าแก้ไฟล์ดิบ
- `rice_price_105/` ดึงผ่าน **datastore_search API** ของ data.go.th (ไฟล์ดาวน์โหลดตรงของ OAE โดน Cloudflare 403 — ห้ามใช้ลิงก์นั้น); ปีเป็น พ.ศ. (Buddhist Era) — จุดสอน
- การตรวจสอบทั้งหมด (URL มีชีวิต, จำนวนแถว, license) ลงบันทึกไว้ใน `docs/research/dataset-candidates.md` §Appendix — รวมธงเตือน URL/เคลมที่**ผิด ห้ามอ้าง**
