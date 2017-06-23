-----------------DDL-----------
CREATE TABLE `deposit_types` (
	`deposit_type_id` INT,
	`name` VARCHAR(20),
	CONSTRAINT `pk_depoits_type` PRIMARY KEY (`deposit_type_id`)
);

CREATE TABLE `deposits` (
	`deposit_id` INT AUTO_INCREMENT,
	`amount` DECIMAL(10,2),
	`start_date` DATE,
	`end_date` DATE,
	`deposit_type_id` INT,
	`customer_id` INT,
	CONSTRAINT `pk_deposits` PRIMARY KEY (`deposit_id`),
   CONSTRAINT `fk_deposits_deposit_types` FOREIGN KEY (`deposit_type_id`) REFERENCES `deposit_types`(`deposit_type_id`),
   CONSTRAINT `fk_deposits_customers` FOREIGN KEY (`customer_id`) REFERENCES `customers`(`customer_id`)
);

CREATE TABLE `employees_deposits` (
	`employee_id` INT,
	`deposit_id` INT,
	CONSTRAINT `pk_employees_deposits` PRIMARY KEY (`employee_id`, `deposit_id`),
	CONSTRAINT `fk_employees_deposits_employees` FOREIGN KEY (`employee_id`) REFERENCES `employees`(`employee_id`),
	CONSTRAINT `fk_employees_deposits_deposits` FOREIGN KEY (`deposit_id`) REFERENCES `deposits`(`deposit_id`)
);

 CREATE TABLE `credit_history` (
	`credit_history_id` INT,
	`mark` CHAR(1),
	`start_date` DATE,
	`end_date` DATE,
	`customer_id` INT,
	CONSTRAINT `pk_credit_history` PRIMARY KEY (`credit_history_id`),
	CONSTRAINT `fk_credit_hystory_costomers` FOREIGN KEY (`customer_id`) REFERENCES `customers`(`customer_id`)
);

CREATE TABLE `payments`(
	`payement_id` INT,
	`date` DATE,
	`amount` DECIMAL(10,2),
	`loan_id` INT,
	CONSTRAINT `pk_payment` PRIMARY KEY (`payement_id`),
	CONSTRAINT `fk_payments_loans` FOREIGN KEY (`loan_id`) REFERENCES `loans`(`loan_id`)
);

CREATE TABLE `users`(
	`user_id` INT,
	`user_name` VARCHAR(20),
	`password` VARCHAR(20),
	`customer_id` INT UNIQUE,
	CONSTRAINT `pk_user_id` PRIMARY KEY (`user_id`),
	CONSTRAINT `fk_users_customers` FOREIGN KEY (`customer_id`) REFERENCES `customers`(`customer_id`)
);

ALTER TABLE `employees`
ADD `manager_id` INT,
ADD CONSTRAINT `fk_employees_employees` FOREIGN KEY(`manager_id`) REFERENCES `employees`(`employee_id`);
------------Insert-------------
INSERT INTO deposit_types
VALUES (1,'Time Deposit'), (2,'Call Deposit'), (3,'Free Deposit');

INSERT INTO deposits(amount, start_date, end_date, deposit_type_id, customer_id)
SELECT
	CASE
		WHEN c.date_of_birth > DATE('1980-01-01') THEN 1000
	ELSE 1500
	END
	+
	CASE WHEN c.gender = 'M' THEN 100
		ELSE 200
	END AS amount,
	NOW() AS start_date,
	NULL AS end_date,
	CASE 
		WHEN c.customer_id > 15 THEN 3
		ELSE
			CASE 
				WHEN c.customer_id % 2 = 0 THEN 2
			ELSE 1
			END
	END AS deposit_type_id,
	c.customer_id
FROM customers AS c
WHERE c.customer_id < 20;

INSERT INTO employees_deposits(employee_id, deposit_id)
VALUES 
	(15,4),
	(20,15),
	(8,7),
	(4,8),
	(3,13),
	(3,8),
	(4,10),
	(10,1),
	(13,4),
	(14,9);
------------Update------------
UPDATE employees
SET manager_id = CASE 	
	WHEN employee_id BETWEEN 2 AND 10 THEN 1
	WHEN employee_id BETWEEN 12 AND 20 THEN 11
	WHEN employee_id BETWEEN 22 AND 30 THEN 21
	WHEN employee_id IN(11,21) THEN 1
	END;
-------------Delete------------

DELETE FROM employees_deposits
WHERE deposit_id = 9 OR employee_id =3;

------ Section 3: Querying - P01. Employees’ Salary ----

select e.employee_id,e.hire_date,e.salary,e.branch_id
from employees as e
where salary > 2000 and date(hire_date)>'2009-06-15'

------ Section 3: Querying - P02. Customer Age ----------

select cu.customer_id,cu.first_name,cu.last_name,cu.gender,c.city_name from cities as c
right join customers as cu
on cu.city_id=c.city_id
where (cu.last_name like 'Bu%' or cu.first_name like '%a') and LENGTH(c.city_name)>=8
order by cu.customer_id asc ;

----- Section 3: Querying - P04. Employee Accounts ------

select distinct e.employee_id,e.first_name,a.account_number
from employees as e
join employees_accounts as ea
on ea.employee_id=e.employee_id
join accounts as a
on a.account_id=ea.account_id
where year(a.start_date)> '2012'
order by e.first_name desc
limit 5;

----- Section 3: Querying - P05. Count Cities ----------------

select c.city_name,name,count(e.employee_id) as employees_count
from employees as e
join branches as b
on b.branch_id=e.branch_id
join cities as c
using (city_id)
group by c.city_name,name
having count(e.employee_id)>=3

--- Section 3: Querying - P06. Loan Statistics ----------------

select sum(l.amount),max(l.interest),min(e.salary)
from employees as e
join employees_loans as el
using(employee_id)
join loans as l
using (loan_id)

--- Section 3: Querying - P07. Unite People -----------------

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

------ Section 3: Querying - P08. Customers w/o Accounts --------

SELECT c.`customer_id`, c.`height`
FROM `customers` AS c
LEFT JOIN `accounts` AS a
ON c.`customer_id` = a.`customer_id`
WHERE a.`account_id` IS NULL AND c.`height` BETWEEN 1.74 AND 2.04;

----- Section 3: Querying - P09. Average Loans ------------------

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

------ Section 3: Querying - P10. Oldest Account ---------------

select c.customer_id,c.first_name,a.start_date
from customers as c
join accounts as a
using (customer_id)
order by a.start_date limit 1 ;

------ Section 4: Programmability - P01. String Joiner ----------

CREATE FUNCTION udf_concat_string(first_string VARCHAR(50), second_string VARCHAR(50))
RETURNS VARCHAR(100)
BEGIN
	DECLARE result VARCHAR(100);
	SET result = CONCAT(REVERSE(first_string), REVERSE(second_string));
	RETURN result;
END

------ Section 4: Programmability - P02. Inexpired Loans ----------

CREATE PROCEDURE usp_customers_with_unexpired_loans(customer_id_var INT)
BEGIN
	SELECT c.customer_id, c.first_name, l.loan_id, l.expiration_date
	FROM customers AS c
	INNER JOIN loans AS l
	ON c.customer_id = l.customer_id
	WHERE c.customer_id = customer_id_var AND l.expiration_date IS NULL;
END

------ Section 4: Programmability - P03. Take Loan ----------

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
END

------ Section 4: Programmability - P04. Hire Employee ----------

CREATE TRIGGER tr_hire_employee
AFTER INSERT
ON employees
FOR EACH ROW
BEGIN
	UPDATE employees_loans
	SET employee_id = NEW.employee_id
	WHERE employee_id = NEW.employee_id - 1;
END

-------- Section 5: Bonus - P01. Delete Trigger ------------