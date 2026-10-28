import os
import sys

# Add scripts directory to path
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "scripts")))

from update_expected_results import (
    extract_output_from_cell,
    format_expected_result_markdown,
    update_notebook_expected_results,
    apply_expected_results_to_notebook,
)


def test_extract_stream_output():
    code_cell = {
        "cell_type": "code",
        "outputs": [
            {
                "name": "stdout",
                "output_type": "stream",
                "text": ["กาแฟเย็น\n", "45\n"],
            }
        ],
    }
    output_info = extract_output_from_cell(code_cell)
    assert output_info["type"] == "text"
    assert output_info["content"] == "กาแฟเย็น\n45"


def test_extract_execute_result_output():
    code_cell = {
        "cell_type": "code",
        "outputs": [
            {
                "output_type": "execute_result",
                "data": {
                    "text/plain": ["       country  year\n0  Afghanistan  1952\n"],
                },
            }
        ],
    }
    output_info = extract_output_from_cell(code_cell)
    assert output_info["type"] == "text"
    assert output_info["content"] == "       country  year\n0  Afghanistan  1952"


def test_extract_image_output():
    fake_b64 = "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk+M9QDwADhgGAWjR9awAAAABJRU5ErkJggg=="
    code_cell = {
        "cell_type": "code",
        "outputs": [
            {
                "output_type": "display_data",
                "data": {
                    "image/png": fake_b64,
                    "text/plain": ["<Figure size 640x480 with 1 Axes>"],
                },
            }
        ],
    }
    output_info = extract_output_from_cell(code_cell)
    assert output_info["type"] == "image"
    assert output_info["content"] == fake_b64


def test_format_expected_result_markdown_text():
    output_info = {"type": "text", "content": "40\nFalse"}
    md = format_expected_result_markdown(output_info)
    assert "**ผลลัพธ์ที่คาดหวัง**" in md
    assert "<pre style=\"margin:8px 0 0 0; white-space:pre-wrap; color:#123d6b;\">40\nFalse</pre>" in md


def test_format_expected_result_markdown_image():
    fake_b64 = "ABCD1234"
    output_info = {"type": "image", "content": fake_b64}
    md = format_expected_result_markdown(output_info, alt_text="กราฟเส้น")
    assert "**ผลลัพธ์ที่คาดหวัง**" in md
    assert f'<img src="data:image/png;base64,{fake_b64}" alt="กราฟเส้น"' in md


def test_update_notebook_expected_results():
    nb = {
        "cells": [
            {
                "cell_type": "markdown",
                "source": ["## ✏️ ลองเอง 1\n"],
            },
            {
                "cell_type": "code",
                "source": ["print(123)\n"],
                "outputs": [{"name": "stdout", "output_type": "stream", "text": ["123\n"]}],
            },
            {
                "cell_type": "markdown",
                "source": [
                    "<div style=\"...\">\n\n**ผลลัพธ์ที่คาดหวัง**\n\n<pre>old</pre>\n\n</div>"
                ],
            },
        ]
    }
    expected_map = update_notebook_expected_results(nb)
    assert len(expected_map) == 1
    assert "123" in "".join(nb["cells"][2]["source"])


def test_apply_expected_results_to_notebook():
    nb_main = {
        "cells": [
            {
                "cell_type": "markdown",
                "source": ["## ✏️ ลองเอง 1\n"],
            },
            {
                "cell_type": "code",
                "source": ["# ลองเขียนโค้ดของคุณที่นี่\n"],
                "outputs": [],
            },
            {
                "cell_type": "markdown",
                "source": [
                    "<div style=\"...\">\n\n**ผลลัพธ์ที่คาดหวัง**\n\n<pre>old</pre>\n\n</div>"
                ],
            },
        ]
    }
    expected_map = {0: ["<div style=\"...\">\n\n**ผลลัพธ์ที่คาดหวัง**\n\n<pre>123</pre>\n\n</div>"]}
    apply_expected_results_to_notebook(nb_main, expected_map)
    assert "123" in "".join(nb_main["cells"][2]["source"])
    assert "# ลองเขียนโค้ดของคุณที่นี่" in "".join(nb_main["cells"][1]["source"])
    assert nb_main["cells"][1]["outputs"] == []
