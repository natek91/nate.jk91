-- *****************************************************************************
-- LAB 3 - Week 3 (Single-Line Functions)
-- CourseID: DBS301SCC
-- Professor Name: Clint Macdonald
-- Student Name: JuAn Kim
-- Student #: 131549164
-- *****************************************************************************

-- Question 1 - Write a query to display the tomorrow's date in the given format
-- Solution 1 -
SELECT TO_CHAR(sysdate + 1, 'Month ddth "of year" YYYY') AS "tomorrow"
  FROM dual;

-- Question 2 - Display and label the employee information as specified
-- Solution 2 -
SELECT last_name, first_name, salary, (salary * 1.05) AS "Good Salary",
  (((salary  * 1.05) - salary) * 12) AS "Annual Pay Increase"
  FROM employees
  WHERE department_id IN (20, 50, 60);
  
-- Question 3 - Write a query that displays the employee's info as specified\
-- Solution 3 -
SELECT
  UPPER (last_name) || ', ' ||
  UPPER (first_name) || ' is ' ||
  CASE job_id WHEN 'ST_CLERK' THEN 'Store Clerk'
              WHEN 'ST_MAN'   THEN 'Store Manager'
  END
  AS "Person and Job"
  FROM employees
  WHERE UPPER (SUBSTR(last_name, -1, 1)) IN 'S' 
  AND UPPER (SUBSTR(first_name, 1, 1)) IN ('C','K')
  ORDER BY last_name;
  
-- Question 4 - Display the employee's info, label and order the results
-- Solution 4 -
SELECT
  last_name, hire_date, ROUND((sysdate - hire_date)/365)
  AS "Years worked"
  FROM employees
  WHERE TO_CHAR(hire_date, 'YYYY') < 1992
  ORDER BY 3 DESC;
  
-- Question 5 - Create a query that display all the specified information
-- Solution 5 -
SELECT city AS "City names", country_id AS "Country Code",
  NVL (state_province, 'Unknown Province') AS "Province Name"
  FROM locations
  WHERE UPPER (SUBSTR(city, 1, 1)) IN 'S' AND LENGTH(city) >= 8;
  
-- Question 6 - Display, label, format and sort employee's info as specified
-- Solution 6 -
SELECT last_name, hire_date,
  TO_CHAR(NEXT_DAY(ADD_MONTHS(hire_date, 12), 'Thursday'),
  'fmDAY, Month "the" Ddspth "of year" YYYY') AS "REVIEW DAY"
  FROM employees
  WHERE TO_CHAR (hire_date, 'YYYY') > 1997
  ORDER BY 3;