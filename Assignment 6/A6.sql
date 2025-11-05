create database A5;
use A5;
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
create procedure proc_grade(in p_roll int,in p_name varchar(100),in p_marks int)
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
    
    insert into result_table(roll_no, name, class) values (p_roll, p_name, v_class);
end ;
//

delimiter ;

call proc_grade(1,'Amit',1450);
call proc_grade(2,'Beena',980); 

select * from result_table;