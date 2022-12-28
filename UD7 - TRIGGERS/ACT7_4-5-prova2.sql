DECLARE
    TYPE r_employees is RECORD (
        employee_id employees.employee_id%TYPE,
		last_name	employees.last_name%TYPE,
        salary      employees.salary%TYPE
    );

   TYPE t_employees IS TABLE OF r_employees INDEX BY PLS_INTEGER;
   v_employees	t_employees;

   --
   TYPE empCurTyp IS REF CURSOR;
   emp_cv		empCurTyp;
BEGIN
	OPEN emp_cv FOR
		SELECT employee_id, last_name, salary
		FROM employees 
		WHERE job_id = 'SA_REP';
	FETCH emp_cv BULK COLLECT INTO v_employees;
	CLOSE emp_cv;
    --
	FOR i IN v_employees.FIRST..v_employees.LAST LOOP
		DBMS_OUTPUT.PUT_LINE(i || ' ' || v_employees(i).employee_id || ' ' || v_employees(i).last_name || ' ' || v_employees(i).salary);
	END LOOP;
END;