CREATE OR REPLACE TRIGGER trg_customers
  BEFORE INSERT OR UPDATE OF account_mgr_id
  ON customers
  FOR EACH ROW
DECLARE
	v_department_id	departments.department_id%TYPE;
BEGIN
	SELECT department_id INTO v_department_id
	FROM employees
	WHERE employee_id = NVL(:NEW.account_mgr_id, -1);
	--
	IF v_department_id != '80' THEN
		-- This employee does not belong to 80-Sales.
		RAISE_APPLICATION_ERROR(-20001,'Error, este empleado no pertenece al Dpto 80.');
	END IF;
END;

CREATE TRIGGER trg_employees
	BEFORE UPDATE OF department_id
	ON employees
	FOR EACH ROW
DECLARE	
	dummy VARCHAR2(1);
BEGIN
	BEGIN
		SELECT '1' INTO dummy
		FROM customers
		WHERE account_mgr_id = :OLD.employee_id;
		--
		RAISE_TOO_MANY_ROWS;
	EXCEPTION
		WHEN TOO_MANY_ROWS THEN
			IF :NEW.department_id != 80 THEN
				RAISE_APPLICATION_ERROR(-20000, 'El empleado ' || :OLD.employee_id || ' tiene clientes asociados.');
			END IF;
		WHEN NO_DATA_FOUND THEN	
			NULL;
	END;
END;