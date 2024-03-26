/*
        Data Mart #1: sum of salary_in_usd per work_year and employment_type
*/
SELECT
  extract(Year from work_year) as work_year,
  employment_type,
  SUM(salary_in_usd) AS total_salary
FROM
  `jobs-salaries-in-data.jobs_salaries_in_data_dataset.jobs_cleaned_partitioned_data`
GROUP BY
  1,
  2
ORDER BY
  3 DESC;
/*
        Data Mart #2: sum of salary_in_usd per work_year and company_size
*/
SELECT
  extract(Year from work_year) as work_year,
  company_size,
  SUM(salary_in_usd) AS total_salary
FROM
  `jobs-salaries-in-data.jobs_salaries_in_data_dataset.jobs_cleaned_partitioned_data`
GROUP BY
  1,
  2
ORDER BY
  3 DESC;
/*
        Data Mart #3: Count of occuernce of each category, and show only Top 5
*/
SELECT
  job_category,
  COUNT(*) AS count_top_categories
FROM
  `jobs-salaries-in-data.jobs_salaries_in_data_dataset.jobs_cleaned_partitioned_data`
GROUP BY
  1
ORDER BY
  2 DESC
LIMIT
  5;
/*
        Data Mart #4: Count of occuernce of each category of each experience_level
*/
SELECT
  job_category,
  experience_level,
  COUNT(*) AS count_top_categories_levels
FROM
  `jobs-salaries-in-data.jobs_salaries_in_data_dataset.jobs_cleaned_partitioned_data`
GROUP BY
  1,
  2
ORDER BY
  3 DESC;
