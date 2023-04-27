-- a non rollbacked sequence related to a COLUMN
CREATE OR REPLACE TRIGGER trg_employees
	BEFORE INSERT OR UPDATE OF employee_id
	ON employees
	FOR EACH ROW
BEGIN
	IF INSERTING THEN
		SELECT seq_employees INTO :NEW.employee_id FROM sequences_tab;
		--
		UPDATE sequences_tab SET seq_employees = seq_employees + 1;
	ELSE
		RAISE_APPLICATION_ERROR(-20000,'Error, instrucción no permitida.');
	END IF;
END;
/
