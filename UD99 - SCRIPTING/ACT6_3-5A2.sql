-- SOTA ELS USUARIS 'HR_SALES' I 'HR_NOSALES'

-- ES CREA TBL, PK DE DEPARTMENTS
CREATE TABLE departments AS 
	SELECT * FROM HR.departments WHERE 1 = 2;
ALTER TABLE departments ADD CONSTRAINT dep_PK1 PRIMARY KEY( department_id );

-- ES CREA TBL, PK DE JOBS
CREATE TABLE jobs AS 
	SELECT * FROM HR.jobs WHERE 1 = 2;
ALTER TABLE jobs ADD CONSTRAINT jobs_PK1 PRIMARY KEY( job_id );

-- ES CREA TBL, PK, FK DE EMPLOYEES
CREATE TABLE employees AS 
	SELECT * FROM HR.employees WHERE 1 = 2;
ALTER TABLE employees ADD CONSTRAINT emp_PK1 PRIMARY KEY( employee_id );
ALTER TABLE employees ADD CONSTRAINT emp_dep_FK1 FOREIGN KEY (department_id) REFERENCES departments(department_id);
ALTER TABLE employees ADD CONSTRAINT emp_job_FK1 FOREIGN KEY (job_id) REFERENCES jobs(job_id);

-- ES CREA TBL, PK, FK DE JOB_HISTORY
CREATE TABLE job_history AS 
	SELECT * FROM HR.job_history WHERE 1 = 2;
ALTER TABLE job_history ADD CONSTRAINT job_history_PK1 PRIMARY KEY( job_id, start_date );
ALTER TABLE job_history ADD CONSTRAINT jobh_emp_FK1 FOREIGN KEY (employee_id) REFERENCES employees(employee_id);
ALTER TABLE job_history ADD CONSTRAINT jobh_dep_FK1 FOREIGN KEY (department_id) REFERENCES departments(department_id);
ALTER TABLE job_history ADD CONSTRAINT jobh_job_FK1 FOREIGN KEY (job_id) REFERENCES jobs(job_id);
