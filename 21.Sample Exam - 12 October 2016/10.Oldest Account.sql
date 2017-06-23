#10.	Oldest Account
SELECT c.customer_id, c.first_name, a.start_date
FROM customers AS c
INNER JOIN accounts AS a
ON c.customer_id = a.customer_id
WHERE a.start_date = (SELECT MIN(sa.start_date) FROM accounts AS sa);
