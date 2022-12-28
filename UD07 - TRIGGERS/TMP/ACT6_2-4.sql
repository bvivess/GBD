-- a Log table
CREATE TABLE log_persones(
	log_per_id		VARCHAR2(10) NOT NULL,
    log_per_nom		VARCHAR2(100) NOT NULL,
    log_per_tdoc	VARCHAR2(1) NOT NULL,
    log_per_docid	VARCHAR2(15) NOT NULL,
	log_opeid		VARCHAR2(1) NOT NULL,
	log_date		DATE NOT NULL,
	log_user		VARCHAR2(100) NOT NULL
);

CREATE OR REPLACE TRIGGER trg_persones
  BEFORE INSERT OR DELETE OR UPDATE
  ON persones
  FOR EACH ROW
DECLARE
	v_opeid	VARCHAR2(1);
BEGIN
	IF INSERTING THEN
		v_opeid := 'I';
	ELSIF UPDATING THEN
		v_opeid := 'U';
	ELSIF DELETING THEN
		v_opeid := 'D';
	END IF;
	--
	INSERT log_persones( log_per_id, log_per_nom, log_per_tdoc, log_per_docid,
	                     log_opeid, log_date, log_user )
	VALUES( NVL(:new.per_id,:old.per_id), NVL(:new.per_nom,:old.per_nom), 
	        NVL(:new.per_tdoc,:old.per_tdoc), NVL(:new.per_docid,:old.per_docid),
			v_opeid, SYSDATE, USER );
END;




