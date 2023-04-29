-- Data Engineering


drop table if exists Dept_emp;
drop table if exists Dept_manager;
drop table if exists Salaries;
drop table if exists Employees;
drop table if exists Titles;
drop table if exists Departments;

create table Departments (
	dept_no varchar(4) not null primary key,
	dept_name varchar(25) not null
);

create table Titles (
	title_id varchar(5) primary key,
	title varchar(25)
);

create table Employees (
	emp_no varchar(6) not null primary key,
	emp_title_id varchar(5) not null,
	birth_date date not null,
	first_name varchar(25) not null,
	last_name varchar(25) not null,
	sex varchar(1) not null,
	hire_date date not null,
	foreign key (emp_title_id) references Titles(title_id)
);

create table Dept_emp (
	emp_no varchar(6) not null,
	dept_no varchar(4) not null,
	foreign key (emp_no) references Employees(emp_no),
	foreign key (dept_no) references Departments(dept_no),
	primary key (emp_no, dept_no)
);

create table Dept_manager (
	dept_no varchar(4) not null,
	emp_no varchar(6) not null,
	foreign key (emp_no) references Employees(emp_no),
	foreign key (dept_no) references Departments(dept_no),
	primary key (dept_no, emp_no)
);

create table Salaries (
	emp_no varchar(6) primary key,
	salary numeric(6) not null,
	foreign key (emp_no) references Employees(emp_no)
);


copy departments from
'/private/tmp/sql-challenge-data/departments.csv' 
csv header delimiter ',';

-- select * from departments;

copy titles from
'/private/tmp/sql-challenge-data/titles.csv' 
csv header delimiter ',';

-- select * from titles;

copy employees from
'/private/tmp/sql-challenge-data/employees.csv' 
csv header delimiter ',';

-- select * from employees;

copy dept_emp from
'/private/tmp/sql-challenge-data/dept_emp.csv' 
csv header delimiter ',';

-- select * from dept_emp;

copy dept_manager from
'/private/tmp/sql-challenge-data/dept_manager.csv' 
csv header delimiter ',';

-- select * from dept_manager;

copy salaries from
'/private/tmp/sql-challenge-data/salaries.csv' 
csv header delimiter ',';

-- select * from salaries;
-- Data Analysis

-- List the employee number, last name, first name, sex, and salary of each employee.
select e.emp_no, e.last_name, e.first_name, e.sex, s.salary
from Employees as e join salaries as s 
on e.emp_no = s.emp_no;

-- List the first name, last name, and hire date for the employees who were hired in 1986.
select e.first_name, e.last_name, e.hire_date
from employees as e
where Year(e.hire_date) = 1986;

-- List the manager of each department along with their department number, department name, employee number, last name, and first name.
-- FIX THIS --
select Distinct(e.first_name, departments.dept_no, departments.dept_name, e.emp_no, e.last_name, e.first_name)
from employees as e inner join dept_manager on e.emp_no=dept_manager.emp_no 
inner join departments on dept_manager.dept_no=departments.dept_no 
inner join dept_emp on departments.dept_no=dept_emp.dept_no;

-- List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
-- FIX THIS --
select departments.dept_no, e.emp_no, e.last_name, e.first_name, departments.dept_name
from employees as e inner join dept_manager on e.emp_no=dept_manager.emp_no 
inner join departments on dept_manager.dept_no=departments.dept_no 
inner join dept_emp on departments.dept_no=dept_emp.dept_no;

-- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
select e.first_name, e.last_name, e.sex
from employees as e 
where e.first_name like 'Hercules%' and e.last_name like 'B%';

-- List each employee in the Sales department, including their employee number, last name, and first name.
select e.emp_no, e.last_name, e.first_name
from employees as e inner join dept_manager on e.emp_no=dept_manager.emp_no
inner join departments on dept_manager.dept_no=departments.dept_no
where departments.dept_name like 'Sales';

-- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
-- FIX THIS --
select e.emp_no, e.last_name, e.first_name, departments.dept_no
from employees as e inner join dept_manager on e.emp_no=dept_manager.emp_no
inner join departments on dept_manager.dept_no=departments.dept_no
where departments.dept_name like 'Sales' and departments.dept_name like 'Development';

-- List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
select e.last_name, count(distinct(e.last_name))
from employees as e
group by e.last_name
order by e.last_name desc;
