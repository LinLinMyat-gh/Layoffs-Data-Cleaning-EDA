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



## Tools Used
- MySQL
- SQL Window Functions
- Common Table Expressions (CTEs)
- Aggregate Functions



## Dataset
The dataset contains company layoff information including:
- Company
- Industry
- Country
- Total Laid Off
- Percentage Laid Off
- Funding Raised
- Dates


## Data Cleaning Process

### Removed Duplicates
- Identified and filtered duplicates using CTE
- Deleted duplicates 
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

### Before Cleaning
<img width="973" height="525" alt="image" src="https://github.com/user-attachments/assets/f3a73019-f295-4549-8e99-1cf703c6d35d" />

### After Cleaning
<img width="1027" height="525" alt="image" src="https://github.com/user-attachments/assets/67178f54-e675-4f52-9848-0a56c24a6fe6" />


## Exploratory Data Analysis

### Key Questions
- Which company had the highest layoffs?
- Which industry was most affected?
- Which country had the highest layoffs?
- What were the monthly layoff trends?
- Which companies ranked top in layoffs each year?

---
### Top Companies With Most Layoffs

```sql
SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company 
ORDER BY 2 DESC;
```

<img width="247" height="527" alt="image" src="https://github.com/user-attachments/assets/099e1b03-49d0-452b-b897-701ed19040dc" />

## Total Layoffs By Country

```sql
SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;
```

<img width="292" height="527" alt="image" src="https://github.com/user-attachments/assets/a6aa77d7-6b81-415a-abc5-d3ce1d980119" />


## Yearly Layoff Trends

```sql
SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;
```

<img width="253" height="142" alt="image" src="https://github.com/user-attachments/assets/ea9be2cc-daaa-473a-94bf-d2727146c281" />


## Rolling Total Analysis

```sql
WITH Rolling_Total AS
(
SELECT SUBSTRING(`date` , 1, 7) AS `month`, SUM(total_laid_off) as total_off
FROM layoffs_staging2
WHERE SUBSTRING(`date` , 1, 7) IS NOT NULL
GROUP BY `month`
ORDER BY 1
)
SELECT `month`, total_off, SUM(total_off) OVER(ORDER BY `month`) AS rolling_total
FROM Rolling_Total;
```

This analysis tracks cumulative layoffs over time using window functions.

<img width="250" height="522" alt="image" src="https://github.com/user-attachments/assets/fb04def1-0d8d-4bfa-b80d-87c6c28b079d" />


## Top 5 Companies With Highest Layoffs Per Year

Used:
```sql
WITH Company_Year(company, years, total_laid_off) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
), Company_Year_Rank AS
(
SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) as Ranking
FROM Company_Year
WHERE years IS NOT NULL
)
SELECT *
FROM Company_Year_Rank
WHERE Ranking <=5;
```

to rank companies based on yearly layoffs.

<img width="347" height="500" alt="image" src="https://github.com/user-attachments/assets/ca14caca-5813-473a-8560-ca25ffe07d4a" />


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



## Key Insights
- Tech industry experienced the highest layoffs.
- United States had the largest number of layoffs.
- Layoffs increased significantly during 2022–2023.
- Several companies reported 100% workforce layoffs.


