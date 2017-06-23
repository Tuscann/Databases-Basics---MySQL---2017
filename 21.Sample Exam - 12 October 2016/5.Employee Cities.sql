#5.	Employee Cities
SELECT cs.city_name , b.name, COUNT(e.employee_id) AS 'employees_count'
FROM cities AS cs
INNER JOIN branches AS b
ON cs.city_id = b.city_id
INNER JOIN employees AS e
ON b.branch_id = e.branch_id
GROUP BY cs.city_name, b.name
HAVING COUNT(e.employee_id) > 2;