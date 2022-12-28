SET SERVEROUTPUT ON


DECLARE
  v_employee_id employees.employee_id%TYPE;
BEGIN
  SELECT employee_id INTO v_employee_id
  FROM employees;
  --
  DBMS_OUTPUT.PUT_LINE('SORTIR');
END;

DECLARE
  v_employee_id employees.employee_id%TYPE;
BEGIN
  SELECT employee_id INTO v_employee_id
  FROM employees;
  --
  DBMS_OUTPUT.PUT_LINE('SORTIR');
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('N-D-F');
  WHEN TOO_MANY_ROWS THEN
    DBMS_OUTPUT.PUT_LINE('T-M-R');
END;

DECLARE
  v_employee_id employees.employee_id%TYPE;
BEGIN
  SELECT employee_id INTO v_employee_id
  FROM employees
  WHERE employee_id = -1;
  --
  DBMS_OUTPUT.PUT_LINE('SORTIR');
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('N-D-F');
  WHEN TOO_MANY_ROWS THEN
    DBMS_OUTPUT.PUT_LINE('T-M-R');
END;

DECLARE
  v_employee_id NUMBER(1);
BEGIN
  SELECT employee_id INTO v_employee_id
  FROM employees
  WHERE employee_id = 100;
  --
  DBMS_OUTPUT.PUT_LINE('SORTIR');
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('N-D-F');
  WHEN TOO_MANY_ROWS THEN
    DBMS_OUTPUT.PUT_LINE('T-M-R');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('O');
END;

DECLARE
  v_descripcio VARCHAR2(250) := '123456789012345678901234567890';
BEGIN
  INSERT INTO regions(region_id, region_name)
  VALUES(99, v_descripcio);
  --
  DBMS_OUTPUT.PUT_LINE('SORTIR');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    DBMS_OUTPUT.PUT_LINE('D-V-O-I');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE( SQLCODE );
    DBMS_OUTPUT.PUT_LINE( SQLERRM );
END;


DECLARE
    CURSOR c1 IS
        SELECT employee_id, first_name, last_name
        FROM employees;
    CURSOR c2(PARAM NUMBER) IS
        SELECT *
        FROM job_history
        WHERE employee_id = (PARAM);

  r1 c1%ROWTYPE;
  r2 c2%ROWTYPE;
BEGIN
  FOR r1 IN c1 LOOP
    DBMS_OUTPUT.PUT_LINE( r1.first_name || ' ' || r1.last_name );
    FOR r2 IN c2(r1.employee_id LOOP
        SELECT * INTO v_job_description
        FROM jobs
        WHERE job_id = r2.job_id;
        --
        DBMS_OUTPUT.PUT_LINE( r2.job_id );
    END LOOP;
  END LOOP;
END;