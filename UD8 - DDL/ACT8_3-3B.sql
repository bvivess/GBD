--
ALTER TABLE employees ADD last_name VARCHAR(30);
ALTER TABLE employees ADD first_name VARCHAR(30);

--
UPDATE employees
SET last_name  = SUBSTR(emp_cname, 1, INSTR(emp_cname,', ') - 1), 
    first_name = SUBSTR(emp_cname, INSTR(emp_cname,', ') + 2, 100);

-- 
ALTER TABLE employees DROP emp_cname;
