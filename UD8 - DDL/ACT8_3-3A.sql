--
ALTER TABLE employees ADD emp_cname VARCHAR(100);

--
UPDATE employees 
SET emp_cname = CONCAT( last_name, ', ' , first_name );

-- 
ALTER TABLE employees MODIFY emp_cname VARCHAR(100) NOT NULL;