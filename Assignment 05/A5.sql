create database A4_1;
use A4_1;

create table areas(
    radius decimal(5,2),
    area decimal(10,2)
);

delimiter //
create procedure circle_area()
begin
    declare r int default 5;
    declare a decimal(10,2);

    while r<=9 do 
        set a=pi()*r*r;
        insert into areas(radius,area) values(r,round(a,2));
        set r=r+1;
    end while;
end;
//
delimiter ;

call circle_area();

select * from areas();