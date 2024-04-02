select * from SalesLT.Address
select * from SalesLT.Customer
select * from SalesLT.CustomerAddress
select * from SalesLT.Product
select * from SalesLT.ProductCategory
select * from SalesLT.ProductDescription
select * from SalesLT.ProductModel
select * from SalesLT.ProductModelProductDescription
select * from SalesLT.SalesOrderDetail
select * from SalesLT.SalesOrderHeader

SELECT OrderQty, UnitPrice, LineTotal, Name
from SalesLT.SalesOrderDetail
left join SalesLT.Product
on SalesLT.SalesOrderDetail.ProductID = SalesLT.Product.ProductID

SELECT OrderQty, UnitPrice, LineTotal, Name
from SalesLT.SalesOrderDetail
RIGHT join SalesLT.Product
on SalesLT.SalesOrderDetail.ProductID = SalesLT.Product.ProductID

SELECT OrderQty, UnitPrice, LineTotal, Name
from SalesLT.SalesOrderDetail
INNER join SalesLT.Product
on SalesLT.SalesOrderDetail.ProductID = SalesLT.Product.ProductID

SELECT OrderQty, UnitPrice, LineTotal, Name
from SalesLT.SalesOrderDetail
full outer join SalesLT.Product
on SalesLT.SalesOrderDetail.ProductID = SalesLT.Product.ProductID

SELECT OrderQty, UnitPrice, LineTotal, Name
from SalesLT.SalesOrderDetail
cross join SalesLT.Product

create table MyTabel
    (Id int IDENTITY(1,1),
    FirstName nvarchar(30),
    Lastname nvarchar(30),
    Email nvarchar(30),
    Gender nvarchar(30),
    Phone int,
    Age int)

INSERT into MyTabel (FirstName, Lastname, Email, Gender, Phone, Age) VALUES
('Minni', 'Paju','minni@minni.ee', 'naine', 1234, 50),
('Kalle', 'Tamm','kalle@tamm.ee', 'mees', 1234, 20),
('Liina', 'Kask','liina@kask.ee', 'naine', 1234, 38),
('Leida', 'Kuusk','leida@kuusk.ee', 'naine', 1234, 40),
('Miina', 'Mänd','miina@mand.ee', 'naine', 1234, 71),
('Mai', 'Kadakas','mai@kadakas.ee', 'naine', 1234, 68),
('Lembit', 'Palm','lembit@palm.ee', 'mees', 1234, 23),
('Herbert', 'Okas','herbert@okas.ee', 'mees', 1234, 37),
('Endel', 'Mets','endel@mets.ee', 'mees', 1234, 35),
('Ellen', 'Meri','ellen@meri.ee', 'naine', 1234, 47)

SELECT * from MyTabel
