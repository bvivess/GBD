-- SOTA L'USUARI 'SYSTEM'
GRANT SELECT, INSERT, UPDATE, DELETE ON hr_sales.departments TO PUBLIC;
GRANT SELECT, INSERT, UPDATE, DELETE ON hr_sales.employees TO PUBLIC;
GRANT SELECT, INSERT, UPDATE, DELETE ON hr_sales.jobs TO PUBLIC;
GRANT SELECT, INSERT, UPDATE, DELETE ON hr_sales.job_history TO PUBLIC;
--
GRANT SELECT, INSERT, UPDATE, DELETE ON hr_nosales.departments TO PUBLIC;
GRANT SELECT, INSERT, UPDATE, DELETE ON hr_nosales.employees TO PUBLIC;
GRANT SELECT, INSERT, UPDATE, DELETE ON hr_nosales.jobs TO PUBLIC;
GRANT SELECT, INSERT, UPDATE, DELETE ON hr_nosales.job_history TO PUBLIC;

-- SOTA L'USUARI 'HR'
DECLARE
	CURSOR c_employees_HR IS
		SELECT employee_id
		FROM employees;
	r_employee1	c_employeesHR%ROWTYPE;
	--
	CURSOR c_employees_SALESNOSALES IS
		 SELECT employee_id
		 FROM HR_SALES.employees
		UNION
		 SELECT employee_id
		 FROM HR_NOSALES.employees;
	r_employee2	c_employees_SALESNOSALES%ROWTYPE;
	--
	dummy	VARCHAR2(1);
BEGIN
	-- Es comprova que tots els registres d''HR' estan a 'HR_SALES' o a 'HR_NOSALES'
	FOR r_employee1 IN c_employees_HR LOOP
		BEGIN
			 SELECT '1' INTO dummy
			 FROM HR_SALES.employees
			 WHERE employee_id = r.employee1.employee_id
			UNION
			 SELECT '2'
			 FROM HR_NOSALES.employees
			 WHERE employee_id = r.employee1.employee_id;
		EXCEPTION
			WHEN NO_DATA_FOUND OR TOO_MANY_ROWS THEN
				DBMS_OUTPUT.PUT_LINE( 'Empleat amb ID: ' || r.employee1.employee_id ' no es troba.');
			WHEN TOO_MANY_ROWS THEN
				DBMS_OUTPUT.PUT_LINE( 'Empleat amb ID: ' || r.employee1.employee_id ' duplicat.');
		END;
	END LOOP;
	-- Es comprova que tots els registres d''HR_SALES' i 'HR_NOSALES' estan a 'HR'
	FOR r_employee2 IN c_employees_SALESNOSALES LOOP
		BEGIN
			SELECT '1' INTO dummy
			FROM employees
			WHERE employee_id = r.employee2.employee_id;
		EXCEPTION
			WHEN NO_DATA_FOUND OR TOO_MANY_ROWS THEN
				DBMS_OUTPUT.PUT_LINE( 'Empleat amb ID: ' || r.employee2.employee_id ' no es troba.');
			WHEN TOO_MANY_ROWS THEN
				DBMS_OUTPUT.PUT_LINE( 'Empleat amb ID: ' || r.employee2.employee_id ' duplicat.');
		END;
	END LOOP;
END;	
	