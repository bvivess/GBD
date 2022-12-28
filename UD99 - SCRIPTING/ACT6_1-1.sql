SET SERVEROUTPUT ON


BEGIN
	DBMS_OUTPUT.PUT_LINE( 'Hello world !!!' );
END;

DECLARE
	missatge VARCHAR2(100) := 'Hello world !!!';
BEGIN
	DBMS_OUTPUT.PUT_LINE( missatge );
END;