-- STEP 1
CREATE TABLE marital_status_tab(
	marital_status_id	VARCHAR(1) NOT NULL,
	marital_description	VARCHAR(30),
	CONSTRAINT marital_status_PK PRIMARY KEY (marital_status_id)
);

-- STEP 2
ALTER TABLE customers DROP CONSTRAINT MARITAL_STATUS_CK;

-- STEP 3
INSERT INTO marital_status_tab( marital_status_id, marital_description )
	SELECT DISTINCT UPPER(SUBSTR(marital_status,1,1)), marital_status
	FROM customers;

INSERT INTO marital_status_tab( marital_status_id, marital_description )
VALUES( 'D', 'Divorced' ),
      ( 'W', 'Widow' );

UPDATE customers
SET marital_status = UPPER(SUBSTR(marital_status,1,1));

-- STEP 4
ALTER TABLE customers MODIFY marital_status VARCHAR(1);
ALTER TABLE customers RENAME COLUMN marital_status TO marital_status_id;
ALTER TABLE customers ADD CONSTRAINT MST_CUS_FK FOREIGN KEY (marital_status_id) REFERENCES marital_status_tab(marital_status_id);


