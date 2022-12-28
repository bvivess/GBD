-- Compound trigger
CREATE OR REPLACE TRIGGER trg_order_items
	FOR INSERT OR DELETE OR UPDATE 
	ON order_items
	COMPOUND TRIGGER

	BEFORE EACH ROW IS
	BEGIN	
		IF INSERTING THEN
			SELECT NVL(MAX(line_item_id),0) + 1 INTO :NEW.line_item_id
			FROM order_items
			WHERE order_id = :NEW.order_id;
		END IF;
	END BEFORE EACH ROW;

	AFTER EACH ROW IS
	BEGIN
		UPDATE orders
		SET order_total = order_total - (NVL(:OLD.unit_price,0) * NVL(:OLD.quantity,0))
									  + (NVL(:NEW.unit_price,0) * NVL(:NEW.quantity,0))
		WHERE order_id = NVL(:NEW.order_id, :OLD.order_id);
	END AFTER EACH ROW;
	
END trg_order_items;
