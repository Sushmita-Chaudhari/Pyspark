use AdventureWorks2022;

--19. find all the products with special offer
select *from sales.SpecialOfferProduct

select name, p.ProductID,so.SpecialOfferID
from Sales.SpecialOffer so, sales.SpecialOfferProduct sop,
Production.Product p
where so.SpecialOfferID=sop.SpecialOfferID
and p.ProductID=sop.ProductID

select name,productid from Production.Product where ProductID in
(select ProductID from sales.SpecialOfferProduct where SpecialOfferID in
(select specialofferid from sales.SpecialOffer ))

--Q20)find all employees name , job title, card details whose credit card 
--expired in the month 11 and year as 2008
select *from Sales.CreditCard
select * from Sales.PersonCreditCard

select (select CONCAT_WS('',firstname,lastname) from Person.Person p where p.BusinessEntityID=cc.BusinessEntityID),
(select jobtitle from HumanResources.Employee e where e.BusinessEntityID=cc.BusinessEntityID),
(select CardType from sales.CreditCard c where c.CreditCardID=cc.CreditCardID )
from Sales.PersonCreditCard cc
where cc.CreditCardID in (select CreditCardID from sales.CreditCard c where c.ExpMonth=11
and ExpYear=2008)

--21. Find the employee whose payment might be revised (Hint : Employee payment history)
select BusinessEntityID,count(*)
from HumanResources.EmployeePayHistory
group by BusinessEntityID
having count(*)>1

--22)Find total standard cost for the active Product. (Product cost history)
select * from Production.ProductCostHistory
select ProductID,sum(standardcost) addition
from Production.ProductCostHistory
where EndDate is null																														
group by ProductID

--23. Find the personal details with address and
--address type(hint: Business Entiry Address , Address, Address type)
select * from Person.Address;

select *from Person.Address where AddressID in
(select AddressID  from Person.BusinessEntityAddress where BusinessEntityID in
(select BusinessEntityID from HumanResources.Employee));

--24.Find the name of employees working in group of North America territory
select * from Sales.SalesTerritory

select firstname,LastName 
from Person.Person p,Sales.SalesTerritory st,
Sales.SalesTerritoryHistory sh
where sh.TerritoryID=st.TerritoryID
and p.BusinessEntityID=sh.BusinessEntityID
and [group]='north america'

--Q 25.Find the employee whose payment is revised for more than once
--27. Which shelf is having maximum quantity (product inventory)
select * from Production.ProductInventory
select shelf,max(quantity)
from Production.ProductInventory
group by shelf

--28. Which shelf is using maximum bin(product inventory)
select * from Production.ProductInventory

select shelf,max(bin) maximum
from Production.ProductInventory
group by shelf
order by maximum desc


--29. Which location is having minimum bin (product inventory)
select * from Production.ProductInventory
select * from Production.Location

select name,l.LocationID ,min(bin)
from Production.ProductInventory p,Production.Location l
where p.locationid=l.LocationID
group by name,l.LocationID

--30. Find out the product available in most of the locations (product inventory)
select  p.name,count(LocationID)
from Production.Product p,
Production.ProductInventory i
where p.ProductID = i.ProductID
group by p.name
order by count(LocationID) desc

--31. Which sales order is having most order qualtity
select * from Sales.SalesOrderDetail

select salesorderid,count(orderqty) most_order
from Sales.SalesOrderDetail
group by SalesOrderID
order by most_order desc

--32 Inline view ,table question

--33 check if any employee from jobcandidate table is having any payment revisions
select * from HumanResources.JobCandidate
select * from HumanResources.EmployeePayHistory

select jobcandidateid,count(ep.BusinessEntityID)
from HumanResources.JobCandidate j,HumanResources.EmployeePayHistory ep
where ep.BusinessEntityID=j.BusinessEntityID
group by JobCandidateID
having count(ep.businessentityid)>1

--34check the department having more salary revision
select *from HumanResources.EmployeeDepartmentHistory
select * from HumanResources.EmployeePayHistory

select businessentityid, count(departmentid) more_sal
from HumanResources.EmployeeDepartmentHistory
group by BusinessEntityID
having count(departmentid)>1

--35 check the employee whose payment is not yet revised
select businessentityid, count(BusinessEntityID) more_sal
from HumanResources.EmployeeDepartmentHistory
group by BusinessEntityID
having count(BusinessEntityID)=0


--36. find the job title having more revised payments
select titlejob, count(*)
 from (select e.jobtitle titlejob ,eph.businessentityid,count(*) cnt
 from HumanResources.Employee e, HumanResources.EmployeePayHistory eph
where e.BusinessEntityID=eph.BusinessEntityID    
group by e.jobtitle,eph.BusinessEntityID
having count(*)>1) as t
group by t.titlejob

--37. find the employee whose payment is revised in shortest duration (inline view)


--38 find the colour wise count of the product (tbl: product)
select color,count(productid)
from Production.Product
where color is not null
group by Color

--39.find out the product who are not in position to sell (hint: check the sell start and end date)
select p.SellStartDate,  p.Name, p.SellEndDate  from Production.Product p
where p.SellEndDate is not null

--40. find the class wise, style wise average standard cost

select class, style, avg(StandardCost)
from Production.Product
where class is not null and style is not null
group by class, style

-- 41.check colour wise standard cost
select color,sum(standardcost) from Production.Product
where color is not null
group by Color

--42. find the product line wise standard cost
select PRODUCTline from Production.Product
where productline is not null
group by ProductLine

--43. Find the state wise tax rate (hint: Sales.SalesTaxRate, Person.StateProvince)
select * from Sales.SalesTaxRate
select * from Person.StateProvince

select stateprovincecode from Person.StateProvince
where StateProvinceID in (select StateProvinceid from Sales.SalesTaxRate)
group by StateProvinceCode
 
--44. Find the department wise count of employees
select * from HumanResources.Department

select d.Name,count(*)
from HumanResources.Employee e,
HumanResources.Department d,
HumanResources.EmployeeDepartmentHistory dh
where e.BusinessEntityID = dh.BusinessEntityID and
dh.DepartmentID = d.DepartmentID
group by d.Name

--45. Find the department which is having more employees
select d.Name,count(*)
from HumanResources.Employee e,
HumanResources.Department d,
HumanResources.EmployeeDepartmentHistory dh
where e.BusinessEntityID = dh.BusinessEntityID and
dh.DepartmentID = d.DepartmentID
group by d.Name
order by count(*) desc

--46. Find the job title having more employee
select jobtitle,count(*) total from HumanResources.Employee
group by JobTitle
order by total desc

-- 47. Check if there is mass hiring of employees on single day

--48. Which product is purchased more? (purchase order details
select  p.name,p.ProductID ,count(*)
from Purchasing.PurchaseOrderDetail po,
Production.Product p
where p.ProductID = po.ProductID
group by p.Name,p.ProductID 

--49 Find the territory wise customers count (hint: customer)
select * from Sales.Customer where TerritoryID in
(select TerritoryID from [Sales].[SalesTerritory] where TerritoryID in
(select count(territoryid) from [Sales].[SalesTerritory]))

--50. Which territory is having more customers (hint: customer)
select * from Sales.Customer where TerritoryID in
(select TerritoryID from [Sales].[SalesTerritory] where TerritoryID in
(select count(territoryid) from [Sales].[SalesTerritory]))

use adventureworks2022
----51.Which territory is having more stores (hint: customer)
select TerritoryID,max(StoreID) from Sales.Customer
group by TerritoryID
order by max(StoreID) desc


--52. Is there any person having more than one credit card (hint: PersonCreditCard)
select businessentityid,creditcardid, count(distinct CreditCardID) credit_card_total
from [Sales].[PersonCreditCard]
group by BusinessEntityID, CreditCardID
having count(distinct CreditCardID)>1

--53 Find the product wise sale price (sales order details)
select * from Sales.SalesOrderDetail


--54 Find the total values for line total product having maximum order

--55 Calculate the age of employees
select p.FirstName,p.LastName,datediff(year,BirthDate,GETDATE())age
from HumanResources.Employee e,
Person.Person p
where p.BusinessEntityID =e.BusinessEntityID
order by age 

--56.Calculate the year of experience of the employee based on hire date
select p.FirstName,p.LastName,datediff(year,HireDate,GETDATE())experience
from HumanResources.Employee e,
Person.Person p
where p.BusinessEntityID =e.BusinessEntityID


--57 Find the age of employee at the time of joining
select p.FirstName,p.LastName,datediff(year,BirthDate,HireDate)hiring_age
from HumanResources.Employee e,
Person.Person p
where p.BusinessEntityID =e.BusinessEntityID
--order by hiring_age

--58 Find the average age of male and female
select gender,avg(datediff(year,BirthDate,GETDATE())) avg_age
from HumanResources.Employee 
group by gender

--59. Which product is the oldest product as on the date 
--(refer the product sell start date)
select  * from Production.Product
select * from Sales.SalesOrderDetail

select Name,DATEDIFF(DAY,SellStartDate,getdate()) 
from Production.Product

--60.Display the product name, standard cost, 
--and time duration for the same cost. (Product cost history)
select * from Production.ProductCostHistory

--### Window function
--64.Display business entity id, marital status, gender, vacationhr, average vacation based on marital status
select BusinessEntityID,MaritalStatus,Gender,VacationHours,
avg(VacationHours)over(partition by maritalStatus) 
from HumanResources.Employee

--