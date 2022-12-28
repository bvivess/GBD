-- STEP 1
CREATE TABLE provinces(
  pro_id        	VARCHAR(5) NOT NULL,
  pro_description	VARCHAR(30),
  pro_cou_id		VARCHAR(2) NOT NULL
);

ALTER TABLE provinces PK ...

-- STEP 3
-- Checking out 
SELECT SUBSTR(state_province,1,5)
FROM locations
GROUP BY SUBSTR(state_province,1,5)
HAVING COUNT(*) > 1;

-- Inserting & Updating
INSERT INTO provinces( pro_id, pro_description, pro_cou_id )
	SELECT DISTINCT SUBSTR(state_province,1,5), state_province, country_id 
	FROM locations
	WHERE state_province IS NOT NULL;
--
UPDATE locations
SET loc_pro_id = SUBSTR(state_province,1,5);

-- STEP 4
ALTER TABLE locations ADD DROP COLUMN COLUMN state_province;

ALTER TABLE locations ADD loc_pro_id VARCHAR(5);
ALTER TABLE locations FK ...