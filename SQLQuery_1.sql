--loome db
create database TARge23SQL

-- db valimine
use TARge23SQL

--db kustutamine
drop database TARge23SQL

-- tabeli loomine
create table Gender
(
Id int not null primary key,
Gender nvarchar(10) not null
)

--andmete sisestamine
insert into Gender (Id, Gender)
values (1, 'Male'),
(2, 'Female'),
(3, 'Unknown')

-- vaatame tabeli sisu
select * from Gender

--loome uue tabeli
create table Person
(
Id int not null primary key,
Name nvarchar(30),
Email nvarchar(30),
GenderId int
)

--andmete sisestamine
insert into Person (Id, Name, Email, GenderId) values
(1, 'Superman', 's@s.com', 1),
(2, 'Wonderwoman', 'w@w.com', 2),
(3, 'Batman', 'b@b.com', 1),
(4, 'Aquaman', 'a@a.com', 1),
(5, 'Catwoman', 'c@c.com', 2),
(6, 'Antman', 'ant"ant.com', 1),
(7, NULL, NULL, 3)

--vaadake Person tabeli andmeid
select * from Person

-- võõrvõtme ühenduse loomine kahe tabeli vahel
alter table Person add constraint tblPerson_GenderId_FK
foreign key (GenderId) references Gender(Id)

--kui sisestad uue rea andmeid ja ei ole sisestanud GenderId-d
--alla väärtust, siis see automaatselt sisestab sellele reale
--väärtuse 3 e unknown
alter table Person
add constraint DF_persons_GenderId
default 3 for GenderId

--sisestame andmed
--
insert into Person (Id, Name, Email)
values (9, 'Ironman', 'i@i.com')

select * from Person

--lisame uue veeru
alter table Person
add Age nvarchar(10)

-- lisame nr piirangu vanuse sisestamisel
alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 155)

-- sisestame uue rea andmeid
insert into Person (Id, Name, Email, GenderId, Age)
values (10, 'Kalevipoeg', 'k@k.com', 1, 30)

--muudame koodiga andmeid
update Person
set Age = 35
where Id = 9

select * from Person

--sisestame muutuja City nvarchar(50)
alter table Person
add City nvarchar(50)

--sisestame City veergu andmeid
update Person
set City = 'Kaljuvald'
where Id = 10

select * from Person

-- k]ik, kes elavad Gothami linnas
select * from Person where City = 'Gotham'
--k]ik, kes ei ela Gothamis
select * from Person where City <> 'Gotham'
--k]ik, kes ei ela Gothamis
select * from Person where City != 'Gotham'

-- n'itab teatud vanusega inimesi
select * from Person where Age = 120 or Age = 50 or Age = 19
select * from Person where Age in (120, 50, 19)

-- n'itab teatud vanusevahemikus olevaid inimesi
-- ka 22 ja 31 aastaseid
select * from Person where Age between 22 and 31

-- wildcard e n'itab k]ik n-t'hega linnad
-- n-t'hega algavad linnad
select * from Person where City like 'n%'
--k]ik emailid, kus on @-m'rk sees
select * from Person where Email like '%@%'

-- n'itab Emaile, kus ei ole @-m'rki sees
select * from Person where Email not like '%@%'

--n'itab, kellel on emailis ees ja peale @-m'rki ainult [ks t'ht
select * from Person where Email like '_@_.com'

update Person
set Email = 'bat@bat.com'
where Id = 3

-- k]ik, kellel nimes ei ole esimene t'ht W, A, C
select * from Person where name like '[^WAC]%'
select * from Person

--kes elavad Gothamis ja New York-s
select * from Person where (City = 'Gotham' or City = 'New York')

-- k]ik, kes elavad v'lja toodud linnades ja on vanemad, kui
-- 29
select * from Person where (City = 'Gotham' or City = 'New York')
and Age >= 30

-- kuvab t'hestikulises j'rjekorras inimesi ja v]tab 
-- aluseks nime
select * from Person order by Name
-- kuvab vastupidises j'rjestuses
select * from Person order by Name desc

--v]tab kolm esimest rida
select top 3 * from Person

-- kolm esimest, aga tabeli j'rjestus on Age ja siis Name
select * from Person
select top 3 Age, Name from Person

-- n'ita esimene 50% tabeli sisust
select top 50 percent * from Person

--j'rjestab vanuse j'rgi isikud
select * from Person order by cast(Age as int)

--koikide isikute koondvanus
SELECT SUM(CAST(Age as int)) from Person

--kuvab koige nooremat
SELECT MIN(cast(Age as int)) from Person

--kuvab koige nooremat
SELECT MAX(cast(Age as int)) from Person

--naeme konkreetsetes linnades olevate isikute koondvanust
SELECT City, SUM(CAST(Age as int)) as TotalAge from Person group by City

-- kuidas saab koodiga muuta andmetyypi ja selle pikkust
alter table Person 
alter column Age int

select MAX(Age) from Person

--kuvab esimeses reas valja toodud jarjestises ja muudab Age-i TotalAge-ks
--jarjestab City's olevad nimede jargi ja siis GenderID jargi

SELECT City, GenderId, SUM(Age) as TotalAge from Person
group by City, GenderId
order by City

INSERT into Person VALUES
(11, 'Robin', 'robin@r.com', 1, 29, 'Gotham')

--naitab ridade arvu tabelis
SELECT COUNT(*) from Person
SELECT * from Person

--naitab tulemust, et mitu inimest on GenderId vaartusega 2 konkreetses linnas
--arvutab vanuse kokku selles linnas
SELECT genderId, City, SUM(Age) as TotalAge, COUNT(Id) as [Total Person(s)]
from Person
where GenderId = '2'
GROUP by GenderId, City

SELECT genderId, City, SUM(Age) as TotalAge, COUNT(Id) as [Total Person(s)]
from Person
where GenderId = '1'
GROUP by GenderId, City

--naitab ara, inimeste koondvanuse, mis on yle 41 a ja kui palju neid igas linnas elab
--eristab soo
SELECT GenderId, City, SUM(Age) as TotalAge, COUNT(Id)
as [Total Person(s)]
FROM Person
GROUP BY GenderId, City having SUM(Age) > 41

--loome tabelid Empoyees ja Department

-- tabeli loomine
create table Department
(
Id int not null primary key,
DeparmentName nvarchar(50),
Location nvarchar(50),
DeparmentHead NVARCHAR(50)
)

create table Employees
(
Id int not null primary key,
Name nvarchar(50),
Gender nvarchar(50),
Salary NVARCHAR(50),
Departmendid INT
)

--andmete sisestamine
insert into Department (Id, DeparmentName, Location, DeparmentHead)
values (1, 'IT', 'London', 'Rick'),
(2, 'Payroll', 'Delhi', 'Ron'),
(3, 'HR', 'New York', 'Christie'),
(4, 'Other Department', 'Sydney', 'Cindrella')

insert into Employees (Id, Name, Gender, Salary, Departmendid)
values (1, 'Tom', 'Male', '4000', 1),
(2, 'Pam', 'Female', '3000', 3),
(3, 'John', 'Male', '3500', 1),
(4, 'Sam', 'Male', '4500', 2),
(5, 'Todd', 'Male', '2800', 2),
(6, 'Ben', 'Male', '7000', 1),
(7, 'Sara', 'Female', '4800', 3),
(8, 'Valarie', 'Female', '5500', 1),
(9, 'James', 'Male', '6500', null),
(10, 'Russell', 'Male', '8800', null)


--left join
SELECT Name, Gender, Salary, DeparmentName 
from Employees
LEFT JOIN Department
on Employees.Departmendid = Department.Id

--arvutab koikide palgad kokku Employees tabelis
SELECT SUM(CAST(Salary as int)) FROM Employees

--min palga saaja
SELECT MIN(CAST(Salary as int)) FROM Employees

--yhe kuu palga saaja linnade loikes
SELECT Location, SUM(CAST(Salary as int)) as TotalSalary
FROM Employees 
left join Department
on Employees.Departmendid = Department.Id
group by Location

--Lisa tabelile veerg
alter TABLE Employees
add City NVARCHAR(30)

--Lisa veergu andmeid
update Employees
set City = 'New York'
where Id = 10


select * from Employees
SELECT * from Department

--naitab erinevust palgafondi osas nii linnade kui ka soo osas
SELECT City, Gender, SUM(CAST(Salary as int)) as TotalSalary from Employees
GROUP BY City, Gender
--Sama nagu eelmine, aga linnad on tahestikulises jarjestuses 
SELECT City, Gender, SUM(CAST(Salary as int)) as TotalSalary from Employees
GROUP BY City, Gender
ORDER by City --desk (jarjestab tagurpidi order lopus)

--loeb ara ridade arvu tabelis
SELECT COUNT(*) FROM Employees

--mitu tootajat on soo ja linna kaupa
SELECT Gender, City,
COUNT (Id) as [Total Employee(s)]
FROM Employees
GROUP by Gender, City

--kuvab ainult naised linnade kaupa
SELECT Gender, City,
COUNT (Id) as [Total Employee(s)]
FROM Employees
where Gender = 'Female'
GROUP by Gender, City

--kuvab mehed linnade kaupa
--kasuta having
SELECT Gender, City,
COUNT (Id) as [Total Employee(s)]
FROM Employees
GROUP by Gender, City
HAVING Gender = 'Male'

SELECT * FROM Employees where SUM(CAST(Salary as int)) > 4000

select Gender, City, SUM(CAST(Salary as int)) as TotalSalary, count (Id)
as [Total Employee(s)]
from Employees GROUP BY Gender, City
HAVING SUM(cast(Salary as int)) > 4000

--loome tabeli, millest hakatakse automaatselt nummerdama Id-d
CREATE table Test1
(
    Id int IDENTITY(1,1),
    Value NVARCHAR(20)
)

INSERT into Test1 VALUES('x')
select * from Test1