# Dataset candidates for the 2-day beginner course (research ticket #3)

**Date:** 2026-10-01 · **Branch:** `research/datasets` · **Ticket:** [#3 คัดเลือกชุดข้อมูล public สำหรับโมดูลต่าง ๆ](https://github.com/utarn/datascience-metrology/issues/3)

**Criteria (locked):** public/research source only · citation + license always shown · small enough to run offline on ordinary student laptops · NOT metrology-specific · deterministic seeded synthetic data acceptable when content must be controlled.

**Verification:** every URL below was fetched (HTTP status recorded) and the data files actually downloaded/inspected on 2026-10-01. See [Verification log](#appendix-verification-log). URLs that failed are explicitly flagged **do-not-cite** so future readers don't copy them.

---

## Summary table

| Category | Primary pick | License / credit | Shape (verified) | Alternates |
|---|---|---|---|---|
| 1. Messy everyday tabular data | **UCI Adult** (income) | CC BY 4.0 (DOI 10.24432/C5XW20) | 32,561 × 15 (no header; missing = `?`) | Coffee Quality Database (best dirt density, MIT + CQI), NYC 311 slice (license unspecified), Thai PM2.5 TIS-620 drill |
| 2. Time series (trend / moving average / extrapolation trap) | **NOAA globally-averaged CO₂** | Free with required credit; Version 2026-09, DOI 10.15138/9N0H-ZH07 | 571 monthly rows (1979–2026) | AirPassengers via Rdatasets (Box–Jenkins classic), PCD Air4Thai PM2.5 daily 2025 (Thai context, 8.5 MB), Intl. tourist arrivals to Thailand (the climax extrapolation trap) |
| 3. Chart-story data (distribution / comparison / relationship) | **Palmer Penguins** | CC0-1.0 | 344 × 8, 15 KB | Gapminder (CC BY 4.0 provenance), tips (cite Bryant & Smith 1995; seaborn-data repo unlicensed), UCI Iris (overused) |
| Thai-context bonus | **OAE ราคาข้าวเปลือกหอมมะลิ 105** (monthly) + **PCD PM2.5 daily 2025** | "Open Data Common" (data.go.th / pcd.gdcatalog.go.th) | 44 × 6 / 38,325 × 10 | Intl. tourist arrivals (CC BY per CKAN) |

**Recommendation in one line per module:** Adult + Coffee for the cleaning modules · NOAA CO₂ (+ tourist-arrivals as the "extrapolation destroyed it" climax) for trend/moving-average/extrapolation · Penguins (+ Gapminder) for statistics and charts · rice price and PM2.5 wherever Thai relatability helps. Total download weight of the primary set ≈ 10 MB — trivially offline-able.

---

## Category 1 — Real-world messy everyday tabular data (data-handling / dirty-data modules)

### Primary: UCI Adult (census income)
- **What it is:** 1994 US Census extract (donors Ronny Kohavi, Barry Becker; donated 1996-05-01) — everyday demographic/employment table. The canonical "a bit dirty, not hopeless" beginner dataset.
- **URL (direct, verified):** https://archive.ics.uci.edu/static/public/2/adult.zip — HTTP 200, 620,237 bytes.
- **License:** CC BY 4.0 (stated on https://archive.ics.uci.edu/dataset/2/adult).
- **DOI / citation:** Donor: Kohavi, R. & Becker, B. (1996). *Adult* [Data set]. UCI Machine Learning Repository. https://doi.org/10.24432/C5XW20
- **Size/shape (verified):** `adult.data` 3,974,305 bytes, **32,561 data rows × 15 columns**, no header row; `adult.test` 16,281 rows with a junk first line (`|1x3 Cross validator`) and a trailing dot on labels; plus `adult.names` schema doc.
- **The dirt (perfectly pitched for beginners):** missing values coded `?` (2,399 lines in `adult.data` — workclass/occupation/native-country), whitespace-padded CSV, no header, test file with junk header + `<=50K.` dot suffix, trailing blank line. All fixable with basic pandas; none requires domain knowledge.
- **Limits:** 1994 data — older vibe but timeless story ("who earns >50K"); 2 numeric columns are integers, the rest categorical → great for both `.describe()` and value-counts teaching.

### Best dirt density: Coffee Quality Database (Coffee Quality Institute reviews)
- **What it is:** 1,340+ coffee reviews scraped from the CQI database (Jan 2018) by James LeDoux — farms, altitudes, processing methods, 10+ cupping scores. Everyday-consumer topic that students find fun.
- **URL (direct, verified):** https://raw.githubusercontent.com/jldbc/coffee-quality-database/master/data/arabica_data_cleaned.csv — HTTP 200, 649,689 bytes, **1,311 data rows × 44 columns** (a `robusta_data_cleaned.csv`, 28 rows, sits alongside for comparison exercises).
- **License:** MIT (repo LICENSE, © 2018 James LeDoux). The underlying data was scraped from the Coffee Quality Institute (database.coffeeinstitute.org) — credit CQI alongside the repo.
- **Citation (plain):** LeDoux, J. (2018). *coffee-quality-database: Digitizing 1,340 coffee reviews* [Data set]. GitHub, https://github.com/jldbc/coffee-quality-database (data © Coffee Quality Institute).
- **The dirt (verified programmatically, the richest of the three):** `Lot.Number` empty in 1,041/1,311 rows; `Farm.Name` 356 / `Mill` 307 / `Producer` 229 / `Altitude` 223 / `Color` 216 / `Variety` 201 / `Processing.Method` 152 nulls; altitude mixes bare numbers with unit words (`"1450 msnm"`, `"1000 meters"`) and ranges; row id 1311 skipped; near-duplicate farm entries (ids 1305–1307 differ only by id); misspellings in free text (`"metad agricultural developmet plc"`).
- **Limits:** 44 columns is a lot for day one — better as the *second* cleaning exercise or an instructor demo, after students warm up on Adult.

### Optional scale-realism slice: NYC 311 Service Requests
- **What it is:** the city's live complaint log — extremely relatable everyday data (noise complaints, street conditions…).
- **URL (verified):** https://data.cityofnewyork.us/resource/erm2-nwe9.csv?$limit=10000 — HTTP 200, 7,818,070 bytes, 10,000 rows × 41 columns. Backend holds ~22.6M rows; export a slice with `$limit` (≈0.78 MB per 10k rows; 20k rows ≈ 1.6 MB).
- **License caveat:** the Socrata metadata itself reports "license for this dataset is unspecified"; data is governed by the NYC Open Data Terms of Use — use with attribution "311" and don't present it as CC/public-domain.
- **Dirt:** null `closed_date`, `Unspecified` placeholder strings, free-text descriptions/addresses, duplicate-looking reports.
- **Limits:** no formal license field is the weakest point of the three; keep as an optional extra, not a primary.

### Thai "dirty file" drill (small, not analysis material)
- The PCD yearly air-quality files (พ.ศ. 2554–2567) on pcd.gdcatalog.go.th are genuinely dirty: pivot-style header, `M/D/YYYY` dates, sparse values, and a `หมายเหตุ` footer row. License stated "Open Data Common". Great as a 15-minute decoding/cleaning drill, too thin for real analysis.
- **⚠️ CORRECTION (2026-10-01, during M3 prototype):** the original verification of this section was wrong — the URL `https://pcd.gdcatalog.go.th/download/aqpm2.5bangkokmetropolitanregion2554.csv` (bare `/download/` path) returns a **CKAN 404 HTML page in UTF-8**, and the "368 rows / TIS-620 confirmed" reading was that HTML page misread through TIS-620 (mojibake). The real CSVs live under the dataset's resource path — e.g. year 2556: `https://pcd.gdcatalog.go.th/dataset/78495048-ce78-4b53-b6b9-63610fc9e841/resource/f166a354-724a-4a9a-bc50-7df0ad50a4a8/download/aqpm2.5bangkokmetropolitanregion2556.csv` (verified: 367×16, TIS-620 strict decodes clean, footer row present, ~351 non-null values — sparse). Add the bare `/download/` path to the do-not-cite flags below. The committed file is the 2556 one (most data of 2554–2556: 216/331/351 non-null).

**Recommendation:** **UCI Adult** as the primary cleaning dataset (clean license, canonical, dirt exactly at beginner level) with **Coffee Quality Database** as the richer second exercise; NYC 311 only as an optional relatable slice with the license caveat spelled out.

---

## Category 2 — Time series (trend line / moving average / extrapolation trap)

### Primary: NOAA GML globally-averaged CO₂, monthly
- **What it is:** globally-averaged atmospheric CO₂, monthly, 1979–present — clean monotone trend + clear annual cycle. The classic trend+seasonality teaching series.
- **URL (direct, verified):** https://gml.noaa.gov/webdata/ccgg/trends/co2/co2_mm_gl.csv — HTTP 200, 24,723 bytes, 38-line header + **571 monthly data rows** (1979-01 → 2026-06); columns `year, month, decimal, average, average_unc, trend, trend_unc` (ppm; 336.6 → 427.6).
- **License/terms (verified in file header):** free use with **required credit** ("please include relevant citation text").
- **Citation (verified on https://gml.noaa.gov/ccgg/trends/gl_data.html):** Lan, X., Tans, P. and Thoning, K.W.: *Trends in globally-averaged CO₂ determined from NOAA Global Monitoring Laboratory measurements*, Version 2026-09. DOI: 10.15138/9N0H-ZH07 — **note: the correct author list is Lan, Tans & Thoning; the widely-copied "Lan, Thoning, Dlugokencky" is wrong** (Dlugokencky belongs to the CH4/Mauna Loa series).
- **Extrapolation trap:** excellent — a naive linear fit on the last 12 months misses both the seasonal cycle and the acceleration; the `trend` column lets students compare deseasonalized vs raw; recent years carry an in-file "subject to recalibration" caveat (another teachable point).

### Classic seasonality: AirPassengers (1949–1960 monthly airline passengers)
- **What it is:** the Box–Jenkins classic — multiplicative seasonality + growth, small enough (144 points) for hand-drawn moving averages.
- **URL (direct, verified):** https://raw.githubusercontent.com/vincentarelbundock/Rdatasets/master/csv/datasets/AirPassengers.csv — HTTP 200, 3,032 bytes, **144 data rows** (`rownames, time, value`).
- **License caveat:** Rdatasets repo is GPL-3 but its README marks the data rows only "free to re-distribute" in good faith; canonical source is Box, G.E.P. & Jenkins, G.M. (1976), *Time Series Analysis: Forecasting and Control*. Attribute both R `datasets` and Box–Jenkins.
- **Do-not-cite flag:** AirPassengers is **not** shipped in statsmodels' GitHub repo — the `raw.githubusercontent.com/statsmodels/.../airpassengers.csv` URL 404s.
- **Friendlier variant (with a caveat):** seaborn-data `flights.csv` (https://raw.githubusercontent.com/mwaskom/seaborn-data/master/flights.csv — HTTP 200, 2,350 bytes, 143 rows, nicer columns `year, month, passengers`) — but the mwaskom/seaborn-data repo carries **no license at all**, so teach with it only if the citation block cites the AirPassengers/Box–Jenkins provenance, not the repo.

### Thai context: PCD (Air4Thai) daily PM2.5, full year 2025
- **What it is:** daily 24-h PM2.5 averages for **105 stations nationwide** (incl. Bangkok stations 02T, 05T, 10T…), 2025-01-01 → 2025-12-31, tidy long format.
- **URL (direct, verified):** https://pcd.gdcatalog.go.th/dataset/78495048-ce78-4b53-b6b9-63610fc9e841/resource/131fb591-1475-408d-bc4e-ec589763f08d/download/pm2.5_daily_2025_single_sheet.csv — HTTP 200, **8,484,479 bytes (8.5 MB), 38,325 rows × 10 columns** (`observation_date, parameter, averaging_period, station_code, station_name, station_location, measured_value, original_value, data_status, unit`; µg/m³, UTF-8 with BOM).
- **License:** "Open Data Common" (stated on the pcd.gdcatalog.go.th dataset page; source: กรมควบคุมมลพิษ / Pollution Control Department).
- **Real-world gaps for cleaning:** `data_status` = `N/A` (1,724 rows) and blanks (848); measured values 2.1–289.8 µg/m³.
- **Extrapolation trap:** the Jan–Apr haze spike makes naive extrapolation of a January peak obviously wrong. Per-station filtering keeps it beginner-sized (365 rows).
- **Limits:** 8.5 MB total — still fine offline, but commit only the filtered per-station extract to the repo.

### Climax extrapolation trap: International tourist arrivals to Thailand (Ministry of Tourism and Sports)
- **What it is:** arrivals per year per country, 2015–2023, 1,376 records (286 countries; fields `year, iso, country_name, tourist_number`). Aggregates (computed from the file): 29.9M (2015) → 39.2M (2019) → **7.3M (2020), 0.43M (2021)** → 11.2M (2022) → 6.5M (2023).
- **URL (direct, verified):** https://data.go.th/dataset/6342a7c6-7260-4bd2-bdd4-29855166b1ce/resource/a9460d54-44d0-4584-bf36-c3f7242dfba2/download/international-tourist-arrivals-to-thailand.json — HTTP 200, 106,610 bytes (JSON, not CSV).
- **License:** "Creative Commons Attributions" (as spelled in the CKAN record; organization: สำนักงานปลัดกระทรวงการท่องเที่ยวและกีฬา).
- **Why it is the best extrapolation demo:** fit a trend on 2015–2019 → extrapolate → predicted 40M+; actual 2020 = 7.3M. COVID collapse is the most culturally resonant "trend lines lie" moment possible for a Thai audience.
- **Caveats (teachable in themselves):** annual only; JSON not CSV; and the 2023 total (6.5M) is far below the officially reported ~28M arrivals — the file looks stale/partial for the last year. Present it as a curated snapshot with the caveat on the slide.

**Recommendation:** **NOAA CO₂** as the primary trend/moving-average series; **AirPassengers** (Rdatasets file) for the seasonality classic; **PCD PM2.5 2025** for the Thai-context exercise; and **tourist arrivals** as the one-shot extrapolation-trap climax. If only one Thai series is wanted, PM2.5 wins on data quality; the tourist series wins on drama.

---

## Category 3 — Chart-story datasets (statistics + charts: distribution, comparison, relationship)

### Primary: Palmer Penguins
- **What it is:** 344 measured penguins (Adelie / Gentoo / Chinstrap) on 3 Antarctic islands, 2007–2009 — the friendliest modern replacement for Iris.
- **URL (direct, verified):** https://raw.githubusercontent.com/allisonhorst/palmerpenguins/main/inst/extdata/penguins.csv — HTTP 200, 15,241 bytes, **344 data rows × 8 columns** (`species, island, bill_length_mm, bill_depth_mm, flipper_length_mm, body_mass_g, sex, year`). Identical file also at https://raw.githubusercontent.com/mcnakhaee/palmerpenguins/master/palmerpenguins/data/penguins.csv (Python package mirror).
- **Do-not-cite flag:** the `.../palmerpenguins/raw/penguins.csv` path returns 404 — use the `inst/extdata` path above.
- **License:** **CC0-1.0** — confirmed via GitHub API license field and the repo README ("Data are available by [CC-0] license… Palmer Station LTER Data Policy… Type I data").
- **Citation:** Horst AM, Hill AP, Gorman KB (2020). *palmerpenguins: Palmer Archipelago (Antarctica) penguin data.* R package v0.1.0, doi:10.5281/zenodo.3960218. Original data: **Gorman KB, Williams TD, Fraser WR (2014). "Ecological sexual dimorphism and environmental variability within a community of Antarctic penguins (genus *Pygoscelis*)." PLoS ONE 9(3):e90081** — note it is PLoS ONE, not Ecology.
- **Chart stories:** distribution (histogram/boxplot of body mass, bill length by species); comparison (boxplot by species or sex; grouped bar island × species); relationship (the classic bill length vs depth scatter nearly separates the 3 species with no ML). A few missing values are a bonus for NA-handling. Highest beginner engagement of anything on this list.

### Secondary: Gapminder (life expectancy / GDP / population, 1952–2007)
- **What it is:** the famous 5-year excerpt — 1,704 rows × 6 columns (`country, year, pop, continent, lifeExp, gdpPercap`), 142 countries, **includes Thailand**.
- **URL (direct, verified):** https://raw.githubusercontent.com/plotly/datasets/master/gapminderDataFiveYear.csv — HTTP 200, 82,079 bytes. (The vega-datasets `gapminder.json` variant, 75,201 bytes, lacks GDP — less useful; and `vega-datasets/.../gapminder.csv` 404s — do not cite.)
- **License/provenance:** the data itself is **Gapminder Foundation, CC BY 4.0** (vega-datasets' datapackage documents it verbatim as CC-BY-4.0, source gapminder.org/free-material); the plotly repo's MIT covers its own code, not the data. Cite Gapminder Foundation CC BY 4.0 (and optionally the R `gapminder` package by Jennifer Bryan, which popularized this excerpt).
- **Citation (plain):** Gapminder Foundation, *Life expectancy, GDP per capita and population* [Data set], https://www.gapminder.org/free-material/ (CC BY 4.0), 5-year excerpt 1952–2007.
- **Chart stories:** the best relationship-chart dataset — gdpPercap vs lifeExp scatter (log-axis teaching moment), faceted comparison by continent, per-country line charts. Cons: long format needs explaining; gdpPercap decimals are noisy for beginners.

### Small extra: tips
- **What it is:** 244 restaurant bills with tips (`total_bill, tip, sex, smoker, day, time, size`) — 9,729 bytes at https://raw.githubusercontent.com/mwaskom/seaborn-data/master/tips.csv (HTTP 200, verified).
- **License caveat (verified):** the mwaskom/seaborn-data repo carries **no license** (GitHub API license = None; README says it is not a data archive). Use the file in class but cite the actual source: Bryant, P. G. & Smith, M. A. (1995). *Practical Data Analysis: Case Studies in Business Statistics*. Do not cite the repo as a licensed source.
- **Chart stories:** tip vs bill scatter (fit a line by eye — no ML needed), boxplot of tip by day, grouped comparisons by sex/smoker.

### Known alternative: UCI Iris
- CC BY 4.0, DOI 10.24432/C56C76 (both confirmed verbatim on https://archive.ics.uci.edu/dataset/53/iris). Legally clean and tiny, but culturally overused and less engaging; Penguins covers the same 3-class chart stories better. Keep only as a fallback.

**Recommendation:** **Palmer Penguins** as the primary chart dataset (CC0, 15 KB, three chart types in one table), **Gapminder** as the relationship/comparison heavyweight, tips as a small extra with the Bryant & Smith citation.

---

## Thai-context bonus (roundup)

| Dataset | Verified route | License | Teaching use |
|---|---|---|---|
| **ราคาข้าวเปลือกหอมมะลิ 105 (OAE, monthly)** | data.go.th datastore API: `https://data.go.th/api/3/action/datastore_search?resource_id=d9f8ed5c-6072-4ac0-a717-a30850216a39` (HTTP 200, 44 rows × 7 cols, Jan 2022 – Aug 2025, farm-gate baht/tonne, all-Thailand rows) | "Open Data Common" (CKAN) | Relatable monthly line chart / percent change; Buddhist-Era year is a teachable quirk |
| **PCD PM2.5 daily 2025** | direct CSV above (8.5 MB, 105 stations) | "Open Data Common" | Thai time-series exercise + gaps to clean |
| **Intl. tourist arrivals** | direct JSON above | "Creative Commons Attributions" (CKAN) | Extrapolation-trap climax |
| PCD legacy PM2.5 yearly files (2554–2567) | direct CSV verified (TIS-620, pivot header) | "Open Data Common" | Dirty-file decoding drill |

**Important verified caveats for Thai sources:** (1) the OAE resource's direct file URL (`catalog.oae.go.th/.../download/untitled.csv`) is **Cloudflare-403** from here — do not cite it; use the `datastore_search` API route. (2) data.go.th has **no `datastore_dump` action** (400 "Action name not known") — use `datastore_search` with `limit`/pagination. (3) Bangkok Open Data (data.bangkok.go.th) datasets checked all say `license_title: "License not specified"` — fails the stated-license criterion; skip.

---

## Citation-block requirement (applies to every notebook)

Every notebook displays, in its first markdown cell, the dataset name, source URL, license, and citation string. BibTeX for the key picks:

```bibtex
@misc{adult1996,
  author = {Kohavi, Ronny and Becker, Barry},
  title  = {Adult},
  year   = {1996},
  howpublished = {UCI Machine Learning Repository},
  doi    = {10.24432/C5XW20}
}

@misc{ledoux2018coffee,
  author = {LeDoux, James},
  title  = {coffee-quality-database: Digitizing 1,340 coffee reviews},
  year   = {2018},
  howpublished = {GitHub, \url{https://github.com/jldbc/coffee-quality-database}},
  note   = {Data from the Coffee Quality Institute (database.coffeeinstitute.org); repository under MIT License}
}

@misc{noaaco22026,
  author = {Lan, Xin and Tans, Pieter and Thoning, Kirk W.},
  title  = {Trends in globally-averaged CO2 determined from NOAA Global Monitoring Laboratory measurements},
  year   = {2026},
  howpublished = {Version 2026-09, NOAA Global Monitoring Laboratory},
  doi    = {10.15138/9N0H-ZH07}
}

@book{boxjenkins1976,
  author    = {Box, George E. P. and Jenkins, Gwilym M.},
  title     = {Time Series Analysis: Forecasting and Control},
  publisher = {Holden-Day},
  year      = {1976},
  note      = {Source of the AirPassengers series (144 monthly observations, 1949--1960); file via Rdatasets, \url{https://raw.githubusercontent.com/vincentarelbundock/Rdatasets/master/csv/datasets/AirPassengers.csv}}
}

@misc{pcdpm25,
  author = {{กรมควบคุมมลพิษ (Pollution Control Department)}},
  title  = {ข้อมูลคุณภาพอากาศจากจุดตรวจวัดคุณภาพอากาศอัตโนมัติ PM2.5 รายวัน ปี 2568},
  year   = {2025},
  howpublished = {pcd.gdcatalog.go.th, \url{https://pcd.gdcatalog.go.th/} (Open Data Common)}
}

@misc{touristarrivals,
  author = {{สำนักงานปลัดกระทรวงการท่องเที่ยวและกีฬา (Ministry of Tourism and Sports)}},
  title  = {International Tourist Arrivals to Thailand},
  year   = {2023},
  howpublished = {data.go.th, \url{https://data.go.th/dataset/6342a7c6-7260-4bd2-bdd4-29855166b1ce} (Creative Commons Attribution)}
}

@article{gorman2014penguins,
  author  = {Gorman, Kristen B. and Williams, Tony D. and Fraser, William R.},
  title   = {Ecological sexual dimorphism and environmental variability within a community of Antarctic penguins (genus Pygoscelis)},
  journal = {PLoS ONE},
  volume  = {9}, number = {3}, pages = {e90081}, year = {2014},
  doi     = {10.1371/journal.pone.0090081},
  note    = {Data distributed under CC0-1.0; package: Horst, Hill, Gorman (2020), palmerpenguins, doi:10.5281/zenodo.3960218}
}

@misc{gapminder,
  author = {{Gapminder Foundation}},
  title  = {Life expectancy, GDP per capita and population (5-year excerpt, 1952--2007)},
  year   = {2007},
  howpublished = {\url{https://www.gapminder.org/free-material/} (CC BY 4.0); excerpt file via \url{https://raw.githubusercontent.com/plotly/datasets/master/gapminderDataFiveYear.csv}}
}

@book{bryant1995tips,
  author    = {Bryant, Peter G. and Smith, Michael A.},
  title     = {Practical Data Analysis: Case Studies in Business Statistics},
  publisher = {Duxbury Press},
  year      = {1995},
  note      = {Source of the ``tips'' dataset (244 observations); file via \url{https://raw.githubusercontent.com/mwaskom/seaborn-data/master/tips.csv}}
}

@misc{rice105,
  author = {{สำนักงานเศรษฐกิจการเกษตร (Office of Agricultural Economics)}},
  title  = {ราคาข้าวเปลือกเจ้าหอมมะลิ 105 (รายเดือน)},
  year   = {2025},
  howpublished = {data.go.th, dataset rice105, datastore resource d9f8ed5c-6072-4ac0-a717-a30850216a39 (Open Data Common)}
}
```

NIST-style note: NOAA CO₂ is a U.S. Government product — free use with required credit (terms in the file header); NYC 311 has **no formal license field** (NYC Open Data Terms of Use) and should be labeled as such wherever it appears.

---

## Appendix: verification log (2026-10-01)

| Resource | Check | Result |
|---|---|---|
| UCI Adult zip (`/static/public/2/adult.zip`) | HTTP GET + unzip | 200; 620,237 B; `adult.data` 32,561 rows × 15 cols, 2,399 lines with `?`; test file has junk first line + label dots |
| UCI Adult page | license + DOI | CC BY 4.0; DOI 10.24432/C5XW20 |
| Coffee `arabica_data_cleaned.csv` (raw GitHub) | HTTP GET + column nulls | 200; 649,689 B; 1,311 × 44; null counts verified (Lot.Number 1,041 etc.); repo LICENSE = MIT (© 2018 James LeDoux) |
| NYC 311 Socrata CSV (`erm2-nwe9.csv?$limit=10000`) | HTTP GET | 200; 7,818,070 B; 10,000 × 41; license field "unspecified"; ids `6n2h-v6fc` / `erf7-j8jm` / `6n2h-vubu` all 404 — do not cite |
| PCD legacy yearly files | HTTP GET + decode test | **corrected 2026-10-01** — see ⚠️ note in Category 1; bare `/download/` URL = 404 HTML page (do-not-cite); real resource-path URL verified (2556: 367×16 TIS-620) |
| NOAA `co2_mm_gl.csv` | HTTP GET + line count | 200; 24,723 B; 571 data rows + 38-line header; credit policy + Version/DOI confirmed on gl_data.html (Lan, Tans & Thoning) |
| Rdatasets `AirPassengers.csv` | HTTP GET | 200; 3,032 B; 144 data rows; statsmodels airpassengers URL 404 — do not cite |
| seaborn-data `flights.csv` | HTTP GET + repo license check | 200; 2,350 B; 143 rows; repo has no license (GitHub API) |
| PCD `pm2.5_daily_2025_single_sheet.csv` | HTTP GET + inspection | 200; 8,484,479 B; 38,325 × 10; 105 stations × 365 days; N/A/blank gaps verified |
| Tourist arrivals JSON (data.go.th resource download) | HTTP GET + aggregation | 200; 106,610 B; 1,376 records; totals 29.9M→39.2M→7.3M→0.43M→11.2M→6.5M (2023 looks stale vs ~28M official) |
| penguins.csv (allisonhorst + mcnakhaee mirrors) | HTTP GET both | 200 / 200; both 15,241 B, 344 × 8; `.../palmerpenguins/raw/...` path 404 — do not cite; license CC0-1.0 (API + README) |
| gapminderDataFiveYear.csv (plotly) + vega gapminder.json | HTTP GET | 200 (82,079 B; 1,704 × 6; Thailand present) / 200 (75,201 B; no GDP); vega gapminder.csv 404 — do not cite; Gapminder data = CC BY 4.0 per vega datapackage |
| tips.csv (mwaskom/seaborn-data) | HTTP GET + repo license check | 200; 9,729 B; 244 × 7; repo license = None — cite Bryant & Smith 1995 instead |
| UCI Iris page | license + DOI | 200; CC BY 4.0; DOI 10.24432/C56C76 |
| OAE rice105 datastore_search | HTTP GET JSON | 200; 44 rows; OAE direct file URL is Cloudflare 403 — do not cite; `datastore_dump` action does not exist (400) |
| data.bangkok.go.th population datasets | CKAN metadata | license "License not specified" — excluded |

**Flags — URLs/claims verified as wrong, do not cite:** NYC 311 ids `6n2h-v6fc`/`erf7-j8jm`/`6n2h-vubu` · statsmodels AirPassengers URL · `palmerpenguins/raw/` path · vega `gapminder.csv` · OAE `catalog.oae.go.th` direct file · `datastore_dump` endpoint · the "CC BY-NC-SA" claim sometimes attached to the coffee dataset (repo is MIT) · "Lan, Thoning, Dlugokencky" as the CO₂ citation (correct: Lan, Tans & Thoning).

No synthetic fallback is required by policy anywhere; a seeded synthetic generator remains an option only if the final module list demands planted effects.
