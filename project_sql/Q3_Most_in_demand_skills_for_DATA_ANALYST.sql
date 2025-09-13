

WITH demand_skills AS (
SELECT skills,job_title_short
from skills_dim


LEFT JOIN skills_job_dim ON skills_job_dim.skill_id =
skills_dim.skill_id
LEFT JOIN job_postings_fact  ON job_postings_fact.job_id =
skills_job_dim.job_id

WHERE job_title_short = 'Data Analyst' AND job_work_from_home = TRUE
)
SELECT skills, count(skills) as Total_skills FROM demand_skills
GROUP BY skills
ORDER BY Total_skills DESC

LIMIT 10



