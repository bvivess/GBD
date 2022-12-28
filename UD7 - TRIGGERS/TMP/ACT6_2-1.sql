- a Sequence related to a PK COLUMN
CREATE OR REPLACE TRIGGER trg_persones
  BEFORE INSERT
  ON persones
  FOR EACH ROW
BEGIN
  SELECT COUNT(*) + 1 INTO :new.per_id FROM persones;
END;

