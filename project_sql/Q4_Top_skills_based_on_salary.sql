WITH demand_skills AS (
    SELECT 
        skills_dim.skills,
        job_title_short,
        ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS average_salary
    FROM skills_dim
    LEFT JOIN skills_job_dim 
        ON skills_job_dim.skill_id = skills_dim.skill_id
    LEFT JOIN job_postings_fact  
        ON job_postings_fact.job_id = skills_job_dim.job_id
    WHERE job_postings_fact.salary_year_avg IS NOT NULL
    GROUP BY skills_dim.skills, job_title_short
)

SELECT 
    skills,  
    average_salary
FROM demand_skills
WHERE job_title_short = 'Data Analyst'
ORDER BY average_salary DESC
LIMIT 25;

/* Here are some quick insights from the top-paying skills list you shared:

1. Strong Demand for AI/ML Tools

Frameworks like Keras, PyTorch, TensorFlow, Hugging Face, MXNet, and DataRobot show up often.

This highlights how AI/ML expertise is directly tied to higher salaries for data analysts, especially when moving into data science and deep learning roles.

2. Cloud, DevOps, and Automation Skills Pay Well

Terraform, Ansible, Puppet, VMware, Airflow all indicate demand for people who can manage cloud infrastructure, automate processes, and handle data pipelines.

Analysts with data engineering + cloud automation skills are rewarded.

3. Big Data & Real-Time Processing Skills Are Valuable

Kafka, Cassandra, Couchbase, Scala all point to large-scale, distributed, and streaming data systems.

These are the backbone for high-volume, real-time analytics.

4. Programming Languages Matter

Solidity (blockchain), Golang, Perl, Scala make the list.

Solidity’s presence (with $179k) shows blockchain + Web3 data roles command premium pay.

5. Collaboration & Workflow Tools Are Not Just “Soft” Skills

Tools like GitLab, Bitbucket, Atlassian, Notion, Twilio appear in the top 25.

Shows that companies pay well for analysts who can integrate smoothly with dev teams, manage projects, and build communication/automation workflows.

6. Trend: Analysts Are Expected to Be More “Full-Stack”

The highest-paying skills aren’t just about analyzing data with SQL/Excel.

They’re about combining data science, engineering, cloud, and collaboration into one hybrid role.*/