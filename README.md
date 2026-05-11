#  E-Commerce 360° Analytics

> **Full-cycle data analysis project** using SQL, Python, Excel, and Power BI  
> on the Olist Brazilian E-Commerce dataset (100k+ orders, 2016–2018)

![SQL](https://img.shields.io/badge/SQL-PostgreSQL-336791?logo=postgresql)
![Python](https://img.shields.io/badge/Python-3.10-3776AB?logo=python)
![Excel](https://img.shields.io/badge/Excel-Dashboard-217346?logo=microsoftexcel)
![Power BI](https://img.shields.io/badge/Power_BI-Report-F2C811?logo=powerbi)

##  Project Overview
Analysis of 100,000+ e-commerce transactions to uncover revenue drivers,
customer behavior patterns, and operational inefficiencies.

##  Key Findings
- São Paulo generates 40% of revenue — geographic diversification is a growth lever
- Delivery speed is the #1 predictor of customer satisfaction (r = -0.63)
- 60%+ of customers are one-time buyers — retention is a massive opportunity
- November revenue spikes 120% — requires dedicated logistics planning

##  Tools & Approach
| Tool | Purpose |
|---|---|
| SQL (PostgreSQL) | Data extraction, RFM segmentation, revenue analysis |
| Python (Pandas, Seaborn, Plotly) | EDA, cleaning, statistical analysis, charts |
| Excel | KPI dashboard, pivot analysis, slicers |
| Power BI | Interactive 4-page report with DAX measures |

## 📊 Dashboard Preview
# E-Commerce Analytics Dashboard (Power BI Project)

## What i did in powerbi

## 1. Data Preparation (Power Query)
The raw datasets were cleaned and transformed inside Power Query:

- Fixed data types (dates, decimals, integers)
- Removed errors and filtered invalid records (e.g., non-delivered orders removed)
- Created calculated columns:
  - `delivery_days = delivery date − purchase date`
  - `total_value = price + freight_value`
- Kept only relevant columns in each table
- Aggregated payment data by `order_id` to remove duplicates

---


## 2. Category Enrichment
- Merged product table with category translation table
- Converted Portuguese categories to English
- Removed redundant category columns

---

## 3. Date Table Creation
A custom calendar table was created using DAX:

- Year, Month, Quarter, Week, Day Name
- Linked to `order_purchase_timestamp`
- Marked as official Date Table for time intelligence

---

## 4. DAX Measures
Key business KPIs were created:

- Total Revenue  
- Total Orders  
- Average Order Value  
- Average Review Score  
- Total Customers  
- Average Delivery Days  
- Revenue YoY Growth  
- Revenue MTD and YTD  

---

## 5. Dashboard Pages

### Executive Overview
- Revenue, Orders, AOV, Reviews (KPIs)
- Revenue and Orders trend analysis
- Payment method distribution
- Revenue by customer state (map)

### Product Performance
- Revenue by product category (Top 15)
- Category vs review score analysis (scatter plot)

### Customer Insights
- Customer distribution by state
- Revenue contribution by region
- Key customer KPIs

### Delivery and Operations
- Delivery time analysis by state
- Relationship between delivery speed and reviews

---

## Key Insights
- Revenue distribution varies significantly by region
- Delivery time impacts customer review scores
- Certain product categories dominate total revenue
- Payment methods show distinct customer preferences

---

## Tools Used
- Power BI
- Power Query
- DAX
- Data Modeling (Star Schema)
- Data Visualization

---

## Outcome
This project demonstrates:
- End-to-end BI pipeline
- Strong data cleaning and modeling skills
- Advanced DAX calculations
- Interactive dashboard design for business decision-making

## 🗂️ Repository Structure


## 📁 Dataset
[Olist Brazilian E-Commerce](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
