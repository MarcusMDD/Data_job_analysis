/* Question: What are the most in-demand skills for my role? 
-Join job postings to inner join table similar to query 2 
-Identify the top 5 in-demand skills for a Data Analyst 
-Focus on all job postings (not just remote postings)
Why? Retrieves the top 5 skills with the highest demand in the job market,
providing insights in to the most valuable skills for job seekers.
I wrote 2 separate queries to work out the most in demand skills
The first query shown below does satisfy our needs, but can be made more efficent 
*/
WITH remote_job_skills AS (

SELECT
    skill_id,
    COUNT(*) AS skill_count
FROM 
    skills_job_dim AS skills_to_job 
INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
WHERE
    job_postings.job_work_from_home = True AND job_postings.job_title_short = 'Data Analyst'
GROUP BY 
    skill_id )

SELECT 
    skills.skill_id, 
    skills AS skill_name,
    skill_count
FROM 
    remote_job_skills
INNER JOIN skills_dim AS skills on skills.skill_id = remote_job_skills.skill_id
ORDER BY skill_count DESC
LIMIT 5 ;
-- The 2nd query obtains tha same result in less lines, resulting in a more efficent query-- 

SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count

FROM job_postings_fact

INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id

INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id

WHERE job_title_short = 'Data Analyst'

GROUP BY 
    skills
ORDER BY
    demand_count DESC
LIMIT 5 
/* Both return the same result: 
SQL is the most in demand with over 92,000 postings including the skill.
Excel is in 2nd place with around 67,000 postings including the skill.
Python is in 3rd place with around  57,000 postings including the skill.
Tableau and Power BI are both present in around 40,000 to 45,000 postings.
When compared to only looking at remote jobs , the ranking of the skills is unchanged, but the skill count decreases by over 90% per skill.
*/