-- Create the Log table
CREATE TABLE log_employees ( log_employee_id, log_first_name, log_last_name, 
							 log_email, log_phone_number, log_hire_date,
							 log_job_id, log_salary, log_commission_pct,
							 log_manager_id, log_department_id ) AS
SELECT employee_id, first_name, last_name, 
	   email, phone_number, hire_date, 
	   job_id, salary, commission_pct,
	   manager_id, department_id
FROM employees
WHERE 1=2;

ALTER TABLE log_employees
	ADD log_opeid VARCHAR2(1) NOT NULL;

ALTER TABLE log_employees
	ADD log_date DATE NOT NULL;

ALTER TABLE log_employees
	ADD log_user VARCHAR2(10) NOT NULL;

-- Create the trigger
CREATE OR REPLACE TRIGGER trg_employees
  BEFORE INSERT OR DELETE OR UPDATE
  ON employees
  FOR EACH ROW
BEGIN
	IF INSERTING THEN
		INSERT INTO log_employees( log_employee_id, log_first_name, log_last_name, 
								   log_email, log_phone_number, log_hire_date,
								   log_job_id, log_salary, log_commission_pct,
								   log_manager_id, log_department_id,
								   log_opeid, log_date, log_user )
		VALUES( :NEW.employee_id,
				:NEW.first_name,
				:NEW.last_name,
				:NEW.email, 
				:NEW.phone_number, 
				:NEW.hire_date,
				:NEW.job_id, 
				:NEW.salary, 
				:NEW.commission_pct,
				:NEW.manager_id,
				:NEW.department_id,
				'I', SYSDATE, USER );

	ELSIF UPDATING THEN
		INSERT INTO log_employees( log_employee_id, log_first_name, log_last_name, 
								   log_email, log_phone_number, log_hire_date,
								   log_job_id, log_salary, log_commission_pct,
								   log_manager_id, log_department_id,
								   log_opeid, log_date, log_user )
		VALUES( :OLD.employee_id,
				:OLD.first_name,
				:OLD.last_name,
				:OLD.email, 
				:OLD.phone_number, 
				:OLD.hire_date,
				:OLD.job_id, 
				:OLD.salary, 
				:OLD.commission_pct,
				:OLD.manager_id,
				:OLD.department_id,
				'U', SYSDATE, USER );
	ELSIF DELETING THEN
		INSERT INTO log_employees( log_employee_id, log_first_name, log_last_name, 
								   log_email, log_phone_number, log_hire_date,
								   log_job_id, log_salary, log_commission_pct,
								   log_manager_id, log_department_id,
								   log_opeid, log_date, log_user )
		VALUES( :OLD.employee_id,
				:OLD.first_name,
				:OLD.last_name,
				:OLD.email, 
				:OLD.phone_number, 
				:OLD.hire_date,
				:OLD.job_id, 
				:OLD.salary, 
				:OLD.commission_pct,
				:OLD.manager_id,
				:OLD.department_id,
				'D', SYSDATE, USER );
	END IF;
END;




