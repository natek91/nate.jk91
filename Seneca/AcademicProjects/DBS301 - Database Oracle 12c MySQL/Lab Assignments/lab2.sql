-- *****************************************************************************
-- LAB 2 - Week 2 (SELECT, RANGE, ORDER)
-- CourseID: DBS301SCC
-- Professor Name: Clint Macdonald
-- Student Name: JuAn Kim
-- Student #: 131549164
-- *****************************************************************************

-- Question 1: Display the employee_id, last name and salary of employees 
-- earning in the range 8,000 ~ 15,000. Sort by top salaries first and then 
-- by last name.
SELECT employee_id, last_name, salary
  FROM employees
  WHERE salary BETWEEN 8000 AND 15000
  ORDER BY salary DESC, last_name;
  
-- Question 2:  Modify the previous query, display only the Programmers or Sales
SELECT employee_id AS "Emp ID", last_name, salary, job_id
  FROM employees
  WHERE (salary BETWEEN 8000 AND 15000)AND
        (job_id LIKE 'IT_PROG' OR job_id LIKE 'SA_REP')
  ORDER BY salary DESC, last_name;

-- Question 3: Modify the previous query, same job but who earn outside the
-- given salary range from question 1. Same sorting method.
SELECT employee_id, last_name, salary, job_id
  FROM employees
  WHERE (salary < 8000 OR SALARY > 15000) AND
        (job_id LIKE 'IT_PROG' OR job_id LIKE 'SA_REP')
  ORDER BY salary DESC, last_name;
  
-- Question 4: Display last name, job id, and salary or employees hired before
-- 1998. List the most recently hired employees first.
SELECT last_name, job_id, salary, hire_date
  FROM employees
  WHERE hire_date < to_date ('01011998', 'ddmmyyyy')
  ORDER BY hire_date DESC;

-- Question 5: Modify the previous query, so that it displays only employees
-- earning more than $10,000. Sort by job title alphabeticcaly and then highest
-- salary.
SELECT last_name, job_id, salary, hire_date
  FROM employees
  WHERE (hire_date < to_date ('01011998', 'ddmmyyyy')) AND
        (salary > 10000)
  ORDER BY job_id, salary DESC, hire_date DESC;

-- Question 6: Display the job titles and full names of employees whose first
-- name contains an 'e' or 'E' anywhere.
SELECT
  job_id, first_name || ' ' || last_name AS "Full Name"
  FROM employees
  WHERE first_name like '%e%' OR first_name LIKE '%E%';

-- Question 7: Create a report to display last name, salary, and commission %
-- for all employees that earn a commission.
SELECT last_name, salary, commission_pct
  FROM employees
  WHERE commission_pct IS NOT NULL;
  
-- Question 8: Same as Q7, but sort the report in order of DESC salaries.
SELECT last_name, salary, commission_pct
  FROM employees
  WHERE commission_pct IS NOT NULL
  ORDER BY salary DESC;
  
-- Question 9: Same as Q8, but use a numeric value instead of a column name to
-- do the sorting.
SELECT last_name, salary, commission_pct
  FROM employees
  WHERE commission_pct IS NOT NULL
  ORDER BY 2 DESC;
