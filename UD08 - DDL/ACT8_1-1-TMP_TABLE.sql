-- STEP 1: Drop all FK
ALTER TABLE countries
	DROP CONSTRAINT COU_REG_FK;

-- STEP 2: Make a copy of Regions → REGIONS_TMP
CREATE TABLE regions_tmp AS	
	SELECT region_id, region_name FROM regions;

-- STEP 3: Drop table and its PK, Create again  
DROP TABLE regions;

CREATE TABLE regions(
	region_id 	VARCHAR(4) NOT NULL,
	region_name VARCHAR(25) 
);

-- STEP 4: Insert files from TMP
INSERT INTO regions(region_id, region_name)
	SELECT CAST(region_id AS CHAR(4)), region_name
	FROM regions_tmp;

-- STEP 3 & 4: RENAME TABLE tmp TO original (not possible in MySQL)
-- RENAME regions_tmp TO regions;
 
-- STEP 5: ALTER FK COLUMNS (repeat it for each one)
ALTER TABLE countries ADD  region_id2 VARCHAR(4);
UPDATE countries SET region_id2 = region_id;
ALTER TABLE countries DROP COLUMN region_id;
ALTER TABLE countries RENAME COLUMN region_id2 TO region_id;

-- STEP 6
ALTER TABLE regions
	ADD CONSTRAINT reg_PK PRIMARY KEY (region_id);
	
ALTER TABLE countries
	ADD CONSTRAINT cou_reg_FK FOREIGN KEY (region_id)
	REFERENCES regions(region_id);

-- STEP 7
DROP TABLE regions_tmp;




