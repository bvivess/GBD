-- STEP 1
CREATE TABLE people_tab(
	( people_id			INT NOT NULL AUTO_INCREMENT,
	  first_name		VARCHAR(30) NOT NULL,
	  last_name			VARCHAR(30) NOT NULL,
	  people_people_id	INT,
	  CONSTRAINT peo_pk PRIMARY KEY (people_id)
);

-- ALTER TRIGGER UPDATE_job_history DISABLE;
DROP TRIGGER UPDATE_job_history;

-- STEP 2: RULE: an employee and a customer share the same First_name and Last_name
INSERT INTO people_tab( first_name, last_name )
		SELECT UPPER(first_name), UPPER(last_name)
		FROM employees
	UNION
		SELECT UPPER(cust_first_name), UPPER(cust_last_name)
		FROM customers;

UPDATE employees e
SET people_id = ( SELECT people_id 
                  FROM people_tab p
				  WHERE UPPER(e.first_name) = UPPER(p.first_name)
				  AND   UPPER(e.last_name)  = UPPER(p.last_name)
				);
				 
UPDATE customers c
SET people_id = ( SELECT people_id 
                  FROM people_tab p
				  WHERE UPPER(c.cust_first_name) = UPPER(p.first_name)
				  AND   UPPER(c.cust_last_name)  = UPPER(p.last_name)
				);

-- STEP 3
-- employees 1:N departments
ALTER TABLE departments DROP CONSTRAINT dep_mgr_fk;

UPDATE departments
SET people_id = (SELECT people_id
                 FROM employees
				 WHERE employee_id = manager_id);

ALTER TABLE departments DROP COLUMN manager_id;

-- employees 1:N employees
ALTER TABLE employees DROP CONSTRAINT emp_mgr_fk;
ALTER TABLE employees ADD people_people_id INT;

UPDATE employees
SET people_people_id = (SELECT people_id
						FROM employees
						WHERE employee_id = manager_id);

ALTER TABLE employees DROP COLUMN manager_id;
ALTER TABLE employees MODIFY people_people_id INT NOT NULL;

-- employees 1:N job_history
ALTER TABLE job_history DROP CONSTRAINT jhist_emp_fk;
ALTER TABLE job_history ADD people_id INT;
UPDATE job_history j
SET people_id = (SELECT people_id
				 FROM employees e
				 WHERE j.employee_id = e.employee_id);

ALTER TABLE job_history DROP COLUMN employee_id;
ALTER TABLE job_history MODIFY people_id INT NOT NULL;


-- employees PK and its FK
ALTER TABLE employees DROP PRIMARY KEY;
ALTER TABLE employees ADD CONSTRAINT emp_pk PRIMARY KEY (people_id);
ALTER TABLE employees ADD CONSTRAINT emp_peo_FK
	FOREIGN KEY(people_id) REFERENCES people( people_id );

ALTER TABLE departments ADD CONSTRAINT dep_emp_fk 
	FOREIGN KEY (people_id) REFERENCES employees(people_id);
	
ALTER TABLE employees ADD CONSTRAINT emp_emp_fk 
	FOREIGN KEY (people_id) REFERENCES employees(people_people_id);

ALTER TABLE job_history ADD CONSTRAINT jhist_emp_fk 
	FOREIGN KEY (people_id) REFERENCES employees(people_id);
	
-- customers 1:orders
ALTER TABLE orders DROP CONSTRAINT ord_cus_fk;
ALTER TABLE orders ADD people_id INT;

UPDATE orders o
SET people_id = (SELECT people_id
				 FROM customers c
				 WHERE o.customer_id = c.customer_id);

ALTER TABLE orders DROP COLUMN customer_id;
ALTER TABLE orders MODIFY people_id INT NOT NULL;

-- customer PK and its FK
ALTER TABLE customers DROP PRIMARY KEY;

ALTER TABLE customers ADD CONSTRAINT cust_peo_FK
	FOREIGN KEY(people_id) REFERENCES people( people_id );
	
ALTER TABLE orders ADD CONSTRAINT ord_cus_fk 
	FOREIGN KEY (people_id) REFERENCES customers(people_id);


-- ALTER TRIGGER UPDATE_job_history ENABLE;
CREATE TRIGGER UPDATE_job_history ...

-- DROP COLUMNS on EMPLOYEES, CUSTOMERS
ALTER TABLE employees DROP COLUMN first_name;
ALTER TABLE employees DROP COLUMN last_name;

ALTER TABLE customers DROP COLUMN cust_first_name;
ALTER TABLE customers DROP COLUMN cust_last_name;
