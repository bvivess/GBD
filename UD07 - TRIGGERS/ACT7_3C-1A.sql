-- a non rollbacked sequence related to a COLUMN
ALTER TABLE sequences_tab ADD (seq_customers NUMBER(3) DEFAULT 1 NOT NULL);

UPDATE sequences_tab
SET seq_customers = (SELECT MAX(customer_id) + 1 FROM customers);

CREATE OR REPLACE TRIGGER trg_customers
	BEFORE UPDATE OF customer_id
	ON customers
	FOR EACH ROW
BEGIN
	IF INSERTING THEN
		SELECT seq_customers INTO :NEW.customer_id FROM sequences_tab;
		--
		UPDATE sequences_tab SET seq_customers = seq_customers + 1;
	ELSE
		RAISE_APPLICATION_ERROR(-20000,'Error, instrucción no permitida.');
	END IF;
END;
/