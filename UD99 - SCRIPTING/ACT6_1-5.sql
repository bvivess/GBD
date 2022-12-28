SET SERVEROUTPUT ON

DECLARE
	CURSOR c (p_department VARCHAR2) IS
		SELECT first_name, last_name
		FROM employees
		WHERE department_id = p_department
		ORDER BY employee_id;
	--
	r c%ROWTYPE;
	
BEGIN
    FOR r IN c (80) LOOP
		DBMS_OUTPUT.PUT_LINE( r.last_name || ' ' || r.first_name );
	END LOOP;
END;
