SET SERVEROUTPUT ON

DECLARE
	CURSOR c IS
		SELECT first_name, last_name
		FROM employees
		ORDER BY employee_id;
	r c%ROWTYPE;
BEGIN
    FOR r IN c LOOP
		DBMS_OUTPUT.PUT_LINE( r.last_name || ' ' || r.first_name );
	END LOOP;
END;
