-- *****************************************************************************
-- LAB 4 - Week 4 (Aggregate Functions)
-- CourseID: DBS301SCC
-- Professor Name: Clint Macdonald
-- Student Name: JuAn Kim
-- Student #: 131549164
-- *****************************************************************************

-- Question 1 - Display the difference btw Ave.pay and Lowest pay with 2 deci.
-- Solution 1 -
SELECT ROUND(AVG(salary) - MIN(salary), 2) AS "Real Amount"
FROM employees;

-- Question 2 - Display the department number and High/Lowest and Avg pay /dep
-- Solution 2 -
SELECT NVL(department_id, 0) AS "Department Number",
    MAX(salary) AS "High", MIN(salary) AS "Low",
    ROUND(AVG(salary), 2) AS "Avg"
FROM employees
GROUP BY department_id
ORDER BY 4 DESC;

-- Question 3 - Display how many ppl work the same job in the same department.
-- Include only jobs that involve more than one person.
-- Sort so that the most ppl involved are shown first.
-- Solution 3 -
SELECT department_id AS "Dept#", job_id AS "Job", 
    COUNT(employee_id) AS "How Many"
FROM employees
GROUP BY department_id, job_id
HAVING COUNT (employee_id) > 1
ORDER BY 3 DESC;

-- Question 4 - Display the job title and total amount paid each month.
-- Exclude titles AD_PRES and AD_VP and also include only jobs that reuqire
-- more than $12,000. Sort by the top paid jobs first.
SELECT job_id AS "Title", SUM(salary) AS "Total Amount Paid /month"
FROM employees
GROUP BY job_id
HAVING job_id NOT IN('AD_PRES', 'AD_VP') AND SUM(SALARY) > 15000
ORDER BY 2 DESC;

-- Question 5 - For each manager number, display how many persons he/she 
-- supervises.
-- Exclude managers with number 100, 101 and 102 
-- And also include only the ones that supervise more than 2 persons.
SELECT manager_id AS "Manager",
       COUNT(employee_id) AS "# of employees supervised"
FROM employees
GROUP BY manager_id
HAVING manager_id NOT IN(100, 101, 102) AND
       manager_id IS NOT NULL AND
       COUNT(employee_id) > 2
ORDER BY 2 DESC;

-- Question 6 - For each department show the latest and earliest hire date, BUT
-- exclude departments 10 and 20
-- exclude departments where the last person was hired in this century
-- sort the output so that the most recent, meaning latest hire dates, first.
SELECT department_id AS "Department ID", 
    MAX(hire_date) AS "Latest Hire date",
    MIN(hire_date) AS "Earliest Hire date"
FROM employees
GROUP BY department_id
HAVING department_id NOT IN(10, 20) AND MAX(hire_date) < '01-JAN-01'
ORDER BY 2 DESC;