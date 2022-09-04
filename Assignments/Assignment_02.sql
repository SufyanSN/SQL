create database Assignment_2_db

use Assignment_2_db

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


---------------------------------------------------------	SET-1	-------------------------------------------------------------------

-- 1) List all employees whose name begins with 'A'
select * from Emp where ename like 'A%'

-- 2) Select all those employees who don't have a manager
select * from Emp where mgr_id is null

--3) List employee name, number and salary for those employees who earn in the range 1200 to 1400
select ename, empno, sal from Emp where sal between 1200 and 1400

--4) Give all the employees in the RESEARCH department a 10% pay rise. Verify that this has been done by listing all their details before and after the rise
select empno,ename,sal 'Old salary',sal + sal*0.1 'Hiked salary' from Emp where deptno=(select deptno from Dept where dname='research')

--5) Find the number of CLERKS employed. Give it a descriptive heading
select job 'No of clerks',count(job) from Emp group by job having job='clerk'

--6) Find the average salary for each job type and the number of people employed in each job
select job,avg(sal) as 'Avg salary',count(empno) 'No of people employed' from Emp group by job

--7) List the employees with the lowest and highest salary
/*
select min(sal) from Emp
select max(sal) from Emp
*/

select empno,ename from Emp where sal=
									(select min(sal) from Emp)
							or 
								sal=
									(select max(sal) from Emp)

--8) List full details of departments that don't have any employees
select dpt.* from Dept as dpt where dpt.deptno not in(select distinct(deptno) from Emp)

--9) Get the names and salaries of all the analysts earning more than 1200 who are based in department 20. Sort the answer by ascending order of name
select ename,sal,job from Emp where job='Analyst' and sal>1200 and deptno=20

--10) For each department, list its name and number together with the total salary paid to employees in that department
select Dept.deptno, Dept.dname ,SUM(sal) 'Total salary paid' from Emp right outer join Dept
on Emp.deptno=Dept.deptno
group by Dept.deptno, Dept.dname


--11) Find out salary of both MILLER and SMITH
select ename, sal from Emp where ename='Miller' or ename='Smith'

--12) Find out the names of the employees whose name begin with ‘A’ or ‘M’
select * from Emp where ename like '[AM]%'

		-- OR
select * from Emp where ename like 'A%' or ename like 'M%'

--13) Compute yearly salary of SMITH
select ename,sal * 12 as 'Yearly salary' from Emp where ename='Smith'

--14) List the name and salary for all employees whose salary is not in the range of 1500 and 2850
select ename,sal from Emp where sal not between 1500 and 2050


