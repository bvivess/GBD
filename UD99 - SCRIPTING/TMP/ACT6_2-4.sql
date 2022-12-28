SET SERVEROUTPUT ON	

CREATE OR REPLACE PROCEDURE Procediment1 IS
	a	EXCEPTION;
	b	VARCHAR2(1);
BEGIN
	RAISE a;
	-- RAISE b; /*no es possible pq existeix una variable anomenada b */
EXCEPTION
	WHEN a THEN
		dbms_output.put_line('Z');
END;

CREATE OR REPLACE PROCEDURE Procediment2 IS
	a	VARCHAR2(1);
BEGIN
	RAISE TOO_MANY_ROWS;
	-- RAISE a; /*no es possible pq existeix una variable anomenada a */
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		dbms_output.put_line('X');
END;

-- connectat a Gestio
GRANT EXECUTE ON Procediment1 TO ROL_gestio;
GRANT EXECUTE ON Procediment2 TO ROL_gestio;
-- connectat a system
CREATE PUBLIC SYNONYM Procediment1 FOR gestio.Procediment1;
CREATE PUBLIC SYNONYM Procediment2 FOR gestio.Procediment2;

-- EXEMPLE 1
DECLARE
    i NUMBER := 1;
    j NUMBER;
BEGIN
    dbms_output.put_line(TO_CHAR( i + j ));
END;

-- EXEMPLE 2
DECLARE
	a 	EXCEPTION;
	b 	EXCEPTION;
	c	EXCEPTION;
BEGIN
	DECLARE
		a 		EXCEPTION;
		b 		EXCEPTION;
	BEGIN
		RAISE a;
	EXCEPTION
		WHEN a THEN
			BEGIN
				dbms_output.put_line('a');
				RAISE a;
			EXCEPTION
				WHEN OTHERS THEN 
					dbms_output.put_line('b');
					RAISE c;
					-- RAISE b;
			END;
		WHEN b THEN
			dbms_output.put_line('c');
		WHEN NO_DATA_FOUND THEN
			dbms_output.put_line('d');
		WHEN OTHERS THEN 
			dbms_output.put_line('e');
	END;
EXCEPTION
	WHEN c THEN
		dbms_output.put_line('f');
END;

-- EXEMPLE 3
DECLARE
	a EXCEPTION;
	b EXCEPTION;
	c EXCEPTION;
BEGIN
	Procediment1;
	--
	Procediment2;
EXCEPTION
	WHEN a THEN
		dbms_output.put_line('a');
	WHEN b THEN
		dbms_output.put_line('b');
	WHEN NO_DATA_FOUND THEN
		dbms_output.put_line('c');
	WHEN OTHERS THEN
		dbms_output.put_line('d');
END;

