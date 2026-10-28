#!/usr/bin/env python3
"""
update_expected_results.py

Extracts actual execution outputs from exercise cells in `with_answer`
and fills them into the 'ผลลัพธ์ที่คาดหวัง' (Expected Result) markdown cells.
Can also dump the expected cells to a JSON mapping and apply them to `main`.
"""

import argparse
import glob
import json
import os
import re
import sys
from typing import Any, Dict, List

MODULE_NOTEBOOKS = [
    "day1/module1_python_primer/book.ipynb",
    "day1/module2_pandas_tables/book.ipynb",
    "day1/module3_dirty_data/book.ipynb",
    "day1/module4_charts/book.ipynb",
    "day2/module5_statistics/book.ipynb",
    "day2/module6_simple_forecasting/book.ipynb",
    "day2/module7_automation/book.ipynb",
]


def extract_output_from_cell(cell: Dict[str, Any]) -> Dict[str, str]:
    """
    Extracts output from a code cell.
    If an image/png display_data is found, returns type 'image' with base64 data.
    Otherwise, returns type 'text' with plain text content from stream/execute_result.
    """
    outputs = cell.get("outputs", [])

    # Check for image/png first
    for out in outputs:
        if out.get("output_type") == "display_data":
            data = out.get("data", {})
            if "image/png" in data:
                b64 = data["image/png"]
                if isinstance(b64, list):
                    b64 = "".join(b64)
                return {"type": "image", "content": b64.strip()}

    # Collect text outputs
    text_parts = []
    for out in outputs:
        otype = out.get("output_type")
        if otype == "stream":
            text_parts.append("".join(out.get("text", [])))
        elif otype == "execute_result":
            data = out.get("data", {})
            if "text/plain" in data:
                val = data["text/plain"]
                if isinstance(val, list):
                    text_parts.append("".join(val))
                else:
                    text_parts.append(str(val))

    full_text = "".join(text_parts).rstrip("\r\n")
    return {"type": "text", "content": full_text}


def format_expected_result_markdown(output_info: Dict[str, str], alt_text: str = "") -> str:
    """
    Formats the expected result container HTML.
    """
    if output_info["type"] == "image":
        alt_attr = f' alt="{alt_text}"' if alt_text else ' alt="กราฟผลลัพธ์ที่คาดหวัง"'
        img_tag = (
            f'<img src="data:image/png;base64,{output_info["content"]}"{alt_attr}'
            ' style="max-width:100%; border-radius:4px; margin-top:8px;" />'
        )
        return (
            '<div style="background-color:#e8f1fb; border-left:4px solid #2b6cb0;'
            ' padding:10px 14px; border-radius:4px; color:#123d6b;">\n\n'
            '**ผลลัพธ์ที่คาดหวัง**\n\n'
            f'{img_tag}\n\n'
            '</div>'
        )
    else:
        text_content = output_info["content"]
        return (
            '<div style="background-color:#e8f1fb; border-left:4px solid #2b6cb0;'
            ' padding:10px 14px; border-radius:4px; color:#123d6b;">\n\n'
            '**ผลลัพธ์ที่คาดหวัง**\n\n'
            f'<pre style="margin:8px 0 0 0; white-space:pre-wrap; color:#123d6b;">{text_content}</pre>\n\n'
            '</div>'
        )


def to_notebook_source(text: str) -> List[str]:
    """Converts a multi-line string into notebook cell source list."""
    return text.splitlines(keepends=True)


def update_notebook_expected_results(nb: Dict[str, Any]) -> Dict[int, List[str]]:
    """
    Updates the expected result cells in the given notebook in place.
    Returns a dictionary mapping exercise index (0, 1, ...) to the new source lines.
    """
    expected_map: Dict[int, List[str]] = {}
    ex_idx = 0

    for i, cell in enumerate(nb.get("cells", [])):
        if cell.get("cell_type") == "markdown":
            src = "".join(cell.get("source", []))
            if "ผลลัพธ์ที่คาดหวัง" in src:
                # Preceding cell is the exercise code cell
                if i > 0 and nb["cells"][i - 1].get("cell_type") == "code":
                    code_cell = nb["cells"][i - 1]
                    output_info = extract_output_from_cell(code_cell)

                    # Extract existing pre text to preserve as alt_text for images
                    m = re.search(r"<pre[^>]*>(.*?)</pre>", src, re.DOTALL)
                    alt_text = m.group(1).strip() if m else ""

                    new_md = format_expected_result_markdown(output_info, alt_text=alt_text)
                    new_src = to_notebook_source(new_md)
                    cell["source"] = new_src
                    expected_map[ex_idx] = new_src
                    ex_idx += 1

    return expected_map


def apply_expected_results_to_notebook(
    nb: Dict[str, Any], expected_map: Dict[int, List[str]]
) -> int:
    """
    Applies the expected result source lines to the notebook's expected result cells.
    Returns the number of cells updated.
    """
    ex_idx = 0
    updated_count = 0

    for cell in nb.get("cells", []):
        if cell.get("cell_type") == "markdown":
            src = "".join(cell.get("source", []))
            if "ผลลัพธ์ที่คาดหวัง" in src:
                key = ex_idx if ex_idx in expected_map else str(ex_idx)
                if key in expected_map:
                    cell["source"] = expected_map[key]  # type: ignore
                    updated_count += 1
                ex_idx += 1

    return updated_count


def process_with_answer(notebook_paths: List[str]) -> Dict[str, Dict[int, List[str]]]:
    """
    Updates notebooks in with_answer branch in place, and returns all expected cell maps.
    """
    all_maps: Dict[str, Dict[int, List[str]]] = {}
    for path in notebook_paths:
        if not os.path.exists(path):
            print(f"Warning: {path} not found, skipping.")
            continue
        with open(path, "r", encoding="utf-8") as f:
            nb = json.load(f)

        expected_map = update_notebook_expected_results(nb)
        all_maps[path] = expected_map

        with open(path, "w", encoding="utf-8") as f:
            json.dump(nb, f, ensure_ascii=False, indent=1)
            f.write("\n")
        print(f"Updated {len(expected_map)} exercises in {path}")

    return all_maps


def process_main(notebook_paths: List[str], all_maps: Dict[str, Dict[int, List[str]]]):
    """
    Applies expected cell maps to main branch notebooks in place.
    """
    for path in notebook_paths:
        if path not in all_maps:
            print(f"Warning: No expected mapping for {path}, skipping.")
            continue
        if not os.path.exists(path):
            print(f"Warning: {path} not found, skipping.")
            continue
        with open(path, "r", encoding="utf-8") as f:
            nb = json.load(f)

        count = apply_expected_results_to_notebook(nb, all_maps[path])

        with open(path, "w", encoding="utf-8") as f:
            json.dump(nb, f, ensure_ascii=False, indent=1)
            f.write("\n")
        print(f"Applied {count} expected result cells to {path}")


def main():
    parser = argparse.ArgumentParser(description="Update expected results in course notebooks.")
    parser.add_argument("--target", choices=["with_answer", "main"], help="Target branch mode.")
    parser.add_argument("--dump-expected-map", help="File path to dump expected cells mapping JSON.")
    parser.add_argument("--apply-from-map", help="File path of JSON mapping to apply to current notebooks.")
    args = parser.parse_args()

    notebooks = [p for p in MODULE_NOTEBOOKS if os.path.exists(p)]
    if not notebooks:
        notebooks = sorted(glob.glob("day*/module*/book.ipynb"))

    if args.target == "with_answer" or args.dump_expected_map:
        all_maps = process_with_answer(notebooks)
        if args.dump_expected_map:
            with open(args.dump_expected_map, "w", encoding="utf-8") as f:
                json.dump(all_maps, f, ensure_ascii=False, indent=2)
            print(f"Dumped expected results mapping to {args.dump_expected_map}")

    elif args.apply_from_map or args.target == "main":
        map_file = args.apply_from_map or "expected_cells.json"
        if not os.path.exists(map_file):
            print(f"Error: mapping file {map_file} not found.", file=sys.stderr)
            sys.exit(1)
        with open(map_file, "r", encoding="utf-8") as f:
            all_maps = json.load(f)
        process_main(notebooks, all_maps)
    else:
        parser.print_help()


if __name__ == "__main__":
    main()
