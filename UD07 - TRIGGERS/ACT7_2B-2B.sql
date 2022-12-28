CREATE OR REPLACE TRIGGER trg_persones
	AFTER INSERT
	ON persones
	FOR EACH ROW
BEGIN
	INSERT INTO alumnes( alu_per_id )
	VALUES( :NEW.per_id );
END;
/


