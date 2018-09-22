-- *****************************************************************************
-- LAB 5 - Week 5 Joins
-- CourseID: DBS301SCC
-- Professor Name: Clint Macdonald
-- Student Name: JuAn Kim
-- Student #: 131549164
-- *****************************************************************************

-- Part A --
-- Question 1 - Display the dep. name, city, street and postal, and sort specif
-- Solution 1 -
SELECT 
    d.department_name AS "Department",
    l.city AS "City",
    l.street_address AS "Street Address",
    l.postal_code AS "Postal Code"
FROM departments d, locations l  
WHERE d.location_id = l.location_id
ORDER BY l.city, d.department_name;

-- Question 2 - Display full name, hire date, salary, department name and city,
-- but only for departs. with names starting with an 'A' or 'S'
-- sorted by department name and employee name.
-- Solution 2 -
SELECT
    e.last_name || ', ' || e.first_name AS "Full Name",
    e.hire_date AS "Hire Date",
    e.salary AS "Salary",
    d.department_name AS "Department",
    l.city AS "City"
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id
AND d.location_id = l.location_id
AND substr(d.department_name,1,1) IN ('A','S')
ORDER BY 4, 1;

-- Question 3 - Display full name of manager of each depart.
-- in states/provinces of Ontario, California and Washington
-- along with the depart name, city, postal, and province name. And sort
-- Solution 3 -
SELECT
    d.department_name AS "Department",
    e.last_name || ', ' || e.first_name AS "Manager Full Name",
    l.city AS "City",
    l.postal_code AS "Postal Code",
    l.state_province AS "State/Province"
FROM   departments d 
    LEFT JOIN employees e
        ON d.manager_id = e.employee_id
    JOIN locations l
        ON d.location_id = l.location_id
        AND l.state_province IN ('Ontario', 'California', 'Washington')
ORDER BY l.city, d.department_name;

-- Question 4 - Display employee's last name and number
-- along with their manager's last name and number.
-- Label the columns Employee, Emp#, Manager, and Mgr# respectively.
-- Solution 4 -
SELECT 
      e.last_name AS "Employee",
      e.employee_id AS "Emp#",
      m.last_name AS "Manager",
      m.manager_id AS "Mgr#"
FROM employees e JOIN employees m
ON  e.manager_id = m.employee_id;


-- Part B -

-- Question 5 - Display department name, city, street address, postal and
-- country name for all departments. Use the Join and Using form of syntax.
-- Sort the ouput by department name descending.
SELECT
    d.department_name AS "Department",
    l.city AS "City",
    l.street_address AS "Street Address",
    l.postal_code AS "Postal Code",
    c.country_name AS "Country"
FROM departments d 
    JOIN locations l
        USING (location_id)
    LEFT JOIN countries c
        USING (country_id)
ORDER BY 1 DESC;

-- Question 6 - Display employees full name, their hire date and asalary
-- together with their depart. name, but only for departments which names start
-- with A or S. Full name should be in format of:
--    a. First / Last. Use the JOIN and ON form of syntax.
--    b. Sort the output by department name and then by last name.
SELECT 
    e.first_name || ' / ' || e.last_name AS "Full Name",
    e.hire_date	AS "Hire Date",
    e.salary AS "Salary",
    d.department_name	AS "Department"
FROM employees e
    LEFT JOIN departments d
    ON d.department_id = e.department_id
WHERE d.department_name LIKE 'A%' OR d.department_name LIKE 'S%'
ORDER BY d.department_name, e.last_name;

-- Question 7 - Rewrite the previous question by using Standard (Old -- prior
-- to Oracle9i) Join method.
-- Solution 7 -
SELECT 
    first_name ||' / '|| last_name AS "Full Name", 
    hire_date AS "Hire Date", 
    salary AS "Salary",
    department_name AS "Department"
FROM employees 
    JOIN departments
       USING (department_id)
WHERE substr(department_name, 1,1) in ('A','S')
ORDER BY department_name, last_name;

-- Question 8 - Display full name of the manager of each department in provinces
-- Ontario, California and Washington + depart. name, city, postal code and
-- province name.
-- Full name should be in format as follows:
--    a.	Last, First.  Use the JOIN and ON form of syntax.
--    b.	Sort the output by city and then by department name.
SELECT 
    e.last_name || ', ' || e.first_name AS "Manager Full Name", 
		d.department_name AS "Department", 
		l.city AS "City", 
		l.postal_code AS "Postal Code", 
		l.state_province AS "State/Province"
FROM employees e
		LEFT JOIN departments d
        ON e.department_id = d.department_id
		LEFT JOIN locations l
        ON d.location_id = l.location_id      
WHERE l.state_province IN ('Ontario', 'California', 'Washington')
    AND (e.job_id LIKE '%MGR%' OR e.job_id LIKE '%MAN%')
ORDER BY 3, 2;

-- Question 9 - Rewrite the previous question by using Standard (Old -- prior
-- to Oracle9i) Join method.
-- Solution 9 -
SELECT last_name || ', ' || first_name AS "Full Name" ,
		department_name AS "Department", 
		city AS "City", 
		postal_code AS "Postal Code", 
		state_province AS "State/Province"
FROM employees  
		JOIN departments 
        USING (department_id)
		JOIN locations 
        USING (location_id)
WHERE state_province in ('Ontario', 'California' , 'Washington')
    AND (job_id like '%MGR%' or job_id like '%MAN%')
ORDER BY city, department_name;

-- Question 10 - Display the depart. name and Highest, Lowest and Average pay 
-- per each department. Name these results High, Low and Avg.
--    a. Use JOIN and ON form of the syntax.
--    b. Sort the output so that department with highest average salary are
--       shown first.
SELECT 
    d.department_name AS "Department",
		MAX(e.salary)	AS "High",
		MIN(e.salary)	AS "Low",
		ROUND(AVG(e.salary)) AS "Average"
FROM departments d
		LEFT JOIN employees e
        ON e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY AVG(e.salary) DESC;

-- Question 11 - Display the employee last name and employee number along with
--  their manager’s last name and manager number.
--  Label the columns:
--    Employee, Emp#, Manager, and Mgr#, respectively.
--    Include also employees who do NOT have a manager 
--        and also employees who do NOT supervise anyone 
--        (or you could say managers without employees to supervise).
SELECT 
    e.last_name AS "Employee", 
    e.employee_id AS "Emp#", 
    m.last_name AS "Manager", 
    m.manager_id AS "Mgr#"
FROM employees e 
		FULL OUTER JOIN employees m 
        ON e.employee_id = m.manager_id;