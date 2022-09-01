/*  Day-01 Assignment */

create database Assignment_1_db

use Assignment_1_db

create table Clients
(
client_id int primary key,
Cname varchar(40) not null,
Address varchar(30),
Email varchar(30),
Phone varchar(10),
Business varchar(20) not null
constraint unqemail unique(email)
)

sp_help Clients

create table Departments
(
Deptno int primary key,
Dname varchar(15) not null,
Loc varchar(20)
)

/*
alter table Departments
drop column Loc

alter table Departments
add Loc varchar(20)
*/

sp_help Departments

create table Employees
(
Empno int primary key,
Ename varchar(20) not null,
Job varchar(15),
Salary int,
Deptno int references Departments(Deptno), -- Foreign key
constraint salarychk check(Salary > 0)
)

sp_help Employees

create table Projects
(
Project_ID int primary key,
Descr varchar(30) not null,
Start_Date date,
Planned_End_Date date,
Actual_End_Date date,
Budget int,
Client_ID int references Clients(client_id), -- Foreign key
constraint endDataCheck check(Actual_End_Date > Planned_End_Date),
constraint budgetchk check(Budget>0)
)

sp_help Projects

create table EmpProjectTasks
(
Project_ID int references Projects(Project_ID), -- Foreign key
Empno int references Employees(Empno), -- Foreign key
Start_Date date,
End_Date date,
Task varchar(25) not null,
status varchar(15) not null,

primary key(Project_ID,Empno)
)

sp_help EmpProjectTasks






------------------------------------------------------------------------------------------------------------------------------------------------------------------

insert into Clients values(1001,'ACME Utilities', 'Noida','email@acmeutil.com',9567880031,'Manufacturing')

insert into Clients values(1002, 'Trackon consultants', 'Mumbai', 'email@trackon.com', 8734210090, 'Consultant'),
							(1003, 'Money Saver dist', 'Kolkata', 'email@moneysaver.com', 7799886655, 'Reseller'),
							 (1004, 'lawful corp ', 'chennai', 'email@lawful.com', 9210342219, 'Professional')

select * from Clients

insert into Departments values(10, 'Design', 'Pune')

insert into Departments values(20, 'Development', 'Pune'),
								(30, 'Testing', 'Mumbai'),
								  (40, 'Document', 'Mumbai')

select * from Departments

insert into Employees values(6000, 'Emp1', 'Analyst' , 0, 10)
insert into Employees values(6000, 'Emp1', 'Analyst' , -1, 10)

insert into Employees values(7001, 'Emp1', 'Analyst' , 25000, 10)

insert into Employees values(7002, 'Emp2', 'Designer' , 30000, 10),
							(7003, 'Emp3', 'Developer' , 40000, 20),
							(7004, 'Emp4', 'Developer' , 40000, 20),
							(7005, 'Emp5', 'Designer' , 35000, 10),
							(7006, 'Emp6', 'Tester' , 30000, 30),
							(7007, 'Emp7', 'Tech writer' , 30000, 40),
							(7008, 'Emp8', 'Tester' , 35000, 30),
							(7009, 'Emp9', 'Developer' , 45000, 20),
							(7010, 'Emp10', 'Analyst' , 20000, 10),
							(7011, 'Emp11', 'Project Mgr' , 65000, 10)

select * from Employees

insert into Projects values(401, 'Inventory', '2011/04/01', '2011/10/01', '2011/10/31', 150000, 1001)

insert into Projects values(402, 'Accounting', '2011/08/01', '2012/01/01', null, 500000, 1002),
							(403, 'Payroll', '2011/10/01', '2011/12/31', null, 75000, 1003),
							 (404, 'Contact Mgmt', '2011/11/01', '2011/12/31', null, 50000, 1004)

/*
delete from Projects where Project_ID=402
*/

select * from Projects

insert into EmpProjectTasks values(401, 7001, '2011-04-01', '2011-04-20', 'Sydt anlyst', 'Completed')

insert into EmpProjectTasks values(401, 7002, '2011-04-21', '2011-05-30', 'Syst design', 'Completed'),
									(401, 7003, '2011-06-01', '2011-07-15', 'Coding', 'Completed'),
									(401, 7004, '2011-07-18', '2011-09-01', 'Coding', 'Completed'),
									(401, 7006, '2011-09-03', '2011-09-15', 'Testing', 'Completed'),
									(401, 7009, '2011-09-18', '2011-10-05', 'Code challehnge', 'Completed'),
									(401, 7008, '2011-10-06', '2011-10-16', 'Testing', 'Completed'),
									(401, 7007, '2011-10-06', '2011-10-22', 'Documentation', 'Completed'),
									(401, 7011, '2011-10-22', '2011-10-31', 'Sign off', 'Completed'),
									(402, 7010, '2011-08-01', '2011-08-20', 'System analysis', 'Completed'),
									(402, 7002, '2011-08-22', '2011-09-30', 'System Design', 'Completed'),
									(402, 7004, '2011-10-01', null, 'Coding', 'In Progress')

select * from EmpProjectTasks