--------------------------------------
--------------queries-----------------
--------------------------------------

--1
--List the following details of each employee: employee number, last name, first name, gender, and salary.
CREATE VIEW view_emp_salary AS
SELECT 
	e.emp_no, 
	e.last_name, 
	e.first_name, 
	e.gender, 
	s.salary
FROM tbl_employees e
JOIN tbl_salaries s 
	ON (e.emp_no = s.emp_no);

SELECT * FROM view_emp_salary;

--2
--List employees who were hired in 1986.
CREATE VIEW view_hires_1986 AS
SELECT 
	e.emp_no, 
	e.last_name, 
	e.first_name, 
	d.from_date
FROM tbl_employees e
JOIN tbl_dept_emp d 
	ON (e.emp_no = d.emp_no)
WHERE CAST(d.from_date as TEXT) LIKE '1986%'
ORDER BY d.from_date, e.last_name;

SELECT * FROM view_hires_1986;

--3
--List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
CREATE VIEW view_managers AS
SELECT 
	d.dept_no, 
	d.dept_name, 
	e.emp_no, 
	e.last_name, 
	e.first_name, 
	dd.from_date, 
	dd.to_date
FROM tbl_employees e
	JOIN tbl_dept_manager m 
		ON (e.emp_no = m.emp_no)
	JOIN tbl_departments d
		ON (m.dept_no = d.dept_no)
	JOIN tbl_dept_emp dd
		ON (m.emp_no = dd.emp_no)
ORDER BY d.dept_no, dd.from_date;

SELECT * FROM view_managers;

--4
--List the department of each employee with the following information: employee number, last name, first name, and department name.
CREATE VIEW view_emp_dept_names AS
SELECT 
	e.emp_no, 
	e.last_name, 
	e.first_name, 
	dd.dept_name
FROM tbl_employees e
	JOIN tbl_dept_emp d 
		ON (e.emp_no = d.emp_no)
	JOIN tbl_departments dd
		ON (dd.dept_no = d.dept_no)
ORDER BY dd.dept_name, e.last_name;

SELECT * FROM view_emp_dept_names;
--5
---List all employees whose first name is "Hercules" and last names begin with "B."
CREATE VIEW view_hercs AS
SELECT * 
FROM tbl_employees
WHERE 
	first_name LIKE 'Hercules' AND
	last_name LIKE 'M%'
ORDER BY hire_date;

SELECT * from view_hercs;

--6
--List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT * 
FROM view_emp_dept_names
WHERE dept_name LIKE 'Sale%';

--7
--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT * 
FROM view_emp_dept_names
WHERE 
	dept_name LIKE 'Sale%' OR
	dept_name LIKE 'Develop%';

--8
--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
CREATE VIEW view_namecount AS
SELECT 
	COUNT(last_name) count_name,
	last_name
FROM tbl_employees
GROUP BY last_name
ORDER BY count_name DESC;

SELECT * FROM view_namecount;

select * from view_namecount
where last_name = 'Foolsday';
