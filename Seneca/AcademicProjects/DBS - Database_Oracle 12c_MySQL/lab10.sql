SELECT * FROM DepartmentEmployeeCount_View;

DROP VIEW DepartmentEmployeeCount_View;

---Create a VIEW called  DepartmentEmployeeCount_View that will display the total number of employees in each department 
--(show only employees that have been assigned to a department).Only the columns shown should be in the view. 
--Sort by department name in alphabetical order.
CREATE VIEW DepartmentEmployeeCount_View AS
SELECT d.Department_Name AS "DEPARTMENT",
       COUNT(e.employee_id) AS "# of Employees"
FROM DEPARTMENTS d INNER JOIN EMPLOYEES e
USING (Department_ID)
GROUP BY d.Department_Name
ORDER BY d.Department_Name;

--You MUST do question 1 before doing this question.
--Modify the existing view called DepartmentEmployeeCount_View to display the number of employees in each department
--and if an employee has not been assigned to a department they should be classified in a department called "Not Yet Assigned".
--Sort alphabetically by Department Name.

CREATE OR REPLACE VIEW DepartmentEmployeeCount_View AS
SELECT NVL(d.Department_Name, 'Not Yet Assigned') AS "DEPARTMENT",
       COUNT(e.employee_id) AS "# of Employees"
FROM DEPARTMENTS d RIGHT OUTER JOIN EMPLOYEES e ON e.Department_id = d.Department_id
GROUP BY d.Department_Name, NVL(d.Department_Name, 'Not Yet Assigned')
ORDER BY d.Department_Name;


--Create a view called DepartmentEmployees_View.  It should show all employees and their associated departments.
--If an employee has not yet been assigned to a department it should display "Not Yet Assigned" in the department name column.
--Note: There are 2 different Jonathan Taylor's in the Sales department.
--Order by Department and Employee name in alphabetical order.  The view should only contain the 2 columns shown.
CREATE VIEW DepartmentEmployees_View AS
SELECT NVL(d.Department_Name, 'Not Yet Assigned') AS "DEPARTMENT",
       e.First_Name ||' '|| e.Last_Name AS "EMPLOYEE"
FROM DEPARTMENTS d RIGHT OUTER JOIN EMPLOYEES e ON e.Department_id = d.Department_id
ORDER BY d.Department_Name;

SELECT * FROM DepartmentEmployees_View;
DROP VIEW DepartmentEmployees_View;
