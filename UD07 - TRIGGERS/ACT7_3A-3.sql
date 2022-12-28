UPDATE order_items
SET unit_price = NVL(unit_price,0),
    quantity   = NVL(quantity,0);

ALTER TABLE order_items
	MODIFY COLUMN unit_price NUMBER(8,2) NOT NULL;
	
ALTER TABLE order_items
	MODIFY COLUMN quantity NUMBER(8) NOT NULL;

-- Version I
CREATE OR REPLACE TRIGGER trg_order_items
  BEFORE INSERT OR DELETE OR UPDATE
  ON order_items
  FOR EACH ROW
BEGIN
	IF INSERTING THEN
		UPDATE orders
		SET order_total = order_total + (:NEW.unit_price * :NEW.quantity)
		WHERE order_id = :NEW.order_id;
	ELSIF DELETING THEN
		UPDATE orders
		SET order_total = order_total - (:OLD.unit_price * :OLD.quantity)
		WHERE order_id = :OLD.order_id;
	ELSIF UPDATING THEN
		UPDATE orders
		SET order_total = order_total - (:OLD.unit_price * :OLD.quantity)
									  + (:NEW.unit_price * :NEW.quantity)
		WHERE order_id = :OLD.order_id;
	END IF;
END;

-- Version II
CREATE OR REPLACE TRIGGER trg_order_items
  BEFORE INSERT OR DELETE OR UPDATE
  ON order_items
  FOR EACH ROW
BEGIN
	UPDATE orders
	SET order_total = order_total - (NVL(:OLD.unit_price,0) * NVL(:OLD.quantity,0))
								  + (NVL(:NEW.unit_price,0) * NVL(:NEW.quantity,0))
	WHERE order_id = NVL(:NEW.order_id, :OLD.order_id));
END;