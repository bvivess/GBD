-- VERSIÓ I
CREATE TABLE seq_param( 
	seq_fac	NUMBER(10) DEFAULT 1 NOT NULL,		--> Seqüència per a 'FACTURES'
	seq_per	NUMBER(5) DEFAULT 1 NOT NULL		--> Seqüència per a 'PERSONES'
);

-- La taula amb un únic registre i tantes columnes com seqüències calguin
INSERT INTO seq_param( seq_fac, seq_per ) VALUES ( 1, 1 );	

CREATE OR REPLACE TRIGGER trg_factures
	BEFORE INSERT OR UPDATE
	ON factures
	FOR EACH ROW
DECLARE
	v_fac_id factures.fac_id%TYPE;
BEGIN
	SELECT seq_fac + 1 INTO v_fac_id
	FROM seq_param;
	--
	:NEW.fac_id := v_fac_id;
	--
	UPDATE seq_param
	SET seq_fac = v_fac_id;
EXCEPTION
	WHEN NO_DATA_FOUND OR TOO_MANY_ROWS THEN
		-- O más de 1 empleado, OK
		RAISE_APPLICATION_ERROR(-20000, 'ERROR: la tabla SEQ_PARAM debe contener una sola fila.');
END;

-- VERSIÓ II
-- Este ejercicio también puede pensarse de la siguiente manera:
CREATE TABLE seq_param( 
	seq_tipo	VARCHAR2(3) NOT NULL,			--> Defineix l'ús de la seqüència
	seq_num		NUMBER(5) DEFAULT 1 NOT NULL	--> Numerador de la seqüència
);

-- La taula tindrà tants registres com seqüències calguin
INSERT INTO seq_param( seq_tipo, seq_num ) VALUES ( 'FAC', 1 );		--> Seqüència per a 'FACTURES'
INSERT INTO seq_param( seq_tipo, seq_num ) VALUES ( 'PER', 1 );		--> Seqüència per a 'PERSONES'

CREATE OR REPLACE TRIGGER trg_factures
	BEFORE INSERT OR UPDATE
	ON factures
	FOR EACH ROW
DECLARE
	v_fac_id factures.fac_id%TYPE;
BEGIN
	SELECT seq_num + 1 INTO v_fac_id
	FROM seq_param
	WHERE seq_tipo = 'FAC';
	--
	:NEW.fac_id := v_fac_id;
	--
	UPDATE seq_param
	SET seq_num = v_fac_id
	WHERE seq_tipo = 'FAC';
EXCEPTION
	WHEN NO_DATA_FOUND OR TOO_MANY_ROWS THEN
		-- O más de 1 empleado, OK
		RAISE_APPLICATION_ERROR(-20000, 'ERROR: la tabla SEQ_PARAM debe inicializarse correctamente para tipo FAC.');
END;

