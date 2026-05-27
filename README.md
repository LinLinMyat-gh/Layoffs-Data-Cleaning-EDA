# SQL Data Cleaning & Exploratory Data Analysis - Layoffs Dataset

This raw data is messy, contains duplicates and has missing information. We will see how to fix those data problems step-by-step in this project and look for trends in the data how layoffs grew over time in which categories.


## Data Cleaning Process

### Removed Duplicates
- I used a Common Table Expression (CTE) and the ROW_NUMBER() function to find identical rows because I found raw data had identical rows entered more than once.
<img width="1343" height="116" alt="image" src="https://github.com/user-attachments/assets/ad47774e-3c4e-4afb-a318-bad429f5aca4" />


<img width="1342" height="230" alt="image" src="https://github.com/user-attachments/assets/6cb95f5f-2ab3-4675-9989-60bc0f9e1239" />

(Deleting duplicates after creating a new table (which has the rows from CTE))
<img width="1337" height="83" alt="image" src="https://github.com/user-attachments/assets/4f3efe1a-8065-46c1-bae7-95cce4cdbc45" />



### Standardized Data
- I cleaned up text fields by removing extra spaces using TRIM() and fixing misspelled or inconsistent names.

### Handled Null Values
- As blank text fields were found so i changed them into NULL values. Then I used a Self Join to fill in missing industries based on other rows for the same company.

### Formatted Dates
- The date column was text strings so changed that into DATE format.
---

## Exploratory Data Analysis

### Areas to esplore
- Which company had the highest layoffs?
- Which industry was most affected?
- Which country had the highest layoffs?
- What were the monthly layoff trends?
- Which companies ranked top in layoffs each year?


### Top Companies With Most Layoffs
<img width="1433" height="112" alt="image" src="https://github.com/user-attachments/assets/77a3f9eb-fc91-481b-805c-a220f101799a" />


## Total Layoffs By Country
<img width="1455" height="113" alt="image" src="https://github.com/user-attachments/assets/a56a9993-ef7f-4a1d-89c6-11e224a8a186" />


## Yearly Layoff Trends
<img width="1437" height="112" alt="image" src="https://github.com/user-attachments/assets/194e58ea-0014-43af-b032-8cb06761c2ed" />


## Rolling Total Analysis
<img width="1440" height="352" alt="image" src="https://github.com/user-attachments/assets/157a74eb-15cd-4c70-8272-e631dfb4df67" />


## Top 5 Companies With Highest Layoffs Per Year

<img width="1457" height="341" alt="image" src="https://github.com/user-attachments/assets/3383117e-b4b8-42f6-89bf-2055fc55a147" />




## Key Insights
This trend proves that major tech companies heavily over-hired during the pandemic's online boom. When the economy cooled down in 2022 and 2023, these companies were forced to aggressively cut costs to fix their bloated headcounts.


