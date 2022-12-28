-- STEP 1: Drop all FK, PK
ALTER TABLE countries DROP FOREIGN KEY COU_REG_FK;
ALTER TABLE regions DROP PRIMARY KEY;

-- STEP2: Alter PK table
ALTER TABLE regions MODIFY REGION_ID VARCHAR(4);

-- STEP3: Alter FK tables
ALTER TABLE countries MODIFY REGION_ID VARCHAR(4);

-- STEP4: Create PK, FK again
ALTER TABLE regions ADD constraint reg_pk PRIMARY KEY (region_id);

ALTER TABLE countries ADD CONSTRAINT COU_REG_FK  
	FOREIGN KEY (region_id) REFERENCES regions(region_id);
