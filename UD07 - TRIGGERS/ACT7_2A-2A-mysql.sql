-- a complex CK: a double related columns
DELIMITER /
DROP TRIGGER IF EXISTS trg_persones_I;
CREATE TRIGGER trg_persones_I
	BEFORE INSERT  OR UPDATE
	ON persones
	FOR EACH ROW
BEGIN
	--
	-- PER_TDOC + PER_DOCID
	--
	IF (NEW.per_tdoc = '1') AND (LENGTH(NEW.per_docid) != 10) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error, longitud DNI errònia';
	END IF;    
	IF (new.per_tdoc = '2') AND (LENGTH(new.per_docid) != 12) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error, longitud NIF errònia';
	END IF;
	IF (NEW.per_tdoc = '3') AND (LENGTH(new.per_docid) != 15) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error, longitud NIE errònia';
	END IF;
END;
/
DELIMITER ;

DELIMITER /
CREATE TRIGGER trg_persones_U
	BEFORE UPDATE 
	ON persones
	FOR EACH ROW
BEGIN
	--
	-- PER_TDOC + PER_DOCID
	--
	IF (NEW.per_tdoc = '1') AND (LENGTH(NEW.per_docid) != 10) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error, longitud DNI errònia';
	END IF;    
	IF (new.per_tdoc = '2') AND (LENGTH(new.per_docid) != 12) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error, longitud NIF errònia';
	END IF;
	IF (NEW.per_tdoc = '3') AND (LENGTH(new.per_docid) != 15) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error, longitud NIE errònia';
	END IF;
END;
/
DELIMITER ;
