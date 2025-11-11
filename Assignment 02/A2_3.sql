create database A2_3;
use A2_3;

create table emp(
    emp_no int primary key,
    emp_name varchar(100),
    dept_no int
);

desc emp;
select * from emp;

create table dept_insem(
    dept_no int primary key,
    dept_name varchar(50)
);

desc dept_insem;
select * from dept_insem;

insert into dept_insem (dept_no, dept_name) values
(1,'Computer Science'),
(2,'Information Technology'),
(3,'Mechanical');

insert into emp (emp_no, emp_name, dept_no) values
(1,'Ram',1),
(2,'Shyam',2),
(3,'Sita',1),
(4,'Pooja',3);

select * from dept_insem;
select * from emp;

--Q.i
select dept_name from dept_insem
where dept_no = (
    select dept_no from emp
    where emp_name='Ram'
);

select d.dept_name
from emp e
join dept_insem d on e.dept_no = d.dept_no
where e.emp_name='Ram';


--Q.ii
create view emp_count_view as
select d.dept_name, count(e.emp_no) as total_emp
from dept_insem d
left join emp e on d.dept_no = e.dept_no
group by d.dept_name
order by total_emp asc;

desc emp_count_view;
select * from emp_count_view;

--Q.iii
-- Nested Query
select dept_name from dept_insem
where dept_no not in (select distinct dept_no from emp);

-- Left Join
select d.dept_name
from dept_insem d
left join emp e on d.dept_no = e.dept_no
where e.emp_no is null;

-- Set Operation (EXCEPT)
select dept_name from dept_insem
except
select d.dept_name
from dept_insem d join emp e on d.dept_no=e.dept_no;
