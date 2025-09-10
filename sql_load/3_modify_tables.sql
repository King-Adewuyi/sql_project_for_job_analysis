/* ⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️
Database Load Issues (follow if receiving permission denied when running SQL code below)

NOTE: If you are having issues with permissions. And you get error: 

'could not open file "[your file path]\job_postings_fact.csv" for reading: Permission denied.'

1. Open pgAdmin
2. In Object Explorer (left-hand pane), navigate to `sql_course` database
3. Right-click `sql_course` and select `PSQL Tool`
    - This opens a terminal window to write the following code
4. Get the absolute file path of your csv files
    1. Find path by right-clicking a CSV file in VS Code and selecting “Copy Path”
5. Paste the following into `PSQL Tool`, (with the CORRECT file path)

\copy company_dim FROM '[Insert File Path]/company_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy skills_dim FROM '[Insert File Path]/skills_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy job_postings_fact FROM '[Insert File Path]/job_postings_fact.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy skills_job_dim FROM '[Insert File Path]/skills_job_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

*/

-- NOTE: This has been updated from the video to fix issues with encoding

COPY company_dim
FROM 'C:\Users\King David\Desktop\sql_project_for_job_analysis\csv_files\company_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY skills_dim
FROM 'C:\Users\King David\Desktop\sql_project_for_job_analysis\csv_files\skills_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY job_postings_fact
FROM 'C:\Users\King David\Desktop\sql_project_for_job_analysis\csv_files\job_postings_fact.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY skills_job_dim
FROM 'C:\Users\King David\Desktop\sql_project_for_job_analysis\csv_files\skills_job_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');


SELECT COUNT(job_id), 
EXTRACT(MONTH FROM job_posted_date) AS MONTH
FROM job_postings_fact

GROUP BY MONTH
limit 13


-- January
CREATE TABLE january_jobs AS
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

-- February
CREATE TABLE february_jobs AS
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

-- March
CREATE TABLE march_jobs AS
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;


select job_posted_date from march_jobs



select 

        COUNT(job_id),
      

        case 
         when  job_location = 'Anywhere' then 'Remote'
         when job_location = 'New York, NY' then 'Local'
         else 'Onsite'   

        end as location_category

        
from job_postings_fact
GROUP by location_category;


select salary_year_avg,

case
when salary_year_avg > 500000 then 'High'
when salary_year_avg > 300000 and salary_year_avg < 500000  then 'Standard'
else 'Low'
end as Bucket

from job_postings_fact
where job_title_short = 'Data Analyst'
and salary_year_avg is not null


order by salary_year_avg desc


select * from ( 
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1

) as january_job;


with january_jobs as (
    select * from job_postings_fact
    where EXTRACT(MONTH from job_posted_date)= 1
)

select * from january_jobs;


select company_id, name as company_name 
from company_dim 
where company_id in (
select company_id

from 
     job_postings_fact
where 
job_no_degree_mention = true)

select company_id , count(*)
from 
job_postings_fact
group by 
company_id

select * from(

select job_title_short,
company_id, job_location, salary_year_avg

from january_jobs

union all

select job_title_short,
company_id, job_location, salary_year_avg

from february_jobs

union all 

select job_title_short,
company_id, job_location , salary_year_avg

from march_jobs ) as total

where total.salary_year_avg > 70000




 


 

