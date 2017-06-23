#3.	Take Loan Procedure
DELIMITER $$
CREATE PROCEDURE usp_take_loan(customer_id_var INT, loan_amount_var DECIMAL(18,2), interest_var DECIMAL(4,2), start_date_var DATE)
BEGIN
	START TRANSACTION;
		INSERT INTO loans(start_date, amount, interest, expiration_date, customer_id)
		VALUES(start_date_var, loan_amount_var, interest_var, NULL, customer_id_var);
		
		IF(loan_amount_var NOT BETWEEN 0.01 AND 100000) THEN
			ROLLBACK;
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid Loan Amount.';
		ELSE 
			COMMIT;
		END IF;
END $$
DELIMITER ;