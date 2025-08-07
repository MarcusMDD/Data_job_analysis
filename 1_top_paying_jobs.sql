/*
Question: What are the top-paying Data Analyst jobs 
-Identify the top 10 paying data Analyst jobs available remotely.
-Focuses on job postings with specified salaries (Ignore null values)
-Why? Highlights the top-paying oppurtunities for Data Analysts, offering insights into exmployment options 
*/

SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM 
    job_postings_fact 
WHERE
     job_title_short = 'Data Analyst' AND
     job_location = 'Anywhere' AND 
     salary_year_avg IS NOT NULL 
-- The above where statements filters all jobs down to remote Data Analyst jobs, with Salary Data-- 
ORDER BY salary_year_avg DESC
--This orders all of the job postings by yearly salary from highest to lowest--
LIMIT 10 
--This limits the reuslts to the top 10--