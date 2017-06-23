#6.	Loan Statistics
SELECT SUM(l.amount) AS 'total_loan_amount', MAX(l.interest), MIN(e.salary) AS 'min_employee_salary'
FROM loans AS l
INNER JOIN employees_loans AS el
ON l.loan_id = el.loan_id
INNER JOIN employees AS e
ON el.employee_id = e.employee_id;