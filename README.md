# SQL Data Cleaning & Exploratory Data Analysis - Layoffs Dataset

## Project Overview
This project focuses on cleaning and analyzing a global layoffs dataset using MySQL.

The project includes:
- Data Cleaning
- Data Standardization
- Handling Null Values
- Exploratory Data Analysis (EDA)
- Trend Analysis
- Rolling Totals
- Company Rankings

---

## Tools Used
- MySQL
- SQL Window Functions
- Common Table Expressions (CTEs)
- Aggregate Functions

---

## Dataset
The dataset contains company layoff information including:
- Company
- Industry
- Country
- Total Laid Off
- Percentage Laid Off
- Funding Raised
- Dates

---

## Data Cleaning Process

### Removed Duplicates
Used:
```sql
ROW_NUMBER() OVER(...)
```

### Standardized Data
- Trimmed extra spaces
- Fixed inconsistent industry names
- Corrected country values

### Handled Null Values
- Converted blanks to NULL
- Filled missing industries using self joins
- Removed irrelevant rows

### Formatted Dates
Converted text dates into MySQL DATE format.

---

## Exploratory Data Analysis

### Key Questions
- Which company had the highest layoffs?
- Which industry was most affected?
- Which country had the highest layoffs?
- What were the monthly layoff trends?
- Which companies ranked top in layoffs each year?

---

## SQL Concepts Used
- CTEs
- Window Functions
- DENSE_RANK()
- Aggregate Functions
- GROUP BY
- ORDER BY
- SELF JOIN
- SUBSTRING()
- YEAR()

---

## Key Insights
- Tech industry experienced the highest layoffs.
- United States had the largest number of layoffs.
- Layoffs increased significantly during 2022–2023.
- Several companies reported 100% workforce layoffs.


