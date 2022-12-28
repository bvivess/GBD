-- TABLES
CREATE TABLE states(
	stt_code	VARCHAR(5) NOT NULL,
	stt_name	VARCHAR(100) NOT NULL
);

CREATE TABLE provinces(
	prv_code		VARCHAR(2) NOT NULL,
	prv_name		VARCHAR(100) NOT NULL,
	prv_stt_code	VARCHAR(10)	NOT NULL
);

CREATE TABLE locations(
	loc_code		VARCHAR(10) NOT NULL,
	loc_name		VARCHAR(100) NOT NULL,
	loc_prv_code	VARCHAR(2) NOT NULL
);
-- PRIMARY KEYS
ALTER TABLE states ADD CONSTRAINT stt_pk PRIMARY KEY( sst_code );
ALTER TABLE provinces ADD CONSTRAINT prv_pk PRIMARY KEY( prv_stt_code );
ALTER TABLE states ADD CONSTRAINT loc_pk PRIMARY KEY( loc_prv_code );

-- FOREIGN KEYS
ALTER TABLE provinces
    ADD CONSTRAINT prv_stt_fk FOREIGN KEY ( prv_stt_code )
        REFERENCES states ( stt_code );
		
ALTER TABLE locations
    ADD CONSTRAINT loc_prv_fk FOREIGN KEY ( loc_prv_code )
        REFERENCES provinces ( prv_code );
