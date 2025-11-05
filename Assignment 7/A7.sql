create database A6;
use A6;

create table stud_marks(
    roll_no int PRIMARY KEY,
    name varchar(50),
    marks int
);

insert into stud_marks(roll_no,name,marks) values 
    (1,'Amit',1450),
    (2,'Beena',980),
    (3,'Chetan',920);

select * from stud_marks;

delimiter //
create procedure list_of_students()
begin
    declare v_roll int;
    declare v_name varchar(100);
    declare v_marks int;
    declare done int default 0;
    declare cur_stud cursor for
        select roll_no,name,marks from stud_marks;
    declare continue handler for not found
        set done = 1;

    open cur_stud;

    read_loop: loop
        fetch cur_stud into v_roll,v_name,v_marks;
        if done=1 then 
            leave read_loop;
        end if;
        select v_roll ,v_name,v_marks;
    end loop;

    close cur_stud;
end;
//
delimiter ;

call list_of_students();





create table N_RollCall(
    student_id int,
    class_date DATE,
    status varchar(10)
);

create table O_RollCall(
    student_id int,
    class_date DATE,
    status varchar(10),
    PRIMARY KEY (student_id,class_date)
);

insert into N_RollCall(student_id,class_date,status) values 
    (107,'2025-09-01','Present');

insert into O_RollCall(student_id,class_date,status) values 
    (101,'2025-09-01','Present'),
    (102,'2025-09-01','Absent'),
    (103,'2025-09-01','Present');

insert into N_RollCall (student_id,class_date,status) values 
    (101,'2025-09-01','Present'),
    (102,'2025-09-02','Present'),
    (104,'2025-09-01','Absent'),
    (105,'2025-09-03','Present');

select * from N_RollCall;
select * from O_RollCall;

delimiter //
create procedure MergeRollCall2(in p_student_id int)
begin
    declare done int default false;
    declare v_student_id int;
    declare v_class_date DATE;
    declare v_status varchar(10);
    declare cur cursor for select student_id,class_date,status from N_RollCall where student_id = p_student_id;
    declare continue handler for not found set done = true;

    open cur;

    read_loop: loop
        fetch cur into v_student_id,v_class_date,v_status;
        if done then 
            leave read_loop;
        end if;

        insert into O_RollCall(student_id,class_date,status)
        select v_student_id,v_class_date,v_status
        where not exists(
            select 1 from O_RollCall 
            where student_id = v_student_id AND class_date = v_class_date
        );
    end loop;

    close cur;
end;
//
delimiter ;

call MergeRollCall2(107);

select * from O_RollCall;
select * from N_RollCall;