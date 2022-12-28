DECLARE
    TYPE r_employees is RECORD (
        employee_id employees.employee_id%TYPE,
        salary      employees.salary%TYPE
    );

   TYPE l_employees IS TABLE OF r_employees INDEX BY PLS_INTEGER;
   v_employees	l_employees;
   i            NUMBER := 0;
BEGIN
	v_employees(i).employee_id := 1;
	v_employees(i).salary := 10;
    --
	DBMS_OUTPUT.PUT_LINE(v_employees(i).employee_id);
    DBMS_OUTPUT.PUT_LINE(v_employees(i).salary);
END;