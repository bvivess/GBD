CREATE OR REPLACE TRIGGER trg_customers
  BEFORE INSERT OR UPDATE OF nls_language, nls_territory
  ON customers
  FOR EACH ROW
BEGIN
	-- 
	IF NOT ( (:NEW.nls_language = 'us'  AND :NEW.nls_territory = 'AMERICA') OR 
			 (:NEW.nls_language = 'I'   AND :NEW.nls_territory = 'ITALY') OR
			 (:NEW.nls_language = 'ja'  AND :NEW.nls_territory = 'JAPAN') OR
			 (:NEW.nls_language = 'd'   AND :NEW.nls_territory = 'SWITZERLAND') OR
			 (:NEW.nls_language = 'd'   AND :NEW.nls_territory = 'GERMANY') OR
			 (:NEW.nls_language = 'zhs' AND :NEW.nls_territory = 'CHINA') OR
			 (:NEW.nls_language = 'th'  AND :NEW.nls_territory = 'THAILAND') OR
			 (:NEW.nls_language = 'hi'  AND :NEW.nls_territory = 'INDIA') ) THEN	
		RAISE_APPLICATION_ERROR(-20000, 'Language and Territory do not match');
	END IF;
END;
/