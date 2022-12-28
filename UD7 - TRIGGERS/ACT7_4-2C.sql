-- Compound trigger
CREATE OR REPLACE TRIGGER trg_employees
	FOR INSERT OR DELETE OR UPDATE OF first_name, phone_number
	ON employees
	COMPOUND TRIGGER

	AFTER EACH ROW IS
	BEGIN	
		IF INSERTING THEN
			IF :NEW.first_name IS NULL THEN
				-- first_name: NULL
				INSERT INTO rmd_employees(rmd_employee_id, rmd_column_name, rmd_text )
				VALUES(:NEW.employee_id, 'FIRST_NAME', 'First_name is null');
			END IF;
			--
			IF :NEW.phone_number IS NULL THEN
				-- phone_number: NULL
				INSERT INTO rmd_employees(rmd_employee_id, rmd_column_name, rmd_text )
				VALUES(:NEW.employee_id, 'PHONE_NUMBER', 'Phone_number is null');
			END IF;
		END IF;
	END AFTER EACH ROW;

	BEFORE EACH ROW IS
	BEGIN
		IF DELETING THEN
			DELETE FROM rmd_employees
			WHERE rmd_employee_id = :OLD.employee_id;
		ELSIF UPDATING THEN
			IF :OLD.first_name IS NULL AND :NEW.first_name IS NOT NULL THEN
				-- first_name: NULL --> NOT NULL
				DELETE FROM rmd_employees
				WHERE rmd_employee_id = :NEW.employee_id
				AND   rmd_column_name = 'FIRST_NAME';
			ELSIF :OLD.first_name IS NOT NULL  AND :NEW.first_name IS NULL THEN
				-- first_name: NOT NULL --> NULL
				INSERT INTO rmd_employees(rmd_employee_id, rmd_column_name, rmd_text )
				VALUES(:NEW.employee_id, 'FIRST_NAME', 'First_name is null');
			END IF;
			--
			IF :OLD.phone_number IS NULL AND :NEW.phone_number IS NOT NULL THEN
				-- phone_number: NULL --> NOT NULL
				DELETE FROM rmd_employees
				WHERE rmd_employee_id = :NEW.employee_id
				AND   rmd_column_name = 'PHONE_NUMBER';
			ELSIF :OLD.phone_number IS NOT NULL  AND :NEW.phone_number IS NULL THEN
				-- phone_number: NOT NULL --> NULL
				INSERT INTO rmd_employees(rmd_employee_id, rmd_column_name, rmd_text )
				VALUES(:NEW.employee_id, 'PHONE_NUMBER', 'Phone_number is null');
			END IF;
		END IF;
	END BEFORE EACH ROW;
	
END trg_employees;
