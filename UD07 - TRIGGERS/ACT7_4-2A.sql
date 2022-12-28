-- Trigger AFTER
CREATE OR REPLACE TRIGGER trg_employees
	AFTER INSERT
	ON employees
	FOR EACH ROW
BEGIN
	IF :NEW.first_name IS NULL THEN
		INSERT INTO rmd_employees(rmd_employee_id, rmd_column_name, rmd_text )
		VALUES(:NEW.employee_id, 'FIRST_NAME', 'First_name is null');
	END IF;
	--
	IF :NEW.phone_number IS NULL THEN
		INSERT INTO rmd_employees(rmd_employee_id, rmd_column_name, rmd_text )
		VALUES(:NEW.employee_id, 'PHONE_NUMBER', 'Phone_number is null');
	END IF;
END;
