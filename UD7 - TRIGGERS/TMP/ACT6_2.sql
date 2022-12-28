CREATE TABLE persones(
    per_id		VARCHAR2(10) NOT NULL,
    per_nom		VARCHAR2(100) NOT NULL,
    per_tdoc	VARCHAR2(1) NOT NULL,
    per_docid	VARCHAR2(15) NOT NULL
);

CREATE TABLE alumnes(
    alu_per_id	VARCHAR2(10) NOT NULL
);

CREATE TABLE professors(
    pro_per_id	VARCHAR2(10) NOT NULL
);

--
CREATE TABLE factures
	fac_id 		VARCHAR2(10) NOT NULL,
	fac_total	NUMBER(8,2) DEFAULT 0 NOT NULL
);

CREATE TABLE lfactures
	lfa_fac_id		VARCHAR2(10) NOT NULL,
	lfa_num			VARCHAR2(5) NOT NULL,
	lfa_subtotal	NUMBER(5,2)
);
