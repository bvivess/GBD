CREATE OR REPLACE TRIGGER trg_order_items
  BEFORE INSERT OR DELETE OR UPDATE
  ON order_items
  FOR EACH ROW
DECLARE
	v_order_status orders.order_status%TYPE;
BEGIN
	-- Querying if its 'ORDERS.order_status' > 3
	SELECT order_status INTO m_order_status
	FROM orders
	WHERE order_id = :NEW.order_id;
	--
	IF (m_order_status <= 3) THEN
		UPDATE orders
		SET order_total = order_total - (NVL(:OLD.unit_price,0) * NVL(:OLD.quantity,0))
									  + (NVL(:NEW.unit_price,0) * NVL(:NEW.quantity,0))
		WHERE order_id = NVL(:NEW.order_id, :OLD.order_id));
	ELSE
		RAISE_APPLICATION_ERROR(-20000, 'Statement is forbidden due to order-->order_status = ' || m_order_status);
	END IF;
END;