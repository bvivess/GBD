CREATE TABLE states(
	stt_code	VARCHAR(10) NOT NULL,
	stt_name	VARCHAR(100),
	CONSTRAINT stt_pk PRIMARY KEY (stt_code)
);

CREATE TABLE provinces(
	prv_code		VARCHAR(2) NOT NULL,
	prv_name		VARCHAR(100),
	prv_stt_code	VARCHAR(10) NOT NULL,
	CONSTRAINT prv_pk PRIMARY KEY (prv_code),
	CONSTRAINT prv_stt_fk FOREIGN KEY(prv_stt_code) REFERENCES states(stt_code)
);

CREATE TABLE locations(
	loc_code		VARCHAR(10) NOT NULL,
	loc_name		VARCHAR(100),
	loc_prv_code	VARCHAR(2) NOT NULL,
	CONSTRAINT loc_pk PRIMARY KEY (loc_code),
	CONSTRAINT loc_prv_fk FOREIGN KEY( loc_prv_code) REFERENCES provinces(prv_code)
);

