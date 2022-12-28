CREATE OR REPLACE TRIGGER trg_inventories
	BEFORE INSERT OR UPDATE OF product_id, warehouse_id
	ON inventories
	FOR EACH ROW
DECLARE
	v_wname	warehouses.warehouse_name%TYPE;
BEGIN
	IF INSERTING THEN
		SELECT warehouse_name INTO v_wname
		FROM warehouses
		WHERE warehouse_id = :NEW.warehouse_id;
		--
		IF v_wname IS NULL THEN
			-- This warehouse does not have a name.
			RAISE_APPLICATION_ERROR(-20002, 'Warehouse no informado.');
		END IF;
	ELSIF UPDATING THEN
		-- Any update that fires this trigger: UPDATE OF product_id OR UPDATE OF warehouse_id
		RAISE_APPLICATION_ERROR(-20001, 'Error, no es posible modificar las columnas PK');
	END IF;
END;
