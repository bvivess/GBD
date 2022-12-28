CREATE SEQUENCE seq_employees START WITH 207;  --> SELECT MAX(employee_id) + 1 FROM employees;

CREATE OR REPLACE TRIGGER trg_employees
	BEFORE INSERT
	ON employees
	FOR EACH ROW
BEGIN
	:new.emp_id := seq_employees.NEXTVAL;
END;

