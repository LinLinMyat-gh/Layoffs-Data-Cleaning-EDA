# SQL Data Cleaning & Exploratory Data Analysis - Layoffs Dataset

## Project Overview
This raw data is messy, contains duplicates and has missing information. We will see how to fix those data problems step-by-step in this project and look for trends in the data how layoffs grew over time in which categories.

---
## Table of Contents

- Project Overview
- Data Cleaning Process
  - Removed Duplicates
  - Standardized Data
  - Handled Null Values
  - Removed Columns
- Exploratory Data Analysis
- Key Insights

---
## Data Cleaning Process

### 1. Removed Duplicates
- The raw dataset contained duplicate entries, which could affect the accuracy of the analysis. To address this, I first identified duplicate rows using the ROW_NUMBER() window function.

ROW_NUMBER() assigns a sequential number to rows that share the same values across selected columns. If multiple records are identical, the first occurrence receives 1, while subsequent duplicates receive higher numbers.
<img width="1343" height="116" alt="image" src="https://github.com/user-attachments/assets/ad47774e-3c4e-4afb-a318-bad429f5aca4" />

- After assigning row numbers, I used a Common Table Expression (CTE) to isolate and review duplicate records. This allowed me to verify which rows were duplicated before making any changes.
<img width="1342" height="230" alt="image" src="https://github.com/user-attachments/assets/6cb95f5f-2ab3-4675-9989-60bc0f9e1239" />

- To safely remove duplicates without modifying the original dataset, I created a new staging table with the same structure as the source table. I then inserted all records into this staging table while generating a row_num column using ROW_NUMBER().

Finally, I deleted records where row_num was greater than 1, keeping only the first occurrence of each duplicated record. This ensured that the dataset contained only unique records while preserving the integrity of the original data.
<img width="1337" height="83" alt="image" src="https://github.com/user-attachments/assets/4f3efe1a-8065-46c1-bae7-95cce4cdbc45" />



### 2. Standardized Data
- To improve data consistency, I cleaned and standardized text fields across the dataset.

First, I used the TRIM() function to remove unnecessary leading and trailing spaces from text values. This helps prevent issues where records appear different due to hidden spaces.
<img width="1267" height="230" alt="image" src="https://github.com/user-attachments/assets/73dc3983-bc69-46bc-bdf4-a755a46c0423" />


Next, I reviewed text columns for inconsistencies such as misspellings, variations in naming conventions, and different formats representing the same value. These entries were standardized so that identical categories, company names, industries, and locations were recorded consistently throughout the dataset.
<img width="1251" height="207" alt="image" src="https://github.com/user-attachments/assets/9a4c7a53-39ae-436b-a4a6-d162fcabee77" />

<img width="1252" height="220" alt="image" src="https://github.com/user-attachments/assets/60f705ec-9f59-4cf1-b255-27eaf73c649e" />

The date column was originally stored as text, which limited its usefulness for time-based analysis.
To make the data easier to analyze, I converted the text values into the SQL DATE data type.
Converting the column to a proper date format also allowed me to perform trend analysis over time
<img width="1242" height="318" alt="image" src="https://github.com/user-attachments/assets/3c6b0017-8f11-40fa-b6ec-0a6d07f872ac" />

### 3. Handled Null Values
- I found several blank text fields that represented missing information. To ensure consistency and make the data easier to work with, I converted these blank values into NULL values.

After identifying the missing data, I used a Self Join to populate missing industry information. Since some companies appeared multiple times in the dataset, I matched records from the same company and used existing industry values to fill in missing entries where possible.
<img width="1260" height="352" alt="image" src="https://github.com/user-attachments/assets/ffb8d9df-fdd1-4cba-9c46-2252ac473a23" />


### 4. Removed Columns
In the last stage, I deleted unnecessary columns.


---

## Exploratory Data Analysis
After cleaning the dataset, I conducted an exploratory data analysis to identify patterns and trends in layoffs across companies, industries, countries, and time periods.


## Areas Explored
Companies with the highest number of layoffs
Industries most affected by layoffs
Countries with the highest layoffs
Monthly and yearly layoff trends
Top companies by layoffs each year
Cumulative (rolling) layoff trends over time



### Total Layoffs By Country
<img width="1455" height="113" alt="image" src="https://github.com/user-attachments/assets/a56a9993-ef7f-4a1d-89c6-11e224a8a186" />


### Yearly Layoff Trends
<img width="1437" height="112" alt="image" src="https://github.com/user-attachments/assets/194e58ea-0014-43af-b032-8cb06761c2ed" />


### Rolling Total Analysis
<img width="1440" height="352" alt="image" src="https://github.com/user-attachments/assets/157a74eb-15cd-4c70-8272-e631dfb4df67" />


### Top 5 Companies With Highest Layoffs Per Year

<img width="1457" height="341" alt="image" src="https://github.com/user-attachments/assets/3383117e-b4b8-42f6-89bf-2055fc55a147" />



---
## Key Insights
What I saw in this analysis is it demonstrates how changing market conditions, economic uncertainty, and post-pandemic business adjustments contributed to one of the largest waves of corporate layoffs in recent years.


