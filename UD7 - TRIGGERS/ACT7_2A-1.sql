-- a non rollbacked sequence related to a COLUMN
CREATE TABLE sequences_tab(
	seq_persones NUMBER(3) DEFAULT 1 NOT NULL
);

INSERT INTO sequences_tab( seq_persones ) VALUES ( 1 );

-- Version I
CREATE OR REPLACE TRIGGER trg_persones
	BEFORE INSERT
	ON persones
	FOR EACH ROW
BEGIN
	SELECT COUNT(*) + 1 INTO :NEW.per_id FROM persones;
END;
/

-- Version II
CREATE OR REPLACE TRIGGER trg_persones
	BEFORE INSERT
	ON persones
	FOR EACH ROW
BEGIN
	--
	SELECT seq_persones INTO :NEW.per_id FROM sequences_tab;
	--
	UPDATE sequences_tab SET seq_persones = seq_persones + 1;
END;
/

