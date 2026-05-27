-- =========================================
-- SkillScope AI SQL Analysis Project
-- Author: LAHARI KASINA
-- Database: SQL Server Management Studio 2025
-- Dataset: featured_jobs
-- Project Type: Data Analyst Portfolio Project
-- =========================================

USE SkillScopeAI;
GO


-- =========================
-- LEVEL 1: BASIC ANALYSIS
-- =========================

-- 1. Total Jobs
SELECT COUNT(*) AS total_jobs
FROM featured_jobs;
GO


-- 2. Average Salary
SELECT 
    AVG(average_salary) AS avg_salary
FROM featured_jobs
WHERE average_salary IS NOT NULL
AND average_salary > 0;
GO


-- 3. Top 10 Highest Paying Jobs
SELECT TOP 10
    job_title,
    average_salary
FROM featured_jobs
WHERE average_salary IS NOT NULL
AND average_salary > 0
ORDER BY average_salary DESC;
GO



-- =========================
-- LEVEL 2: BUSINESS INSIGHTS
-- =========================

-- 1. Average Salary by Location
SELECT 
    location,
    AVG(average_salary) AS avg_salary
FROM featured_jobs
WHERE average_salary IS NOT NULL
AND average_salary > 0
GROUP BY location
ORDER BY avg_salary DESC;
GO


-- 2. Companies with Most Job Listings
SELECT 
    company_name,
    COUNT(*) AS total_jobs
FROM featured_jobs
GROUP BY company_name
ORDER BY total_jobs DESC;
GO


-- 3. Salary Category Distribution
SELECT 
    CASE 
        WHEN average_salary >= 100000 THEN 'High'
        WHEN average_salary >= 50000 THEN 'Medium'
        ELSE 'Low'
    END AS salary_category,
    
    COUNT(*) AS total_jobs

FROM featured_jobs

WHERE average_salary IS NOT NULL
AND average_salary > 0

GROUP BY 
    CASE 
        WHEN average_salary >= 100000 THEN 'High'
        WHEN average_salary >= 50000 THEN 'Medium'
        ELSE 'Low'
    END

ORDER BY total_jobs DESC;
GO


-- 4. Top Paying Job Titles
SELECT TOP 10
    job_title,
    AVG(average_salary) AS avg_salary
FROM featured_jobs
WHERE average_salary IS NOT NULL
AND average_salary > 0
GROUP BY job_title
ORDER BY avg_salary DESC;
GO


-- 5. Most Frequent Job Titles
SELECT 
    job_title,
    COUNT(*) AS job_count
FROM featured_jobs
GROUP BY job_title
ORDER BY job_count DESC;
GO


-- 6. Salary Range Overview
SELECT 
    MIN(average_salary) AS min_salary,
    MAX(average_salary) AS max_salary,
    AVG(average_salary) AS avg_salary
FROM featured_jobs
WHERE average_salary IS NOT NULL
AND average_salary > 0;
GO



-- =========================
-- LEVEL 3: ADVANCED SQL
-- =========================

-- 1. Row Number by Salary
SELECT 
    job_title,
    average_salary,

    ROW_NUMBER() OVER (
        ORDER BY average_salary DESC
    ) AS row_num

FROM featured_jobs

WHERE average_salary IS NOT NULL
AND average_salary > 0;
GO


-- 2. Rank Jobs by Salary
SELECT 
    job_title,
    average_salary,

    RANK() OVER (
        ORDER BY average_salary DESC
    ) AS salary_rank

FROM featured_jobs

WHERE average_salary IS NOT NULL
AND average_salary > 0;
GO


-- 3. Dense Rank Jobs by Salary
SELECT 
    job_title,
    average_salary,

    DENSE_RANK() OVER (
        ORDER BY average_salary DESC
    ) AS dense_rank

FROM featured_jobs

WHERE average_salary IS NOT NULL
AND average_salary > 0;
GO


-- 4. Salary Rank Within Each Location
SELECT 
    location,
    job_title,
    average_salary,

    RANK() OVER (
        PARTITION BY location
        ORDER BY average_salary DESC
    ) AS location_rank

FROM featured_jobs

WHERE average_salary IS NOT NULL
AND average_salary > 0;
GO


-- 5. Highest Paying Job in Each Location
WITH RankedJobs AS (

    SELECT 
        location,
        job_title,
        average_salary,

        ROW_NUMBER() OVER (
            PARTITION BY location
            ORDER BY average_salary DESC
        ) AS rn

    FROM featured_jobs

    WHERE average_salary IS NOT NULL
    AND average_salary > 0
)

SELECT 
    location,
    job_title,
    average_salary
FROM RankedJobs
WHERE rn = 1;
GO



-- =========================
-- BONUS ANALYSIS QUERIES
-- =========================

-- 1. Top Hiring Locations
SELECT TOP 10
    location,
    COUNT(*) AS total_jobs
FROM featured_jobs
GROUP BY location
ORDER BY total_jobs DESC;
GO


-- 2. Remote vs Non-Remote Jobs
SELECT
    is_remote,
    COUNT(*) AS total_jobs
FROM featured_jobs
GROUP BY is_remote;
GO


-- 3. Average Salary by Company
SELECT TOP 10
    company_name,
    AVG(average_salary) AS avg_salary
FROM featured_jobs
WHERE average_salary IS NOT NULL
AND average_salary > 0
GROUP BY company_name
ORDER BY avg_salary DESC;
GO