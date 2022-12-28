CREATE OR REPLACE TRIGGER trg_inventories
	BEFORE INSERT OR UPDATE 
	ON inventories
	FOR EACH ROW
DECLARE
	v_wname	warehouses.warehouse_name%TYPE;
BEGIN
	SELECT warehouse_name INTO v_wname
	FROM warehouses
	WHERE warehouse_id = :NEW.warehouse_id;
	--
	IF v_wname IS NULL THEN
		-- This warehouse does not have a name.
		RAISE_APPLICATION_ERROR(-20001,'Warehouse no informado.');
	END IF;
END;