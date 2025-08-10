/*
Question: What skills are required for the top-paying Data Analyst jobs?
-Use the top 10 highest paying Data jobs from the 1st Query 
-Add the specific skills required for these roles
-Why? It provides a detailed look at which high-paying jobs demands certain skills,
helping job seekers understnad which skills to develop that align with top salaries 
*/ 
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
         salary_year_avg,
  
        name AS company_name 
    FROM 
        job_postings_fact 
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
         job_title_short = 'Data Analyst' AND
         job_location = 'Anywhere' AND 
         salary_year_avg IS NOT NULL 
    ORDER BY salary_year_avg DESC
    LIMIT 10 
    -- This CTE queries for the top 10 jobs which were returned in query 1 so we can then query for thier skills--
   )

SELECT
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skill_dim.skill_id = skills_job_dim.skill_id
/* These 2 joins allows us to query for the skills asked for in the postings. 
Inner joins are used as we are not interested in jobs that do not have any skills tagged in their post */
ORDER BY  salary_year_avg DESC
/* I exported the output as a CSV into python to get the skill count
-The results of this showed that SQL was the most popular skill, appearing in 8 job postings.
-Python appeared in 7 job postings, and Tableu appeared in 6. 
-The skills of R,Snowflake, Pandas and Excel also showed varying amounts of demand 
*/ 