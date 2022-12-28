SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello world !!!');
END;

DECLARE
    v_employee_id employees.employee_id%TYPE;
BEGIN
    SELECT employee_id INTO v_employee_id
    FROM employees;
EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Error buscando empleados, demasiados empleados seleccionados');
END;

DECLARE
    i NUMBER;
BEGIN
    FOR i IN 1 .. 10 LOOP 
     dbms_output.put_line( i );
    END LOOP;
END;

DECLARE
    i NUMBER;
BEGIN
    FOR i IN 1 .. 10 LOOP 
        IF (MOD(i,2) = 1) THEN
             dbms_output.put_line( i );
        END IF;
    END LOOP;
END;

DECLARE
    CURSOR c_employees IS 
        SELECT employee_id, last_name
        FROM employees;
    r_employees c_employees%ROWTYPE;
BEGIN
    FOR r_employees IN c_employees LOOP
        dbms_output.put_line( r_employees.employee_id || ' ' || r_employees.last_name );
    END LOOP;
END;
