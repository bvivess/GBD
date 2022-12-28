CREATE TABLE r_tmp AS
SELECT * FROM regions
WHERE 1=2;

DECLARE
  CURSOR c IS 
    SELECT region_id, region_name
    FROM regions;
  r c%ROWTYPE;
BEGIN
  FOR r IN c LOOP
    INSERT INTO r_tmp(region_id, region_name)
    VALUES(r.region_id, r.region_name);
  END LOOP;
  --
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
END;

ALTER TABLE countries
  DROP CONSTRAINT COUNTR_REG_FK;
  

DROP TABLE regions;

CREATE TABLE regions(
  region_id NUMBER(2) NOT NULL,
  region_name VARCHAR2(25) 
);

ALTER TABLE regions
  ADD CONSTRAINT reg_PK PRIMARY KEY (region_id);

ALTER TABLE countries
  ADD CONSTRAINT cou_reg_FK FOREIGN KEY (region_id)
  REFERENCES regions(region_id);
















