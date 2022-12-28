-- View
CREATE OR REPLACE VIEW VW_products(
	product_id,		product_name,		product_description,
	category_id,	weight_class,		warranty_period,
	supplier_id,	product_status,		list_price,
	min_price,		catalog_url,
	language_id,	translated_name,	translated_description
) AS
	SELECT 
		i.product_id,	i.product_name,		i.product_description,
		i.category_id,	i.weight_class,		i.warranty_period,
		i.supplier_id,	i.product_status,	i.list_price,
		i.min_price,	i.catalog_url,
		d.language_id,	d.translated_name,	d.translated_description
	FROM product_information i,  product_descriptions d
	WHERE d.product_id  = i.product_id
	AND   d.language_id = 'E';


-- Trigger
CREATE OR REPLACE TRIGGER trg_VW_products
   INSTEAD OF INSERT OR UPDATE OR DELETE
   ON VW_products
DECLARE
	dummy VARCHAR2(1);
BEGIN
	IF DELETING OR UPDATING THEN
		RAISE_APPLICATION_ERROR(-20001, 'Delete/update this view IS UNABLE');
	ELSIF INSERTING THEN
		BEGIN
			SELECT '1' INTO dummy
			FROM product_information
			WHERE product_id = :NEW.product_id;
			--
			-- RAISE DUP_VAL_ON_INDEX;
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				INSERT INTO product_information ( product_id,  product_name,   product_description,
				                                  category_id, weight_class,   warranty_period,
												  supplier_id, product_status, list_price,
												  min_price,   catalog_url )
				VALUES( :NEW.product_id,  :NEW.product_name,   :NEW.product_description,
				        :NEW.category_id, :NEW.weight_class,   :NEW.warranty_period,
						:NEW.supplier_id, :NEW.product_status, :NEW.list_price,
						:NEW.min_price,   :NEW.catalog_url );
		END;
		--
		BEGIN
			SELECT '1' INTO dummy
			FROM product_descriptions
			WHERE product_id  = :NEW.product_id
			AND   language_id = :NEW.language_id;
			--
			RAISE DUP_VAL_ON_INDEX;
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				INSERT INTO product_descriptions ( product_id,		language_id,
				                                   translated_name,	translated_description )
				VALUES( :NEW.product_id,		:NEW.language_id,
					    :NEW.translated_name,	:NEW.translated_description );
		END;
	END IF;
END;



