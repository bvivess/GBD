-- Compound trigger
CREATE OR REPLACE TRIGGER trg_oitems2
	AFTER INSERT OR DELETE OR UPDATE 
	ON order_items
	EACH ROW IS
BEGIN
	UPDATE orders
	SET order_total = order_total - (NVL(:OLD.unit_price,0) * NVL(:OLD.quantity,0))
								  + (NVL(:NEW.unit_price,0) * NVL(:NEW.quantity,0))
	WHERE order_id = NVL(:NEW.order_id, :OLD.order_id);	
END;
