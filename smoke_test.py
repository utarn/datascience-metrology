# Smoke test for the Data Skills with Python course environment.
# Run: uv run python smoke_test.py (or: python smoke_test.py in a venv)
# Prints library versions, then exercises the core workflow:
# pandas read/filter/groupby -> Excel roundtrip (openpyxl) -> matplotlib render.
# Ends with a clear pass/fail line.
#
# Deliberately NO scikit-learn / ML — this course teaches no ML (ADR-0002)
# and uses pandas, not Polars (ADR-0001).

import sys
import tempfile
from pathlib import Path

failures = []


def check(label, fn):
    try:
        fn()
        print(f"  OK   {label}")
    except Exception as exc:  # noqa: BLE001 - report any failure and continue
        failures.append((label, exc))
        print(f"  FAIL {label}: {exc}")


def check_versions():
    import matplotlib
    import numpy
    import openpyxl
    import pandas
    import pyarrow

    versions = {
        "python": sys.version.split()[0],
        "numpy": numpy.__version__,
        "pandas": pandas.__version__,
        "pyarrow": pyarrow.__version__,
        "matplotlib": matplotlib.__version__,
        "openpyxl": openpyxl.__version__,
    }
    for name, ver in versions.items():
        print(f"  {name}=={ver}")


def check_pandas():
    import pandas as pd
    df = pd.DataFrame({"x": [1.0, 2.0, 3.0], "group": ["a", "b", "a"]})
    with tempfile.TemporaryDirectory() as tmp:
        p = Path(tmp) / "smoke.csv"
        df.to_csv(p, index=False)
        back = pd.read_csv(p)
    assert back.shape == (3, 2)
    grouped = back.groupby("group")["x"].sum()
    assert grouped["a"] == 4.0


def check_excel():
    import pandas as pd
    df = pd.DataFrame({"name": ["A", "B"], "value": [10, 20]})
    with tempfile.TemporaryDirectory() as tmp:
        p = Path(tmp) / "smoke.xlsx"
        df.to_excel(p, index=False)  # needs openpyxl
        back = pd.read_excel(p)  # needs openpyxl
    assert back.shape == (2, 2) and back["value"].sum() == 30


def check_matplotlib():
    import matplotlib
    matplotlib.use("Agg")  # no display needed in a smoke test
    import matplotlib.pyplot as plt
    fig, ax = plt.subplots()
    ax.plot([0, 1, 2], [0, 1, 4])
    with tempfile.TemporaryDirectory() as tmp:
        fig.savefig(Path(tmp) / "smoke.png")
    plt.close(fig)


print("Data Skills with Python course environment smoke test")
print("Versions:")
check("versions import + print", check_versions)
print("Core workflow:")
check("pandas read/filter/groupby", check_pandas)
check("Excel roundtrip (openpyxl)", check_excel)
check("matplotlib render to file", check_matplotlib)

print()
if failures:
    print("ไม่ผ่าน (FAIL) — environment is NOT ready:")
    for label, exc in failures:
        print(f"  - {label}: {exc}")
    sys.exit(1)
print("ผ่าน (PASS) — environment is ready. สภาพแวดล้อมพร้อมใช้งาน")
