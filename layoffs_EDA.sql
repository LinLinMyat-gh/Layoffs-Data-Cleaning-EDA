-- Exploratory Data Analysis

SELECT * 
FROM layoffs_staging2;

-- The highest number of people laid off and the highest layoff percentage?
SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

-- Companies that laid off 100% employees
SELECT * 
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

SELECT * 
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

-- Total layoffs by company
SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company 
ORDER BY 2 DESC;

-- Earliest and latest dates in dataset
SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;

-- Total layoffs by industry
SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

SELECT * 
FROM layoffs_staging2;

-- Total layoffs by country
SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

-- Total layoffs by location
SELECT location, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY location
ORDER BY 2 DESC;

-- Total layoffs by country + location
SELECT country, location, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country, location
ORDER BY 3 DESC;

-- Total layoffs by date
SELECT `date`, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY `date`
ORDER BY 1 DESC;

-- Total layoffs by year
SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;

-- Total layoffs by stage
SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

-- SUM vs AVG percentage laid off
SELECT company, SUM(percentage_laid_off)
FROM layoffs_staging2
GROUP BY company 
ORDER BY 2 DESC;

SELECT company, AVG(percentage_laid_off)
FROM layoffs_staging2
GROUP BY company 
ORDER BY 2 DESC;

-- Monthly (year + month) total layoffs
SELECT SUBSTRING(`date` , 1, 7) AS `month`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date` , 1, 7) IS NOT NULL
GROUP BY `month`
ORDER BY 1 ; 

-- Rolling total by Monthly (year + month)
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

-- -- Total layoffs by company
SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company 
ORDER BY 2 DESC;

-- Total layoffs by company and year
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY company ASC;

SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC ;

-- Ranking companies by total layoffs
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


-- WITH Company_Year(company, years, total_laid_off) AS
-- (
-- SELECT company, YEAR(`date`), SUM(total_laid_off)
-- FROM layoffs_staging2
-- GROUP BY company, YEAR(`date`)
-- )
-- SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) as Ranking
-- FROM Company_Year
-- WHERE years IS NOT NULL
-- LIMIT 5;

