#2.	Unexpired Loans Procedure
DELIMITER $$
CREATE PROCEDURE usp_customers_with_unexpired_loans(customer_id_var INT)
BEGIN
	SELECT c.customer_id, c.first_name, l.loan_id, l.expiration_date
	FROM customers AS c
	INNER JOIN loans AS l
	ON c.customer_id = l.customer_id
	WHERE c.customer_id = customer_id_var AND l.expiration_date IS NULL;
END $$
DELIMITER ;

#tests
SELECT c.customer_id, c.first_name, l.loan_id, l.expiration_date
FROM customers AS c
INNER JOIN loans AS l
ON c.customer_id = l.customer_id
WHERE c.customer_id = 6 AND l.expiration_date IS NULL