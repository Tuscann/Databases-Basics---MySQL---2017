#2.	Customer Age
SELECT c.first_name, c.date_of_birth,
		FLOOR(DATEDIFF(DATE('2016-10-01'), c.date_of_birth) / 360) AS 'age'
FROM customers AS c
WHERE DATEDIFF(DATE('2016-10-01'), c.date_of_birth) / 360 BETWEEN 40 AND 50;


