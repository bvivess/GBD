-- a complex CK: a double related columns, VERSION I

CREATE OR REPLACE TRIGGER trg_professors
  BEFORE INSERT
  ON professors
  FOR EACH ROW
DECLARE
	msg_err VARCHAR2(100);
BEGIN
	IF :new.per_tdoc = '1' THEN
		IF LENGHT(:new.per_docid) != 10 THEN
			msg_err := 'Longitud per a DNI no vàlida';
		END IF;
	ELSIF :new.per_tdoc = '2' THEN
		IF LENGHT(:new.per_docid) != 12 THEN
			msg_err := 'Lomgitud per a NIF no vàlida';
		END IF;
	ELSIF :new.per_tdoc = '3' THEN
		IF LENGHT(:new.per_docid) != 15 THEN
			msg_err := 'Lomgitud per a NIE no vàlida';
		END IF;
	END IF;
	--
	IF msg_err IS NOT NULL THEN
		RAISE_APPLICATION_ERROR( -20003, msg_err );
	END IF;
END;

-- a complex CK: a double related columns, VERSION II (INCLUDING ACT6_2-1.sql)
CREATE OR REPLACE TRIGGER trg_persones
  BEFORE INSERT OR UPDATE OR DELETE
  ON persones
  FOR EACH ROW
BEGIN
  IF DELETING THEN
    RAISE_APPLICATION_ERROR(-20004, 'No és possible eliminar el registre');
  ELSE
    --
    -- PER_ID
    --
    IF INSERTING THEN
      SELECT COUNT(*) + 1 INTO :new.per_id FROM persones;
    END IF;
    --
    -- PER_TDOC + PER_DOCID
    --
    IF (:new.per_tdoc = '1' AND LENGTH(:new.per_docid) != 10) OR THEN
      RAISE_APPLICATION_ERROR(-20003, 'Error, longitud DNI errònia');
    ELSIF :new.per_tdoc = '2' AND LENGTH(:new.per_docid) != 12 THEN
      RAISE_APPLICATION_ERROR(-20003, 'Error, longitud NIF errònia');
    ELSIF :new.per_tdoc = '3' AND LENGTH(:new.per_docid) != 15 THEN
      RAISE_APPLICATION_ERROR(-20003, 'Error, longitud NIE errònia');
    END IF;
  END IF;
END;
