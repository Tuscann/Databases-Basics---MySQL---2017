#7.	Unite People
SELECT e.first_name, cs.city_name
FROM employees AS e
INNER JOIN branches AS b
ON e.branch_id = b.branch_id
INNER JOIN cities AS cs
ON b.city_id = cs.city_id
LIMIT 3;

SELECT c.first_name, cu.city_name
FROM customers AS c
INNER JOIN cities AS cu
ON c.city_id = cu.city_id
LIMIT 3;
