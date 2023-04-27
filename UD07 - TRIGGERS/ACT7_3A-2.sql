CREATE OR REPLACE TRIGGER trg_employees
  BEFORE INSERT OR UPDATE OF salary
  ON employees
  FOR EACH ROW
DECLARE
	min_salary	employees.salary%TYPE;
	max_salary	employees.salary%TYPE;
BEGIN
	SELECT NVL(min_salary,0), NVL(max_salary,0) INTO min_salary, max_salary
	FROM jobs
	WHERE job_id = :NEW.job_id;
	--
	IF (:NEW.salary NOT BETWEEN min_salary AND max_salary) THEN
		RAISE_APPLICATION_ERROR(-20001,'Error, el salario no está en el margen definido: ' || TO_CHAR(min_salary) || '-' || TO_CHAR(max_salary));
	END IF;
END;
/