CREATE OR REPLACE TRIGGER trg_product_information
	BEFORE INSERT 
	ON product_information
	FOR EACH ROW
BEGIN
	INSERT INTO product_descriptions( product_id, language_id, translated_name, translated_description )
	VALUES( NULL, 'ES', :NEW.product_name, :NEW.product_description );
END;
/

CREATE OR REPLACE TRIGGER trg_product_information
	AFTER INSERT OR UPDATE OF product_name, product_description
	ON product_information
	FOR EACH ROW
BEGIN
	INSERT INTO product_descriptions( PRODUCT_ID, LANGUAGE_ID, TRANSLATED_NAME, TRANSLATED_DESCRIPTION )
	VALUES( :NEW.product_id, 'ES', :NEW.product_name, :NEW.product_description );
	--
	UPDATE product_descriptions
	SET TRANSLATED_NAME = :NEW.product_name,
	    TRANSLATED_DESCRIPTION = :NEW.product_name
	WHERE product_id = :NEW.product_id
	AND   language_id = 'ES';
END;
/
