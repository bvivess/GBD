-- STEP 1
CREATE TABLE genders_tab(
    gender_id			VARCHAR(1) NOT NULL,
    gender_description	VARCHAR(30)
);

-- STEP 2
NO EXISTE NINGUNA CK

ALTER TABLE customers RENAME COLUMN gender TO gender_id;

-- STEP 3
INSERT INTO genders_tab( gender_id, gender_description )
VALUES('M', 'Male'),
	  ('F', 'Female');
	
-- STEP 4
ALTER TABLE customer ADD CONSTRAINT cus_gen_FK 
	FOREIGN KEY gender_id REFERENCES gender_tab(gender_id);

