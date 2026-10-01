#!/usr/bin/env bash
# Re-download every course dataset from its canonical source.
#   scripts/download_datasets.sh
# The committed copies in datasets/ are the working copies; this script
# rebuilds them from scratch (e.g. for the PM2.5 full-file -> extract step).
# See datasets/README.md and docs/research/dataset-candidates.md for
# license/citation details. Run from the repo root (needs internet + uv).
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p datasets/{adult,coffee_quality,noaa_co2,air_passengers,pcd_pm25_2025,tourist_arrivals,palmer_penguins,gapminder,rice_price_105,pcd_pm25_legacy}

# UCI Adult (CC BY 4.0, DOI 10.24432/C5XW20)
curl -sSL -o /tmp/adult.zip "https://archive.ics.uci.edu/static/public/2/adult.zip"
unzip -o -q /tmp/adult.zip -d datasets/adult/
rm -f datasets/adult/Index datasets/adult/old.adult.names

# Coffee Quality Database (MIT repo; data © CQI)
curl -sSL -o datasets/coffee_quality/arabica_data_cleaned.csv \
  "https://raw.githubusercontent.com/jldbc/coffee-quality-database/master/data/arabica_data_cleaned.csv"
curl -sSL -o datasets/coffee_quality/robusta_data_cleaned.csv \
  "https://raw.githubusercontent.com/jldbc/coffee-quality-database/master/data/robusta_data_cleaned.csv"

# NOAA globally-averaged CO2 (free with required credit; DOI 10.15138/9N0H-ZH07)
curl -sSL -o datasets/noaa_co2/co2_mm_gl.csv \
  "https://gml.noaa.gov/webdata/ccgg/trends/co2/co2_mm_gl.csv"

# AirPassengers (Box & Jenkins 1976; file via Rdatasets)
curl -sSL -o datasets/air_passengers/AirPassengers.csv \
  "https://raw.githubusercontent.com/vincentarelbundock/Rdatasets/master/csv/datasets/AirPassengers.csv"

# PCD PM2.5 daily 2025 (Open Data Common) — full file is 8.5 MB / 105 stations
curl -sSL -o /tmp/pm25_full.csv \
  "https://pcd.gdcatalog.go.th/dataset/78495048-ce78-4b53-b6b9-63610fc9e841/resource/131fb591-1475-408d-bc4e-ec589763f08d/download/pm2.5_daily_2025_single_sheet.csv"
# Extract 15 stations (กทม. 12 + เชียงใหม่ 2 + หาดใหญ่ 1); full file is NOT committed
uv run python - <<'EOF'
import pandas as pd
pm = pd.read_csv('/tmp/pm25_full.csv', encoding='utf-8-sig')
pick = ['02T','03T','05T','10T','11T','12T','50T','52T','53T','54T','59T','61T','35T','36T','44T']
pm[pm['station_code'].isin(pick)].to_csv(
    'datasets/pcd_pm25_2025/pm25_daily_2025_15stations.csv', index=False, encoding='utf-8-sig')
print("extract rows:", len(pm[pm['station_code'].isin(pick)]))
EOF

# International tourist arrivals to Thailand (CC Attribution) — JSON from source
curl -sSL -o datasets/tourist_arrivals/international-tourist-arrivals-to-thailand.json \
  "https://data.go.th/dataset/6342a7c6-7260-4bd2-bdd4-29855166b1ce/resource/a9460d54-44d0-4584-bf36-c3f7242dfba2/download/international-tourist-arrivals-to-thailand.json"
uv run python - <<'EOF'
import json, pandas as pd
d = json.load(open('datasets/tourist_arrivals/international-tourist-arrivals-to-thailand.json'))['data']
pd.DataFrame(d).to_csv('datasets/tourist_arrivals/tourist_arrivals_by_country.csv', index=False)
EOF

# Palmer Penguins (CC0)
curl -sSL -o datasets/palmer_penguins/penguins.csv \
  "https://raw.githubusercontent.com/allisonhorst/palmerpenguins/main/inst/extdata/penguins.csv"

# Gapminder excerpt (CC BY 4.0)
curl -sSL -o datasets/gapminder/gapminderDataFiveYear.csv \
  "https://raw.githubusercontent.com/plotly/datasets/master/gapminderDataFiveYear.csv"

# OAE rice105 via data.go.th datastore_search (direct OAE file URL is Cloudflare-403)
curl -sSL "https://data.go.th/api/3/action/datastore_search?resource_id=d9f8ed5c-6072-4ac0-a717-a30850216a39&limit=100" \
  -o /tmp/rice.json
uv run python - <<'EOF'
import json, pandas as pd
d = json.load(open('/tmp/rice.json'))['result']
pd.DataFrame(d['records']).to_csv('datasets/rice_price_105/rice105_monthly.csv', index=False)
EOF

# PCD legacy dirty-file drill, ปี 2556, TIS-620 encoding (Open Data Common)
# NOTE: ใช้ resource path เต็ม — URL แบบย่อ /download/... ได้หน้า 404 HTML (ดู research doc correction)
curl -sSL -o datasets/pcd_pm25_legacy/aqpm2.5bangkokmetropolitanregion2556.csv \
  "https://pcd.gdcatalog.go.th/dataset/78495048-ce78-4b53-b6b9-63610fc9e841/resource/f166a354-724a-4a9a-bc50-7df0ad50a4a8/download/aqpm2.5bangkokmetropolitanregion2556.csv"

echo "done — see datasets/README.md for licenses and citations"
