-- SOTA L'USUARI 'OE_10'

-- VERSIO 1
--

DECLARE
	v_category_id CONSTANT categories_tab.category_id%TYPE := '10';
	--
	CURSOR c_categories( p_id VARCHAR2 ) IS
		SELECT category_name, category_description, category_id, parent_category_id
		FROM OE.categories_tab 
		WHERE category_id = p_id;
	r_category c_categories%ROWTYPE;
	--
	CURSOR c_parent_categories( p_id VARCHAR2 ) IS
		SELECT category_name, category_description, category_id, parent_category_id
		FROM OE.categories_tab 
		WHERE parent_category_id = p_id;
	r_pcategory c_parent_categories%ROWTYPE;
	--
	CURSOR c_product_information( p_id VARCHAR2 ) IS
		SELECT product_id,  product_name,   product_description, 
			   category_id, weight_class,   warranty_period, 
			   supplier_id, product_status, list_price, 
               min_price,   catalog_url
		FROM OE.product_information
		WHERE category_id = p_id;
	r_pinformation c_product_information%ROWTYPE;
	--
	CURSOR c_product_descriptions( p_id VARCHAR2 ) IS
		SELECT product_id, language_id, translated_name, translated_description
		FROM OE.product_descriptions
		WHERE product_id = p_id;
	r_pinformation c_product_descriptions%ROWTYPE;
BEGIN
	-- S'insereix la CATEGORIES_TAB pare de tota la resta (aquelles amb PARENT_CATEGORY_ID IS NULL)
	INSERT INTO categories_tab( category_name, category_description, category_id, parent_category_id )
		SELECT category_name, category_description, category_id, parent_category_id 
		FROM OE.categories_tab
		WHERE parent_category_id IS NULL;
	--
	FOR r_category IN c_categories( v_category_id ) LOOP
		-- S'insereix la CATEGORIES_TAB amb ID = v_category_id
		INSERT INTO categories_tab( category_name, category_description, category_id, parent_category_id )
		VALUES( r_category.category_name, r_category.category_description, r_category.category_id, r_category.parent_category_id );
		-- S'insereixen les CATEGORIES_TAB depenents d'aquesta
		FOR r_pcategory IN c_parent_categories( r_category.CATEGORY_ID ) LOOP
			INSERT INTO categories_tab( category_name, category_description, category_id, parent_category_id )
			VALUES( r_pcategory.category_name, r_pcategory.category_description, r_pcategory.category_id, r_pcategory.parent_category_id );
			-- S'insereixen els PRODUCT_INFORMATION depenents d'aquesta
			FOR r_pinformation IN c_product_information( r_pcategory.CATEGORY_ID ) LOOP
				INSERT INTO product_information( product_id,  product_name,   product_description, 
				                                 category_id, weight_class,   warranty_period, 
												 supplier_id, product_status, list_price, min_price, 
												 catalog_url )
				VALUES( r_pinformation.product_id,  r_pinformation.product_name,   r_pinformation.product_description, 
				        r_pinformation.category_id, r_pinformation.weight_class,   r_pinformation.warranty_period, 
						r_pinformation.supplier_id, r_pinformation.product_status, r_pinformation.list_price, 
                        r_pinformation.min_price, 	r_pinformation.catalog_url );
				-- S'insereixen els PRODUCT_DESCRIPTIONS depenents d'aquests
				FOR r_pdescription IN c_product_descriptions( r_pinformation.product_id ) LOOP
					INSERT INTO product_descriptions( product_id, language_id, 
													  translated_name, translated_description )
					VALUES( r_pdescription.product_id,      r_pdescription.language_id, 
							r_pdescription.translated_name, r_pdescription.translated_description );
				END LOOP; -- r_pdescription
			END LOOP; -- r_pinformation
		END LOOP; -- r_pcategory
		-- 
	END LOOP; -- r_category
	--
	COMMIT;
EXCEPTION	
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE( SQLERRM );
		ROLLBACK;
END;
/