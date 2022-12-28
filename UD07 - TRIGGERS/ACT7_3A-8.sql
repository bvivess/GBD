CREATE OR REPLACE TRIGGER trg_departments
	BEFORE INSERT OR UPDATE
	ON departments
	FOR EACH ROW
DECLARE
	dummy VARCHAR2(1);
BEGIN
	-- Alguien tiene como jefe al jefe del departamento que se está insertando (o modificando) ?
	SELECT '1' INTO dummy
	FROM employees 
	WHERE manager_id = :NEW.manager_id
	AND   ROWNUM    <= 1;
	--
	NULL;  --> Si hay 1 empleado (o puede que más de 1)
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		-- Si nadie tiene como jefe al jefe del departament que se está insertando --> ERROR !!
		RAISE_APPLICATION_ERROR(-20001, 'El empleado al frente de este departamento no tiene empleados a su cargo');
END;



