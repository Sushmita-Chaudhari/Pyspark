--inline view= from subquery is inline view
--one to many=sub query in sub query so use join
use AdventureWorks2022;

--find all records from production ,production control,excutive
--and having birthdate more than 1970
--display first name,address, job title,epartment

select d.Name,e.businessentityid,e.birthdate,
(select firstname from Person.Person p
where p.BusinessEntityID=e.BusinessEntityID) Firstname
from HumanResources.Employee e,
	HumanResources.Department d,
	HumanResources.EmployeeDepartmentHistory ed
where e.BusinessEntityID=ed.BusinessEntityID
and d.DepartmentID=ed.DepartmentID
and BirthDate>='01-01-1970'
and d.Name in('production','production control','executive')

--display national_id,job title, phone number for employee
select NationalIDNumber,JobTitle,PhoneNumber,lastname
from HumanResources.Employee e, Person.PersonPhone pp,
Person.Person p
where e.BusinessEntityID=pp.BusinessEntityID
and p.BusinessEntityID=e.BusinessEntityID

select * from Production.BillOfMaterials;

select * from Production.ProductInventory;
select * from Production.TransactionHistory
select * from Production.WorkOrder;
select * from Production.Product
select * from Purchasing.PurchaseOrderHeader
select * from Purchasing.ShipMethod
select * from Sales.SalesOrderHeader
---aggregrate function column use *Having*, having works only with groupby

--find all product name  scrapped more 
select pp.Name, wo.productid ,count(*) as prcount
from Production.WorkOrder wo,
Production.ScrapReason sr, Production.Product pp
where sr.ScrapReasonID is not null 
and pp.productid=wo.productid
and sr.ScrapReasonID=wo.ScrapReasonID

--find most frequent purchased product

select top 5 pp.name, sum(pt.Quantity) frquency
from Production.TransactionHistory pt,
Production.Product pp
where pp.ProductID=pt.ProductID
group by pp.Name
order by frquency desc;

--which product requires more inventory
select p.name,pi.shelf, sum(pi.quantity) frequency
from Production.Product p, Production.ProductInventory pi
where p.ProductID=pi.ProductID
group by p.name,pi.shelf
order by p.name desc, pi.shelf, frequency desc

--most used ship mode ie shiftmethodid more used
select oh.ShipMethodID, sm.Name,count(*) count12
from Purchasing.ShipMethod sm,
Sales.SalesOrderHeader oh
where sm.ShipMethodID=oh.ShipMethodID
group by oh.ShipMethodID, sm.Name

select oh.ShipMethodID,count(*) count12
from Purchasing.PurchaseOrderHeader poh,
Purchasing.ShipMethod oh
where poh.ShipMethodID=oh.ShipMethodID
group by oh.ShipMethodID

select * from [Sales].[SalesOrderHeader];

---which currency conversion is more average end of date rate
select * from Sales.Currency;
select *from Sales.CurrencyRate

select FromCurrencyCode,ToCurrencyCode,AVG(endofdayrate) Average
from Sales.Currency c,Sales.CurrencyRate cr
where c.CurrencyCode=cr.FromCurrencyCode
group by FromCurrencyCode,ToCurrencyCode 
order by Average desc

--which currency conversion is with top values end of the rate
select top 5 FromCurrencyCode,ToCurrencyCode,AVG(endofdayrate) Average
from Sales.Currency c,Sales.CurrencyRate cr
where c.CurrencyCode=cr.FromCurrencyCode
group by FromCurrencyCode,ToCurrencyCode 
order by Average desc

--which currency conversion is with least values end of the rate
select top 5 FromCurrencyCode,ToCurrencyCode,AVG(endofdayrate) Average
from Sales.Currency c,Sales.CurrencyRate cr
where c.CurrencyCode=cr.FromCurrencyCode
group by FromCurrencyCode,ToCurrencyCode 
order by Average 

---which specil offer was having more duration
select * from Sales.SpecialOffer where SpecialOfferID=707
select * from sales.SpecialOfferProduct where SpecialOfferID=707

select  so.SpecialOfferID, DATEDIFF (DAY,startdate,EndDate)as dates
from Sales.SpecialOffer so, sales.SpecialOfferProduct sop
where so.SpecialOfferID=sop.SpecialOfferID
order by dates desc

----- another way
select specialofferid, datediff(day,startdate,enddate) as duration
from sales.SpecialOffer so
order by duration desc

---which are those products having more specialofferproduct
select type, Category 
from Sales.SpecialOffer so, sales.SpecialOfferProduct sop
where so.SpecialOfferID=sop.SpecialOfferID
group by type, Category


