-- Compound trigger
CREATE OR REPLACE TRIGGER trg_personas
	FOR INSERT OR DELETE OR UPDATE
	ON personas
	COMPOUND TRIGGER

	i   	NUMBER(5) := 0;
	text	VARCHAR2(100);

	BEFORE EACH ROW
		IF DELETING THEN
			RAISE_APPLICATION_ERROR(-20004, 'No és possible eliminar el registre');
		ELSE
			--
			-- PER_ID
			--
			IF INSERTING THEN
			  SELECT COUNT(*) + 1 INTO :NEW.per_id FROM persones;
			END IF;
			--
			-- PER_TDOC + PER_DOCID
			--
			IF (:NEW.per_tdoc = '1' AND LENGTH(:NEW.per_docid) != 10) OR THEN
				RAISE_APPLICATION_ERROR(-20003, 'Error, longitud DNI errònia');
			ELSIF :NEW.per_tdoc = '2' AND LENGTH(:NEW.per_docid) != 12 THEN
				RAISE_APPLICATION_ERROR(-20003, 'Error, longitud NIF errònia');
			ELSIF :NEW.per_tdoc = '3' AND LENGTH(:NEW.per_docid) != 15 THEN
				RAISE_APPLICATION_ERROR(-20003, 'Error, longitud NIE errònia');
			END IF;
		END IF;
	END BEFORE EACH ROW;

	AFTER EACH ROW IS BEGIN	
        i := i + 1;
	END AFTER EACH ROW;

	AFTER STATEMENT IS BEGIN
		IF INSERTING THEN
			text := 'INSERTED';
		ELSIF UPDATING THEN
			text := 'UPDATED';
		ELSIF DELETING THEN
			text := 'DELETED';
		END IF;
		--
		INSERT INTO log_personas( log_date, log_text )
		VALUES( SYSDATE, 'Number of rows ' || text || ' is ' || TO_CHAR(i) );
	END AFTER STATEMENT;
	
END trg_personas;
