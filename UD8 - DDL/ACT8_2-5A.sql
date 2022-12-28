-- STEP 1
ALTER TABLE customers DROP CONSTRAINT MST_CUS_FK;

-- STEP 2
CREATE TABLE mst_x_cus(
	customer_id			INT NOT NULL,
	marital_status_id	VARCHAR(1) NOT NULL,
	date_from			DATE NOT NULL,
	date_to				DATE,
	CONSTRAINT mxc_pk PRIMARY KEY (customer_id, marital_status_id, date_from )
);

-- STEP 3
INSERT INTO mst_x_cus( customer_id, marital_status_id, date_from, date_to )
	SELECT customer_id, marital_status_id, STR_TO_DATE('01-01-2000','%d-%m-%Y'), NULL
	FROM customers;

-- STEP 4
ALTER TABLE mst_x_cus ADD CONSTRAINT mxc_cus_fk FOREIGN KEY (customer_id) REFERENCES customers(customer_id); 
ALTER TABLE mst_x_cus ADD CONSTRAINT mxc_mst_fk FOREIGN KEY (marital_status_id) REFERENCES marital_status_tab(marital_status_id);

-- STEP 5
ALTER TABLE customers DROP marital_status_id;
