-- Table RMD_EMPLOYEES
CREATE TABLE rmd_employees(
	rmd_employee_id	NUMBER(6) NOT NULL,
	rmd_column_name	VARCHAR2(30) NOT NULL,
	rmd_text		VARCHAR2(100) NOT NULL
);

ALTER TABLE rmd_employees ADD CONSTRAINT rmd_PK
  PRIMARY KEY (rmd_employee_id, rmd_column_name);


-- ??????
ALTER TABLE rmd_employees ADD CONSTRAINT rmd_emp_FK
  FOREIGN KEY (rmd_employee_id) REFERENCES employees(employee_id);
  
