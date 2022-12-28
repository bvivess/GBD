-- STEP 1
CREATE TABLE discount_per_product_tab(
	( product_id			DECIMAL(6) NOT NULL,
	  from					DATE NOT NULL,
	  to					DATE,
	  discount_percentage	DECIMAL(5,3)
);

ALTER TABLE discount_per_product_tab
    ADD CONSTRAINT disc_pk PRIMARY KEY (product_id, from);

-- STEP 2


-- STEP 3
