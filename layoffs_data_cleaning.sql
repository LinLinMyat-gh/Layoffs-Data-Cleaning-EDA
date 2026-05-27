-- World layoffs Data Cleaning Projects
-- 1.Remove Duplicates
-- 2.Standardize data
-- 3. Null values or blank values
-- 4. Remove columns


-- Looking at the messy data
SELECT *
FROM layoffS;

-- Creating a copy before cleaning
CREATE TABLE layoffs_staging
LIKE layoffs;

-- Viewing the copied table
SELECT *
FROM layoffs_staging; 

-- Inserting the rows
INSERT layoffs_staging
SELECT *
FROM layoffs;

SELECT *
FROM layoffs_staging;

-- 1. Removing duplicates
-- 1.1 Identifying duplicates with ROW_NUMBER()
SELECT *,
ROW_NUMBER() OVER( 
PARTITION BY company, location, industry, total_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;

-- 1.2 Filtering duplicates only
WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER( 
PARTITION BY company, location, industry, total_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

-- 1.3 Deleting duplicates
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


SELECT *
FROM layoffs_staging2; 

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER( 
PARTITION BY company, location, industry, total_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;

-- SELECT *
-- FROM layoffs_staging2; 

SELECT *
FROM layoffs_staging2
WHERE row_num > 1;

DELETE
FROM layoffs_staging2
WHERE row_num > 1;

-- SELECT *
-- FROM layoffs_staging2;



-- 2. Standardizing data
-- 2.1 Removing extra space and updating the trimmed column value to original column
SELECT DISTINCT company
FROM layoffs_staging2;

SELECT company, TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT company, TRIM(company)
FROM layoffs_staging2;

-- 2.2 Fixing and Updating inconsistent value in industry column
SELECT DISTINCT industry
FROM layoffs_staging2;

SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1;

SELECT * 
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT * 
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1;

-- 2.3 Checking other columns
SELECT DISTINCT location
FROM layoffs_staging2;

SELECT DISTINCT location
FROM layoffs_staging2
ORDER BY 1; 

-- 2.4 Updating inconsistent value in country column
SELECT DISTINCT country
FROM layoffs_staging2;

SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;

SELECT *
FROM layoffs_staging2
WHERE country LIKE 'United States%'
ORDER BY 1;

UPDATE layoffs_staging2
SET country = 'United States'
WHERE country LIKE 'United States%';

SELECT *
FROM layoffs_staging2
WHERE country LIKE 'United States%'
ORDER BY 1;

SELECT *
FROM layoffs_staging2;

-- 2.5 Fixing date column format
SELECT `date`,
STR_TO_DATE(`DATE`, '%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`DATE`, '%m/%d/%Y');

SELECT `date`
FROM layoffs_staging2;

ALTER TABLE  layoffs_staging2
MODIFY COLUMN `date` DATE;

SELECT *
FROM layoffs_staging2;




-- 3. Removing Null values or blank values
-- 3.1 Finding Null values or blank values
SELECT *
FROM layoffs_staging2
WHERE total_laid_off is NULL
AND percentage_laid_off is NULL;

-- 3.2 Turning blank into NULL
UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL 
OR industry = '';

SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb';

-- 3.2 Filling missing industry names
SELECT * 
FROM layoffs_staging2 AS t1
JOIN layoffs_staging2 AS t2
	ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry is NOT NULL;

SELECT t1.industry, t2.industry
FROM layoffs_staging2 AS t1
JOIN layoffs_staging2 AS t2
	ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry is NOT NULL;

UPDATE layoffs_staging2 AS t1
JOIN layoffs_staging2 AS t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL 
AND t2.industry is NOT NULL;  

SELECT *
FROM layoffs_staging2;  

SELECT *
FROM layoffs_staging2
WHERE total_laid_off is NULL
AND percentage_laid_off is NULL; 

-- 3.2 Deleting Null values rows
DELETE
FROM layoffs_staging2
WHERE total_laid_off is NULL
AND percentage_laid_off is NULL; 

SELECT *
FROM layoffs_staging2; 




-- 4. Removing columns
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

SELECT *
FROM layoffs_staging2;

--
-- What I did is 
-- Copy the data
-- Find repeated rows
-- Remove repeats
-- Fix messy text
-- Fix dates
-- Handle missing information
-- Delete useless rows
-- Remove temporary columns

