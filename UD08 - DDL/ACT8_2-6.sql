-- STEP 1
CREATE TABLE income_level_tab(
	income_level_id		VARCHAR(1) NOT NULL,
	level_description	VARCHAR(30) NOT NULL,
	CONSTRAINT ilt_pk PRIMARY KEY (income_level_id)
);

-- STEP 2
-- ALTER TABLE income_level_tab DROP CONSTRAINT CK ... --> NO EXISTEIX

-- STEP 3
INSERT INTO income_level_tab( income_level_id, level_description )
	SELECT DISTINCT SUBSTR(income_level,1,1) income_level_id, SUBSTR(income_level, 3, 20) level_description
	FROM customers;

UPDATE customers
SET income_level = SUBSTR(income_level,1,1);

-- STEP 4
ALTER TABLE customers MODIFY income_level VARCHAR(1);
ALTER TABLE customers RENAME COLUMN income_level TO income_level_id;

ALTER TABLE customers ADD CONSTRAINT ilt_cus_fk FOREIGN KEY (income_level) REFERENCES income_level_tab(income_level_id);



