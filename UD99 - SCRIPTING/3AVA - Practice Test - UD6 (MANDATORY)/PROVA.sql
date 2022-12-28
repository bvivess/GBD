-- EXERCICI 1 -----------------------------------------------------------
DECLARE
	a     EXCEPTION;
	b     EXCEPTION;
	i     NUMBER(2) := 0;
	j     NUMBER(2) := 10;
	dummy VARCHAR2(1);
BEGIN
	DBMS_OUTPUT.PUT_LINE('In');
	--
	SELECT '1' INTO dummy FROM employees WHERE UPPER(name) = 'KING';
	--
	WHILE (i < 10) LOOP
		DBMS_OUTPUT.PUT_LINE( i );
		--
		i := i + j;
	END LOOP;
	--
	DBMS_OUTPUT.PUT_LINE('Fi');
EXCEPTION
	WHEN a THEN
		DBMS_OUTPUT.PUT_LINE( 'A' );
	WHEN b THEN
		DBMS_OUTPUT.PUT_LINE( 'B' );
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE( 'Z' );
END;

-- EXERCICI 2 -----------------------------------------------------------
DECLARE
	a     EXCEPTION;
	b     EXCEPTION;
	i     NUMBER(2) := 0;
	j     NUMBER(2) := 10;
	dummy VARCHAR2(1);
BEGIN
	DBMS_OUTPUT.PUT_LINE('In');
	--
	IF (i > 10) THEN
		RAISE b;
	ELSIF (i < 10) THEN
		RAISE a;
	ELSE
		j := i + j;
	END LOOP;
	--
	SELECT '1' INTO dummy FROM employees WHERE LOWER(name) = 'moore';
	--
	DBMS_OUTPUT.PUT_LINE('Fi');
EXCEPTION
	WHEN a THEN
		DBMS_OUTPUT.PUT_LINE( 'A' );
	WHEN b THEN
		DBMS_OUTPUT.PUT_LINE( 'B' );
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE( 'Z' );
END;

-- EXERCICI 3 -----------------------------------------------------------
DECLARE
	a     EXCEPTION;
	b     EXCEPTION;
	i     NUMBER(2) := 0;
	j     NUMBER(2) := 10;
	dummy VARCHAR2(1);
BEGIN
	DBMS_OUTPUT.PUT_LINE('In');
	--
	FOR i IN 1..3 LOOP
		DBMS_OUTPUT.PUT_LINE( i );
        --
		IF (i = 10) THEN
			RAISE NO_DATA_FOUND;
		END IF;
		--
		i := i + j;
	END LOOP;
	--
	SELECT '1' INTO dummy FROM employees WHERE INITCAP(name) = 'Redmon';
	--
	DBMS_OUTPUT.PUT_LINE('Fi');
EXCEPTION
	WHEN a THEN
		DBMS_OUTPUT.PUT_LINE( 'A' );
	WHEN b THEN
		DBMS_OUTPUT.PUT_LINE( 'B' );
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE( 'Z' );
END;

-- EXERCICI 4 -----------------------------------------------------------
DECLARE
	a     EXCEPTION;
	b     EXCEPTION;
	i     NUMBER(2) := 0;
	j     NUMBER(2) := 5;
	dummy VARCHAR2(1);
BEGIN
	DBMS_OUTPUT.PUT_LINE('In');
	--
	SELECT '1' INTO dummy FROM employees WHERE SUBSTR(name,1,5)= 'BARRY';
	--
	WHILE (i < j) LOOP
		IF (i = j) THEN
			RAISE a;
		ELSIF (j < i) THEN
			RAISE b;
		ELSE
			i := i + 1;
			j := j - 1;
		END IF;
	END LOOP;
	--
	DBMS_OUTPUT.PUT_LINE('Fi');
EXCEPTION
	WHEN a THEN
		DBMS_OUTPUT.PUT_LINE( 'A' );
	WHEN b THEN
		DBMS_OUTPUT.PUT_LINE( 'B' );
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE( 'Z' );
END;

-- EXERCICI 5 -----------------------------------------------------------
DECLARE
	a     EXCEPTION;
	b     EXCEPTION;
	i     NUMBER(2) := 0;
	j     NUMBER(2) := 5;
	dummy VARCHAR2(1);
BEGIN
	DBMS_OUTPUT.PUT_LINE('In');
	--
	SELECT '1' INTO dummy FROM employees WHERE INSTR(name,'K')= 1;
	--
	BEGIN
		DBMS_OUTPUT.PUT_LINE( 'A1' );
		--
		RAISE b;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE( 'A2' );
	END;
	--
	BEGIN
		DBMS_OUTPUT.PUT_LINE( 'A3' );
		--
		RAISE a;
	EXCEPTION
		WHEN OTHERS THEN
			DBMS_OUTPUT.PUT_LINE( 'A4' );
	END;
	--
	DBMS_OUTPUT.PUT_LINE('Fi');
EXCEPTION
	WHEN a THEN
		DBMS_OUTPUT.PUT_LINE( 'A' );
	WHEN b THEN
		DBMS_OUTPUT.PUT_LINE( 'B' );
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE( 'Z' );
END;

-- EXERCICI 6 -----------------------------------------------------------
DECLARE
	v_name employees.name%TYPE;
BEGIN
	DBMS_OUTPUT.PUT_LINE('In');
	--
	SELECT name INTO v_name
	FROM employees 
	WHERE salary IN (SELECT MIN(salary) FROM employees);
	--
	DBMS_OUTPUT.PUT_LINE('Fi');
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('A');
	WHEN TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE('B');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Z');
END;

-- EXERCICI 7 -----------------------------------------------------------
DECLARE
	v_salary NUMBER(2);
BEGIN
	DBMS_OUTPUT.PUT_LINE('Inici');
	--
	SELECT e.salary INTO v_salary
	FROM employees e, employees m
	WHERE e.employee_id = '100'
	AND   NVL(e.manager_id,0) = m.employee_id;
	--
	DBMS_OUTPUT.PUT_LINE('Fi');
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('A');
	WHEN TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE('B');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Z');
END;

-- EXERCICI 8 -----------------------------------------------------------
DECLARE
	a        EXCEPTION;
	b        EXCEPTION;
	v_salary employees.salary%TYPE;
BEGIN
	DBMS_OUTPUT.PUT_LINE('In');
	--
	SELECT salary INTO v_salary
	FROM employees e, customers c 
	WHERE e.employee_id = c.employee_id
	AND   c.name LIKE '%MOLER';
	--
	IF v_salary IS NULL THEN
		RAISE a;
	ELSE
		RAISE b;
	END IF;
	--
	INSERT INTO employees( employee_id, name, manager_id, salary )
	VALUES( 200, 'ROSE', NULL, 500 );
	--
	DBMS_OUTPUT.PUT_LINE('Fi');
EXCEPTION
	WHEN a THEN
		DBMS_OUTPUT.PUT_LINE('A');
	WHEN b THEN
		DBMS_OUTPUT.PUT_LINE('B');
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('C');
	WHEN TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE('D');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Z');
END;

-- EXERCICI 9 -----------------------------------------------------------
DECLARE
	v_id employees.employee_id%TYPE;
BEGIN
	DBMS_OUTPUT.PUT_LINE('In');
	--
	SELECT MAX(employee_id) INTO v_id
	FROM employees;
	--
	INSERT INTO employees( employee_id, name, manager_id, salary )
	VALUES( v_id, 'MORRISON', NULL, 700 );
	--
	DBMS_OUTPUT.PUT_LINE('Fi');
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('C');
	WHEN TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE('D');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Z');
END;

-- EXERCICI 10 -----------------------------------------------------------
DECLARE
	v_total NUMBER;
BEGIN
	DBMS_OUTPUT.PUT_LINE('In');
	--
	SELECT SUM(NVL(salary,0)) INTO v_total
	FROM employees 
	WHERE salary < 100;
	--
	IF (v_total IS NULL) THEN
		DBMS_OUTPUT.PUT_LINE('A1');
		--
		RAISE NO_DATA_FOUND;
	END IF;
	--
	DBMS_OUTPUT.PUT_LINE('Fi');
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('A');
	WHEN TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE('B');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Z');
END;

-- EXERCICI 11 -----------------------------------------------------------
DECLARE
	v_total NUMBER;
BEGIN
	DBMS_OUTPUT.PUT_LINE('In');
	--
	SELECT COUNT(NVL(salary,0)) INTO v_total
	FROM employees 
	WHERE salary > 1000;
	--
	IF (v_total IS NULL) THEN
		DBMS_OUTPUT.PUT_LINE('A1');
		--
		RAISE NO_DATA_FOUND;
	END IF;
	--
	DBMS_OUTPUT.PUT_LINE('Fi');
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('A');
	WHEN TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE('B');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Z');
END;

-- EXERCICI 12 -----------------------------------------------------------
DECLARE
	a       EXCEPTION;
	b       EXCEPTION;
	c       EXCEPTION;
	v_total NUMBER;
BEGIN
	DBMS_OUTPUT.PUT_LINE('In');
	--
	SELECT AVG(salary) INTO v_total
	FROM employees e, customers c
	WHERE e.employee_id = c.employee_id
	AND   e.manager_id IS NULL;
	--
	IF (v_total > 1000) THEN
		DBMS_OUTPUT.PUT_LINE('A1');
		-- 
		RAISE c;
	ELSIF (v_total < 1000) THEN
		DBMS_OUTPUT.PUT_LINE('A2');
		-- 
		RAISE b;
	ELSE
		DBMS_OUTPUT.PUT_LINE('A3');
		--
		RAISE a;
	END IF;
	--
	DBMS_OUTPUT.PUT_LINE('Fi');
EXCEPTION
	WHEN NO_DATA_FOUND OR TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE('A');
	WHEN b OR c THEN
		DBMS_OUTPUT.PUT_LINE('B');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Z');
END;

-- EXERCICI 13 -----------------------------------------------------------
DECLARE
	v_customer_id customers.customer_id%TYPE;
	total         NUMBER(8,2);
BEGIN
	DBMS_OUTPUT.PUT_LINE('In');
	--
	SELECT customer_id, COUNT(*) INTO v_customer_id, total
	FROM customers 
	GROUP BY customer_id
	HAVING COUNT(*) = 1;
	--
	DBMS_OUTPUT.PUT_LINE('Fi');
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('A');
	WHEN TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE('B');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Z');
END;

-- EXERCICI 14 -----------------------------------------------------------
DECLARE
	error         EXCEPTION;
	v_employee_id employees.employee_id%TYPE := 300;
BEGIN
	DBMS_OUTPUT.PUT_LINE('In');
	--
	BEGIN
		INSERT INTO customers( customer_id, name, employee_id )
		VALUES( 110, 'SALAS SA', v_employee_id ); 
	EXCEPTION
		WHEN OTHERS THEN
			DBMS_OUTPUT.PUT_LINE('B1');
			RAISE error;
	END;
	--
	DBMS_OUTPUT.PUT_LINE('A1');
	--
	BEGIN
		SELECT e.employee_id INTO v_employee_id
		FROM employees e, customers c
		WHERE e.employee_id = c.employee_id (+)
		AND   c.employee_id IS NULL;
	EXCEPTION
		WHEN OTHERS THEN
			DBMS_OUTPUT.PUT_LINE('B2');
			RAISE error;
	END;
	--
	DBMS_OUTPUT.PUT_LINE('A2');
	--
	BEGIN
		INSERT INTO customers( customer_id, name, employee_id )
		VALUES( 111, 'AITANA SA', v_employee_id ); 
	EXCEPTION
		WHEN OTHERS THEN
			DBMS_OUTPUT.PUT_LINE('B3');
			RAISE error;
	END;
	--
	DBMS_OUTPUT.PUT_LINE('Fi');
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('A');
	WHEN TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE('B');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Z');
END;

-- EXERCICI 15 ----------------------------------------------------------
DECLARE
	CURSOR c_emp( p_salary NUMBER) IS
		SELECT name 
		FROM employees
		WHERE employee_id IN (SELECT DISTINCT NVL(manager_id,0) FROM employees)
		AND   salary > p_salary;
	--
	r_emp  c_emp%ROWTYPE;
	--
	v_name employees.name%TYPE;
BEGIN
	DBMS_OUTPUT.PUT_LINE('In');
	--
	FOR r_emp IN c_emp( 550 ) LOOP
		DBMS_OUTPUT.PUT_LINE( r_emp.name );	
	END LOOP;
	--
	DBMS_OUTPUT.PUT_LINE('Fi');
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('A');
	WHEN TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE('B');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Z');
END;

-- EXERCICI 16 ----------------------------------------------------------
DECLARE
	CURSOR c_emp( p_total NUMBER) IS
		SELECT name 
		FROM employees e
		WHERE ( SELECT COUNT(*)
		        FROM customers c 
		        WHERE e.employee_id = c.employee_id ) = p_total;
	--
	r_emp c_emp%ROWTYPE;
	--
	v_name employees.name%TYPE;
BEGIN
	DBMS_OUTPUT.PUT_LINE('In');
	--
	FOR r_emp IN c_emp( 1000 ) LOOP
		DBMS_OUTPUT.PUT_LINE( r_emp.name );	
	END;
	--
	DBMS_OUTPUT.PUT_LINE('Fi');
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('A');
	WHEN TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE('B');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Z');
END;

-- EXERCICI 17 ----------------------------------------------------------
DECLARE
	CURSOR c_emp( p1, p2 NUMBER ) IS
		SELECT employee_id, name 
		FROM employees
		WHERE salary BETWEEN p1 AND p2;
	--
	r_emp  c_emp%ROWTYPE;
	--
	CURSOR c_cus( p_emp NUMBER ) IS
		SELECT customer_id, name
		FROM customers
		WHERE employee_id = p_emp;
	--
	r_cus c_cus%ROWTYPE;
	--
	v_name employees.name%TYPE;
BEGIN
	DBMS_OUTPUT.PUT_LINE('In');
	--
	FOR r_emp IN c_emp(200, 300) LOOP
		DBMS_OUTPUT.PUT_LINE( c_emp.name );	
		--
		FOR r_cus IN c_cus LOOP
			DBMS_OUTPUT.PUT_LINE( r_cus.name );	
		END LOOP;
	END;
	--
	DBMS_OUTPUT.PUT_LINE('Fi');
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('A');
	WHEN TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE('B');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Z');
END;
