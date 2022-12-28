CREATE TABLE log_personas(
	log_date    DATE,
    log_text	VARCHAR2(100) NOT NULL);

-- Compound trigger
CREATE OR REPLACE TRIGGER trg_employees
	FOR INSERT OR UPDATE OF salary
	ON employees
	COMPOUND TRIGGER

    TYPE r_employees IS RECORD (
        employee_id employees.employee_id%TYPE,
        salary      employees.salary%TYPE
    );

	TYPE l_employees IS TABLE OF r_employees INDEX BY PLS_INTEGER;
	v_employees	l_employees; 
	--
	i   	NUMBER(5) := 0;
	text	VARCHAR2(100);

	BEFORE EACH ROW IS BEGIN	
        i := i + 1;
	END BEFORE EACH ROW;

	AFTER STATEMENT IS BEGIN
		IF INSERTING THEN
			text := 'INSERTED';
		ELSIF UPDATING THEN
			text := 'UPDATED';
		ELSIF DELETING THEN
			text := 'DELETED';
		END IF;
		--
		INSERT INTO log_personas( log_date, log_text )
		VALUES( SYSDATE, 'Number of rows ' || text || ' is ' || TO_CHAR(i));
	END AFTER STATEMENT;
	
END trg_personas;
