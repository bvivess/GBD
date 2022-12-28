-- a Sequence related to a PK COLUMN
ALTER TABLE sequences_tab ADD seq_factures NUMBER(10) DEFAULT 1 NOT NULL;

-- 
DROP TRIGGER trg_factures;
CREATE TRIGGER trg_factures
	BEFORE INSERT
	ON factures
	FOR EACH ROW
BEGIN
	SELECT seq_factures INTO :NEW.fac_id FROM sequences_tab;
	--
	UPDATE sequences_tab SET seq_factures = seq_factures + 1;
END;
/

