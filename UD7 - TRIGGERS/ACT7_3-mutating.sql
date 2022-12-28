-- Què vol dir 'Mutating table error' ?
-- https://docs.oracle.com/cd/E11882_01/appdev.112/e25519/triggers.htm#LNPLS2005
-- http://www.dba-oracle.com/t_avoiding_mutating_table_error.htm
-- https://stackoverflow.com/questions/16182089/table-is-mutating-trigger-function-may-not-see-it-stopping-an-average-grade-fr

-- Què es pragma autonomous_transaction ?
-- https://carlosal.wordpress.com/2007/06/21/transacciones-autonomas-commits-rollbacks-y-gestion-de-errores/

CREATE OR REPLACE TRIGGER trg_employees
  BEFORE INSERT OR UPDATE OF salary
  ON employees
  FOR EACH ROW
DECLARE
	PRAGMA AUTONOMOUS_TRANSACTION;
	mgr_salary	employees.salary%TYPE;
BEGIN
	SELECT salary INTO mgr_salary
	FROM employees
	WHERE employee_id = NVL(:NEW.manager_id, -1);
	--
	IF NVL(:NEW.salary, 0) >= mgr_salary THEN
		RAISE_APPLICATION_ERROR(-20001,'Error, salario excede importe posible: ' || TO_CHAR(mgr_salary));
	END IF;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		-- This employee does not have any manager.
		NULL;
END;