--
ALTER TABLE product_information DROP CONSTRAINT PRO_PST_FK; 
ALTER TABLE product_information RENAME COLUMN product_status_id TO product_status;
ALTER TABLE product_information MODIFY COLUMN product_status VARCHAR(20) NOT NULL;

--
UPDATE product_information
SET product_status = CASE 
						WHEN product_status = 'O' THEN 'orderable'
						WHEN product_status = 'P' THEN 'planned'
						WHEN product_status = 'U' THEN 'under development'
						WHEN product_status = 'X' THEN 'obsolete'
					 END;

-- 
ALTER TABLE product_information ADD CONSTRAINT PRODUCT_STATUS_CK 
	CHECK product_status IN ('orderable', 'planned','under development','obsolete');

-- 
DROP TABLE product_status_tab;