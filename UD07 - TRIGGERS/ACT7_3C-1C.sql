-- Version I
CREATE OR REPLACE TRIGGER trg_order_items
  BEFORE INSERT OR DELETE OR UPDATE
  ON order_items
  FOR EACH ROW
BEGIN
	IF INSERTING THEN
		UPDATE orders
		SET order_total = order_total + (:new.unit_price * :new.quantity)
		WHERE order_id = :new.order_id;
	ELSIF DELETING THEN
		UPDATE orders
		SET order_total = order_total - (:old.unit_price * :old.quantity)
		WHERE order_id = :old.order_id;
	ELSIF UPDATING THEN
		IF UPDATING('order_id') OR UPDATING('product_id') THEN
			RAISE_APPLICATION_ERROR(-20001, 'Error, no es posible modificar las columnas PK');
		ELSE
			UPDATE orders
			SET order_total = order_total - (:old.unit_price * :old.quantity)
										  + (:new.unit_price * :new.quantity)
			WHERE order_id = :old.order_id;
		END IF;
	END IF;
END;

-- Version II
CREATE OR REPLACE TRIGGER trg_order_items
  BEFORE INSERT OR DELETE OR UPDATE
  ON order_items
  FOR EACH ROW
BEGIN
	IF UPDATING('order_id') OR UPDATING('product_id') THEN
		RAISE_APPLICATION_ERROR(-20001, 'Error, no es posible modificar las columnas PK');
	ELSE
		UPDATE orders
		SET order_total = order_total - (NVL(:OLD.unit_price,0) * NVL(:OLD.quantity,0))
									  + (NVL(:NEW.unit_price,0) * NVL(:NEW.quantity,0))
		WHERE order_id = NVL(:NEW.order_id, :OLD.order_id));
	END IF;
END;