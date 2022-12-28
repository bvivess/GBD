-- Triggers
CREATE OR REPLACE TRIGGER trg_cuentas_bancarias
	BEFORE INSERT 
	ON cuentas_bancarias
	FOR EACH ROW
DECLARE
	dummy	VARCHAR2(20);
BEGIN
	IF (:NEW.cta_per_id IS NULL AND :NEW.cta_emp_id IS NULL) OR 
	   (:NEW.cta_per_id IS NOT NULL AND :NEW.cta_emp_id IS NOT NULL) THEN
		RAISE_APPLICATION_ERROR(-20001, 'Debe informar un titular de la cuenta bancaria.');
	ELSIF :NEW.cta_per_id IS NOT NULL THEN
		BEGIN
			SELECT '1' INTO dummy
			FROM empleados
			WHERE emp_per_id = :NEW.cta_per_id;
			--
			RAISE_APPLICATION_ERROR(-20002, 'La persona titular de la cuenta bancaria es a la vez cliente del banco.');
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				NULL;
		END;
	END IF;
END;