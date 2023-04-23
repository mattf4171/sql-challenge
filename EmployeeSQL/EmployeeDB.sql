-- Data Engineering

drop table if exists Departments;
drop table if exists Dept_emp;
drop table if exists Dept_manager;
drop table if exists Employees;
drop table if exists Salaries;
drop table if exists Titles;

create table Departments (
	dept_no varchar(4) not null primary key,
	dept_name varchar(25) not null,
);

create table Employees (
	emp_no numeric(6) not null primary key,
	emp_title_id varchar(5) not null,
	birth_date date not null,
	first_name varchar(25) not null,
	last_name varchar(25) not null,
	sex varchar(1) not null,
	hire_date date not null
);

create table Dept_emp (
	emp_no varchar(6) not null,
	dept_no varchar(4) not null,
	foreign key (emp_no) references Employees(emp_no),
	foreign key (dept_no) references Departments(dept_no)
);

create table Dept_manager (
	emp_no varchar(6) not null,
	dept_no varchar(4) not null,
	foreign key (emp_no) references Employees(emp_no),
	foreign key (dept_no) references Departments(dept_no)
);

create table Dept_manager (
	emp_no varchar(6) not null,
	dept_no varchar(4) not null,
	foreign key (emp_no) references Employees(emp_no),
	foreign key (dept_no) references Departments(dept_no)
);

create table Titles (
	title_id varchar(5) not null,
	title varchar(25) not null,
	foreign key (title_id) references Employees(emp_title_id)
);

-- Data Analysis






