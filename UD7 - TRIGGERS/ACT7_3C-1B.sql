CREATE OR REPLACE TRIGGER trg_employees
  BEFORE INSERT OR UPDATE OF salary OR UPDATE OF employee_id
  ON employees
  FOR EACH ROW
DECLARE
	PRAGMA AUTONOMOUS_TRANSACTION;
	mgr_salary	employees.salary%TYPE;
BEGIN
	IF UPDATING('employee_id') THEN
		RAISE_APPLICATION_ERROR(-20001, 'Error, no es posible modificar la columna PK');
	ELSE
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