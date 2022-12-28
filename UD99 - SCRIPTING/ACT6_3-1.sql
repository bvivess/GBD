-- VERSIÓ 1
DECLARE
    CURSOR c_employees( p_employee_id_D NUMBER, p_employee_id_H NUMBER ) IS
        SELECT employee_id
           FROM employees
		WHERE employee_id BETWEEN p_employee_id_D AND p_employee_id_H;
    --
    r_employees c_employees%ROWTYPE;
BEGIN
    FOR r_employees IN c_employees( 100, 300 ) LOOP
		DELETE FROM customers 
		WHERE employee_id = r_employees.employee_id;
		--
		DELETE from employees
		WHERE employee_id = r_employees.employee_id;
    END LOOP;
    --
    COMMIT;
EXCEPTION 
    WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE( SQLERRM );
		--
        ROLLBACK;
END;

-- VERSIO 2
DECLARE
	v_employee_id_D employees.employee_id%TYPE;
	v_employee_id_H employees.employee_id%TYPE;
BEGIN
	DELETE FROM customers
	WHERE employee_id BETWEEN v_employee_id_D AND v_employee_id_H;
	--
	DELETE FROM employees
	WHERE employee_id BETWEEN v_employee_id_D AND v_employee_id_H;
	--
    COMMIT;
EXCEPTION 
    WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE( SQLERRM );
		--
        ROLLBACK;
END;