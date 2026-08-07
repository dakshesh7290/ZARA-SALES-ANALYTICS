# Zara Sales Analysis Dashboard

## Overview
An end-to-end retail sales analysis project built on a Zara product catalog dataset (252 products), covering data cleaning, SQL querying, Python EDA, and an interactive Power BI dashboard. The goal was to practice the full analyst workflow — from raw data to a shareable dashboard — while working with a real-world, imperfect dataset.

## Objective
To sharpen data cleaning, SQL querying, Python EDA, and dashboard-building skills by analyzing product-level sales data: identifying top-performing categories, evaluating the impact of promotions, and understanding revenue concentration across a retail product catalog.

## Tools Used
- **Excel** — Data cleaning, null handling, delimiter correction, pivot tables for a first-pass sanity check
- **SQL (SQLite)** — Queries for category performance, section (MAN/WOMAN) revenue, shelf-placement analysis, and average price/revenue by segment
- **Python (pandas, numpy)** — EDA on promotion impact and category revenue concentration
- **Power BI (Power BI Service)** — Interactive dashboard with KPI cards, slicers, bar charts, donut charts, and a matrix heatmap

## Dataset
A Zara product catalog scrape of 252 products, semicolon-delimited, with fields including price, sales volume, promotion status, seasonal flag, shelf position, category (`terms`), and section (MAN/WOMAN).

**Important limitation:** This is a single-day catalog snapshot (all rows scraped within the same ~20-minute window), not a transaction log across time. There is no real date range, region, or store field in the data — so month-over-month growth, YoY growth, region-wise revenue, and AOV-by-store (as originally planned) were not possible with this dataset. These were substituted with equivalent, honestly-scoped analyses (see below).

**Second limitation:** The WOMAN section is represented only by sweaters in this dataset — jackets, jeans, shoes, and t-shirts have no WOMAN rows at all. Any MAN vs WOMAN comparison in this project reflects that gap, not a real gender-based sales comparison.

## Process

### 1. Data Cleaning (Excel)
- Fixed semicolon delimiter on import (via Text to Columns)
- Dropped constant, non-informative columns: `Product Category`, `brand`, `currency`
- Filled missing `name` (1) and `description` (2) values
- Converted `price` and `Sales Volume` to numeric types; formatted `price` as currency
- Added a computed `Revenue = price × Sales Volume` column
- Converted the cleaned range into a formal Excel Table
- Built 3 pivot tables: terms × Promotion, terms × Seasonal, terms × Section (with sales volume)

**Initial finding:** Jackets emerged as the dominant category even at this stage, with the WOMAN-section gap already visible in the terms × section pivot.

### 2. SQL Analysis
All 4 queries below (see `queries.sql`) were run in SQLite and cross-checked against the Excel pivot results — all matched exactly.

1. **Top-selling categories** — revenue and units by `terms`
2. **Revenue by section** — MAN vs WOMAN (substitute for region-wise revenue, given no region field exists)
3. **Revenue by shelf position** — Aisle / End-cap / Front of Store (substitute for month-over-month growth, given no date range exists)
4. **Average price and revenue by category × section** — (substitute for AOV by store, given no store field exists)

### 3. Python EDA (pandas/numpy)
- Computed a `revenue` column (`price × Sales Volume`)
- Compared mean/median revenue for promoted vs non-promoted items
- Calculated each category's % share of total revenue

Both results were independently validated against the Excel and SQL findings — all three tools agreed.

### 4. Power BI Dashboard
Built in Power BI Service (browser-based, given a Mac environment without Power BI Desktop). The dashboard includes:
- 5 KPI cards (total revenue, total units, avg revenue/product, total products, and one additional metric)
- 3 interactive slicers (category, section, promotion)
- 2 bar charts (revenue by category, revenue by section)
- 2 donut charts (product count by category, product count by shelf position)
- 1 matrix heatmap (category × section breakdown)
- 2 text callouts highlighting the jacket-dominance finding and the WOMAN-section data caveat

## Key Findings
- **Jackets dominate revenue**: 68.2% of total revenue ($26.58M of $38.99M) comes from jackets alone, despite representing a smaller share of total product listings — confirmed independently across Excel, SQL, and Python.
- **Promotions show a real, if modest, lift**: Promoted items earned ~16% higher average revenue ($166,620 vs $143,895) and ~21% higher median revenue than non-promoted items — though the effect varies by category rather than being universal (jackets and shoes benefit; jeans, sweaters, and t-shirts see lower revenue when promoted).
- **Shelf placement matters**: Aisle-placed products led in both total revenue ($15.48M) and average revenue per product ($159,602), narrowly ahead of Front of Store; End-cap placement had higher unit volume but the lowest average revenue per product, suggesting it moves lower-priced items.
- **Data limitation**: The WOMAN section in this dataset is represented only by sweaters — not a full category comparison with MAN. This is a scope limitation of the source data, not a business insight.

## Files in This Repo
- `zara sales analysis raw.csv` — original raw dataset
- `zara sales cleaned.xlsx` — cleaned data (Excel Table + 3 pivot tables)
- `queries.sql` — all 4 SQL queries
- `eda.py` — Python EDA code (promotion comparison, category concentration)
- `zara sales analytics dashboard.pbix` — Power BI dashboard file

## What I Learned
This project reinforced that real-world datasets rarely match an original analysis plan exactly — the original brief called for region-wise revenue, MoM growth, and AOV by store, none of which this dataset could support. Adapting the plan honestly (shelf-position analysis instead of MoM, section instead of region) while clearly documenting the data's limitations felt like a more realistic analyst exercise than working with a "clean," purpose-built dataset would have been. Cross-validating the same finding (jacket dominance) across three separate tools was also a good confidence-check exercise in itself.
