# Fill Executed Outputs into Expected Result Cells Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Fill the executed outputs from exercise cells into the "**ผลลัพธ์ที่คาดหวัง**" (Expected Result) markdown cells across all 7 module `book.ipynb` files in both the `with_answer` and `main` branches.

**Architecture:** A standalone Python script `scripts/update_expected_results.py` inspects the executed exercise outputs in `with_answer` notebooks. For textual outputs (streams and execute_results), it formats the exact text into `<pre>` tags. For graphical outputs (matplotlib charts in Module 4 and Module 5 Ex 7), it embeds the chart image via `<img src="data:image/png;base64,...">` inside the styled container. The script applies these expected result cells to `with_answer`, regenerates `book.html`, and transfers the identical expected result cells to `main` while preserving `main`'s unanswered exercise code cells.

**Tech Stack:** Python 3, `nbformat` / standard `json`, `jupyter nbconvert`, `bash`, `git`.

**Spec:** User request to populate "**ผลลัพธ์ที่คาดหวัง**" cells with actual executed outputs across all modules in both `with_answer` and `main` branches.

---

## Global Constraints

- Never modify the non-exercise content or code structure in `book.ipynb`.
- In `main`, exercise code cells must remain unanswered (`# ลองเขียนโค้ดของคุณที่นี่` comments only, no answers).
- In `with_answer`, exercise code cells must retain their verified working answers and executed output state.
- The `**ผลลัพธ์ที่คาดหวัง**` cells in both branches must be 100% identical in markdown source.
- All notebooks must pass `./scripts/check_materials.sh` (nbqa flake8 and headless notebook execution).
- Attribution on git commits:
  Co-Authored-By: Claude Code <noreply@anthropic.com>

## Review Focus

1. **Chart image embedding**: Matplotlib plots in Module 4 (Ex 1-8) and Module 5 (Ex 7) must render properly in Jupyter and `book.html` without breaking notebook format or exceeding reasonable size constraints.
2. **Whitespace and formatting**: Exact whitespace and newlines from stdout/execute_result (e.g. pandas table alignment, series dtype lines) must be preserved in `<pre>` tags.
3. **Exercise pairing accuracy**: Expected result cells must precisely map to their immediate preceding exercise code cell across all 56 exercises.
4. **Main branch purity**: When transferring updated expected result cells to `main`, no answers or execution metadata must leak into `main`'s exercise code cells.
5. **Quality gate compliance**: Both branches must pass `./scripts/check_materials.sh` with 0 lint errors and 0 execution failures.

---

### Task 1: Create implementation plan

- [x] **Step 1: Inspect repository structure, branch differences, and notebook cell formats**
- [x] **Step 2: Document approach and write implementation plan**
- [x] **Step 3: Save plan to `docs/superpowers/plans/2026-10-28-fill-expected-results-notebooks.md`**

---

### Task 2: Develop output extraction and notebook updating script

**Files:**
- Create: `scripts/update_expected_results.py`
- Test: `tests/test_update_expected_results.py`

**Interfaces:**
- Consumes: `with_answer` notebook JSON structure (`nbformat` v4)
- Produces: Formatted HTML string for "**ผลลัพธ์ที่คาดหวัง**" markdown cell:
  - For text: `<div style="background-color:#e8f1fb; border-left:4px solid #2b6cb0; padding:10px 14px; border-radius:4px; color:#123d6b;">\n\n**ผลลัพธ์ที่คาดหวัง**\n\n<pre style="margin:8px 0 0 0; white-space:pre-wrap; color:#123d6b;">{output_text}</pre>\n\n</div>`
  - For image: `<div style="background-color:#e8f1fb; border-left:4px solid #2b6cb0; padding:10px 14px; border-radius:4px; color:#123d6b;">\n\n**ผลลัพธ์ที่คาดหวัง**\n\n<img src="data:image/png;base64,{base64_data}" alt="{description}" style="max-width:100%; border-radius:4px; margin-top:8px;" />\n\n</div>`

- [ ] **Step 1: Write test in `tests/test_update_expected_results.py`**
  Verify text output extraction, image output extraction, and container HTML generation.
- [ ] **Step 2: Run test to verify it fails**
  Run: `python3 -m pytest tests/test_update_expected_results.py`
  Expected: FAIL (module not found)
- [ ] **Step 3: Implement `scripts/update_expected_results.py`**
  Implement extraction and update logic.
- [ ] **Step 4: Run test to verify it passes**
  Run: `python3 -m pytest tests/test_update_expected_results.py`
  Expected: PASS

---

### Task 3: Update expected results and HTML in with_answer branch

**Files:**
- Modify: `day1/module1_python_primer/book.ipynb`
- Modify: `day1/module2_pandas_tables/book.ipynb`
- Modify: `day1/module3_dirty_data/book.ipynb`
- Modify: `day1/module4_charts/book.ipynb`
- Modify: `day2/module5_statistics/book.ipynb`
- Modify: `day2/module6_simple_forecasting/book.ipynb`
- Modify: `day2/module7_automation/book.ipynb`
- Modify: All corresponding `book.html` files in `day*/module*/`

- [ ] **Step 1: Execute script on with_answer branch to update all 7 notebooks**
  Run: `python3 scripts/update_expected_results.py --target with_answer`
- [ ] **Step 2: Run quality gate on with_answer**
  Run: `./scripts/check_materials.sh`
  Expected: All checks PASS (lint and execution)
- [ ] **Step 3: Re-export HTML files using jupyter nbconvert**
  Run: `for nb in day*/module*/book.ipynb; do jupyter nbconvert --to html "$nb"; done`
- [ ] **Step 4: Verify git status and commit on with_answer**
  Commit message:
  ```
  Fill executed outputs into expected result cells

  Co-Authored-By: Claude Code <noreply@anthropic.com>
  ```

---

### Task 4: Update expected results in main branch

**Files:**
- Modify: All 7 `day*/module*/book.ipynb` on `main` branch

- [ ] **Step 1: Export expected result cells mapping from with_answer**
  Run: `python3 scripts/update_expected_results.py --dump-expected-map expected_cells.json`
- [ ] **Step 2: Switch to main branch**
  Run: `git checkout main`
- [ ] **Step 3: Apply expected result cells mapping to main's book.ipynb files**
  Run: `python3 scripts/update_expected_results.py --apply-to-main expected_cells.json`
- [ ] **Step 4: Verify with_answer vs main expected result equality**
  Ensure all `ผลลัพธ์ที่คาดหวัง` cells are identical between `main` and `with_answer`.
  Ensure exercise code cells in `main` remain unanswered.
- [ ] **Step 5: Run quality gate on main**
  Run: `./scripts/check_materials.sh`
  Expected: All checks PASS (lint and execution)
- [ ] **Step 6: Commit on main branch**
  Commit message:
  ```
  Fill executed outputs into expected result cells

  Co-Authored-By: Claude Code <noreply@anthropic.com>
  ```

---

### Task 5: Verify both branches and summarize changes

- [ ] **Step 1: Diff main vs with_answer to confirm the only notebook differences are answers in exercise code cells**
  Run: verify diff between main and with_answer
- [ ] **Step 2: Clean up temporary files**
- [ ] **Step 3: Present clear summary of updated exercises and expected results to user**
