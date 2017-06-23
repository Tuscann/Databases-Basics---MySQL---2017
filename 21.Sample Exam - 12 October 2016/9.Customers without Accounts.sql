#9.	Customers without Accounts
SELECT c.customer_id, l.amount
FROM customers AS c
INNER JOIN loans AS l
ON c.customer_id = l.customer_id
WHERE l.amount > (SELECT  AVG(l.amount) FROM loans AS l
INNER JOIN customers AS c
ON l.customer_id = c.customer_id
WHERE c.gender ='M')
ORDER BY c.last_name
LIMIT 5;


