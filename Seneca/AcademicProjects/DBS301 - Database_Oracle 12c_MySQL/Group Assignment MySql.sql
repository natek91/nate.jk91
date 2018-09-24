-- Task 1: 
-- Display the employee number, full employee name, job and hire date of all employees hired in May or November of any 
-- year, with the most recently hired employees displayed first. Exclude people hired in 1994/1995.
SELECT  TRIM(employee_id) AS "Employee Number", 
        CAST(last_name || ', ' || first_name AS CHAR (25)) AS "Full Name",
        job_id AS "Job",
        to_char(last_day(hire_date), '[fmMonth ddth') || ' of ' || to_char(hire_date, 'YYYY]') AS "Hire Date"
        FROM employees
        WHERE to_char(hire_date, 'YYYY') NOT IN ('1994', '1995')
              AND to_char(hire_date, 'MM') IN ('05', '11')
        ORDER BY hire_date DESC;



-- Task 2: 
-- List the employee number, full name, job and the modified salary for all employees whose monthly earning (without 
-- this increase) is outside the range $6,000 – $11,000 and who are employed as Vice Presidents or Managers (President is not 
-- counted here). VPs get 30% raises and regular managers get 20%.
SELECT  to_char(
            'Emp# ' || employee_id || ' named ' || first_name || ' ' || last_name ||
            ' who is ' || job_id || ' will have a new salary of ') || 
        CASE 
            WHEN job_id LIKE '%VP' THEN to_char(salary*1.3, 'fm$999,999')
            ELSE to_char(salary*1.2, 'fm$999,999')
        /* using else instead of 2 cases with %MAN and %MGR because (for example) Alexander Hunold's job title 
           matches neither of those, but he is shown as the manager of the IT department in the 'departments' table */
        END AS "Employees With Increased Pay"
        FROM employees
        WHERE   NOT(salary BETWEEN 6000 AND 11000)
                AND job_id LIKE ('%_VP') 
                OR employee_id IN
                    (SELECT manager_id FROM departments
                        MINUS SELECT manager_id FROM departments WHERE manager_id = 100)
        ORDER BY salary DESC;


-- Task 3: Display the employee last name, salary, job title and manager# of all employees not earning a commission OR if they 
-- work in the SALES department, but only  if their total monthly salary with $1000 included bonus and  commission (if  earned) 
-- is  greater  than  $15,000.  
SELECT
   	 last_name AS "Last Name",
   	 TO_CHAR(salary, '$999,999') AS "Salary",
   	 job_id AS "Job",
   	 nvl(TO_CHAR(e.manager_id), TO_CHAR('NONE')) AS "Manager#",
   	 TO_CHAR((salary + 1000 + NVL2(commission_pct, commission_pct* salary, 0))
   			 * 12, '$999,999.00') AS "Total Income"
FROM employees e JOIN departments USING(department_id)
WHERE (commission_pct IS NULL OR department_name = 'Sales')
AND (salary + 1000 + NVL2(commission_pct, commission_pct * salary, 0)) > 15000
ORDER BY salary DESC;


-- Task 4: 
-- Display Department_id, Job_id and the Lowest salary for this combination under the alias Lowest Dept/Job Pay, but only if 
-- that Lowest Pay falls in the range $6000 - $18000. Exclude people who work as some kind of Representative job from this 
-- query and departments IT and SALES as well.
SELECT  department_id AS "Department", 
        job_id AS "Job",
        trim(to_char(MIN(salary), '$999,999')) AS "Lowest Pay"
        FROM employees
        WHERE department_id NOT IN (80, 60)
            AND job_id NOT LIKE '%REP'
        GROUP BY department_id, job_id
        HAVING MIN(salary) BETWEEN 6000 AND 18000
        ORDER BY department_id, job_id;
        
        
-- Task 5: 
-- Display last_name, salary and job for all employees who earn more than all lowest paid employees per department outside the 
-- US locations, exclusing the VPs and President
SELECT
   	 last_name AS "Last Name",
   	 TO_CHAR(salary, '$999,999') AS "Salary",
   	 job_id AS "Job"
FROM employees
WHERE salary > ALL (
                	SELECT MIN(salary)
                	FROM employees  
                	JOIN departments USING(department_id)
                	JOIN locations USING(location_id)
                	WHERE country_id != 'US'
                	GROUP BY department_id )
AND (job_id NOT LIKE '%PRES' AND job_id NOT LIKE '%VP')
ORDER BY job_id;


-- Task 6:
-- Who are the employees (show last_name, salary and job) who work either in IT or MARKETING department and earn more than the 
-- worst paid person in the ACCOUNTING department. 
SELECT
   	 last_name AS "Last Name",
   	 salary AS "Salary",
   	 job_id AS "Job"
FROM employees
WHERE department_id IN (
                    	SELECT department_id
                    	FROM departments
                    	WHERE department_name IN ('IT', 'Marketing')
                   	)
AND salary > (
       		 SELECT MIN(salary)
          	FROM employees
          	WHERE department_id = (
                           				 SELECT department_id
                                  	FROM departments
                               		 WHERE department_name = 'Accounting'
                                	)
        	)
ORDER BY last_name;


-- Task 7: 
-- Display alphabetically the full name, job, salary (formatted as a currency amount incl. thousand separator, but no decimals) 
-- and department number for each employee who earns less than the best paid unionized employee (i.e. not the president nor any
-- manager nor any VP), and who work in either SALES or MARKETING department.  
SELECT
   	 CAST(first_name || ' ' || last_name AS CHAR(20)) AS "Employee",
   	 job_id AS "Job",
   	 LPAD(TO_CHAR(salary, '$99,999'), 12, '=') AS "Salary",
   	 department_id AS "Department"
FROM employees
WHERE salary < (
            	SELECT MAX(salary)
            	FROM employees JOIN departments USING(department_id)
            	WHERE (
   					 job_id NOT LIKE '%PRES'
   				 AND job_id NOT LIKE '%MAN'
   				 AND job_id NOT LIKE '%VP')
   				 AND department_name NOT IN ('Sales', 'Marketing')
            	)
ORDER BY last_name;


-- Task 8:
-- Display department name, city and number of different jobs in each department. If city is null, you should print Not 
-- Assigned Yet, showing both from the employee's point of view as well as the city's. 
SELECT
	 CAST(NVL(department_name, 'N/A') AS CHAR (20)) AS "Department",
   	 CAST(NVL(city, 'Not Assigned Yet') AS CHAR(25)) AS "City",
   	 count(DISTINCT job_id) AS "# of Jobs"
FROM departments
RIGHT JOIN employees USING(department_id)
FULL JOIN locations USING(location_id)
GROUP BY
	 department_name, 
   	 CAST(NVL(department_name, 'N/A') AS CHAR (20)),
 	 CAST(NVL(city, 'Not Assigned Yet') AS CHAR(25))
     ORDER BY count(DISTINCT job_id) DESC; 
