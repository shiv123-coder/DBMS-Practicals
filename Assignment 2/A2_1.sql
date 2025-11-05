create database A2;
use A2;

-- 1. Department Table
create table dept(
    dept_id int primary key,
    dept_name varchar(50) unique not null
);

desc dept;
select * from dept;

-- 2. Instructor Table
create table instructor(
    instr_id int primary key,
    instr_name varchar(100) not null,
    salary decimal(10,2) check(salary >= 0),
    dept_id int,
    constraint fk_instr foreign key(dept_id) references dept(dept_id)
);

desc instructor;
select * from instructor;

-- 3. Student Table
create table student(
    stud_id int primary key,
    stud_name varchar(100),
    dept_id int,
    constraint fk_stud foreign key(dept_id) references dept(dept_id)
);

desc student;
select * from student;

-- 4. Course Table
create table course(
    course_id varchar(20) primary key,
    title varchar(100),
    credits int check(credits > 0),
    dept_id int,
    constraint fk_course foreign key(dept_id) references dept(dept_id)
);

desc course;
select * from course;

-- 5. Company Table
create table company(
    comp_id int primary key,
    comp_name varchar(100) unique,
    city varchar(100)
);

desc company;
select * from company;

-- 6. Employee Table
create table employee(
    emp_id int primary key,
    emp_name varchar(100),
    salary decimal(10,2)
);

desc employee;
select * from employee;

-- 7. Employee-Company Table
create table emp_comp(
    emp_id int,
    comp_id int,
    primary key(emp_id, comp_id),
    foreign key(emp_id) references employee(emp_id),
    foreign key(comp_id) references company(comp_id)
);

desc emp_comp;
select * from emp_comp;

-- 8. View
create view instr_dept_view as
select i.instr_id, i.instr_name, d.dept_name, i.salary
from instructor i join dept d on i.dept_id = d.dept_id;

desc instr_dept_view;
select * from instr_dept_view;

-- 9. Index
create index idx_instr_salary on instructor(salary);

-- 10. Sequence for student IDs
create sequence stud_seq start with 101 increment by 1;

-- 11. Synonym
create synonym instr_alias for instructor;

-- Insert Data
insert into dept (dept_id, dept_name) values
(1,'Computer Science'),
(2,'Information Technology'),
(3,'Mechanical');

insert into instructor (instr_id, instr_name, salary, dept_id) values
(1,'Ramesh',80000,1),
(2,'Suresh',75000,2),
(3,'Anil',90000,1),
(4,'Sunita',70000,3);

insert into student (stud_id, stud_name, dept_id) values
(1,'Rahul',1),
(2,'Neha',2),
(3,'Amit',3);

insert into course (course_id, title, credits, dept_id) values
('CS101','DBMS',3,1),
('CS102','Operating Systems',4,1),
('IT101','Networking',3,2),
('ME101','Thermodynamics',3,3);

insert into company (comp_id, comp_name, city) values
(1,'TCS','Mumbai'),
(2,'Infosys','Pune'),
(3,'Wipro','Bangalore');

insert into employee (emp_id, emp_name, salary) values
(1,'Rajesh',50000),
(2,'Deepak',45000),
(3,'Kavita',60000);

insert into emp_comp (emp_id, comp_id) values
(1,1),
(2,1),
(3,2);

-- Final check
select * from dept;
select * from instructor;
select * from student;
select * from course;
select * from company;
select * from employee;
select * from emp_comp;
select * from instr_dept_view;
