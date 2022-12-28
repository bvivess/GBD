CREATE OR REPLACE TRIGGER trg_customers
	BEFORE UPDATE OF customer_id
	ON customers
	FOR EACH ROW
BEGIN
	RAISE_APPLICATION_ERROR(-20001, 'Error, no es posible modificar la columna PK');
END;
