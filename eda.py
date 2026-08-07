# ============================================================
# Zara Sales Analysis — Python EDA (pandas / numpy)
# Dataset: cleaned Zara product catalog (252 rows)
# ============================================================

import pandas as pd
import numpy as np

# ------------------------------------------------------------
# Load and sanity-check the data
# Note: source CSV is semicolon-delimited
# ------------------------------------------------------------
df = pd.read_csv('zara_sales_cleaned.csv', sep=';')

print(df.shape)          # (252, 16)
print(df.dtypes)         # confirm price = float64, Sales Volume = int64


# ------------------------------------------------------------
# Compute revenue (no revenue field exists in the raw data)
# ------------------------------------------------------------
df['revenue'] = df['price'] * df['Sales Volume']


# ------------------------------------------------------------
# Analysis 1: Promotion vs Revenue
# (substitute for discount-vs-revenue correlation — Promotion
# is a binary Yes/No field, not a continuous discount %, so a
# grouped mean/median comparison is used instead of a Pearson
# correlation coefficient)
# ------------------------------------------------------------
promo_summary = df.groupby('Promotion')['revenue'].agg(['mean', 'median', 'sum', 'count'])
print(promo_summary)

# Result:
#             mean         median         sum        count
# No      143894.62      123260.90   18994089.58     132
# Yes     166619.89      149243.65   19994386.90     120
#
# Finding: promoted items show ~16% higher mean revenue and
# ~21% higher median revenue than non-promoted items.


# ------------------------------------------------------------
# Analysis 2: Category revenue concentration
# (substitute for category-wise growth rates — no time
# dimension exists in this dataset, so % share of total
# revenue is used instead)
# ------------------------------------------------------------
category_share = df.groupby('terms')['revenue'].sum().sort_values(ascending=False)
category_pct = (category_share / category_share.sum() * 100).round(1)
print(category_pct)

# Result:
# terms
# jackets     68.2
# sweaters    10.5
# shoes        9.6
# t-shirts     9.5
# jeans        2.2
#
# Finding: jackets alone account for 68.2% of total revenue,
# consistent with the Excel pivot and SQL query results.
