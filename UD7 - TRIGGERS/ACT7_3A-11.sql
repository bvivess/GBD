CREATE OR REPLACE TRIGGER trg_order_item
CREATE OR REPLACE TRIGGER trg_order_item
	BEFORE INSERT OR UPDATE OF unit_price
	ON order_items
	FOR EACH ROW
DECLARE
	v_min_price product_information.min_price%TYPE;
BEGIN
	SELECT min_price INTO v_min_price
	FROM product_information
	WHERE product_id = :NEW.product_id;
	--
	IF (:NEW.unit_price > v_min_price) THEN
		RAISE_APPLICATION_ERROR( -20000,'El importe unitario del productos supera el valor mínimo permitido ' || TO_CHAR(v_min_price) )
	END IF;
END;
/