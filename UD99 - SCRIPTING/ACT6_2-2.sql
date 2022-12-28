SET SERVEROUTPUT ON	
--
-- Crear aquestes taules sota un usuari de tipus RESOURCE, per exemple GESTIO
--          TICKETS                                 LTICKETS
--------------------------------  -----------------------------------------
-- TCK_CODI	TCK_DESCRIPCIO			LTK_TCK_CODI	LTK_CODI	LTK_IMPORT	
-- --------	--------------------	------------	---------	-----------							
--	   1              (null)            1               1           100
--                                      1               2           100
--                                      1               3           100
--                                      1               4        (null)
--	   2        Descripcio 2            2               1           100
--                                      2               2           100
--                                      2               3           100
--                                      2               4           100
--	   3       Descripcio 3
--	   4       Descripcio 4
--
--
-- CREA LES TAULES
CREATE TABLE tickets(
	tck_codi 		VARCHAR2(3) NOT NULL,
	tck_descripcio	VARCHAR2(15)
);

CREATE TABLE ltickets(
	ltk_tck_codi	VARCHAR2(3) NOT NULL,
	ltk_codi		VARCHAR2(3) NOT NULL,
	ltk_import		NUMBER(5,2)
);

-- CREA ELS REGISTRES
DECLARE
	i				NUMBER;
	j 				NUMBER;
	v_descripcio	VARCHAR2(15);
	v_import		NUMBER;
BEGIN
	BEGIN
		DELETE FROM tickets;
		DELETE FROM ltickets;
	EXCEPTION
		WHEN OTHERS THEN
			NULL;
	END;
	COMMIT;
	--
	FOR i IN 1..4 LOOP
		IF i = 1 THEN
			v_descripcio := NULL;
		ELSE
			v_descripcio := 'Descripcio ' || TO_CHAR(i);
		END IF;
		--
		INSERT INTO tickets( tck_codi, tck_descripcio )
		VALUES( i, v_descripcio );
	END LOOP; --TICKETS
	--
	FOR i IN 1..2 LOOP
		FOR j IN 1..4 LOOP
			IF (i = 1) AND (j = 4) THEN
				v_import := NULL;
			ELSE
				v_import := 100;
			END IF;
			--
			INSERT INTO ltickets( ltk_tck_codi, ltk_codi, ltk_import )
			VALUES( i, j, v_import );
		END LOOP; --LTICKETS
	END LOOP; -- TICKETS
	--
	COMMIT;
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE( SQLERRM );
		ROLLBACK;
END;

-- Exemple 1
DECLARE										
    texto	VARCHAR(15);
	OK		EXCEPTION;
BEGIN
	DBMS_OUTPUT.PUT_LINE('inici');
	--
	SELECT tck_descripcio INTO texto 
	FROM tickets
	WHERE tck_codi =  '1';													
	--																	
	IF (texto IS NULL) THEN
		RAISE value_error;
	ELSE
		RAISE OK;
	END IF;
	--
	DBMS_OUTPUT.PUT_LINE('final');
EXCEPTION
	WHEN OK THEN
		DBMS_OUTPUT.PUT_LINE('OK');
	WHEN VALUE_ERROR THEN
		DBMS_OUTPUT.PUT_LINE('b');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('z');
END;

-- Exemple 2
DECLARE
	total	ltickets.ltk_import%TYPE;
BEGIN
	DBMS_OUTPUT.PUT_LINE('inici');
	--
	SELECT SUM(ltk_import) INTO total  
	FROM ltickets
	WHERE ltk_tck_codi = '1';
	--
	IF (total IS NULL) THEN
		DBMS_OUTPUT.PUT_LINE('Z');
	ELSE
		DBMS_OUTPUT.PUT_LINE( TO_CHAR(total) );
	END IF;
	--
	DBMS_OUTPUT.PUT_LINE('final');
EXCEPTION
	WHEN VALUE_ERROR THEN
		DBMS_OUTPUT.PUT_LINE('A');
	WHEN OTHERS THEN 
		DBMS_OUTPUT.PUT_LINE('B');
END;

-- Exemple 3
DECLARE 
	CURSOR c_tickets IS
		SELECT tck_codi
		FROM tickets
		ORDER BY tck_codi;
	r_tickets	c_tickets%ROWTYPE;
	--
	a 			EXCEPTION;
	b 			EXCEPTION;
BEGIN
	DBMS_OUTPUT.PUT_LINE('inici');
	--
	OPEN c_tickets;
	FETCH c_tickets INTO r_tickets;
	--
	DBMS_OUTPUT.PUT_LINE(r_tickets.tck_codi);
	--
	IF (c_tickets%FOUND) THEN
		RAISE a;
	END IF;
	--
	CLOSE c_tickets;
	--
	RAISE b;
	--
	DBMS_OUTPUT.PUT_LINE('final');
EXCEPTION
	WHEN a THEN
		CLOSE c_tickets;
		--
		DBMS_OUTPUT.PUT_LINE('a');
	WHEN b THEN
		DBMS_OUTPUT.PUT_LINE('b');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('c');
END;

-- Exemple 4
DECLARE 
	CURSOR c_tickets IS
		SELECT tck_codi
		FROM tickets
		ORDER BY tck_codi;
	r_tickets	c_tickets%ROWTYPE;
	--
	a 			EXCEPTION;
	b 			EXCEPTION;
BEGIN
	DBMS_OUTPUT.PUT_LINE('inici');
	--
	OPEN c_tickets;
	FETCH c_tickets INTO r_tickets;
	--
	IF (c_tickets%ISOPEN) THEN
		DBMS_OUTPUT.PUT_LINE(r.tickets.tck_codi);
	END IF;
	--
	CLOSE c_tickets;
	--
	DBMS_OUTPUT.PUT_LINE('final');
EXCEPTION
	WHEN a THEN
		DBMS_OUTPUT.PUT_LINE('a');
	WHEN b THEN
		DBMS_OUTPUT.PUT_LINE('b');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('c' || ' - ' || SQLERRM);
END;

-- Exemple 5
DECLARE
	CURSOR c_ltickets IS
		SELECT * FROM ltickets WHERE ltk_codi IS NULL;
	r_ltickets	c_ltickets%ROWTYPE;
	--
	a 		EXCEPTION;
	b 		EXCEPTION;
BEGIN
	DBMS_OUTPUT.PUT_LINE('inici');
	--
	FOR r_ltickets IN c_ltickets LOOP
		NULL;
	END LOOP;
	--
	RAISE a;
	--
	DBMS_OUTPUT.PUT_LINE('final');
EXCEPTION
	WHEN a THEN
		BEGIN
			DBMS_OUTPUT.PUT_LINE('a');
			RAISE a;
		EXCEPTION
			WHEN OTHERS THEN 
				DBMS_OUTPUT.PUT_LINE('b');
				RAISE b;
		END;
	WHEN b THEN
		DBMS_OUTPUT.PUT_LINE('c');
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('d');
	WHEN OTHERS THEN 
		DBMS_OUTPUT.PUT_LINE('e');
END;

-- Exemple 6
DECLARE
	a EXCEPTION;
	b EXCEPTION;
	--
	PROCEDURE Procediment1 IS
		a	EXCEPTION;
		b	VARCHAR2(1);
	BEGIN
		SELECT '1' INTO b FROM dual WHERE 1 = 1;
	EXCEPTION
		WHEN a THEN
			DBMS_OUTPUT.PUT_LINE('Z');
	END;
	--
	PROCEDURE Procediment2 IS
		a	VARCHAR2(1);
	BEGIN
		SELECT '1' INTO a FROM dual WHERE 1 = 2; 
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('X');
	END;
BEGIN
	DBMS_OUTPUT.PUT_LINE('inici');
	--
	Procediment1;
	--
	Procediment2;
	--
	DBMS_OUTPUT.PUT_LINE('final');
EXCEPTION
	WHEN a THEN
		DBMS_OUTPUT.PUT_LINE('a');
	WHEN b THEN
		DBMS_OUTPUT.PUT_LINE('b');
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('c');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('d');
END;
