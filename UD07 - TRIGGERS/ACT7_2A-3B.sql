-- a Derived column II: it should not be possible to store a negative value for 'factures--> fac_total'
CREATE OR REPLACE TRIGGER trg_factures
  BEFORE UPDATE OF fac_total
  ON factures
  FOR EACH ROW
BEGIN
  IF (:NEW.fac_total < 0) THEN
      RAISE_APPLICATION_ERROR(-20005, 'No es posible un valor negatiu per al total de factures');
  END IF;
END;


