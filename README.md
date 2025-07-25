# Instacart Market Basket Analysis - SQL Database Project

![SQL](https://img.shields.io/badge/Database-SQL--Server-blue?logo=MicrosoftSQLServer&style=flat-square)
![Status](https://img.shields.io/badge/Project-Completed-brightgreen?style=flat-square)
![Dataset Size](https://img.shields.io/badge/Dataset-37M+_Records-orange?style=flat-square)
![EDA](https://img.shields.io/badge/EDA-Included-yellow?style=flat-square)
![Churn Prediction](https://img.shields.io/badge/Churn_Analysis-Included-red?style=flat-square)
![Customer Segmentation](https://img.shields.io/badge/Segmentation-Included-purple?style=flat-square)

This project is a comprehensive SQL-based analysis of Instacart’s transaction data. It includes database design, data import, constraints and indexing, ERD, exploratory data analysis (EDA), customer behavior insights, segmentation, churn prediction, and association rule mining.

---

## Project Tasks Overview

This project focuses on building and analyzing a relational database using **Instacart's Market Basket dataset**, consisting of over 37 million records. The goal was to:

- Design and build a SQL database from scratch
- Import and clean massive datasets using **SQL Server**
- Perform **exploratory data analysis (EDA)** on customer orders and products
- Analyze **shopping behavior**, **reorder patterns**, and **seasonal trends**
- Segment customers based on loyalty and spend
- Conduct **churn prediction**
- Identify **frequently bought product combinations**

## Important Note:
For full context, including project objectives, dataset description, and business questions, please refer to the [Project documentation](Instacart%20Market%20Basket%20Analysis%20Documentation.md)

### Task 1: Database Setup & Data Import

- **Database Created** to analyze Instacart data.
- **Tables Imported**: Aisles, Departments, Orders, Products, Order_Products_Train, Order_Products_Prior.
- **Handled Large Files** via Bulk Insert.
- **Data Cleaning**: Removed duplicates and NULLs.
- **Constraints Added**: Primary & Foreign Keys for data integrity.
- **Indexing**: `user_id` indexed in Orders table for performance.
- **ERD Created** to visualize schema.
All table creation, data population, and exploratory queries are included in the [instacart-market-basket-analysis.sql](Instacart%20Market%20Basket%20Analysis.sql) file.

### Task 2: Understanding the Dataset

- **Table Sizes**:
  - Orders: 3.4M rows
  - Products: ~50K products
  - Order Products Prior: 32M rows
- **Variables Defined**: product_id, aisle_id, department_id, user_id, order_dow, etc.
- **Exploratory Data Analysis**:
  - Peak ordering day: **Sunday**
  - Peak hours: **10AM–3PM**
  - Top product: **Bananas**
  - Most popular aisle: **Fresh Fruits, vegitables, yogurt**
  - Most popular department: **Produce, dairy & eggs, snacks**

### Task 3: Data Insights & Customer Behavior

- **First Products Added to Cart**: Bananas, Organic Strawberries, Avocados
- **Reorder Rate**: 59% of products are reorders,showing strong loyalty and routine behavior
- **Average Unique Products per Order**: 10
- **Seasonal Trends**:
  - Busiest day: **Sunday**
  - Peak month: **January**
- **Customer Segmentation**:
  - Frequent Buyers: 50+ orders
  - Loyal Customers: Reorder rate > 50%
- **Churn Prediction**:
  - 369,323 customers inactive in the last 30 days.
  - Identifying dormant users helps target win-back campaigns.
- **Product Association Rules**:
  - Top pairs: Organic Bananas + Hass Avocado, Organic Strawberries + Banana

---

## ERD (Entity Relationship Diagram)
> _ERD was created using SSMS Database Diagram Tool to visualize relationships clearly._  
> _<img width="767" height="373" alt="Screenshot 2025-07-25 070315 EDA" src="https://github.com/user-attachments/assets/6bf467aa-56a2-4557-912c-4870809fe112" />_

---

## Tech Stack

| Tool/Technology        | Purpose                                  |
|------------------------|------------------------------------------|
| **SQL Server**         | Database creation, indexing, constraints |
| **T-SQL**              | Querying and data manipulation           |
| **Bulk Insert**        | Efficiently loading large datasets       |
| **SSMS ERD Tool**      | Entity Relationship Diagram generation   |
| **Excel**              | Initial data inspection and formatting   |

---

## Key Skills Demonstrated

- SQL Data Cleaning & Import
- Relational Schema Design
- Indexing and Optimization
- Exploratory Data Analysis (EDA)
- Segmentation & Customer Behavior
- Churn Prediction
- Product Association Analysis

---

## Dataset Source

Instacart Market Basket Analysis dataset from [Kaggle](https://www.kaggle.com/c/instacart-market-basket-analysis/data).

---

## Let’s Connect

- [Read My Blog on Substack](https://substack.com/@theanalysisangle)
- [Twitter](https://x.com/Anastasia_Nmeso)  
- [FaceBook](https://www.facebook.com/share/16JoCo9x4F/)  
- [LinkedIn](www.linkedin.com/in/anastasia-nmesoma-947b20317)
