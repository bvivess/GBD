SET SERVEROUTPUT ON	

-- Crear les següents taules en un usuari de tipus RESOURCE
-- 
-- A MÉS, VEURE TAULES A ACT3b.sql
--
--
-- TARIFES2                   FACTURES2
-- TAR_CODI  TAR_IMPORT     FAC_CODI  FAC_DATA   FAC_IMPORT    FAC_DESCRIPCIO
-- ----------------------  --------------------------------------------------
-- abc        100			(cap registre)
-- mno        200
-- zyz        300
--
CREATE TABLE tarifes2(
	tar_codi	VARCHAR2(3),
	tar_import	NUMBER(5,2)
);

INSERT INTO tarifes2( tar_codi, tar_import )
VALUES( 'abc', 100);

INSERT INTO tarifes2( tar_codi, tar_import )
VALUES( 'mno', 200);

INSERT INTO tarifes2( tar_codi, tar_import )
VALUES( 'xyz', 300);

CREATE TABLE factures2(
	fac_codi	VARCHAR2(10),
	fac_data	DATE,
	fac_import	NUMBER(7,2),
	fac_descripcio	VARCHAR2(30)
);

ALTER TABLE tickets2 ADD tck_fac_codi VARCHAR2(10);

CREATE TABLE errors2(
	data	DATE,
	log		VARCHAR2(100)
);

CREATE SEQUENCE seq_fac;


-- EXEMPLE 4
-- Procés de facturació d'un TICKET2 és:
--   1. comprovar que el ticket no està ja facturat prèviament
--   2. cercar l'import a facturar (segons la taula de tarifes)
--   3. insertar una factura per l'import 
--   4. marcar el ticket com a facturat
CREATE OR REPLACE PROCEDURE facturar_ticket2 ( p_tckcod VARCHAR2 ) IS
--DECLARE
	v_descripcio tickets2.tck_descripcio%TYPE;
	v_import	NUMBER;
	v_msg		VARCHAR2(100);
	v_faccod	VARCHAR2(10);
	error		EXCEPTION;
	--p_tckcodi	VARCHAR2(3) := '1';
BEGIN
	BEGIN
		SELECT NVL(tck_descripcio,'.') INTO v_descripcio
		FROM tickets2
		WHERE tck_codi = p_tckcod
		AND   tck_fac_codi IS NULL;
   EXCEPTION
		WHEN OTHERS THEN
			v_msg := 'ERROR: ' || TO_CHAR(SQLCODE) || ' el ticket ja està facturat';
			RAISE error;
   END;
   --
   BEGIN
		SELECT tar_import INTO v_import
		FROM tarifes2
		WHERE tar_codi = 'abc';
   EXCEPTION
		WHEN OTHERS THEN
			v_msg := 'ERROR: ' || TO_CHAR(SQLCODE) || ' cercant la tarifa a aplicar';
			RAISE error;
   END;
   --
   
   BEGIN
		SELECT seq_fac.NEXTVAL INTO v_faccod FROM dual;
		INSERT INTO factures2 (fac_codi, fac_data, fac_import, fac_descripcio)
		VALUES( v_faccod, TRUNC(SYSDATE), v_import, v_descripcio);
   EXCEPTION
		WHEN OTHERS THEN
			v_msg := 'ERROR: ' || TO_CHAR(SQLCODE) || ' insertant la factura';
			RAISE ERROR;
   END;
   --
   UPDATE tickets2
   SET tck_fac_codi = v_faccod
   WHERE tck_codi = p_tckcod;
   --
   dbms_output.put_line('Procés completat amb èxit');
   COMMIT;
EXCEPTION
	WHEN OTHERS THEN
		IF v_msg IS NULL THEN
			v_msg := 'ERROR GENÈRIC: ' || TO_CHAR(SQLCODE);
		END IF;
		dbms_output.put_line(v_msg);
		ROLLBACK;
        --
        INSERT INTO errors2( data, log )
        VALUES( TRUNC(SYSDATE), v_msg );
        --
        COMMIT;
END;

-- CONVERTIR EL PL/SQL ANTERIOR EN UN PROCEDIMENT QUE FACTURI 
-- TOTS ELS TICKETS2 PENDENTS DE FACTURAR (tck_fac_codi IS NULL) DE LA SEGÜENT MANERA:
--    en comptes d'anar a cercar l'import en una taula de tarifes
--    cal sumar els seus LTICKETS2

DECLARE
	CURSOR c_tck_a_facturar2 IS
		SELECT tck_codi
		FROM tickets2
		WHERE tck_fac_codi IS NULL
		and tck_codi = '1';
	r_tck_a_facturar	c_tck_a_facturar2%ROWTYPE;
BEGIN
	FOR r_tck_a_facturar2 IN c_tck_a_facturar2 LOOP
	
		facturar_ticket2( r_tck_a_facturar.tck_codi );
	
	END LOOP; -- r_tck_a_facturar
	--
	COMMIT;
EXCEPTION
	WHEN OTHERS THEN
		ROLLBACK;
END;