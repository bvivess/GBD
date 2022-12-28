-- 
CREATE OR REPLACE TRIGGER trg_lfactures
	BEFORE INSERT OR DELETE
	ON lfactures
	FOR EACH ROW
BEGIN
    IF INSERTING THEN
		UPDATE factures
		SET fac_lfac = fac_lfac + 1
		WHERE fac_id = :NEW.lfa_fac_id;
	ELSIF DELETING THEN
		UPDATE factures
		SET fac_lfac = fac_lfac - 1
		WHERE fac_id = :OLD.lfa_fac_id;
    END IF;
END;
/


