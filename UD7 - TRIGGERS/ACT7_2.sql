CREATE TABLE persones(
    per_id		NUMBER(10) NOT NULL,
    per_nom		VARCHAR(100) NOT NULL,
    per_tdoc	VARCHAR(1) NOT NULL,
    per_docid	VARCHAR(15) NOT NULL
);

CREATE TABLE alumnes(
    alu_per_id	NUMBER(10) NOT NULL
);

CREATE TABLE professors(
    pro_per_id	NUMBER(10) NOT NULL
);

--
CREATE TABLE factures(
	fac_id 		NUMBER(10) NOT NULL,
	fac_total	NUMBER(8,2) DEFAULT 0 NOT NULL
);

CREATE TABLE lfactures(
	lfa_fac_id		NUMBER(10) NOT NULL,
	lfa_num			NUMBER(5) NOT NULL,
	lfa_subtotal	NUMBER(5,2)
);
