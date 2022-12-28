DECLARE
    CURSOR c_promotions( p_promotion_id NUMBER ) IS
        SELECT promotion_id
        FROM promotions
        WHERE promotion_id = p_promotion_id;
    --
    r_promotion c_promotions%ROWTYPE;
BEGIN
	FOR r_promotion IN c_promotions( 100 ) LOOP
		UPDATE order_items
		SET unit_price = unit_price *  0.9
		WHERE order_id = r_orders.order_id;
	END;
    -- COMMIT;
EXCEPTION
    WHEN OTHERS THEN 
		DBMS_OUTPUT.PUT_LINE( SQLERRM );
		--
        ROLLBACK;
END;