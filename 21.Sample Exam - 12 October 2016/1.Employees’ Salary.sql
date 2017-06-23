#1.	Employees’ Salary
SELECT e.employee_id, e.hire_date, e.salary, e.branch_id
FROM employees AS e
WHERE e.salary > 2000 AND e.hire_date > DATE('2009-06-15')