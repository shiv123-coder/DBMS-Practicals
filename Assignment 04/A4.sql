use A4;
DROP TABLE IF EXISTS fine;
DROP TABLE IF EXISTS Borrower;

Create table Borrower(
    RollNo Int PRIMARY KEY,
    Name Varchar(100),
    DOI DATE,
    NOB varchar(100),
    status char(1) check (status in ('I','R'))
);

Create table fine(
    RollNo Int ,
    Date DATE,
    Amount decimal(10,2),
    FOREIGN KEY (RollNo) REFERENCES Borrower(RollNo)
);

Insert into Borrower( RollNo, Name, DOI, NOB, status) values
(4, 'Alice', '2025-08-23', 'DBMS', 'I'),
(5, 'Bob', '2025-08-13', 'OS', 'I'),
(6, 'Charlie', '2025-02-24', 'JAVA', 'I');

select * from Borrower;
select * from fine;

delimiter //
DROP PROCEDURE IF EXISTS SFA;
Create procedure SFA( in Rno int, Book_name varchar(100))
begin
    declare x int;
    declare continue handler for not found
    begin
        select 'Not Found';
    end;
    select datediff(curdate(),DOI) into x from Borrower 
        where RollNo=Rno;
    if (x>15 && x<30) then
        insert into fine values(Rno,curdate(),(x*5));
    end if ;
    if (x>30) then
        insert into fine values(Rno,curdate(),(x*50));
    end if;

    update Borrower 
    set status='R' 
    where RollNo=Rno;
    
    end;
    //
 delimiter ;

call SFA(4,'DBMS');
call SFA(5,'OS');

select * from fine;