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

-- Version I
CREATE OR REPLACE TRIGGER trg_persones
	BEFORE UPDATE OR DELETE
	ON persones
	FOR EACH ROW
BEGIN
	IF UPDATING THEN
		INSERT log_persones( log_per_id, log_per_nom, log_per_tdoc, log_per_docid,
							 log_opeid, log_date, log_user )
		VALUES( :OLD.per_id,   :OLD.per_nom, 
				:OLD.per_tdoc, :OLD.per_docid,
				'U', SYSDATE, USER );
	ELSIF DELETING THEN
		INSERT log_persones( log_per_id, log_per_nom, log_per_tdoc, log_per_docid,
							 log_opeid, log_date, log_user )
		VALUES( :OLD.per_id,   :OLD.per_nom, 
				:OLD.per_tdoc, :OLD.per_docid,
				'D', SYSDATE, USER );
	END IF;
END;

-- Version II
CREATE OR REPLACE TRIGGER trg_persones
	BEFORE UPDATE OR DELETE
	ON persones
	FOR EACH ROW
DECLARE
	v_opeid	VARCHAR2(1);
BEGIN
	IF UPDATING THEN
		v_opeid := 'I';
	ELSIF UPDATING THEN
		v_opeid := 'U';
	ELSIF DELETING THEN
		v_opeid := 'D';
	END IF;
	--
	INSERT log_persones( log_per_id, log_per_nom, log_per_tdoc, log_per_docid,
	                     log_opeid, log_date, log_user )
	VALUES( NVL(:OLD.per_id,:NEW.per_id), NVL(:OLD.per_nom,:NEW.per_nom), 
	        NVL(:OLD.per_tdoc,:NEW.per_tdoc), NVL(:OLD.per_docid,:NEW.per_docid),
			v_opeid, SYSDATE, USER );
END;




