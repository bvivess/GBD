-- VERSION I: a Derived column: 'factures.fac_total' must represent the sum of 'lfactures--> lfa_subtotal'
CREATE OR REPLACE TRIGGER trg_lfactures_INSERTING
	BEFORE INSERT 
	ON lfactures
	FOR EACH ROW
BEGIN
	UPDATE factures
	SET fac_total = fac_total + :NEW.lfa_subtotal
	WHERE fac_id = :NEW.lfa_fac_id;
END;
/

CREATE OR REPLACE TRIGGER trg_lfactures_DELETING
	BEFORE DELETE
	ON lfactures
	FOR EACH ROW
BEGIN
	UPDATE factures
	SET fac_total = fac_total - :OLD.lfa_subtotal
	WHERE fac_id = :OLD.lfa_fac_id;
END;
/

CREATE OR REPLACE TRIGGER trg_lfactures_UPDATING
	BEFORE UPDATE OF lfa_subtotal
	ON lfactures
	FOR EACH ROW
BEGIN
	UPDATE factures
	SET fac_total = fac_total + :NEW.lfa_subtotal - :OLD.lfa_subtotal
	WHERE fac_id = :NEW.lfa_fac_id;
END;
/

-- VERSION II: 
CREATE OR REPLACE TRIGGER trg_lfactures
	BEFORE INSERT OR DELETE OR UPDATE OF lfa_subtotal
	ON lfactures
	FOR EACH ROW
BEGIN
	IF INSERTING THEN
		UPDATE factures
		SET fac_total = fac_total + :NEW.lfa_subtotal
		WHERE fac_id = :NEW.lfa_fac_id;
	ELSIF DELETING THEN
		UPDATE factures
		SET fac_total = fac_total - :OLD.lfa_subtotal
		WHERE fac_id = :OLD.lfa_fac_id;
	ELSIF UPDATING THEN
		UPDATE factures
		SET fac_total = fac_total + :NEW.lfa_subtotal - :OLD.lfa_subtotal
		WHERE fac_id = :NEW.lfa_fac_id;
	END IF;
END;
/

-- VERSION III: 
CREATE OR REPLACE TRIGGER trg_lfactures
	BEFORE INSERT OR DELETE OR UPDATE OF lfa_subtotal
	ON lfactures
	FOR EACH ROW
BEGIN
	UPDATE factures
	SET fac_total = fac_total - NVL(:OLD.lfa_subtotal,0) -- :OLD values are NULL for INSERT statement
							  + NVL(:NEW.lfa_subtotal,0) -- :NEW values are NULL for DELETE statement
	WHERE fac_id = NVL(:NEW.lfa_fac_id, :OLD.lfa_fac_id);
END;
/
