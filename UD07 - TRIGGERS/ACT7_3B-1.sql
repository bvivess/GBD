-- Triggers
CREATE OR REPLACE TRIGGER trg_empleados
	BEFORE INSERT
	ON empleados
	FOR EACH ROW
DECLARE
	dummy	VARCHAR2(1);
BEGIN
	-- Un empleado (EMPLEADOS) no puede ser un subcontratado (SUBCONTRATADOS) ni un cliente (CLIENTES) al mismo tiempo.
	-- Recordar que solo se chequea aquello que está prohibido
	  SELECT '1' INTO dummy FROM subcontratados WHERE sub_per_id = :NEW.emp_per_id
	UNION
	  SELECT '1' FROM clientes WHERE cli_per_id = :NEW.emp_per_id;
	--
	RAISE TOO_MANY_ROWS;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		NULL;
	WHEN TOO_MANY_ROWS THEN
		RAISE_APPLICATION_ERROR( -20001, 'Error no es posible crear este empleado.');
END;

CREATE OR REPLACE TRIGGER trg_subcontratados
	BEFORE INSERT
	ON subcontratados
	FOR EACH ROW
DECLARE
	dummy	VARCHAR2(1);
BEGIN
	-- Un subcontratado (SUBCONTRATADOS) puede no ser un empleado (EMPLEADOS) pero puede ser un cliente (CLIENTES)
	-- Recordar que solo se chequea aquello que está prohibido
	SELECT '1' INTO dummy FROM empleados WHERE emp_per_id = :NEW.sub_per_id;
	--
	RAISE_APPLICATION_ERROR( -20001, 'Error no es posible crear este subcontratado, ya existe como empleado.');
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		NULL;
END;

CREATE OR REPLACE TRIGGER trg_clientes
	BEFORE INSERT
	ON clientes
	FOR EACH ROW
DECLARE
	dummy	VARCHAR2(1);
BEGIN
	-- Un cliente (CLIENTES) no puede ser un empleado (EMPLEADOS) pero puede ser un subcontratado (SUBCONTRATADOS)
	-- Recordar que solo se chequea aquello que está prohibido
	SELECT '1' INTO dummy FROM empleados WHERE emp_per_id = :NEW.cli_per_id;
	--
	RAISE_APPLICATION_ERROR( -20001, 'Error no es posible crear este cliente, ya existe como empleado');
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		NULL;
END;