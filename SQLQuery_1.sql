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

--rida 303
ALTER TABLE Employees
DROP COLUMN City

--inner join
--kuvab neid, kellel on DepartmentName all vaartus
SELECT Name, Gender, Salary, DeparmentName
from Employees
inner join Department
on Employees.Departmendid = Department.Id

SELECT * from Employees
SELECT * from Department

--left join
--kuidas saada koik andmed Employeest katte
select Name, Gender, Salary, DeparmentName
from Employees
left join Department
on Employees.Departmendid = department.Id

SELECT * from Employees
SELECT * from Department

--right join
--kuidas saada DepartmentName alla uus nimetus
select Name, Gender, Salary, DeparmentName
from Employees
right join Department --voi kasutada ka RIGHT OUTER JOIN
on Employees.Departmendid = department.Id

-- kuidas saada koikide tabelite vaartused yhte paringusse
select Name, Gender, Salary, DeparmentName
from Employees
full outer join Department
on Employees.Departmendid = department.Id

--cross join votab kaks allpool olevat tabelit kokku
--ja korrutab need omavahel labi
--koikide kombinatsioonide genereerimiseks
select Name, Gender, Salary, DeparmentName
from Employees
cross join Department

--paringu sisu
select ColumnList
from LeftTable
joinType RightTable
on JoinCondition

--kuidas kuvada ainult need isikud, kellel on DepartmentName NULL
select Name, Gender, Salary, DeparmentName
from Employees
left join Department
on Employees.Departmendid = department.Id
where Employees.Departmendid is null

--teine variant
select Name, Gender, Salary, DeparmentName
from Employees
left join Department
on Employees.Departmendid = department.Id
where Department.Id is null

--full join
--molema tabeli mitte-kattuvate vaartustega read kuvab valja
select Name, Gender, Salary, DeparmentName
from Employees
full join Department
on Employees.Departmendid = department.Id
where Employees.Departmendid is null
or Department.Id is null

--kuidas saame Department tabelis oleva rea, kus on NULL
select Name, Gender, Salary, DeparmentName
from Employees
right join Department
on Employees.Departmendid = department.Id
where Employees.Departmendid is null

--kuidas muuta tabeli nime, alguses vana tabeli nimi ja siis uue nimi
sp_rename 'Department1','Department'

-- kasutame Employees tabeli asemel lyhendit E
-- ja Departmendi puhul D
SELECT E.Name as EmpName, D.DeparmentName as DeptName
from Employees E
left join Department D
on E.Departmendid = D.Id

--inner join
-- kuvab ainult isikuid, kellel on DeptId vaartused 
SELECT E.Name as EmpName, D.DeparmentName as DeptName
from Employees E
inner join Department D
on E.Departmendid = D.Id

-- cross join
SELECT E.Name as EmpName, D.DeparmentName as DeptName
from Employees E
cross join Department D

--
select isnull('Pia', 'No Manager') as manager

-- NULL asemel kuvab No Manager
select coalesce(NULL, 'No Manager') as manager

-- kui Expression on oige, siis paneb vaartuse, mida soovid
-- voi mone teise vaartuse

--
alter TABLE Employees
add  ManagerId int

SELECT * from Employees
SELECT * from Department

-- neil, kellel ei ole ylemust, siis paneb neile No Manager teksti
SELECT E.Name as Employee, isnull(M.Name,'No Manager') as manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

-- teeme paringu, kus kasutame case-i
SELECT E.Name as Employee, case when M.Name is null then 'No Manager'
else M.Name end as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

-- lisame tabelisse uued veerud
alter table Employees
add MiddleName nvarchar(30),
LastName nvarchar(30)

SELECT * from Employees
SELECT * from Department

sp_rename 'Employees.Name', 'FirstName'

sp_rename 'Employees.Departmendid', 'DepartmentId'
SELECT * from Employees
SELECT * from Department

insert into Employees (Id, MiddleName, LastName)
values (1, 'Nick', 'Jones')

update Employees
set MiddleName = 'Nick'
where Id = 1

update Employees
set LastName = 'Jones'
where Id = 1

SELECT * from Employees

update Employees
set LastName = 'Anderson'
where Id = 2

update Employees
set LastName = 'Smith'
where Id = 4

update Employees
set FirstName = null
where Id = 5

update Employees
set MiddleName = 'Todd'
where Id = 5

update Employees
set LastName = 'Someone'
where Id = 5

SELECT * from Employees

update Employees
set MiddleName = 'Ten'
where Id = 6

update Employees
set LastName = 'Sven'
where Id = 6

SELECT * from Employees

update Employees
set LastName = 'Connor'
where Id = 7

SELECT * from Employees

update Employees
set MiddleName = 'Balerine'
where Id = 8

SELECT * from Employees

update Employees
set MiddleName = '007'
where Id = 9

update Employees
set LastName = 'Bond'
where Id = 9

SELECT * from Employees

update Employees
set FirstName = null
where Id = 10

update Employees
set LastName = 'Crowe'
where Id = 10

SELECT * from Employees

-- igast reast votab esimesena taidetud lahtri ja kuvab ainult seda
SELECT Id, coalesce(FirstName, MiddleName, LastName) as NAME
FROM Employees

--loome kaks tabelit
CREATE TABLE IndianCustomers
(
    Id INT identity(1,1),
    Name NVARCHAR(25),
    Email NVARCHAR(25)
)

CREATE TABLE UKCustomers
(
    Id INT identity(1,1),
    Name NVARCHAR(25),
    Email NVARCHAR(25)
)

insert into IndianCustomers (Name, Email)
VALUES ('Raj', 'R@R.com'),
('Sam', 'S@S.com')

insert into UKCustomers (Name, Email)
VALUES ('Ben', 'B@B.com'),
('Sam', 'S@S.com')

select * from IndianCustomers
SELECT * FROM UKCustomers

-- kasutame union all, mis naitab koiki ridu
SELECT Id, Name, Email FROM IndianCustomers
union ALL
SELECT Id, Name, Email from UKCustomers

-- union - korduvate vaartustega ridu ei korrata
SELECT Id, Name, Email FROM IndianCustomers
union
SELECT Id, Name, Email from UKCustomers

-- kuidas sorteerida nime jargi
SELECT Id, Name, Email FROM IndianCustomers
union
SELECT Id, Name, Email from UKCustomers
ORDER by Name

-- stored procedure
CREATE PROCEDURE spGetEmployees
as BEGIN
    select FirstName, Gender from Employees
END

-- nyyd saab kasutada selle nimelist sp-d 
-- saab kutsuda kolmel viisil
spGetEmployees
exec spGetEmployees
execute spGetEmployees

---
create PROC spGetEmployeesByGenderAndDepartment
@Gender NVARCHAR(20),
@DepartmentId INT
as BEGIN
    SELECT FirstName, Gender, DepartmentId from Employees WHERE Gender = @Gender
    and DepartmentId = @DepartmentId
END

-- kui nyyd allolevat kasklust kaima panna, siis nouab Gender parameetrit
spGetEmployeesByGenderAndDepartment

--oige variant
spGetEmployeesByGenderAndDepartment 'Male', 1

--nii saab parameetrite jarjestusest mooda minna
spGetEmployeesByGenderAndDepartment @DepartmentId = 1, @Gender = 'Male'

--saab sp sisu vaadata result vaates
sp_helptext spGetEmployeesByGenderAndDepartment

-- muuda sp-d ja pane voti peale,
-- et keegi teine peale teie ei saaks muuta
ALTER PROC spGetEmployeesByGenderAndDepartment
@Gender NVARCHAR(20),
@DepartmentId INT
--WITH encryption
as BEGIN
    SELECT FirstName, Gender, DepartmentId from Employees WHERE Gender = @Gender
    and DepartmentId = @DepartmentId
END

---

create PROC spGetEmployeeCountByGender
@Gender NVARCHAR(20),
@EmployeeCount int OUTPUT
as BEGIN
    select @EmployeeCount = COUNT(Id) from Employees where Gender = @Gender
END

--annab tulemuse, kus loendab ara nouetele vastavad read
--prindib ka tulemuse kirja teel
DECLARE @TotalCount INT
EXECUTE spGetEmployeeCountByGender 'Male', @TotalCount out
IF(@TotalCount = 0)
    print '@TotalCount is null'
ELSE
    PRINT '@TotalCount is not null'
PRINT @TotalCount
GO -- tee ylevalpool ara ja siis mine edasi
SELECT * from Employees

-- naitab ara, et mitu rida vastab n6uetele
DECLARE @TotalCount INT
EXECUTE spGetEmployeeCountByGender @EmployeeCount = @TotalCount out, @Gender = 'Male'
print @TotalCount

-- sp sisu vaatamine
sp_help spGetEmployeeCountByGender

-- tabeli info
sp_help Person

-- kui soovid naha sp teksti
sp_helptext spGetEmployeeCountByGender

-- millest s6ltub sp
sp_depends spGetEmployeeCountByGender
--vaatame tabeli s6ltuvust
sp_depends Employees

--sp tegemine
Create PROC spGetNameById
@Id int,
@Name NVARCHAR(20) OUTPUT
as BEGIN
    SELECT @Name = Id, @Name = FirstName from Employees
END

ALTER PROC spGetNameById
@Id int,
@Name NVARCHAR(20) OUTPUT
as BEGIN
    SELECT @Id = Id, @Name = FirstName from Employees
END

-- annab kogu tabeli ridade arvu
CREATE PROC spTotalCount2
@TotalCount INT OUTPUT
as BEGIN
    SELECT @TotalCount = COUNT(Id) from Employees
end

--saame teada, mitu rida on tabelis
DECLARE @TotalEmployees INT
EXECUTE spTotalCount2 @TotalEmployees output
SELECT @TotalEmployees

--mis id all on keegi nime jargi
Create PROC spGetNameById1
@Id int,
@FirstName NVARCHAR(50) OUTPUT
as BEGIN
    SELECT @FirstName = FirstName from Employees WHERE Id = @Id
END

--annab tulemuse, kus Id esimesel real on keegi koos nimega
DECLARE @FirstName NVARCHAR(50)
EXECUTE spGetNameById1 1, @FirstName output
PRINT 'Name of the employee = ' + @FirstName

---
DECLARE @FirstName NVARCHAR(20)
EXECUTE spGetNameById 1, @FirstName out
PRINT 'Name = ' + @FirstName

sp_help spGetNameById

--
CREATE PROC spGetNameById2
@Id INT
as BEGIN
    return(select FirstName from Employees where Id = @Id)
end

--kutsuda declare abil valja spGetNameBy2
-- ja oelda, et miks see ei toota
DECLARE @EmployeeName NVARCHAR(50)
EXECUTE @EmployeeName = spGetNameById2 1
PRINT 'Name of the employee = ' + @EmployeeName

-- sisseehitatud string funktsioonid

-- see konverteerib ascii tahe vaartuse numbriks
SELECT ascii('a')

-- kuvab A-tahte
SELECT CHAR(65)

--prindime kogu tahestiku valja
DECLARE @Start INT
SET @Start = 65
WHILE (@Start <= 255)
BEGIN
    SELECT CHAR(@Start)
    SET @Start = @Start +1
END

-- eemaldame tyhjad kohad sulgudes
SELECT LTRIM('       Hello')

-- tyhikute eemaldamine veerust
select LTRIM(FirstName) as FirstName, MiddleName, Lastname from Employees

select * from Employees

--- parempoolne trim (eemaldab tyhikud paremalt)
SELECT RTRIM('   Hello                          ')

select RTRIM(FirstName) as FirstName, MiddleName, Lastname from Employees
select * from Employees

--- keerab kooloni sees olevad andmed vastupidiseks
--- vastavalt upper ja lower-ga saan muuta markide suurust
--- reverse funktsioon poorab koik ymber
SELECT REVERSE(UPPER(LTRIM(FirstName))) as FirstName, MiddleName, lower(LastName),
RTRIM(LTRIM(FirstName)) + ' ' + MiddleName + ' ' + Lastname as FullName
FROM Employees

--- naeb, mitu tahte on sonal ja loeb tyhikud sisse
SELECT FirstName, LEN(FirstName) as [Total Characters] FROM Employees

--- naeb, mitu tahte on sonal ja ei ole tyhikuid
SELECT FirstName, LEN(TRIM(FirstName)) as [Total Characters] from Employees

--- left, right, substring
SELECT LEFT('abcdef', 4)
SELECT RIGHT('abcdef', 4)

-- kuvab @-margi asetust
SELECT CHARINDEX('@', 'sara@aaa.com')

--- esimene nr peale komakohta naitab, et mitmendast alustab ja teine mitut peale seda kuvab
SELECT SUBSTRING('pam@bbb.com', 7, 2)

--- @-margist kuvab 3 tahemarki. Viimase numbriga saab maarata pikkust
SELECT SUBSTRING('pam@bbb.com', CHARINDEX('@', 'pam@bbb.com') + 2, LEN('pam@bbb.com') - CHARINDEX('@', 'pam@bbb.com'))

--- saame teada domeeni nimed e-mailides
SELECT SUBSTRING(Email, CHARINDEX('@', Email) + 1, LEN(Email) - CHARINDEX('@', Email)) as EmailDomain
from Person

ALTER TABLE Employees
add Email NVARCHAR(20)


update Employees
set Email = 'Sam@aaa.com'
where Id = 1

update Employees
set Email = 'Ram@aaa.com'
where Id = 2

update Employees
set Email = 'Sara@ccc.com'
where Id = 3

update Employees
set Email = 'Todd@bbb.com'
where Id = 4

update Employees
set Email = 'John@aaa.com'
where Id = 5

update Employees
set Email = 'Sana@ccc.com'
where Id = 6

update Employees
set Email = 'James@bbb.com'
where Id = 7

update Employees
set Email = 'Rob@ccc.com'
where Id = 8

update Employees
set Email = 'Steve@aaa.com'
where Id = 9

update Employees
set Email = 'Pam@bbb.com'
where Id = 10

select * from Employees

SELECT SUBSTRING(Email, CHARINDEX('@', Email) + 1, LEN(Email) - CHARINDEX('@', Email)) as EmailDomain
from Employees

---lisame *-margi alates teatud kohast
SELECT FirstName, LastName,
    SUBSTRING(Email, 1, 2) + REPLICATE('*', 5) + ---peale teist tahemarki paneb 5 tarni
    SUBSTRING(Email, CHARINDEX('@', Email), LEN(Email) - CHARINDEX('@', Email) + 1) as Email
from Employees

--- replicate
SELECT REPLICATE('asd', 3)

---kuidas sisestada tyhikut
SELECT SPACE(5)

---tyhikute arv kahe nime vahel
SELECT FirstName + SPACE(25) + LastName as FullName
FROM Employees

---PATINDEX
---sama, mis charindex aga dynaamilisem ja saab kasutada wildcardi (%)
SELECT Email, PATINDEX('%@aaa.com', Email) as FirstOccurence
FROM Employees
where PATINDEX('%@aaa.com', Email) > 0

--- koik .com-d asendatakse .net-ga
SELECT Email, REPLACE(Email, '.com', '.net') as ConvertedEmail
from Employees

--- asendame peale esimest m'rki kolm tahte viie tarniga
SELECT FirstName, LastName, Email,
    STUFF(Email, 2, 3, '*****') as StuffedEmail
    from Employees
