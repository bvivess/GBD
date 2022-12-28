-- VERSIÓ 1
DECLARE
    CURSOR c_customers( p_inicial NUMBER, p_final NUMBER ) IS
        SELECT customer_id
        FROM customers
        WHERE customer_id BETWEEN p_inicial AND p_final;
    --
    r_customer c_customers%ROWTYPE;
BEGIN
    FOR r_customers IN c_customers( 101, 104 ) LOOP
		DBMS_OUTPUT.PUT_LINE('Es va a eliminar el CUSTOMER amb ID=' || r_customers.customer_id );
        -- Elimina N registres (tants com ORDERS x ORDER_ITEMS tengui el CUSTOMER)
        DELETE FROM order_items i
        WHERE i.order_id IN ( SELECT o.order_id
                              FROM orders o
                              WHERE o.customer_id = r_customers.customer_id );
        -- Elimina N registres (tants com ORDERS tengui el CUSTOMER)
        DELETE FROM orders
        WHERE customer_id = r_customers.customer_id;
        -- Elimina 1 registre
        DELETE FROM customers
        WHERE customer_id = r_customers.customer_id;
		--
		DBMS_OUTPUT.PUT_LINE('CUSTOMER amb ID=' || r_customers.customer_id || ' eliminat correctament ');
    END LOOP;
    --
    -- COMMIT;
	DBMS_OUTPUT.PUT_LINE('S''han eliminat els registres sol·licitats');
EXCEPTION
    WHEN OTHERS THEN 
		DBMS_OUTPUT.PUT_LINE( SQLERRM );
		--
        ROLLBACK;
END;

-- VERSIÓ 2
DECLARE
    CURSOR c_customers( p_inicial NUMBER, p_final NUMBER ) IS
        SELECT customer_id
        FROM customers
        WHERE customer_id BETWEEN p_inicial AND p_final;
    r_customer c_customers%ROWTYPE;
	--
	CURSOR c_orders( p_customer_id NUMBER ) IS
		SELECT order_id
		FROM orders
		WHERE customer_id = p_customer_id;
	r_orders c_orders%ROWTYPE;
BEGIN
    FOR r_customers IN c_customers( 101, 101 ) LOOP
		DBMS_OUTPUT.PUT_LINE('Es va a eliminar el CUSTOMER amb ID=' || r_customers.customer_id );
		-- Elimina totes les ORDERS
		FOR r_orders IN c_orders( r_customers.customer_id ) LOOP
			-- Elimina N registres (tants com ORDER_ITEMS tengui aquesta ORDER) 
			DELETE FROM order_items
			WHERE order_id = r_orders.order_id;
			-- Elimina 1 registre
			DELETE FROM orders
			WHERE order_id = r_orders.order_id;
		END LOOP;
        -- Elimina 1 registre
        DELETE FROM customers
        WHERE customer_id = r_customers.customer_id;
		--
		DBMS_OUTPUT.PUT_LINE('CUSTOMER amb ID=' || r_customers.customer_id || ' eliminat correctament ');
    END LOOP;
    --
    -- COMMIT;
	DBMS_OUTPUT.PUT_LINE('S''han eliminat els registres sol·licitats');
EXCEPTION
    WHEN OTHERS THEN 
		DBMS_OUTPUT.PUT_LINE( SQLERRM );
		--
        ROLLBACK;
END;

-- VERSIÓ 3
DECLARE
	v_customer_id_D customers.customer_id%TYPE := 101;
	v_customer_id_H customers.customer_id%TYPE := 104;
BEGIN
	DELETE FROM order_items WHERE order_id IN ( SELECT order_id 
	                                            FROM orders 
												WHERE customer_id BETWEEN v_customer_id_D AND v_customer_id_H );
	--
	DELETE FROM orders WHERE customer_id BETWEEN v_customer_id_D AND v_customer_id_H; 
	--
	DELETE FROM customers WHERE customer_id BETWEEN v_customer_id_D  AND v_customer_id_H;
    --
    -- COMMIT;
	DBMS_OUTPUT.PUT_LINE('S''han eliminat els registres sol·licitats');
EXCEPTION
    WHEN OTHERS THEN 
		DBMS_OUTPUT.PUT_LINE( SQLERRM );
		--
        ROLLBACK;
END;
