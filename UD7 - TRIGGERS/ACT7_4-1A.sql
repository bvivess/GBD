-- Compound trigger
CREATE OR REPLACE TRIGGER trg_oitems1
	BEFORE INSERT 
	ON order_items
	FOR EACH ROW

BEGIN
	SELECT NVL(MAX(line_item_id),0) + 1 INTO :NEW.line_item_id
	FROM order_items
	WHERE order_id = :NEW.order_id;
END;

