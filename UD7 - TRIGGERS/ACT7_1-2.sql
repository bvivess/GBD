-- View
CREATE OR REPLACE VIEW VW_employees (
	vw_emp_id, vw_emp_name, vw_emp_lastname,
	vw_mgr_id, vw_mgr_name, vw_mgr_lastname ) AS
( SELECT e.employee_id, e.first_name, e.last_name,
         m.employee_id, m.first_name, m.last_name
  FROM employees e, employees m
  WHERE e.manager_id = m.employee_id );