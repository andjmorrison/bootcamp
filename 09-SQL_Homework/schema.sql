--~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~--
--~-~-~-Pewlett Hackard DB Schema-~-~-~--
--~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~--

--employees table
CREATE TABLE tbl_employees(
	emp_no SERIAL NOT NULL PRIMARY KEY,
	birth_date DATE,
	first_name VARCHAR,
	last_name VARCHAR,
	gender VARCHAR (1),
	hire_date DATE
);

--departments table
CREATE TABLE tbl_departments(
	dept_no VARCHAR (255) NOT NULL PRIMARY KEY,
	dept_name VARCHAR (255) NOT NULL
);

--dept/employees table
CREATE TABLE tbl_dept_emp(
	emp_no SERIAL NOT NULL REFERENCES tbl_employees (emp_no),
	dept_no VARCHAR (255) NOT NULL REFERENCES tbl_departments (dept_no),
	PRIMARY KEY (emp_no, dept_no),
	from_date DATE,
	to_date DATE
);

--dept managers table
CREATE TABLE tbl_dept_manager(
	k_dept_manager SERIAL NOT NULL PRIMARY KEY,
	dept_no VARCHAR (255) NOT NULL REFERENCES tbl_departments (dept_no),
	emp_no SERIAL NOT NULL REFERENCES tbl_employees (emp_no),
	from_date DATE,
	to_date DATE
);

--titles table
CREATE TABLE tbl_titles(
	k_title SERIAL NOT NULL PRIMARY KEY,
	emp_no SERIAL NOT NULL REFERENCES tbl_employees (emp_no),
	title VARCHAR (255),
	from_date DATE,
	to_date DATE
);

--salaries table
CREATE TABLE tbl_salaries(
	k_salary SERIAL NOT NULL PRIMARY KEY,
	emp_no SERIAL NOT NULL REFERENCES tbl_employees (emp_no),
	salary MONEY,
	from_date DATE,
	to_date DATE
);

-- DROP TABLE tbl_employees;
-- DROP TABLE tbl_departments;
-- DROP TABLE tbl_dept_emp;
-- DROP TABLE tbl_dept_manager;
-- DROP TABLE tbl_salaries;
-- DROP TABLE tbl_titles;
