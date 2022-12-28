-- STEP 1
CREATE TABLE income_level_temporal_tab(
	customer_id		DECIMAL(6,0) NOT NULL,
	income_level_id	VARCHAR(1) NOT NULL,
	from			DATE NOT NULL,
	to				DATE
);

ALTER TABLE income_level_temporal_tab ADD CONSTRAINT income_level_temporal_tab_pk 
	PRIMARY KEY (income_level_id, customer_id, from );

-- STEP 2
ALTER TABLE customers DROP CONSTRAINT il_cus_fk;

-- STEP 3
INSERT INTO income_level_temporal_tab( customer_id, income_level_id, from, to )
	SELECT customer_id, income_level, STR_TO_DATE('01-01-2000','%d-%m-%Y'), NULL
	FROM customers;

-- STEP 4
ALTER TABLE income_level_temporal_tab ADD CONSTRAINT  ilt_cus_fk ...
ALTER TABLE income_level_temporal_tab ADD CONSTRAINT  ilt_il_fk ...

ALTER TABLE customer DROP income_level;


