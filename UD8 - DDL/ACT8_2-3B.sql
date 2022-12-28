--
ALTER TABLE customer DROP CONSTRAINT cus_gen_FK 

--
ALTER TABLE customers RENAME COLUMN gender_id TO gender;

--



--
DROP TABLE genders_tab;
