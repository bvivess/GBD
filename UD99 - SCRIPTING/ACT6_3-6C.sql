-- SOTA L'USUARI 'OE_20'

-- VERSIO 2
--

DECLARE
	v_category_id CONSTANT categories_tab.category_id%TYPE := '20';
BEGIN
	-- S'insereix la CATEGORIES_TAB pare de tota la resta (aquelles amb PARENT_CATEGORY_ID IS NULL)
	INSERT INTO categories_tab( category_name, category_description, category_id, parent_category_id )
		SELECT category_name, category_description, category_id, parent_category_id 
		FROM OE.categories_tab
		WHERE parent_category_id IS NULL;
	-- S'insereix la CATEGORIES_TAB amb ID = v_category_id = 20
	INSERT INTO categories_tab( category_name, category_description, category_id, parent_category_id )
		SELECT category_name, category_description, category_id, parent_category_id 
		FROM OE.categories_tab
		WHERE category_id = v_category_id;
	-- S'insereix la CATEGORIES_TAB filles de la categoria amb ID = v_category_id = 20
	INSERT INTO categories_tab( category_name, category_description, category_id, parent_category_id )
		SELECT category_name, category_description, category_id, parent_category_id 
		FROM OE.categories_tab
		WHERE parent_category_id = v_category_id;
	-- S'insereixen els PRODUCT_INFORMATION depenents les categories carregades anterioment
	INSERT INTO product_information( product_id,  product_name,   product_description, 
				                     category_id, weight_class,   warranty_period, 
									 supplier_id, product_status, list_price, min_price, 
									 catalog_url )
		SELECT product_id,  product_name,   product_description, 
			   category_id, weight_class,   warranty_period, 
			   supplier_id, product_status, list_price, min_price, 
			   catalog_url
		FROM OE.product_information -- NOTAR EL PREFIXE 'OE.'
		WHERE category_id IN ( SELECT category_id
							   FROM categories_tab ); -- NOTA QUE EN AQUEST CAS NO HI HA 'OE.'
	-- S'insereixen els PRODUCT_DESCRIPTIONS carregats anteriorment
	INSERT INTO product_descriptions( product_id, language_id, translated_name, translated_description )
		SELECT product_id, language_id, translated_name, translated_description
		FROM OE.product_descriptions  -- NOTAR EL PREFIXE 'OE.'
		WHERE product_id IN ( SELECT product_id 
							  FROM product_information ); -- NOTA QUE EN AQUEST CAS NO HI HA 'OE.'
	--
	COMMIT;
EXCEPTION	
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE( SQLERRM );
		ROLLBACK;
END;
/