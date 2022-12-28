-- STEP 1
CREATE TABLE customer_telephones(
  tel_customer_id	INT NOT NULL,
  tel_number		VARCHAR(30) NOT NULL
);

ALTER TABLE customer_telephones
    ADD CONSTRAINT tel_pk PRIMARY KEY (tel_customer_id, tel_number);
	
ALTER TABLE customer_telephones 
    ADD CONSTRAINT tel_cus_fk FOREIGN KEY (tel_customer_id) REFERENCES customers(customer_id);

-- STEP 2
-- Version I: better within fixed length !!
-- Checking out
SELECT(LENGTH(phone_numbers)) FROM customers;

-- Inserting
INSERT INTO customer_telephones( tel_customer_id, tel_number )
		-- First phone
		SELECT customer_id, SUBSTR(phone_numbers, 1, 15 ) 
		FROM customers
		WHERE phone_numbers IS NOT NULL
	UNION
		-- Second phone
		SELECT customer_id, SUBSTR(phone_numbers, 17, 15 ) 
		FROM customers
		WHERE SUBSTR(phone_numbers, 17, 15 ) != '';
		
-- Version II
INSERT INTO customer_telephones( tel_customer_id, tel_number )
		-- First phone
		SELECT customer_id,
			   SUBSTR(phone_numbers, 1, 
					CASE 
						WHEN INSTR(SUBSTR(phone_numbers, 2, 100), '+') = 0 THEN 100 
						ELSE INSTR(SUBSTR(phone_numbers, 2, 100), '+') - 1
					END ) first_phone 
		FROM customers
		WHERE LENGTH(phone_numbers) > 1
	UNION
		-- Second phone
		SELECT customer_id,
			   SUBSTR(phone_numbers,  
					CASE 
						WHEN INSTR(SUBSTR(phone_numbers, 2, 100), '+') = 0 THEN 100 
						ELSE INSTR(SUBSTR(phone_numbers, 2, 100), '+') - 1
					END + 1, 100 ) second_phone
		FROM customers
		WHERE LENGTH(phone_numbers) BETWEEN 17 AND 33;


-- STEP 3
ALTER TABLE customers DROP COLUMN phone_numbers;