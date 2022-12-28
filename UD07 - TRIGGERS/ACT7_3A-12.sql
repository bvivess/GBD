CREATE OR REPLACE TRIGGER trg_orders
	AFTER UPDATE OF order_total
	ON orders
	FOR EACH ROW
DECLARE
	v_credit_limit 		customers.credit_limit%TYPE;
	v_sum_order_total	NUMBER(12,2);
BEGIN
	SELECT credit_limit INTO v_credit_limit
	FROM customers
	WHERE customer_id = :NEW.customer_id;
	--
	SELECT SUM(order_total) INTO v_sum_order_total
	FROM orders
	WHERE customer_id = :NEW.customer_id
	AND   order_status BETWEEN 0 AND 3;
	--
	IF (v_sum_order_total > v_credit_limit) THEN
		RAISE_APPLICATION_ERROR( -20000,'Esta orden supera el LÍMITE DE CRÉDITO para este cliente ' || TO_CHAR(v_credit_limit) );
	END IF;
END;
/

ATENCION !!!
Informe de error -
ORA-04091: la tabla OE.ORDERS está mutando, puede que el disparador/la función no puedan verla
ORA-06512: en "OE.TRG_ORDERS", línea 9
ORA-04088: error durante la ejecución del disparador 'OE.TRG_ORDERS'

	PRAGMA AUTONOMOUS_TRANSACTION;