  -- a Derived column: 'factures.fac_total' must represent the sum of 'lfactures--> lfa_subtotal'
CREATE OR REPLACE TRIGGER trg_lfactures
  BEFORE INSERT OR DELETE OR UPDATE
  ON lfactures
  FOR EACH ROW
BEGIN
	IF INSERTING THEN
		UPDATE factures
		SET fac_total = fac_total + :new.lfa_subtotal
		WHERE fac_id = :new.lfa_fac_id;
	ELSIF DELETING THEN
		UPDATE factures
		SET fac_total = fac_total - :old.lfa_subtotal
		WHERE fac_id = :old.lfa_fac_id;
	ELSIF UPDATING THEN
		UPDATE factures
		SET fac_total = fac_total + :new.lfa_subtotal - :old.lfa_subtotal
		WHERE fac_id = :new.lfa_fac_id;
	END IF;
END;

-- a Derived column I: 'factures.fac_total' must represent the sum of 'lfactures--> lfa_subtotal', VERSION II
CREATE OR REPLACE TRIGGER trg_lfactures
  BEFORE INSERT OR DELETE OR UPDATE
  ON lfactures
  FOR EACH ROW
BEGIN
	UPDATE factures
	SET fac_total = fac_total  
					+ NVL(:new.lfa_subtotal,0) 
					- NVL(:old.lfa_subtotal,0)
	WHERE fac_id = NVL(:new.lfa_fac_id, :old.lfa_fac_id);
END;

-- a Derived column II: it should not be possible to store a negative value for 'factures--> fac_total'
CREATE OR REPLACE TRIGGER trg_factures
  BEFORE INSERT OR UPDATE
  ON factures
  FOR EACH ROW
BEGIN
  IF INSERTING THEN
    SELECT COUNT(*) + 1 INTO :new.fac_id
    FROM factures;
    --
    :new.fac_total := 0;
  ELSIF UPDATING AND :new.fac_total < 0 THEN
      RAISE_APPLICATION_ERROR(-20005,'No es posible un valor negatiu per al total de factures');
  END IF;
END;


