create database Assignment_3_db

use Assignment_3_db

create table Dept
(
deptno int primary key,
dname varchar(20),
loc varchar(20)
)

create table Emp
(
empno int primary key,
ename varchar(25),
job varchar(25),
mgr_id int,
hiredate date,
sal int,
comm int,
deptno int references Dept(deptno)
)

insert into Dept values(10,'Accounting','New york')

insert into Dept values(20,'Research','Dallas'), (30,'Sales','Chicago'), (40,'Operations','Boston')

select * from Dept

insert into Emp values(7369,'Smith','Clerk','7902','1980-12-17',800,null,20)

insert into Emp values(7499,'Allen','Salesman','7698','1981-02-20',1600,300,30),
						(7521,'Ward','Salesman','7698','1981-02-22',1250,500,30),
						(7566,'Jones','Manager','7839','1981-04-02',2975,null,20),
						(7654,'Martin','Salesman','7698','1981-09-28',1250,1400,30),
						(7698,'Blake','Manager','7839','1981-05-01',2850,null,30),
						(7782,'Clark','Manager','7839','1981-06-09',2450,null,10),
						(7788,'Scott','Analyst','7566','1987-04-19',3000,null,20),
						(7839,'king','President',null,'1981-11-17',5000,null,10),
						(7844,'turner','Salesman','7698','1981-09-08',1500,0,30),
						(7876,'Adams','Clerk','7788','1981-05-23',1100,null,20),
						(7900,'James','Clerk','7698','1981-12-03',950,null,30),
						(7902,'Ford','Analyst','7566','1981-12-03',3000,null,20),
						(7934,'Miller','Clerk','7782','1982-01-23',1300,null,10)

select * from Emp

--------------------------------------------------	SET-2	-----------------------------------------------------------------------------------------

--1) Retrieve a list of MANAGERS
select * from Emp where job='manager'

--2) Find out the names and salaries of all employees earning more than 1000 per month
select ename,sal from Emp where sal > 1000

--3) Display the names and salaries of all employees except JAMES
select ename,sal from Emp where ename <> 'james'

--4) Find out the details of employees whose names begin with ‘S’
select * from Emp where ename like 'S%'

--5) Find out the names of all employees that have ‘A’ anywhere in their name
select * from Emp where ename like '%A%'

--6) Find out the names of all employees that have ‘L’ as their third character in their name
select * from Emp where ename like '___L%'

--7) Compute daily salary of JONES
select ename, sal / 30 'Daily salary' from Emp where ename='jones'

--8) Calculate the total monthly salary of all employees
select sum(sal) as 'Total monthly salary' from Emp

--9) Print the average annual salary
select (sum(sal) * 12) / count(empno) as 'Average Annual Salary' from emp

--10) Select the name, job, salary, department number of all employees except SALESMAN from department number 30
select ename,job,sal,deptno from Emp where empno not in (select empno from emp where deptno=30 and job='salesman')

--11) List unique departments of the EMP table
select deptno,dname from Dept where deptno in (select distinct(deptno) from Emp)

--12) List the name and salary of employees who earn more than 1500 and are in department 10 or 30. Label the columns Employee and Monthly Salary respectively
select empno,ename, sal from emp where empno in (select empno from emp where sal>1500) and empno in (select empno from Emp where deptno=10 or deptno=30)

--13) Display the name, job, and salary of all the employees whose job is MANAGER or ANALYST and their salary is not equal to 1000, 3000, or 5000
select ename,job, sal from Emp where job in ('Manager', 'Analyst') and sal not in (1000, 3000, 5000)

--14) Display the name, salary and commission for all employees whose commission amount is greater than their salary increased by 10%.
select ename,sal, comm from Emp where comm > (sal + sal * 0.1)

--15) Display the name of all employees who have two Ls in their name and are in department 30 or their manager is 7782
select ename from Emp where ename like '%L%L%' and (deptno=30 or mgr_id=7782)

--16) Display the names of employees with experience of over 10 years and under 20 yrs.Count the total number of employees
/*
select ename from Emp where DATEDIFF(YEAR, hiredate, GETDATE()) between 10 and 20
*/

select count(ename) as 'no of employees(experience b/w 10 and 20)' from Emp
where ename in (select ename from Emp where DATEDIFF(YEAR, hiredate, GETDATE()) between 10 and 20)

--17) Retrieve the names of departments in ascending order and their employees in descending order
select dpt.dname, e.ename from Emp as e right outer join Dept as dpt 
on e.deptno=dpt.deptno
order by dpt.dname, e.ename desc

--18) Find out experience of MILLER
select empno, ename, DATEDIFF(YEAR, hiredate, GETDATE()) as 'Experience(Years)' from Emp where ename='Miller'
