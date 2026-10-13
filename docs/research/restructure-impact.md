# Restructure impact list: revised 7-module structure (research ticket #20)

**Date:** 2026-10-13 · **Branch:** `research/restructure-impact` · **Ticket:** [#20 รายการผลกระทบจากโครงสร้างใหม่: สื่อ / branch / ตั๋ว / มติ](https://github.com/utarn/datascience-metrology/issues/20) · Part of map [#16](https://github.com/utarn/datascience-metrology/issues/16)

**Sources (all primary — inspected directly):** branch trees read with `git ls-tree -r` / `git show` on `prototype/m1-m2-materials`, `prototype/m3-dirty-data`, `prototype/m4-m7-materials`, `prototype/m8-mini-project`, `docs/kobkoh-project-docx`, and `main`; every notebook and explanation.md on the m8 branch was scanned for cross-module references (M1–M8); issues #2, #10, #11, #12, #13, #14, #15, #17 read in full including resolution comments.

---

## 0. Inventory — what actually exists

| Branch | Produced content | Files |
|---|---|---|
| `prototype/m1-m2-materials` | M1, M2 full sets | 10 (2 modules × 5) |
| `prototype/m3-dirty-data` | M3 full set | 5 |
| `prototype/m4-m7-materials` | M1–M7 full sets (superset of the two above) | 35 (7 × 5) |
| `prototype/m8-mini-project` | M1–M7 + **M8** (exercise / solution / explanation / function — no book.ipynb per มติ #11) | 39 |
| `docs/kobkoh-project-docx` | กบค. docx + `scripts/make_project_docx.py` | docx project branch |

Each produced module = `book.ipynb` · `exercise.ipynb` · `explanation.md` · `function.md` · `solution.ipynb`. **The freshest complete snapshot of all course media is `prototype/m8-mini-project`** (it contains every earlier branch's files plus M8, with the มติ #12 and มติ #13 fixes already applied in-file at commits `30cd214` and `0768260`). Production work should be based on that branch, not on the older three.

Not on any branch: untracked local run artifacts (`day2/module5_charts/*.png`, `day2/module7_automation/outputs/`) in the working tree on `main` — notebook execution outputs, ignorable.

Cross-reference audit result: the modules are densely interlinked by number. Every `function.md` opens with "ฟังก์ชันที่ M1–M(n−1) สอนไปแล้ว…"; `explanation.md` files carry briefs for the next module ("บรีฟ M6"); `book.ipynb` cells reference prior modules by number (e.g. M5 charts book: "histogram (M4 แล้ว)", "กราฟจากตารางสรุปของ M4"). All references found are listed per file in §2.

---

## 1. Mapping old module → new module, and the numbering recommendation

Agreed new structure (map #16): day 1 = Python primer · pandas tables · dirty data · **charts** · day 2 = statistics · simple forecasting (no-ML) · automation + embedded light closing exercise + What's-next script. Old M8 Mini Project is cancelled as a module.

### Recommendation: renumber to `day1/module1–4` + `day2/module5–7` (do NOT keep old numbers)

| New | Directory | Old | Old directory |
|---|---|---|---|
| day1 M1 | `day1/module1_python_primer/` | M1 | `day1/module1_python_primer/` (unchanged) |
| day1 M2 | `day1/module2_pandas_tables/` | M2 | `day1/module2_pandas_tables/` (unchanged) |
| day1 M3 | `day1/module3_dirty_data/` | M3 | `day1/module3_dirty_data/` (unchanged) |
| day1 M4 | `day1/module4_charts/` | **M5** | `day2/module5_charts/` (moved + renamed) |
| day2 M5 | `day2/module5_statistics/` | **M4** | `day2/module4_statistics/` (renamed) |
| day2 M6 | `day2/module6_simple_forecasting/` | M6 | `day2/module6_simple_forecasting/` (unchanged) |
| day2 M7 | `day2/module7_automation/` | M7 | `day2/module7_automation/` (unchanged — becomes closing module) |
| — | (cancelled) | M8 | `day2/module8_mini_project/` (archive or drop; see §2) |

Reasons for renumbering:

1. **The materials' own convention requires it.** Every `function.md` and dozens of notebook cells refer to modules by sequence ("ฟังก์ชันที่ M1–M3 สอนไปแล้ว", "เรียนแล้วใน M2"). Under the new order, statistics (old M4) is the *fifth* module taught and charts (old M5) the *fourth*; keeping old numbers makes every such sentence false while the folder names say the opposite of the teaching order.
2. **Keeping old numbers creates visible gaps** — day 1 would run module1, 2, 3, 5; day 2 would start at module4. Learners and instructors navigating by folder number would be misled about position in the course.
3. **มติ #2 established the rule** that folders are `dayN/moduleN_name/` where N is the module's position; the restructure inherits that rule (map #16 keeps the folder convention and the glossary entry in `CONTEXT.md` — only the module list changes).
4. Cost is a **one-time, mostly mechanical pass** (rename 2 directories, update "M4"/"M5" labels and forward/backward references across ~30 files). The alternative — permanent off-by-one numbering in every future file — is the worse trade.

Suggested slug: `module4_charts` (drop the `_communicate` padding; mirrors `module5_statistics` symmetry). Any short slug is fine as long as dir numbers match teaching order.

### Content-order risk the mapping surfaces (the biggest real edit)

The charts module was **written as a follow-on to statistics**: its explanation opens "เริ่มชั่วโมงด้วยการทวน M4 ผ่านกราฟ" and its book says "histogram (M4 แล้ว)", "กราฟจากตารางสรุปของ M4". Moving charts *ahead* of statistics inverts that framing. Verified mitigating fact: the charts `book.ipynb` code uses only `.mean()` on a `groupby` (taught in M2) — **no statistics-only function** (no `describe`/`median`/`std`/`quantile`). So the reorder is technically safe; the required work is reframing text (review M2/M3 via charts instead of M4) plus deciding how much distribution vocabulary (histogram reading) is taught informally inside charts vs. deferred to statistics. This reframe is the main *non-mechanical* edit in the whole restructure.

---

## 2. Per-file disposition

Legend: ✅ move/rename cleanly (mechanical number-touch-up only) · ✏️ move + content edit · 📦 archive/drop. Line numbers refer to files on `prototype/m8-mini-project`.

### day1 M1 `module1_python_primer` — ✅ 5 files, no content edit needed

References audited: M2 (forward brief — still correct), M3 (still correct), M7 (explanation.md L122 "ปูทาง M7 automation" — still correct; M7 stays M7). Renumbering does not touch M1.

### day1 M2 `module2_pandas_tables` — ✏️ 5 files, 1 substantive edit

- `explanation.md` **L65**: "สถิติ (M4) และกราฟ (M5) จะอ่านตารางสรุปแบบนี้ต่อทันที" — order flips; must become charts (M4) next, statistics (M5) tomorrow.
- `function.md` L201 (M3 forward note) and all notebook cells referencing M1/M3 — unchanged, still correct.

### day1 M3 `module3_dirty_data` — ✏️ 5 files, 2 substantive edits

- `book.ipynb` cell 1: "ตารางสะอาดที่พร้อมเป็นวัตถุดิบของสถิติและกราฟ (M4–M5)" → "กราฟ (M4) และสถิติ (M5)".
- `book.ipynb` cell 29: "วันที่ 2 เราจะเอาข้อมูลสะอาดไปหาสถิติ (M4), วาดกราฟ (M5), และพยากรณ์ (M6)" — charts now happens the same day; rewrite as "วาดกราฟ (M4) ก่อนเลิกวันนี้ · พรุ่งนี้หาสถิติ (M5) และพยากรณ์ (M6)".

### day1 M4 `module4_charts` (old M5, moved from day2) — ✏️ 5 files, the heaviest reframe

Directory move + module number M5→M4 in all four file headers +:

- `explanation.md` **L11** "เริ่มชั่วโมงด้วยการทวน M4 ผ่านกราฟ" and **L99** timetable row "ทวน M4 ผ่านกราฟ 'เมื่อเช้าเราสรุปด้วยตัวเลข ตอนนี้ทำเป็นภาพ'" — statistics hasn't happened yet; reframe the hour-opener to review M2/M3 (groupby summaries, clean tables) through charts, and adjust the closing brief (next module = day 2 statistics, or day-1 wrap-up).
- `explanation.md` **L41** "เชื่อมตรงกับบทเรียน M4 เรื่องกลุ่มซ่อนอยู่ (bimodal)" — decide: either keep the bimodal observation as a chart-level intuition (recommended; statistics then names it formally in M5), or cut the sentence.
- `explanation.md` **L81** "Mini Project (M8) จะเปิดภาพนี้เทียบกับกราฟของตัวเอง" — superseded; repoint to the closing exercise ("reproduce a figure") in M7 or drop.
- `book.ipynb` cell 2 "histogram (M4 แล้ว)", cell 9 "(จำจาก M4 …)", cell 10 "กราฟจากตารางสรุปของ M4" — replace M4-as-prior references; histogram needs no statistics-only function (verified), so teach histogram reading as new here.
- `book.ipynb` cell 23 "**ต่อไป (M6):**" — next module is now M5 statistics; rewrite the forward hook (the line-chart→forecasting teaser can survive as a day-2 teaser).

### day2 M5 `module5_statistics` (old M4, renamed) — ✏️ 5 files

Directory rename `module4_statistics`→`module5_statistics` + module number M4→M5 in headers +:

- `explanation.md` **L83** "ที่ผู้เรียนจะเอา mean รวมไปพูดใน Mini Project (M8)" — superseded; repoint to closing exercise or drop.
- `explanation.md` **L108** closing row "บรีฟ M5" → "บรีฟ M6" (forecasting — as before, next module).
- `function.md` **L7/L10** "ฟังก์ชันที่ M1–M3 สอนไปแล้ว" → "M1–M4" (charts now precedes statistics; charts' `function.md` functions — `plot`, `scatter`, `hist`, `bar`, `savefig` — must be added to the "สมมติว่าจำได้" list).
- `book.ipynb` cell 24 "**ต่อไป (M5):** ตัวเลขพวกนี้จะกลายเป็นภาพ" → "(M6)"; the "numbers become pictures" forward hook needs rewriting (charts already happened — statistics now *feeds* chart choices, or simply brief forecasting).
- `book.ipynb` cells 3, 12 reference M3/M2 — unchanged, still correct.

### day2 M6 `module6_simple_forecasting` — ✏️ 5 files, light edits

Module number unchanged (M6 → M6), no directory move:

- `explanation.md` **L27** "เหมือนการเลือกกราฟใน M5" → "ใน M4" (charts is now M4).
- `explanation.md` L113–114 "บรีฟ M7" — still correct, keep.
- `solution.ipynb` **cell 10** "นี่คือความกล้าหาญทางสถิติที่ Mini Project (M8) จะถามซ้ำอีกครั้ง" — superseded; repoint to the M7 closing exercise or drop.
- `function.md` "M1–M5" prerequisite line — coincidentally still correct under new numbering (M5 = statistics, which forecasting does build on). No edit beyond title-number consistency check.

### day2 M7 `module7_automation` (closing module) — ✏️ 5 files + 2 additions

Module number unchanged, no directory move:

- `explanation.md` **L88** timetable row "เปิด solution เทียบ + … + **บรีฟ M8**" — no M8 to brief; the row becomes the closing-exercise slot.
- `explanation.md` Figure 2 purpose ("ให้ผู้เรียนจำแบบแผนไปใช้กับข้อมูลของตัวเองใน Mini Project") — repoint to แบบฝึกปิดท้าย.
- `book.ipynb` **cell 14** "**ต่อไป (M8 — Mini Project):** ข้อมูลของคุณเอง…" — replace with the closing-exercise brief + What's-next pointer.
- **ADD — closing exercise (~20–30 น., reproduce a figure):** per map #16, embedded at the end of this module. Form options: a final section appended to `exercise.ipynb`, or a small extra notebook. Its design depends on ticket **#19** (which research figure to reproduce) — sequence: #19 → then this exercise. Keep it light: no own-data requirement, uses course datasets.
- **ADD — absorb the What's-next script:** copy the three-slide script from old `day2/module8_mini_project/explanation.md` (the มติ #12 version at commit `30cd214`) into `day2/module7_automation/explanation.md` as the class-closing section, adapting: slide 1 "ยกจาก Mini Project จริงที่เพิ่งนำเสนอ 1–2 กลุ่มในห้อง" → reference the closing exercise's reproduced figures instead; slide 3's closing line "ปิดด้วยเช็คลิสต์ M6 ไม่ใช่โค้ด" survives verbatim. Timing per the new timetable from ticket #17 (supersedes the 5-min M8-era slot).
- `function.md` "M1–M6" prerequisite line — still correct (automation is the 7th module). Plus: document the closing exercise's function usage (it reuses M6 checklist + chart functions from new M4; no new functions).

### old M8 `module8_mini_project` — 📦 4 files, cancelled as a module

| File | Disposition | Why |
|---|---|---|
| `exercise.ipynb` (6-section starter + rubric) | **Archive** (e.g. `archive/mini_project/`) — do not put in a `day*/module*/` path | The 6-section structure (โหลด→จัดการ→สถิติ→กราฟ→พยากรณ์→ทำไมจึงเชื่อ) is a ready-made section map the M7 closing exercise can mine, but the full 55-min brief/rubric/pitch apparatus is dead per map #16. Keeping it out of `day*/` also keeps it out of `check_materials.sh`'s lint+execute glob. |
| `solution.ipynb` (worked example on `datasets/rice_price_105/`, พ.ศ. conversion as the management test) | **Archive as reference** — valuable post-class material | It is the only fully-worked cross-module example in the repo and passed the gate. The M7 closing exercise can point learners to it after class. |
| `explanation.md` (158 lines) | **Mine, then archive** | Already contains the มติ #12 What's-next script (commit `30cd214`) and the มติ #13 post-test choreography — both transplanted/adapted into M7 (above), then the rest (grouping, pitch timing, gallery walk, question cards) is dead weight worth keeping only for history. |
| `function.md` (recap map M1–M7 → 6 sections) | **Mine, then archive** | The per-section "ต้นแบบจากโมดูลไหน" map is exactly what the closing exercise needs as a hint table — reuse inside the M7 closing exercise, then archive. |

Alternatively drop all four outright; archiving is cheap and preserves the มติ-#11 work. Either way `day2/module8_mini_project/.gitkeep` is deleted and the directory removed from `main` and the prototype branches' tip when merging.

### Repo-wide files that also need edits (not module media)

- `README.md` L25–32: the 8-row module table → 7 rows with new numbers/paths; drop M8 row.
- `datasets/README.md`: the per-dataset "โมดูล" column uses old numbers — `palmer_penguins/` "M4, M5" → "M5, M4" order irrelevant but numbers flip to "M5, M4"; `rice_price_105/` "M4/M5 (โบนัสไทย)" → "M5/M4 (โบนัสไทย)"; `adult/`, `coffee_quality/`, `pcd_pm25_*`, `noaa_co2/`, `air_passengers/`, `tourist_arrivals/`, `gapminder/` rows keep numbers except M5-charts references. Mechanical.
- `CONTEXT.md` glossary: **Mini Project** entry → replace with **แบบฝึกปิดท้าย (reproduce a figure)** definition (~20–30 น. ในโมดูล automation — per map #16 the iron rule changes from "จบด้วย Mini Project" to this); **สไลด์ What's next** entry → "…ท้ายแบบฝึกปิดท้าย … สคริปต์ใน explanation.md ของ M7" (currently says M8).
- `scripts/check_materials.sh` — **no edit needed**: it globs `day*/module*/` generically and hardcodes no module names (the worry recorded in มติ #11 does not materialize). It will, however, automatically start linting/executing the moved charts module under day1 — a good free regression check.
- `scripts/download_datasets.sh`, `smoke_test.py`, `pyproject.toml`, `.flake8` — no module references found; unchanged.
- New `.gitkeep` bookkeeping: `day1/module4_charts/.gitkeep`, `day2/module5_statistics/.gitkeep` created; old `day2/module4_statistics/`, `day2/module5_charts/`, `day2/module8_mini_project/` placeholders removed.

### Headline counts

- **39 produced media files** audited.
- **5** clean (M1 × 5) — no move, no edit.
- **30** move and/or edit: M2 (5) · M3 (5) · old-M5 charts → new M4 (5, heaviest) · old-M4 statistics → new M5 (5) · M6 (5) · M7 (5 + 2 additions: closing exercise, What's-next script).
- **4** archive-or-drop (M8 set) — recommend archive under `archive/mini_project/` after mining two files.
- **3** repo-wide docs to touch: `README.md`, `datasets/README.md`, `CONTEXT.md`.
- **0** infrastructure/script edits required.

---

## 3. Decisions #2, #10, #11, #12, #13 — what is superseded vs still valid

| มติ | Superseded (by map #16) | Still valid |
|---|---|---|
| **#2** (course structure) | The 8-module list (M8 row dies; M4/M5 swap day and renumber); both timetables in the resolution (day-2 mini-project block 15:30–16:30, post-test at 16:50, "กราฟ+automation ย่อเวลา" time splits) — minute-level timetable now owned by ticket **#17** which explicitly supersedes มติ #13's minutes | Course name ("Data Skills with Python — จัดการข้อมูลจริง ตั้งแต่ไฟล์ดิบถึงรายงาน"); folder convention `dayN/moduleN_name/`; ช่วง 1 merged into M1's primer; pre-test morning day 1; "What's next sits at class closing" (position survives, surrounding activities change) |
| **#10** (Mini Project format) | **Effectively all of it as a module decision**: starter format, rubric-ผ่าน/ไม่ผ่าน, pitch 1.5 น./กลุ่ม, gallery-walk fallback, ข้อมูลตัวเอง vs dataset สำรอง rule | The intellectual core — "ตอบได้ว่าทำไมจึงเชื่อการพยากรณ์นี้ได้" via M6's 5-item checklist — survives inside M6 content and can carry into the closing exercise's design (optional, ticket #19's scope) |
| **#11** (produce M8 media) | The deliverable itself (a module8) is cancelled; its "❌ ไม่มี book.ipynb" caveat is moot | The *artifacts* remain useful as reference (see §2 M8 table); the media template/conventions it followed (gate, citation cell, Thai per CONTEXT.md) are untouched |
| **#12** (What's next slides) | Only the *physical location and trigger*: script moves from M8 `explanation.md` → M7 `explanation.md`; slide 1's "ยกจาก Mini Project จริงที่เพิ่งนำเสนอ" anchor needs rewording; timing re-set by #17 | The decision itself (3 slides, no slide files, bridge sentence "Python + ข้อมูลสะอาด + แนวโน้ม = วัตถุดิบของ ML", course name without version-locking, glossary terms สไลด์ What's next / จุดเชื่อม in `CONTEXT.md`) — fully valid, content unchanged |
| **#13** (assessments contract) | Item 3 "Mini Project รายกลุ่ม — มีแล้ว" (no longer a deliverable); post-test placement 15:30–15:40 *inside the mini-project block* — the slot itself is re-decided by #17 (which keeps a post-test window in its brief but re-times it) | Pre-test/post-test: 10 items, 4 choices, comprehension-not-syntax, **same set both rounds**, Thai, paper-printable; "แบบฝึกหัดรายบุคคล = exercise.ipynb per module, no new media"; satisfaction survey as in-repo backup; storage in `assessments/` |

---

## 4. Impact on open tickets #14 and #15

### #14 (assessments/pretest_posttest.md + satisfaction_survey.md)

Scope verdict: **#14's task text is still executable with one clarification and one dependency.**

- Topic coverage: old scope "ครอบ M1–M6" maps exactly onto new M1–M6 (Python primer, tables, dirty data, charts, statistics, forecasting) — same six topics, same numbers, automation (new M7) excluded as before. The renumbering is *helpful*, not disruptive: no question needs re-aiming, only the label check.
- One trap: any question that implicitly assumes *statistics precede charts* (e.g. "อ่านผล describe เลือกการแปลผล") still works — describe is taught in new M5 before post-test regardless — but a question keyed to "the module right before charts" does not exist; verify none was written that way.
- Dependency: #14 must wait for **#17** (new timetable) to fix the post-test time reference and to confirm the pre-test slot (day-1 morning, unchanged in principle). Do not start before #17 closes.

### #15 (docx กบค. update on `docs/kobkoh-project-docx`)

Scope verdict: **#15 should be re-scoped and blocked — it is currently written against the dead structure.**

- Its four bullets assume the mini-project block exists: "แถวช่วง Mini Project (14:45–15:40): brief + เลือกข้อมูล 10 น. → ทำงาน + เตรียม pitch 35 น. → post-test 10 น.", "pitch ทุกกลุ่ม 1.5 นาที", the learner-prep line "นำไฟล์ข้อมูลงานตัวเองมา 1 ไฟล์…" (a มติ-#10 consequence — with no mini project there is no own-data requirement; the prep line likely drops unless #19's closing exercise introduces one).
- Correct blocking chain: **#15 blocked by #17** (new minutes-per-module timetable) **and by this mapping** (#20 → the module list/timetable text in the docx must reflect 7 modules, closing exercise, What's next at end of M7). The docx regenerating via `scripts/make_project_docx.py` is cheap; the blocker is *content decisions*, not tooling.
- Additional §6 wording changes for #15's checklist: replace any "Mini Project" deliverable language with "แบบฝึกปิดท้าย reproduce-a-figure" (mirroring the `CONTEXT.md` iron-rule change noted in map #16), keep the pre/post-test same-set note, keep the `assessments/` backup note.

Related sequencing note: ticket #19 (choose the research figure for the closing exercise) gates the *content* of the M7 closing-exercise addition, but not the move/rename work — production can start the mechanical restructure in parallel.

---

## 5. Producer checklist (concrete, ordered)

Base all work on `prototype/m8-mini-project` (freshest superset, มติ #12/#13 fixes included). One restructure PR against a production branch; re-run `scripts/check_materials.sh` after every step group.

**Mechanical restructure (can start now):**

1. [ ] `git mv day2/module5_charts day1/module4_charts` — all 5 files.
2. [ ] `git mv day2/module4_statistics day2/module5_statistics` — all 5 files.
3. [ ] Delete `day2/module8_mini_project/` from the production branch after archiving (step 10).
4. [ ] Update module labels M5→M4 / M4→M5 in the two moved modules' file headers (`# Module M…` in each .ipynb cell 1, `# explanation.md — Module M…`, `# function.md — Module M…`).
5. [ ] Apply the text edits listed in §2, in dependency order: M2 explanation L65 → M3 book cells 1 & 29 → old-M5/new-M4 explanation L11/L41/L81/L99 + book cells 2/9/10/23 → old-M4/new-M5 explanation L83/L108 + function.md prerequisite line + book cell 24 → M6 explanation L27 + solution cell 10 → M7 explanation L88 + Figure-2 line + book cell 14.
6. [ ] Repo-wide: README.md module table (8→7 rows), datasets/README.md โมดูล column, CONTEXT.md glossary (Mini Project → แบบฝึกปิดท้าย; What's-next → M7).
7. [ ] Gate: `scripts/check_materials.sh` must pass (it now picks up charts under day1 automatically).

**Content additions (after dependencies land):**

8. [ ] Wait for **#17** (timetable) → set M7 explanation's closing-slot minutes and the What's-next slot length; also confirm pre/post-test placement for #14.
9. [ ] Wait for **#19** (chosen research figure) → write the ~20–30 น. reproduce-a-figure closing exercise into `day2/module7_automation/` (final section of `exercise.ipynb` or a small extra notebook; no new functions; reuse the M8 `function.md` recap table as the hint map).
10. [ ] Mine M8: copy the What's-next 3-slide script (commit `30cd214` version) into M7 `explanation.md`, rewording slide 1's mini-project anchor to the closing exercise; archive all four M8 files to `archive/mini_project/` (or drop — producer's call, both acceptable).
11. [ ] Final gate + one full dry-run read-through of day1→day2 continuity (each module's closing brief matches the next module's opener).

**Downstream tickets (not this PR):**

12. [ ] #17 closes → then #14 produces `assessments/` (verify no statistics-before-charts assumption per §4) and #15 re-scopes its docx bullets to the 7-module timetable + closing exercise + What's next in M7.
