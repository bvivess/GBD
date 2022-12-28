DECLARE
	CURSOR facturar IS
		SELECT customer_id, SUM(order_total) total
        FROM orders 
        WHERE order_status = '10'
        GROUP BY customer_id;
	--
	r facturar%ROWTYPE;
    m_inv_id invoices.inv_id%TYPE;
    msg VARCHAR2(100);
BEGIN
    FOR r IN facturar LOOP
        BEGIN
            SELECT COUNT(*) INTO m_inv_id
            FROM invoices;
        END;
        --
        BEGIN
            SELECT ...
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                msg := 'ERROR';
                RAISE NO_DATA_FOUND;
        END;
        --
        BEGIN
            SELECT ...
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                msg := 'ERROR';
                RAISE NO_DATA_FOUND;
        END;
        --
        BEGIN
            SELECT ...
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                msg := 'ERROR';
                RAISE NO_DATA_FOUND;
        END;
        --
		BEGIN
			INSERT INTO invoices( inv_id, inv_date, inv_postingdate, 
                                  inv_total, inv_commission, inv_discount )
            VALUES( m_inv_id + 1, TRUNC(SYSDATE), NULL,
             r.total, xxxx, yyyy );
            --
            UPDATE ...
		END;
    END LOOP;
	--
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE( msg );
END;











