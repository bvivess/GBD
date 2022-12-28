ALTER TABLE promotions
	ADD DISCOUNT_PERCENTAGE	NUMBER(5,2) DEFAULT 0 NOT NULL;

CREATE TABLE invoices(
	INV_ID		VARCHAR2(10) NOT NULL,
	INV_DATE	DATE NOT NULL,
	INV_POSTINGDATE	DATE,
	INV_TOTAL		NUMBER(8,2) NOT NULL,
	INV_COMMISSION	NUMBER(8,2) NOT NULL,
	INV_DISCOUNT	NUMBER(8,2) NOT NULL,
	INV_STATUS		VARCHAR2(1) DEFAULT 'P' NOT NULL,
	INV_CUSTOMER_ID	NUMBER(12)
);

ALTER TABLE invoices ADD CONSTRAINT inv_pk
	PRIMARY KEY (inv_id);
	
ALTER TABLE invoices 
    ADD CONSTRAINT inv_cus_fk FOREIGN KEY (inv_customer_id) REFERENCES customers(customer_id);

ALTER TABLE orders
	ADD INV_ID VARCHAR2(10);

ALTER TABLE orders 
    ADD CONSTRAINT ord_inv_fk FOREIGN KEY (inv_id) REFERENCES invoices(inv_id);

INSERT INTO ORDER_STATUS( ost_id, ost_description )
VALUES( 11, 'Invoiced');

COMMIT;
	
DECLARE
	CURSOR facturar IS
		SELECT customer_id, SUM(order_total) total
        FROM orders 
        WHERE order_status = 10
        GROUP BY customer_id;
	--
	r 					facturar%ROWTYPE;
    m_inv_id 			invoices.inv_id%TYPE;
	m_inv_commission	invoices.inv_commission%TYPE;
	m_inv_discount		invoices.inv_discount%TYPE;
	m_total_oi			NUMBER(8,2);
	error_oi			EXCEPTION;
	msg					VARCHAR2(100);
BEGIN
	--
    FOR r IN facturar LOOP
		-- Calculate the Invoice_ID for the INVOICE. In case there is no INVOICES, INVOICE_ID = 1
        BEGIN
            SELECT COUNT(*) + 1 INTO m_inv_id
            FROM invoices;
        END;
        -- Calculate the Commission_amount
        BEGIN
            SELECT (commission_pct  * r.total) INTO m_inv_commission
			FROM employees, customers
			WHERE employee_id = account_mgr_id
			AND   customer_id = r.customer_id;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                msg := 'ERROR';
                RAISE NO_DATA_FOUND;
        END;
        -- Calculate the Discount_amount
        BEGIN
            SELECT NVL(SUM(discount_percentage * order_total), 0) INTO m_inv_discount
			FROM orders o, promotions p
			WHERE o.order_status = '10'
			AND   o.customer_id  = r.customer_id
			AND   p.promo_id     = o.promotion_id;
			--
			IF m_inv_discount = 0 THEN
				DBMS_OUTPUT.PUT_LINE( 'Atención, factura ' || m_inv_id || ' sin descuento para cliente ' || r.customer_id );
			END IF;
        END;
        -- Check if ORDERS--> ORDER_TOTAL is equal to SUM(ORDER_ITEMS--> unit_price * ORDER_ITEMS--> quantity)
        BEGIN
            SELECT NVL(SUM( unit_price * quantity ),0) INTO m_total_oi
			FROM order_items oi, orders o
			WHERE o.order_status = '10'
			AND   o.customer_id  = r.customer_id
			AND   oi.order_id    = o.order_id;
			--
			IF m_total_oi != r.total THEN
				DBMS_OUTPUT.PUT_LINE( 'Error en cálculo OI para cliente ' || r.customer_id );
				RAISE error_oi;
			END IF;

        END;
        --
		BEGIN
			-- INSERT the invoice
			INSERT INTO invoices( inv_id, inv_date, inv_postingdate, 
                                  inv_total, inv_commission, inv_discount )
            VALUES( m_inv_id, TRUNC(SYSDATE), NULL,
             r.total, m_inv_commission, m_inv_discount );
            -- Update the ORDERS related to the INVOICE to ORDER--> order_status = '11'
            UPDATE orders
			SET inv_id = m_inv_id,
			    order_status = 11
			WHERE order_status = '10'
			AND   customer_id  = r.customer_id;
		END;
    END LOOP;
	--
	COMMIT;
EXCEPTION
    WHEN error_oi THEN
        DBMS_OUTPUT.PUT_LINE( msg );
		ROLLBACK;
END;











