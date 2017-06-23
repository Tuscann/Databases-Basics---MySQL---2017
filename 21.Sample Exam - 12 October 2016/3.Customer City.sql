#3.	Customer City
SELECT c.customer_id, c.first_name, c.last_name, c.gender, cs.city_name
FROM customers AS c
INNER JOIN cities AS cs
ON c.city_id = cs.city_id
WHERE (c.last_name LIKE 'Bu%' OR c.first_name LIKE '%a') AND CHAR_LENGTH(cs.city_name) > 7
ORDER BY c.customer_id;