CREATE OR REPLACE TRIGGER trg_factures_2
	BEFORE DELETE OR UPDATE OF fac_id
	ON factures
	FOR EACH ROW
BEGIN
	RAISE_APPLICATION_ERROR(-20000,'Operación no permitida');
END;
/


-- MERGING trg_factures AND trg_factures_2
DROP TRIGGER trg_factures_2;
CREATE OR REPLACE TRIGGER trg_factures
	BEFORE INSERT OR DELETE OR UPDATE OF fac_id
	ON factures
	FOR EACH ROW
BEGIN
	IF INSERTING THEN
		SELECT seq_factures INTO :NEW.fac_id FROM sequences_tab;
		--
		UPDATE sequences_tab SET seq_factures = seq_factures + 1;
	ELSE
		RAISE_APPLICATION_ERROR(-20000,'Operación no permitida');
	END IF;
END;
/

