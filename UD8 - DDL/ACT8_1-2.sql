--
ALTER TABLE countries
	DROP CONSTRAINT cou_reg_FK;

--
CREATE TABLE countries_tmp AS
	SELECT country_id, country_name, region_id FROM countries;

--
DROP TABLE countries;

CREATE TABLE countries(
	country_id 		VARCHAR(2) NOT NULL,
	country_name	VARCHAR(40),
	region_id		VARCHAR(4)
);

--
INSERT INTO countries(country_id, country_name, region_id)
	SELECT country_id, country_name, TO_CHAR(region_id) FROM countries_tmp;

-- 
ALTER TABLE countries
	ADD CONSTRAINT cou_reg_FK FOREIGN KEY (region_id)
	REFERENCES regions(region_id);

-- 
DROP TABLE countries_tmp;