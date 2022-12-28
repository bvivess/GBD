--
ALTER TABLE customers DROP CONSTRAINT MST_CUS_FK;
ALTER TABLE customers RENAME COLUMN marital_status_id TO marital_status;
ALTER TABLE customers MODIFY marital_status VARCHAR(20);

--
UPDATE customers
SET marital_status = CASE 
						WHEN marital_status = 'S' THEN 'single'
						WHEN marital_status = 'M' THEN 'married'
					 END;
					 
--
ALTER TABLE customers ADD CONSTRAINT MARITAL_STATUS_CK CHECK (MARITAL_STATUS IN ('single','married') );

--
DROP TABLE marital_status_tab;
