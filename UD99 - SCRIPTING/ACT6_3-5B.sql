-- SOTA L'USUARI 'HR_SALES'

DECLARE
	CURSOR c_departments IS
		SELECT department_id, department_name, manager_id, location_id  
		FROM HR.departments
		WHERE department_id = 80;
	r_department c_departments%ROWTYPE;
	--
	CURSOR c_employees( p_department_id NUMBER ) IS
		SELECT employee_id, first_name, last_name, email, phone_number,
		       hire_date, job_id, salary, commission_pct, manager_id, department_id 
		FROM HR.employees
		WHERE department_id = p_department_id;
	r_employee c_employees%ROWTYPE;
	--
	CURSOR c_jobs( p_job_id VARCHAR2 ) IS
		SELECT job_id, job_title, min_salary, max_salary
		FROM HR.jobs 
		WHERE job_id = p_job_id;
	r_job c_jobs%ROWTYPE;
	--
	CURSOR c_job_histories( p_employee_id NUMBER ) IS
		SELECT employee_id, start_date, end_date, job_id, department_id
		FROM HR.job_history
		WHERE employee_id = p_employee_id;
	r_jobhistory c_job_histories%ROWTYPE;
BEGIN
	FOR r_department IN c_departments LOOP
		-- S'insereix el departament 'r_department'
		INSERT INTO departments( department_id, department_name, manager_id, location_id )
		VALUES( r_department.department_id, r_department.department_name, r_department.manager_id, r_department.location_id );
		-- S'insereixen els EMPLOYEES d'aquest 'r_department' i els seus JOB_HISTORY
		FOR r_employee IN c_employees( r_department.DEPARTMENT_ID ) LOOP
			-- S'insereixen el JOB de l'empleat, si ja ha estat insertat no es mostrarà un error
			FOR r_job IN c_jobs( r_employee.job_id ) LOOP
				BEGIN
					INSERT INTO jobs( job_id, job_title, min_salary, max_salary )
					VALUES( r_job.job_id, r_job.job_title, r_job.min_salary, r_job.max_salary );
				EXCEPTION
					WHEN DUP_VAL_ON_INDEX THEN
						NULL;
				END;
			END LOOP;
			--
			INSERT INTO employees( employee_id, first_name, last_name, email, phone_number,
		                           hire_date, job_id, salary, commission_pct, manager_id, department_id )
			VALUES( r_employee.employee_id, r_employee.first_name, r_employee.last_name, r_employee.email, r_employee.phone_number,
		            r_employee.hire_date, r_employee.job_id, r_employee.salary, r_employee.commission_pct, r_employee.manager_id,
					r_employee.department_id );
			--
			FOR r_job_history IN c_job_histories( r_employee.employee_id ) LOOP
				INSERT INTO job_history( employee_id, start_date, end_date, job_id, department_id )
				VALUES( r_job_history.employee_id, r_job_history.start_date, r_job_history.end_date, 
				        r_job_history.job_id, r_job_history.department_id );
			END LOOP;
		END LOOP;
	END LOOP;
	--
	COMMIT;
EXCEPTION	
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE( SQLERRM );
		ROLLBACK;
END;
/