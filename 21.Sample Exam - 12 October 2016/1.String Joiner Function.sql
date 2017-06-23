#1.	String Joiner Function
DELIMITER $$
CREATE FUNCTION udf_concat_string(first_string VARCHAR(50), second_string VARCHAR(50))
RETURNS VARCHAR(100)
BEGIN
	DECLARE result VARCHAR(100);
	SET result = CONCAT(REVERSE(first_string), REVERSE(second_string));
	RETURN result;
END $$
DELIMITER ;