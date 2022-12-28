ALTER TABLE job_history DROP PRIMARY KEY;

ALTER TABLE job_history DROP CONSTRAINT jhist_dep_FK;

CREATE TABLE dep_history(
	employee_id 	INT NOT NULL,
	department_id	INT NOT NULL,
	start_date		DATE NOT NULL,
	end_date		DATE,
	CONSTRAINT dhist_emp_PK PRIMARY KEY ( employee_id, department_id, start_date )
);

INSERT INTO dep_history(employee_id, department_id, start_date, end_date )
	SELECT employee_id, department_id, start_date, end_date
	FROM job_history;

ALTER TABLE job_history DROP COLUMN department_id;

ALTER TABLE job_history ADD CONSTRAINT dhist_emp_PK PRIMARY KEY ( employee_id, job_id, start_date );

