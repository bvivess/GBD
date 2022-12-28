SET SERVEROUTPUT ON

DECLARE
	CURSOR c_emp (p_department VARCHAR2) IS
		SELECT e.employee_id, first_name, last_name, job_title, department_name
		FROM jobs j, departments d, employees e
		WHERE j.job_id        = e.job_id
		AND   d.department_id = e.department_id
		AND   d.department_id = p_department
		ORDER BY employee_id;
	--
	r_emp c_emp%ROWTYPE;
	--
	CURSOR c_jobh (p_employee_id NUMBER) IS
		SELECT job_title, department_name
		FROM jobs j, departments d, job_history h
		WHERE j.job_id        = h.job_id
		AND   d.department_id = h.department_id
		AND   h.employee_id   = p_employee_id
		ORDER BY start_date, end_date;
	--
	r_jobh c_jobh%ROWTYPE;
BEGIN
    FOR r_emp IN c_emp (80) LOOP
		DBMS_OUTPUT.PUT_LINE( r_emp.last_name || ' ' || r_emp.first_name || ' ' || r_emp.job_title || ' ' || r_emp.department_name );
		FOR r_jobh IN c_jobh (r_emp.employee_id) LOOP
			DBMS_OUTPUT.PUT_LINE( ' >>>>>>>>>>>>>>>>>>>> ' || r_jobh.job_title || ' ' || r_jobh.department_name );	
		END LOOP;
	END LOOP;
END;
