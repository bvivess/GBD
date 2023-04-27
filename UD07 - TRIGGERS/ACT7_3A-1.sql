-- a non rollbacked sequence related to a COLUMN
CREATE TABLE sequences_tab(
	seq_employees NUMBER(3) DEFAULT 1 NOT NULL
);

INSERT INTO sequences_tab (seq_employees) VALUES (108);

CREATE OR REPLACE TRIGGER trg_employees
	BEFORE INSERT
	ON employees
	FOR EACH ROW
BEGIN
	SELECT seq_employees INTO :NEW.employee_id FROM sequences_tab;
	--
	UPDATE sequences_tab SET seq_employees = seq_employees + 1;
END;
/
