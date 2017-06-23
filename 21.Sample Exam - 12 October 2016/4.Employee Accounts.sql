#4.	Employee Accounts
SELECT e.employee_id, e.first_name, a.account_number 
FROM employees AS e
INNER JOIN employees_accounts AS ea
ON e.employee_id = ea.employee_id
INNER JOIN accounts AS a
ON ea.account_id = a.account_id
WHERE YEAR(a.start_date) > 2012
ORDER BY e.first_name DESC
LIMIT 5;