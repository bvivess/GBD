-- a complex CK: forbid a statement
CREATE OR REPLACE TRIGGER trg_persones
	BEFORE DELETE OR UPDATE
	ON persones
	FOR EACH ROW
BEGIN
	RAISE_APPLICATION_ERROR(-20000,'Error, instrucció no permesa');
END;
/

