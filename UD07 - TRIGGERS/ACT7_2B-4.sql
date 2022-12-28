CREATE OR REPLACE TRIGGER trg_lfactures
	BEFORE INSERT OR DELETE OR UPDATE
	ON lfactures
	FOR EACH ROW
BEGIN
	IF INSERTING THEN
		UPDATE factures
		SET fac_total = fac_total + :NEW.lfa_subtotal
		WHERE fac_id = :NEW.lfa_fac_id;
	ELSE
		RAISE_APPLICATION_ERROR(-20000, 'Error, this statement is forbidden');
	END IF;
END;
/


