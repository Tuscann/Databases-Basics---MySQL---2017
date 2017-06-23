#Section 1. DDL
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