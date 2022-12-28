-- STEP 1
CREATE TABLE product_status_tab(
	product_status_id	VARCHAR(1) NOT NULL,
	status_description	VARCHAR(30) NOT NULL,
	CONSTRAINT PRO_STA_PK PRIMARY KEY (product_status_id )
);

-- STEP 2
ALTER TABLE product_information DROP CONSTRAINT PRODUCT_STATUS_CK;

-- STEP 3
INSERT INTO product_status_tab( product_status_id, status_description )
	VALUES( 'O', 'ORDERABLE'),
		  ( 'P', 'PLANNED'),
		  ( 'U', 'UNDER DEVELOPMENT'),
		  ( 'X', 'OBSOLETE');

--
UPDATE product_information
SET product_status = CASE 
						WHEN UPPER(product_status) = 'ORDERABLE'         THEN 'O'
						WHEN UPPER(product_status) = 'PLANNED'           THEN 'P'
						WHEN UPPER(product_status) = 'UNDER DEVELOPMENT' THEN 'U'
						WHEN UPPER(product_status) = 'OBSOLETE'          THEN 'X'
					 END;
-- STEP 4  
ALTER TABLE product_information MODIFY COLUMN product_status VARCHAR(1) NOT NULL;
ALTER TABLE product_information RENAME COLUMN product_status TO product_status_id;

ALTER TABLE product_information ADD CONSTRAINT PRO_PST_FK FOREIGN KEY (product_status_id) REFERENCES product_status_tab (product_status_id); 

