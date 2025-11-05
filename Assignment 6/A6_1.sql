create database A5_1;
use A5_1;

create table stud_marks(
    roll_no int PRIMARY KEY,
    name varchar(100),
    marks int 
);

insert into stud_marks (roll_no, name, marks) values (1,'Amit',1450),(2,'Beena',980),(3,'Chetan',920),(4,'Divya',860),(5,'Isha',400);

create table result_table(
    roll_no int ,
    name varchar(100),
    class varchar(50)
);

delimiter //
create function fproc_grade(p_marks int)
returns varchar(50)
deterministic
begin
    declare v_class varchar(50);
    if p_marks is null or p_marks<0 or p_marks>1500 then
        set v_class ='Invalid';
    elseif p_marks between 990 and 1500 then
        set v_class = 'Distinction';
    elseif p_marks between 900 and 989 then
        set v_class = 'First Class';
    elseif p_marks between 825 and 899 then
        set v_class = 'Higher Second Class';
    elseif p_marks between 600 and 824 then
        set v_class = 'Second Class';
    elseif p_marks between 400 and 599 then
        set v_class = 'Pass';
    else
        set v_class = 'Fail';
    end if;
    
    return v_class;
end ;
//
delimiter ;

/*
delimiter //
create procedure callf_proc_grade(in p_roll int,in p_name varchar(100),in p_marks int)
begin
    insert into result_table(roll_no, name, class) values (p_roll, p_name, fproc_grade(p_marks));
end ;
//
delimiter ;
call callf_proc_grade(3,'Chetan',920);
call callf_proc_grade(5,'Isha',400);

select * from result_table;
*/

select roll_no, name, fproc_grade(marks) as class from stud_marks;

insert into result_table(roll_no, name, class)
select roll_no, name, fproc_grade(marks) from stud_marks;

select * from result_table;
