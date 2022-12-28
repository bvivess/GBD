-- VERSIÓ 1
DECLARE
	-- Tots els WAREHOUSE d'una localitat
    CURSOR c_warehouses( p_location_id NUMBER ) IS
		SELECT warehouse_id
		FROM warehouses
		WHERE location_id = p_location_id;
    --
    r_warehouse c_warehouses%ROWTYPE;
	-- Tots els PRODUCT_INFORMATION d'un WAREHOUSE
	CURSOR c_products( p_warehouse_id NUMBER ) IS
		SELECT product_id
		FROM inventories i
		WHERE i.warehouse_id = p_warehouse_id;
	--
	r_product c_products%ROWTYPE;		
BEGIN
	FOR r_warehouse IN c_warehouses( 'X' ) LOOP
		DBMS_OUTPUT.PUT_LINE( 'Warehouse ID= ' || r_warehouse.warehouse_id );
		--
		FOR r_product IN c_products ( r_warehouse.warehouse_id ) LOOP
			-- Atenció: aquesta modificació afecta a tots els productes que existeixin a un magatgem 
			--          però no es té en compte si aquella ORDER és o no és d'aquell magatzem o d'un altre
			--          ja que no tenim aquesta informació ...
			UPDATE order_items
			SET unit_price = unit_price * 1.10
			WHERE product_id = r_product.product_id;
		END LOOP;		
	END;
    -- COMMIT;
EXCEPTION
    WHEN OTHERS THEN 
		DBMS_OUTPUT.PUT_LINE( SQLERRM );
		--
        ROLLBACK;
END;

-- VERSIÓ 2
DECLARE
	v_location_id locations.location_id%TYPE := 2100;
BEGIN
	UPDATE order_items
	SET unit_price = unit_price = 1.10
	WHERE product_id IN  (SELECT product_id 
	                      FROM inventories i, warehouses w
						  WHERE i.warehouse_id = w.warehouse_id
						  AND   w.location_id  = v_location_id );
END;