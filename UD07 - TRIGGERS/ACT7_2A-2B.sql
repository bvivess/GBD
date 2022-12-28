-- a complex CK: a Relationships in arc 
CREATE OR REPLACE TRIGGER trg_alumnes
	BEFORE INSERT
	ON alumnes
	FOR EACH ROW
DECLARE 
	dummy VARCHAR2(1);
BEGIN
    SELECT '1' INTO dummy
    FROM professors
    WHERE pro_per_id = :NEW.alu_per_id;
    --
    RAISE_APPLICATION_ERROR(-20000,'No es possible inserir registre');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
		NULL;
END;

CREATE OR REPLACE TRIGGER trg_professors
	BEFORE INSERT
	ON professors
	FOR EACH ROW
DECLARE
  dummy  VARCHAR2(1);
BEGIN
    SELECT '1' INTO dummy
    FROM alumnes
    WHERE alu_per_id = :NEW.pro_per_id;
    --
    RAISE_APPLICATION_ERROR(-20001, 'No es possible inserir registre');
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		NULL;
END;
/



