SET SERVEROUTPUT ON	

-- SUPOSA LES SEGÜENTS TAULES
-- INVOICES
-- INV_ID		INV_DATE	INV_STATUS
-- ----------- ----------- ----------
--      1       06/02/2018     P
--      2       19/03/2018     P
--      3       22/05/2018     C
--      4       20/06/2018     C
--      5       01/12/2018     X
--
-- LINVOICES
-- LIN_INV_ID	LIN_NUM	   LIN_TOTAL
-- ----------- ----------- ---------
--      1           1         500
--      2           1         300
--      2           2         300
--      3           1         200
--      3           2         200
--      3           3         200
--      4           1         0
--      4           2         100
--      4           3         100
--      4           4         100

-- EXERCICI 1
-- CREA LES TAULES I LES DADES 
CREATE TABLE invoices(
	inv_id		VARCHAR2(10) NOT NULL,
	inv_date	DATE NOT NULL,
	inv_status	VARCHAR2(1) NOT NULL ,
	CONSTRAINT inv_PK PRIMARY KEY( inv_id ),
	CONSTRAINT inv_status_CK CHECK( inv_status IN ('P','C','X') )
);

INSERT INTO invoices(inv_id, inv_date, inv_status) VALUES('1',TO_DATE('06022018','DDMMYYYY'),'P');
INSERT INTO invoices(inv_id, inv_date, inv_status) VALUES('2',TO_DATE('19032018','DDMMYYYY'),'P');
INSERT INTO invoices(inv_id, inv_date, inv_status) VALUES('3',TO_DATE('22052018','DDMMYYYY'),'C');
INSERT INTO invoices(inv_id, inv_date, inv_status) VALUES('4',TO_DATE('20062018','DDMMYYYY'),'C');
INSERT INTO invoices(inv_id, inv_date, inv_status) VALUES('5',TO_DATE('01122018','DDMMYYYY'),'X');

CREATE TABLE linvoices(
	lin_inv_id	VARCHAR2(10) NOT NULL,
	lin_num		VARCHAR2(3) NOT NULL,
	lin_total	NUMBER(8,2) NOT NULL,
	CONSTRAINT lin_PK PRIMARY KEY( lin_inv_id, lin_num ),
	CONSTRAINT lin_inv_FK FOREIGN KEY( lin_inv_id ) REFERENCES invoices( inv_id )
);

INSERT INTO linvoices(lin_inv_id, lin_num, lin_total) VALUES('1','1', 500);
INSERT INTO linvoices(lin_inv_id, lin_num, lin_total) VALUES('2','1', 300);
INSERT INTO linvoices(lin_inv_id, lin_num, lin_total) VALUES('2','2', 300);
INSERT INTO linvoices(lin_inv_id, lin_num, lin_total) VALUES('3','1', 200);
INSERT INTO linvoices(lin_inv_id, lin_num, lin_total) VALUES('3','2', 200);
INSERT INTO linvoices(lin_inv_id, lin_num, lin_total) VALUES('3','3', 200);
INSERT INTO linvoices(lin_inv_id, lin_num, lin_total) VALUES('4','1', 0);
INSERT INTO linvoices(lin_inv_id, lin_num, lin_total) VALUES('4','2', 100);
INSERT INTO linvoices(lin_inv_id, lin_num, lin_total) VALUES('4','3', 100);
INSERT INTO linvoices(lin_inv_id, lin_num, lin_total) VALUES('4','4', 100);

-- EXERCICI 2
DECLARE
	a	EXCEPTION;
	b	EXCEPTION;
	i	NUMBER(2); 
BEGIN
	FOR i IN 1..10 LOOP
		IF (i < 1) THEN
			RAISE a;
		ELSIF (i = 5) THEN
			RAISE b;
		ELSE
			DBMS_OUTPUT.PUT_LINE( i );
		END IF;
	END LOOP;
EXCEPTION
	WHEN a THEN
		DBMS_OUTPUT.PUT_LINE( 'A' );
	WHEN b THEN
		DBMS_OUTPUT.PUT_LINE( 'B' );
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE( 'Z' );
END;

-- EXERCICI 3
DECLARE
	a	EXCEPTION;
	b	EXCEPTION;
	i	NUMBER(2) := 0;
	j	NUMBER(2) := 10;
BEGIN
	WHILE (j < i) LOOP
		DBMS_OUTPUT.PUT_LINE( j - i );
		i := i + 5; 
		j := j - 5; 
	END LOOP;
	--
	RAISE a;
EXCEPTION
	WHEN a THEN
		DBMS_OUTPUT.PUT_LINE( 'A' );
	WHEN b THEN
		DBMS_OUTPUT.PUT_LINE( 'B' );
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE( 'Z' );
END;

-- EXERCICI 4
DECLARE
	v_id	invoices.inv_id%TYPE;
	v_date	invoices.inv_date%TYPE;
	a		EXCEPTION;
	b		EXCEPTION;
BEGIN
	BEGIN
		SELECT inv_id, inv_date INTO v_id, v_date
		FROM invoices
		WHERE inv_date >= '06-feb-2018';
	EXCEPTION
		WHEN OTHERS THEN
			DBMS_OUTPUT.PUT_LINE('A');
			RAISE a;
			--
			BEGIN
				SELECT lin_inv_id INTO v_id
				FROM linvoices
				WHERE lin_inv_id = '1';
				--
				RAISE b;
			EXCEPTION
				WHEN a THEN
					DBMS_OUTPUT.PUT_LINE('B');
					RAISE VALUE_ERROR;
				WHEN OTHERS THEN
					DBMS_OUTPUT.PUT_LINE('C');
					RAISE VALUE_ERROR;
			END;
			--
			RAISE TOO_MANY_ROWS;
	END;
	--
	DBMS_OUTPUT.PUT_LINE('D');
EXCEPTION
	WHEN a THEN
		DBMS_OUTPUT.PUT_LINE('E'); 
		-- RAISE b; 
	WHEN b THEN
		DBMS_OUTPUT.PUT_LINE('F');
		RAISE TOO_MANY_ROWS;  
	WHEN TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE('G');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Z');
END;

-- EXERCICI 5
DECLARE
	CURSOR c IS
		SELECT inv_id, inv_date, inv_status
		FROM invoices;
	--
	r	c%ROWTYPE;
	total	NUMBER(8,2);
	i	NUMBER(10) := 1;
BEGIN
	INSERT INTO invoices(inv_id, inv_date, inv_status)
	VALUES( i, TRUNC(SYSDATE), 'P' );
	--
	UPDATE linvoices
	SET lin_total = lin_total * 1.10
	WHERE lin_inv_id = i;
	--
	DBMS_OUTPUT.PUT_LINE( 'A' );
	COMMIT;
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE( 'ERROR: ' || SQLERRM );
		ROLLBACK;
END;

-- EXERCICI 6
DECLARE
	a	EXCEPTION;
	b	EXCEPTION;
	total NUMBER(8,2);
BEGIN
	BEGIN
		SELECT SUM(NVL(lin_total,0)) INTO total
		FROM linvoices
		GROUP BY lin_inv_id
		HAVING SUM(lin_total) IN (SELECT MAX(NVL(lin_total,0)) FROM linvoices);
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE( 'A' );
			--
			IF total = 600 THEN
				RAISE b;
			ELSE
				RAISE a;
			END IF;
		WHEN TOO_MANY_ROWS THEN
			DBMS_OUTPUT.PUT_LINE( 'B' );
			RAISE b;
	END;
EXCEPTION
	WHEN a THEN
		DBMS_OUTPUT.PUT_LINE( 'C' );
	WHEN b THEN
		DBMS_OUTPUT.PUT_LINE( 'D' );
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE( 'Z' );
END;

-- EXERCICI 7
DECLARE
	a	EXCEPTION;
	total NUMBER(8,2);
BEGIN
	BEGIN
		SELECT NVL(SUM(lin_total),0) INTO total
		FROM invoices, linvoices
		WHERE inv_id (+) = lin_inv_id 
		AND   inv_status = 'X';
		--
		RAISE a;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE( 'A' );
			--
			SELECT NVL(lin_total,0) INTO total
			FROM invoices, linvoices
			WHERE inv_id = lin_inv_id (+)
			AND   inv_status = 'X';
		WHEN TOO_MANY_ROWS THEN
			DBMS_OUTPUT.PUT_LINE( 'B' );
			--
			SELECT NVL(lin_total,0) INTO total
			FROM invoices, linvoices
			WHERE inv_id = lin_inv_id (+)
			AND   inv_status = 'X';
		WHEN VALUE_ERROR THEN
			DBMS_OUTPUT.PUT_LINE( 'C' );
			--
			SELECT NVL(lin_total,0) INTO total
			FROM invoices, linvoices
			WHERE inv_id = lin_inv_id (+)
			AND   inv_status = 'X';
	END;
	--
	DBMS_OUTPUT.PUT_LINE( 'D' );
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE( 'E' );
	WHEN TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE( 'F' );
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE( 'Z' );
END;

-- EXERCICI 8
DECLARE
	a	EXCEPTION;
	b	EXCEPTION;
	c	EXCEPTION;
	total NUMBER(8,2);
BEGIN
	BEGIN
		SELECT SUM(NVL(lin_total,0)) INTO total
		FROM invoices, linvoices
		WHERE inv_id = lin_inv_id 
		AND   inv_status = 'C';
		--
		IF total IS NULL THEN
			DBMS_OUTPUT.PUT_LINE( 'A' );
			--
			SELECT NVL(SUM(lin_total),0) INTO total
			FROM invoices, linvoices
			WHERE inv_id = lin_inv_id 
			AND   inv_status = 'C';
			--
			RAISE a;
		ELSE
			DBMS_OUTPUT.PUT_LINE( 'B' );
			--
			SELECT NVL(SUM(lin_total),0) INTO total
			FROM invoices, linvoices
			WHERE inv_id = lin_inv_id 
			AND   inv_status = 'C';
			--
			RAISE b;
		END IF;
		--
		DBMS_OUTPUT.PUT_LINE( 'C' );
		RAISE c;
	EXCEPTION
		WHEN a THEN
			DBMS_OUTPUT.PUT_LINE( 'D' );
		WHEN b THEN
			DBMS_OUTPUT.PUT_LINE( 'E' );
		WHEN OTHERS THEN 
			DBMS_OUTPUT.PUT_LINE( 'F' );
	END;
EXCEPTION
	WHEN a THEN
		DBMS_OUTPUT.PUT_LINE( 'G' );
	WHEN b THEN
		DBMS_OUTPUT.PUT_LINE( 'H' );
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE( 'Z' );
END;


-- EXERCICI 9
DECLARE
	a		EXCEPTION;
	b		EXCEPTION;
	c		EXCEPTION;
	v_id	invoices.inv_id%TYPE;
	total	NUMBER(8,2);
BEGIN
	BEGIN
		SELECT SUM(lin_total) INTO total
		FROM invoices, linvoices
		WHERE inv_id = lin_inv_id 
		AND   inv_status = 'P'
		GROUP BY inv_id;
		--
		IF total IS NULL THEN
			RAISE a;
		ELSE
			RAISE b;
		END IF;
		--
		RAISE c;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN 
			DBMS_OUTPUT.PUT_LINE( 'A' );
			--
			RAISE NO_DATA_FOUND;
		WHEN TOO_MANY_ROWS THEN 
			DBMS_OUTPUT.PUT_LINE( 'B' );
			--
			RAISE TOO_MANY_ROWS;
		WHEN OTHERS THEN 
			DBMS_OUTPUT.PUT_LINE( 'C' );
	END;
EXCEPTION
	WHEN a THEN
		DBMS_OUTPUT.PUT_LINE( 'D' );
	WHEN b THEN
		DBMS_OUTPUT.PUT_LINE( 'E' );
	WHEN NO_DATA_FOUND THEN 
		DBMS_OUTPUT.PUT_LINE( 'F' );
	WHEN TOO_MANY_ROWS THEN 
		DBMS_OUTPUT.PUT_LINE( 'G' );
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE( 'Z' );
END;

-- EXERCICI 10
DECLARE
	CURSOR c IS
		SELECT lin_inv_id, NVL(lin_total,0) lin_total
		FROM linvoices, invoices 
		WHERE inv_id = lin_inv_id
		AND   NVL(lin_total,0) IS NOT NULL
		AND   inv_date NOT IN (SELECT MIN(inv_date) FROM invoices);
	--
	r	c%ROWTYPE;
BEGIN
	FOR r IN c LOOP
		DBMS_OUTPUT.PUT_LINE( r.lin_inv_id || '-' || r.lin_total );
	END LOOP; -- c
	--
	DBMS_OUTPUT.PUT_LINE('D');
EXCEPTION
	WHEN TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE( 'A' );
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE( 'B' );
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE( 'Z' );
END;

-- EXERCICI 11
DECLARE
	CURSOR c IS
		SELECT lin_inv_id,  NVL(AVG(NVL(lin_total,100)),0) total
		FROM linvoices, invoices
		WHERE inv_id = lin_inv_id
		GROUP BY  inv_date, lin_inv_id
		ORDER BY inv_date DESC;
	--
	r		c%ROWTYPE;
	max_avg	NUMBER(8,2) := -1;
BEGIN
	FOR r IN c LOOP
		IF (max_avg > r.total) THEN
			DBMS_OUTPUT.PUT_LINE( max_avg );
			--
			max_avg := r.total;
		ELSE
			DBMS_OUTPUT.PUT_LINE( r.total );
		END IF;
	END LOOP; -- c
	--
	DBMS_OUTPUT.PUT_LINE( max_avg );
EXCEPTION
	WHEN TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE( 'A' );
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE( 'B' );
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE( 'Z' );
END;


-- EXERCICI 12
DECLARE
	CURSOR c1 IS
		SELECT inv_id
		FROM invoices
		ORDER BY inv_id;
	--
	CURSOR c2 (p_id NUMBER) IS
		SELECT lin_num, NVL(lin_total,0) lin_total
		FROM linvoices
		WHERE lin_inv_id = p_id
		ORDER BY lin_num;
	--
	r1		c1%ROWTYPE;
	r2		c2%ROWTYPE;
	total	NUMBER(8,2) := 0;
	a		EXCEPTION;
BEGIN
	FOR r1 IN c1 LOOP
		FOR r2 IN c2(r1.inv_id) LOOP
			IF total <= NVL(r2.lin_total,0) THEN
				total := total + 1;
			ELSE
				RAISE a;
			END IF;
		END LOOP; -- c2
	END LOOP; -- c1
	--
	DBMS_OUTPUT.PUT_LINE( total );
EXCEPTION
	WHEN TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE( 'A' );
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE( 'B' );
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE( 'Z' );
END;

