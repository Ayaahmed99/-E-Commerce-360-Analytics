# 🛒 E-Commerce 360° Analytics

<div align="center">

> **Full-cycle data analysis project** using SQL, Python, Excel, and Power BI  
> on the [Olist Brazilian E-Commerce](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) dataset — 100k+ orders · 2016–2018

[![SQL](https://img.shields.io/badge/SQL-PostgreSQL-336791?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![Python](https://img.shields.io/badge/Python-3.10-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org/)
[![Excel](https://img.shields.io/badge/Excel-Dashboard-217346?style=for-the-badge&logo=microsoftexcel&logoColor=white)](https://www.microsoft.com/excel)
[![Power BI](https://img.shields.io/badge/Power_BI-Report-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)](https://powerbi.microsoft.com/)

</div>

---

## 📌 Table of Contents

- [Project Overview](#-project-overview)
- [Key Findings](#-key-findings)
- [Dataset](#-dataset)
- [Repository Structure](#️-repository-structure)
- [Tools & Approach](#️-tools--approach)
  - [SQL — Data Extraction & Segmentation](#1-sql--data-extraction--segmentation)
  - [Python — EDA & Statistical Analysis](#2-python--eda--statistical-analysis)
  - [Excel — KPI Dashboard](#3-excel--kpi-dashboard)
  - [Power BI — Interactive Report](#4-power-bi--interactive-report)
- [Power BI Deep Dive](#-power-bi-deep-dive)
- [How to Run](#-how-to-run)
- [Contact](#-contact)

---

## 📖 Project Overview

This end-to-end analytics project explores **100,000+ e-commerce transactions** from Olist, Brazil's largest marketplace aggregator, to answer three core business questions:

| Business Question | Approach |
|---|---|
| **Where does revenue come from?** | Geographic & category segmentation via SQL + Power BI |
| **Why do customers churn?** | RFM analysis, cohort retention modeling in Python |
| **What drives satisfaction?** | Delivery time correlation with review scores |

The pipeline goes from raw relational data all the way to an executive-ready interactive Power BI report — covering data cleaning, statistical analysis, and business storytelling.

---

## 💡 Key Findings

| # | Finding | Implication |
|---|---|---|
| 🗺️ 1 | **São Paulo generates 40% of revenue** | Geographic diversification is an untapped growth lever |
| 🚚 2 | **Delivery speed is the #1 satisfaction predictor** (r = −0.63) | Logistics investment has a direct impact on ratings |
| 🔁 3 | **60%+ of customers are one-time buyers** | Retention programs could unlock significant recurring revenue |
| 📅 4 | **November revenue spikes +120%** | Dedicated logistics pre-planning is required for peak season |

---

## 📁 Dataset

**Source:** [Olist Brazilian E-Commerce Public Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) (Kaggle)

The dataset contains a relational schema with 9 interconnected tables:

```
olist_orders_dataset              — order lifecycle & timestamps
olist_order_items_dataset         — line items, price, freight
olist_order_payments_dataset      — payment method & installments
olist_order_reviews_dataset       — customer review scores & comments
olist_customers_dataset           — customer location & IDs
olist_sellers_dataset             — seller location & IDs
olist_products_dataset            — product attributes & category
olist_geolocation_dataset         — zip code → lat/lng mapping
product_category_name_translation — Portuguese → English categories
```

---

## 🗂️ Repository Structure

```
ecommerce-360-analytics/
│
├── 📂 sql/
│   ├── 01_schema_setup.sql          # Table creation & constraints
│   ├── 02_revenue_analysis.sql      # Revenue by region, category, time
│   ├── 03_rfm_segmentation.sql      # Recency, Frequency, Monetary scoring
│   └── 04_delivery_analysis.sql     # Delivery KPIs by state & carrier
│
├── 📂 python/
│   ├── 01_data_cleaning.ipynb       # Null handling, type fixing, deduplication
│   ├── 02_eda.ipynb                 # Distributions, outliers, correlations
│   ├── 03_cohort_analysis.ipynb     # Customer retention cohort heatmaps
│   └── 04_visualizations.ipynb     # Publication-ready Seaborn/Plotly charts
│
├── 📂 excel/
│   └── kpi_dashboard.xlsx           # Pivot tables, slicers, KPI summary
│
├── 📂 powerbi/
│   └── ecommerce_report.pbix        # 4-page interactive Power BI report
│
├── 📂 data/
│   └── (place raw Kaggle CSVs here — not tracked by git)
│
├── 📂 assets/
│   └── screenshots/                 # Dashboard preview images
│
├── .gitignore
├── requirements.txt
└── README.md
```

---

## 🛠️ Tools & Approach

### 1. SQL — Data Extraction & Segmentation

> **Tool:** PostgreSQL · **Purpose:** Foundation of all downstream analysis

- Joined 9 relational tables using order/customer/seller keys
- Built RFM (Recency, Frequency, Monetary) segmentation to classify customer tiers
- Computed delivery delay KPIs per state and compared against estimated delivery dates
- Revenue sliced by geography, product category, payment method, and time period

**Key queries:**
```sql
-- Example: RFM Segmentation
SELECT
  customer_id,
  MAX(order_purchase_timestamp)::date         AS last_order_date,
  COUNT(DISTINCT order_id)                    AS frequency,
  SUM(payment_value)                          AS monetary
FROM orders o
JOIN payments p USING (order_id)
WHERE order_status = 'delivered'
GROUP BY customer_id;
```

---

### 2. Python — EDA & Statistical Analysis

> **Libraries:** Pandas · NumPy · Seaborn · Plotly · Matplotlib

- Cleaned and validated all 9 tables (nulls, duplicates, type mismatches, date parsing)
- Computed Pearson correlation between `delivery_days` and `review_score` → **r = −0.63**
- Built monthly cohort retention heatmaps to visualise churn patterns
- Visualised revenue seasonality, category distributions, and geographic spread

**Tech stack:**
```python
# requirements.txt
pandas==2.1.0
numpy==1.26.0
seaborn==0.13.0
plotly==5.18.0
matplotlib==3.8.0
sqlalchemy==2.0.20      # PostgreSQL connection
psycopg2-binary==2.9.9
jupyter==1.0.0
```

---

### 3. Excel — KPI Dashboard

> **Purpose:** Accessible, shareable snapshot for non-technical stakeholders

- Pivot tables sliced by region, category, and time period
- Interactive slicers for order status, payment method, and state
- KPI cards: Total Revenue · Total Orders · AOV · Avg. Review · Avg. Delivery Days
- Conditional formatting to highlight underperforming states and categories

---

### 4. Power BI — Interactive Report

> **Purpose:** Executive-ready, interactive 4-page report with full drill-through

See [Power BI Deep Dive](#-power-bi-deep-dive) below for full detail.

---

## 📊 Power BI Deep Dive

### Data Preparation (Power Query)

All raw CSVs were loaded and transformed inside Power Query:

- Fixed data types (dates → `datetime`, prices → `decimal`, IDs → `text`)
- Filtered out non-delivered orders to focus on completed transactions
- Created calculated columns:
  - `delivery_days = [delivery_date] - [purchase_date]` (duration in days)
  - `total_value = [price] + [freight_value]`
- Aggregated `order_payments` by `order_id` to eliminate row-level duplicates
- Merged products with category translation table (Portuguese → English)

---

### Data Model (Star Schema)

```
                    ┌─────────────┐
                    │  DimDate    │
                    └──────┬──────┘
                           │
┌──────────────┐    ┌──────▼──────┐    ┌──────────────┐
│ DimCustomer  ├────│  FactOrders │────┤  DimProduct  │
└──────────────┘    └──────┬──────┘    └──────────────┘
                           │
              ┌────────────┼────────────┐
              │            │            │
       ┌──────▼─────┐ ┌───▼────┐ ┌────▼──────┐
       │ DimSeller  │ │DimGeo  │ │DimPayment │
       └────────────┘ └────────┘ └───────────┘
```

---

### DAX Measures

```dax
Total Revenue     = SUMX(FactOrders, FactOrders[total_value])
Total Orders      = DISTINCTCOUNT(FactOrders[order_id])
Avg Order Value   = DIVIDE([Total Revenue], [Total Orders])
Avg Review Score  = AVERAGE(FactOrders[review_score])
Avg Delivery Days = AVERAGE(FactOrders[delivery_days])

Revenue YoY Growth =
  VAR CurrentYear = [Total Revenue]
  VAR PriorYear   = CALCULATE([Total Revenue], SAMEPERIODLASTYEAR(DimDate[Date]))
  RETURN DIVIDE(CurrentYear - PriorYear, PriorYear)

Revenue MTD = TOTALMTD([Total Revenue], DimDate[Date])
Revenue YTD = TOTALYTD([Total Revenue], DimDate[Date])
```

---

### Report Pages

#### Page 1 — Executive Overview
- KPI cards: Revenue · Orders · AOV · Avg. Review Score
- Line chart: Revenue & Orders trend over time
- Donut chart: Payment method distribution
- Filled map: Revenue by customer state (Brazil)

#### Page 2 — Product Performance
- Bar chart: Top 15 categories by revenue
- Scatter plot: Category revenue vs. average review score
- Table: Category-level breakdown with conditional formatting

#### Page 3 — Customer Insights
- Map: Customer distribution by state
- Bar chart: Revenue contribution by region
- KPI cards: Total Customers · Repeat Rate · Avg. Orders per Customer

#### Page 4 — Delivery & Operations
- Bar chart: Average delivery days by state
- Scatter plot: Delivery days vs. review score (with trend line)
- KPI: % of orders delivered on or before estimated date

---

## ▶️ How to Run

### Prerequisites
```bash
# Python environment
pip install -r requirements.txt

# PostgreSQL — create a database and run SQL scripts in order:
psql -U postgres -d ecommerce -f sql/01_schema_setup.sql
psql -U postgres -d ecommerce -f sql/02_revenue_analysis.sql
# ... and so on
```

### Jupyter Notebooks
```bash
jupyter notebook python/
```

### Power BI
1. Open `powerbi/ecommerce_report.pbix` in Power BI Desktop
2. Update the data source path to your local CSV folder
3. Refresh the model

---

## 📬 Contact

Have questions or feedback? Feel free to open an issue or reach out.

---

<div align="center">

*Built with curiosity, coffee, and a lot of GROUP BY clauses.*

</div>
