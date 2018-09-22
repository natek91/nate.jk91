-- *****************************************************************************
-- LAB 6 - Week 6 (Sub-Queries)
-- CourseID: DBS301SCC
-- Professor Name: Clint Macdonald
-- Student Name: JuAn Kim
-- Student #: 131549164
-- *****************************************************************************

-- Question 1 -
-- SET AUTOCOMMIT ON (do this each time you log on), so any updates, deletes and inserts are
-- automatically committed before you exit from Oracle.
-- Solution 1 -
SET AUTOCOMMIT ON;


-- Question 2 -
-- Create an INSERT statement to do this. Add "yourself" as an employee with a NULL salary,
-- 0.2 commision_pct, in department 90, and Manager 100. You started TODAY.
-- Solution 2 -
INSERT INTO employees (
    employee_id,first_name,
    last_name,
    email,
    phone_number,
    hire_date,
    job_id,
    salary,
    commission_pct,
    manager_id,
    department_id
) 
VALUES (	
    222,
    'JuAn',
    'Kim',
    'JKIM',
    '416.111.2222',
    '14-06-18',
    'IT_PROG',
    NULL,
    0.2,
    100,
    90
);

-- Question 3 -
-- Create an Update statement to: Change the salary of the employees with a last name of Matos 
-- and Whalen to be 2500.
-- Solution 3 -
UPDATE employees
SET salary = 2500
WHERE last_name IN ('Matos','Whalen');


-- Question 4 -
-- Display the last names of all employees who are in the same department as the employee named Abel.
-- Solution 4 -
SELECT last_name AS "Last Name"
FROM employees
WHERE department_id =   (
                        SELECT department_id
                        FROM employees
                        WHERE last_name = 'Abel'
                        );


-- Question 5 -
-- Display the last names of the lowest paid employee(s).
-- Solution 5 -
SELECT last_name AS "Last Name"
FROM employees
WHERE salary = (
                SELECT MIN(salary)
                FROM employees
                );

-- Question 6 -
-- Display the city that the lowest paid employees are located in.
-- Solution 6 -
SELECT l.city AS "City"
FROM locations l, departments d, employees e
WHERE l.location_id = d.location_id
    AND d.department_id = e.department_id
    AND e.salary = (
                    SELECT MIN(salary)
                    FROM employees
                    );
                    
-- Question 7 -
-- Display the last name, department_id, and salary of the lowest paid employee(s) in each department.
-- Sort by Department_ID. But careful with deaprtment 60!
-- Solution 7 -
SELECT 
    last_name AS "Last Name",
    department_id AS "Department",
    salary AS "Salary"
FROM employees
WHERE (department_id, salary) IN (
                                    SELECT department_id, 
                                    MIN(salary)
                                    FROM employees
                                    GROUP BY department_id)
ORDER BY department_id;


-- Question 8 -
-- Display the last name of the lowest paid employee(s) in each city.
-- Solution 8 -
SELECT last_name AS "Last Name"
FROM employees 
    JOIN departments USING (department_id)
    JOIN locations   USING (location_id)
WHERE (city, salary) IN (
                        SELECT city, MIN(salary)
                        FROM employees 
                            JOIN departments USING (department_id)
                            JOIN locations USING (location_id)
                        GROUP BY city
                        );	

-- Question 9 -
-- Display last name and salary for all employees who earn less than the lowest salary in
-- ANY department. Sort the output by top salaries first and then by last name.
-- Solution 9 -
SELECT 
    last_name AS "Last Name", 
    salary AS "Salary"
FROM employees
WHERE (department_id, salary) IN (
                                    SELECT department_id, MIN(salary)
                                    FROM employees
                                    GROUP BY department_id
                                 )
ORDER BY salary DESC, last_name;

-- Question 10 -
-- Display last name, job title and salary for all employees whose salary matches any of the salaries from
-- the IT Department.
-- DO NOT use "Join" method.
-- Sort the output by salary ascending first and then by last_name.
-- Solution 10 -
SELECT 
    last_name AS "Last Name",
    job_id AS "Job Title",
    salary AS "Salary"
FROM employees
WHERE salary = ANY (
                    SELECT salary
                    FROM employees
                    WHERE department_id =   (	
                                            SELECT	department_id
                                            FROM	departments
                                            WHERE	department_name IN 'IT'
                                            )
                    )
ORDER BY salary, last_name;
