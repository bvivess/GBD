CREATE OR REPLACE TRIGGER trg_employees
  BEFORE INSERT OR UPDATE OF salary, employee_id
  ON employees
  FOR EACH ROW
DECLARE
	PRAGMA 		AUTONOMOUS_TRANSACTION;
	min_salary	employees.salary%TYPE;
	max_salary	employees.salary%TYPE;
	mgr_salary	employees.salary%TYPE;
BEGIN
	IF INSERTING THEN
		SELECT seq_employees INTO :NEW.employee_id FROM sequences_tab;
		--
		UPDATE sequences_tab SET seq_employees = seq_employees + 1;
	ELSIF UPDATING('employee_id') THEN
		RAISE_APPLICATION_ERROR(-20001, 'Error, no es posible modificar la columna PK');
	ELSIF UPDATING('salary') THEN
		BEGIN
			SELECT NVL(min_salary,0), NVL(max_salary,0) INTO min_salary, max_salary
			FROM jobs
			WHERE job_id = :NEW.job_id;
			--
			IF (:NEW.salary NOT BETWEEN min_salary AND max_salary) THEN
				RAISE_APPLICATION_ERROR(-20001,'Error, el salario no está en el margen definido: ' || TO_CHAR(min_salary) || '-' || TO_CHAR(max_salary));
			END IF;
		
		END;
		--
		BEGIN
			SELECT salary INTO mgr_salary
			FROM employees
			WHERE employee_id = NVL(:NEW.manager_id, -1);
			--
			IF NVL(:NEW.salary, 0) >= mgr_salary THEN
				RAISE_APPLICATION_ERROR(-20002,'Error, salario excede importe posible.');
			END IF;
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				-- This employee does not have any manager.
				NULL;
		END;
	END IF;
END;
/