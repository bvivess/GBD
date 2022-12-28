-- STEP 1
CREATE TABLE price_per_product_tab(
	( PRODUCT_ID	DECIMAL(6) NOT NULL,
	  FROM			DATE NOT NULL,
	  TO			DATE,
	  LIST_PRICE    DECIMAL(8,2)
);

ALTER TABLE price_per_product_tab
    ADD CONSTRAINT pri_pk PRIMARY KEY (product_id, from);

-- STEP 2
INSERT INTO price_per_product_tab( product_id, from, list_price )
		SELECT product_id, STR_TO_DATE('01-01-2000','%d-%m-%y'), list_price
		FROM product_information
		WHERE list_price IS NOT NULL;

-- STEP 3
ALTER TABLE product_information DROP COLUMN list_price;