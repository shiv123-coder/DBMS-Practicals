use A2;
-- 1. List all students
select * from student;

-- 2. Titles of courses in 'Computer Science' with 3 credits
select title from course c join dept d on c.dept_id=d.dept_id
where d.dept_name='Computer Science' and c.credits=3;

-- 3. Names of instructors in 'Information Technology' earning > 70000
select instr_name from instructor i join dept d on i.dept_id=d.dept_id
where d.dept_name='Information Technology' and i.salary>70000;

-- 4. IDs & titles of courses taught by 'Ramesh'
select distinct c.course_id, c.title
from course c join dept d on c.dept_id=d.dept_id
join instructor i on i.dept_id=d.dept_id
where i.instr_name='Ramesh';

-- 5. Course IDs starting with 'CS'
select course_id from course where course_id like 'CS%';

-- 6. Course titles containing 'DBMS'
select title from course where title like '%DBMS%';

-- 7. Highest and lowest salary of instructors
select max(salary) as highest, min(salary) as lowest from instructor;

-- 8. Maximum salary per department
select d.dept_name, max(i.salary) as max_salary
from instructor i join dept d on i.dept_id=d.dept_id
group by d.dept_name;

-- 9. Increase salary by 10% for 'Computer Science' instructors earning < 85000
update instructor set salary=salary*1.1
where dept_id=(select dept_id from dept where dept_name='Computer Science')
and salary < 85000;

-- 10. Delete courses with credits < 3
delete from course where credits<3;

-- 11. Count of employees working at 'TCS'
select count(*) as emp_count
from emp_comp ec join company c on ec.comp_id=c.comp_id
where c.comp_name='TCS';

-- 12. Number of employees in each company
select c.comp_name, count(ec.emp_id) as emp_count
from company c left join emp_comp ec on c.comp_id=ec.comp_id
group by c.comp_name;

-- 13. Average salary per company excluding 'TCS'
select c.comp_name, avg(e.salary) as avg_salary
from company c join emp_comp ec on c.comp_id=ec.comp_id
join employee e on e.emp_id=ec.emp_id
where c.comp_name <> 'TCS'
group by c.comp_name;

-- 14. Employees with salary greater than average
select emp_name, salary from employee
where salary > (select avg(salary) from employee);

-- 15. Departments with no students
select d.dept_name
from dept d
where d.dept_id not in (select distinct dept_id from student);