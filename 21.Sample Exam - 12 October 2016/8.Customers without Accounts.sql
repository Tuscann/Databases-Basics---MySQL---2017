#8.	Customers without Accounts
SELECT c.customer_id, c.height
FROM customers As c
WHERE c.customer_id 
NOT IN (
			SELECT ct.customer_id 
			FROM customers AS ct 
			INNER JOIN accounts AS a 
			ON ct.customer_id = a.customer_id
		)
AND c.height BETWEEN 1.74 AND 2.04;


