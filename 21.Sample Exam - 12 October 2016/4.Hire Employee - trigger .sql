#4.	Trigger Hire Employee
DELIMITER $$
CREATE TRIGGER tr_hire_employee
AFTER INSERT
ON employees
FOR EACH ROW
BEGIN
	UPDATE employees_loans
	SET employee_id = NEW.employee_id
	WHERE employee_id = NEW.employee_id - 1;
END  $$
DELIMITER ;