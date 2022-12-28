SET SERVEROUTPUT ON	

CREATE OR REPLACE FUNCTION Obtenir_tarifa( p_tarifa VARCHAR2 ) RETURN NUMBER IS
	v_import tarifes2.tar_import%TYPE;
BEGIN
	SELECT tar_import INTO v_import
	FROM tarifes2
	WHERE tar_codi = p_tarifa;
	--
	RETURN v_import;
EXCEPTION
	WHEN NO_DATA_FOUND OR TOO_MANY_ROWS THEN
		RAISE_APPLICATION_ERROR('-20001','ERROR: tarifa ' || p_tarifa || ' mal codificada. ERROR: ' || TO_CHAR(SQLCODE));
	WHEN OTHERS THEN
		RAISE_APPLICATION_ERROR('-20009','ERROR: cercant la tarifa ' || p_tarifa || '. ERROR: '|| TO_CHAR(SQLCODE));
END;

CREATE OR REPLACE FUNCTION Obtenir_descripcio( p_tckcod VARCHAR2 ) RETURN NUMBER IS
	v_faccod		tickets2.tck_fac_codi%TYPE;
	v_descripcio	tickets2.tck_descripcio%TYPE;
	error			EXCEPTION;
	v_msgerr		VARCHAR2(100);
BEGIN
	SELECT tck_fac_codi, NVL(tck_descripcio,'.') INTO v_faccod, v_descripcio
	FROM tickets2
	WHERE tck_codi = p_tckcod;
	--
	IF v_faccod IS NOT NULL THEN
		v_msgerr := 'ERROR: el ticket ' || p_tckcod || ' ja està facturat';
		RAISE error;
	END IF;
	--
	RETURN v_descripcio;
EXCEPTION
	WHEN error THEN
		RAISE_APPLICATION_ERROR('-20011', v_msgerr);
	WHEN OTHERS THEN
		RAISE_APPLICATION_ERROR('-20011','ERROR: ' || TO_CHAR(SQLCODE) || ' cercant la descripció del ticket.');
END;

CREATE OR REPLACE FUNCTION Obtenir_faccod( p_tckcod VARCHAR ) RETURN VARCHAR2 IS
	v_faccod	factures2.fac_codi%TYPE;
BEGIN
	SELECT seq_fac.NEXTVAL INTO v_faccod FROM dual;
	--
	RETURN v_faccod;
EXCEPTION
	WHEN OTHERS THEN
		RAISE_APPLICATION_ERROR('-20021','ERROR: ' || TO_CHAR(SQLCODE) || ' cercant el ID factura.');
END;

CREATE OR REPLACE PROCEDURE facturar_ticket2 ( p_tckcod VARCHAR2 ) IS
	v_descripcio tickets2.tck_descripcio%TYPE;
	v_import	NUMBER;
	v_msg		VARCHAR2(100);
	v_faccod	VARCHAR2(10);
	error		EXCEPTION;
	--p_tckcodi	VARCHAR2(3) := '1';
BEGIN
	BEGIN
		v_descripcio := Obtenir_descripcio( p_tckcod );
	END;
	--
	BEGIN
		v_import := Obtenir_tarifa('abc');
	END;
	--
	BEGIN
		v_faccod := Obtenir_faccod( p_tckcod );
	END;
	--
	BEGIN
		INSERT INTO factures2 (fac_codi, fac_data, fac_import, fac_descripcio)
		VALUES( v_faccod, TRUNC(SYSDATE), v_import, v_descripcio);
	EXCEPTION
		WHEN OTHERS THEN
			v_msg := 'ERROR: ' || TO_CHAR(SQLCODE) || ' insertant la factura';
			RAISE ERROR;
	END;
	--
	BEGIN
		UPDATE tickets2
		SET tck_fac_codi = v_faccod
		WHERE tck_codi = p_tckcod;
	EXCEPTION
		WHEN OTHERS THEN
			v_msg := 'ERROR: ' || TO_CHAR(SQLCODE) || ' modificant la factura';
			RAISE ERROR;
	END;
	--
	dbms_output.put_line('Procés completat amb èxit');
	COMMIT;
EXCEPTION
	WHEN no_data_found THEN
		dbms_output.put_line('b');
		ROLLBACK;
	WHEN error THEN
		dbms_output.put_line('c');
		ROLLBACK;
		--
		INSERT INTO errors2( data, log )
		VALUES( TRUNC(SYSDATE), v_msg );
		--
		COMMIT;
END;