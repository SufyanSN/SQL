create database scenarioBased

use scenarioBased

create table tblBooks(
id int identity primary key,
title varchar(30),
author varchar(20),
isbn varchar(30),
published_date datetime
constraint unqisbn unique(isbn)
)

sp_help tblBooks

insert into tblBooks(title,author,isbn,published_date) values('My First SQL book','Mary Parker',981483029127,'2012-02-22 12:08:17.260'),
																('My Second SQL book','Jony Mayer',857300923713,'1972-02-22 12:08:17.260'),
																('My Third SQL book','Cary Flint',523120967812,'2015-02-22 12:08:17.260')
-- 1)  Write a query to fetch the details of the books written by author whose name ends with er
select * from tblBooks where author like '%er'

create table tblReviews
(
id int identity,
book_id int,
reviewer_name varchar(25),
content varchar(25),
rating int,
published_date date
)

insert into tblReviews(book_id,reviewer_name,content,rating,published_date) values(1,'John Smith','My First review',4,'2017-12-10'),
																					(2,'John Smith','My Second review',5,'2017-10-13'),
																					(2,'Alice Walker','Another review',4,'2017-10-22')

select * from tblReviews

-- 2) Display the Title ,Author and ReviewerName for all the books from the above table
select tblBooks.id, tblBooks.title, tblBooks.author, tblReviews.reviewer_name from tblBooks left join tblReviews
on tblBooks.id=tblReviews.book_id

-- 3) Display the reviewer name who reviewed more than one book
select reviewer_name,COUNT(reviewer_name) as 'No of books Reviewed' from tblReviews
group by reviewer_name having COUNT(reviewer_name) > 1

create table tblCustomers
(
id int identity primary key,
name varchar(30),
age int,
address varchar(20),
salary float
)

select * from tblCustomers

insert into tblCustomers(name,age,address,salary) values('Ramesh',32,'Ahmedabad',2000),
														('Khilan',25,'Delhi',1500),
														('Kaushik',23,'Kota',2000),
														('Chaitali',25,'Mumbai',6500),
														('Hardik',27,'Bhopal',8500),
														('Komal',22,'MP',4500),
														('Muffy',24,'Indore',10000)
-- 4) Display the Name for the customer from above customer table who live in same address which has character o anywhere in address
select * from tblCustomers where address in (select distinct(address) from tblCustomers where address like  '%o%' group by address)


create table tblOrders
(
Oid int primary key,
dateOrdered datetime,
custmerId int references tblCustomers(id),  
amount int
)

sp_help tblOrders

insert into tblOrders values(102,'2009-10-08 00:00:00',3,3000)
insert into tblOrders values(100,'2009-10-08 00:00:00',3,1500)
insert into tblOrders values(101,'2009-11-20 00:00:00',2,1560)
insert into tblOrders values(103,'2008-05-20 00:00:00',4,2060)

select * from tblOrders

-- 5) Write a query to display the Date,Total no of customer placed order on same Date
select dateOrdered,count(distinct(custmerId)) as 'No of customers ordered' from tblOrders group by dateOrdered


create table tblCustomers02
(
id int identity primary key,
name varchar(30),
age int,
address varchar(20),
salary float
)

insert into tblCustomers02(name,age,address,salary) values('Ramesh',32,'Ahmedabad',2000),
														('Khilan',25,'Delhi',1500),
														('Kaushik',23,'Kota',2000),
														('Chaitali',25,'Mumbai',6500),
														('Hardik',27,'Bhopal',8500),
														('Komal',22,'MP',null),
														('Muffy',24,'Indore',null)

-- 6) Display the Names of the Employee in lower case, whose salary is null
select name,salary from tblCustomers02 where salary is null


create table tblStudentDetails
(
registerNo int primary key,
Name varchar(20),
Age int,
Qualification varchar(20),
mobileNo varchar(15),
mailId varchar(25),
location_ varchar(20),
gender char(1)
)

insert into tblStudentDetails values(2,'sai',22,'B.E',9952836777,'sai@gmail.com','Chennai','M'),
									(3,'Kumar',20,'BSC',7890125648,'kumar@gmail.com','Madurai','M'),
									(4,'Selvi',22,'B.Tech',8904567342,'selvi@gmail.com','Selam','F'),
									(5,'Nisha',25,'M.E',7904567342,'nisha@gmail.com','Theni','F'),
									(6,'SaiSaran',21,'B.A',8904567342,'saran@gmail.com','Madurai','F'),
									(7,'Tom',22,'BCA',8604567342,'tom@gmail.com','Pune','M')
-- 7) Write a sql server query to display the Gender,Total no of male and female from the above relation
select gender,count(*) as 'Gender count' from tblStudentDetails group by gender


create table tblCourseDetails
(
C_id varchar(10) primary key,
c_name varchar(20),
start_date_ date,
end_date_ date,
Fee int
)

select * from tblCourseDetails

insert into tblCourseDetails values('DN003','DotNet','2018-02-01','2018-02-28',15000)
insert into tblCourseDetails values('DV004','DataVisualization','2018-03-01','2018-04-15',15000)
insert into tblCourseDetails values('JA002','AdvancedJava','2018-01-02','2018-01-20',10000)
insert into tblCourseDetails values('JC001','CoreJava','2018-01-02','2018-01-02',3000)

create table tblCourseRegistration
(
RegisterNo int,
cid varchar(10) references tblCourseDetails(C_id),
batch varchar(3)
)

select * from tblCourseRegistration

insert into tblCourseRegistration values(2,'DN003','FN'),
										(3,'DV004','AN'),
										(4,'JA002','FN'),
										(2,'JA002','AN'),
										(5,'JC001','FN')

-- 8) Retrieve the CourseName and the number of student registered for each course between 2018-01-02 and 2018-02-28
		-- and arrange the result by courseid in descending order
select tblCourseDetails.C_id,C_name,COUNT(RegisterNo) as 'CourseName' from tblCourseDetails join tblCourseRegistration
on tblCourseDetails.C_id=tblCourseRegistration.cid
group by C_id,C_name
having c_name=(select c_name from tblCourseDetails c where start_date_ > '2018-01-02' and end_date_ <= '2018-02-28')
order by C_id desc

create table customer
(
customer_id int primary key,
first_name varchar(15),
last_name varchar(15),
)

insert into customer values(1,'George','Washinghton'),
							(2,'John','Adams'),
							(3,'Thomas','Jefferson')

select * from customer

create table tblOrder
(
order_id int primary key,
order_date date,
amount float,
customer_id int references customer(customer_id)
)

insert into tblOrder values(1,'1776-04-07','234.56',1),
							(2,'1776-04-07','78.56',3),
							(3,'1776-04-07','124.00',2),
							(4,'1776-04-07','65.50',3),
							(5,'1776-04-07','25.50',null)

select * from tblOrder

-- 9) Display the Firstname and LastName of the customer who have placed exactly 2 orders
select first_name as 'First name',last_name as 'Last name' from customer 
where customer_id in (select customer_id from tblOrder group by customer_id having count(customer_id)=2)

-- 10) Display all the student name in reverse order and Capitalize all the character in location
select Name,UPPER(location_) as 'Location' from tblStudentDetails order by Name desc

create table tblorder11
(
id int primary key,
orderDate date,
orderNumber int,
customerId int,
totalAmount int
)

create table tblOrderitem
(
id int primary key,
orderId int,
productId int,
unitPrice int,
quantity int
)

create table tblProduct
(
id int primary key,
productname varchar(20),
supplierId int,
unitPrice int,
package int,
isDiscontinued varchar(4)
)

-- 11) Create a view table to display the ProductName,ordered Quantity and OrderNumber from the above relations
create view ord_prod_view
as
select productname,quantity as 'Order Quantity',orderNumber from tblorder11 join tblOrderitem
on tblorder11.id=tblOrderitem.orderId join tblProduct
on tblOrderitem.productId=tblProduct.id

select * from ord_prod_view

select * from tblStudentDetails
select * from tblCourseDetails
select * from tblCourseRegistration

-- 12) Display the Course Name registered by student Nisha
select C_id, c_name as 'Course Name' from tblCourseDetails where C_id in 
(select cid from tblCourseRegistration where registerno = 
(select registerNo from tblStudentDetails where Name='Nisha'))