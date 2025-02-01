use AdventureWorks2022;

select *from Person.Person;
----subquery in select stmt
select BusinessEntityID, NationalIDNumber, JobTitle,
(select FirstName from Person.Person p where
  p.BusinessEntityID= e.BusinessEntityID) FirstName
 from HumanResources.Employee e;

 --add personal details of employee middle name,last name
 select BusinessEntityID,NationalIDNumber,jobtitle,
 (select middlename from person.person p where  
 p.BusinessEntityID=e.businessentityid) middle_name
 from HumanResources.Employee e;

 select BusinessEntityID,NationalIDNumber,jobtitle,
 (select LastName from person.person p where  
 p.BusinessEntityID=e.businessentityid) Last_name
 from HumanResources.Employee e;

 select BusinessEntityID,NationalIDNumber,JobTitle,
 (select CONCAT_ws (' ', firstname,middlename,lastname) from Person.Person p
 where p.BusinessEntityID=e.businessentityid) complete_name
 from HumanResources.Employee e;

 --display national id, first name, lastname,and department name ,department group
 select NationalIDNumber,
 (select concat(firstname,lastname) from Person.person p
 where p.BusinessEntityID=e.businessentityid) as (firstname,lastname) , 
 (select concat (name,groupname) from HumanResources.Department d 
 where d.ModifiedDate= e.modifieddate) 
from HumanResources.Employee e;


select (select concat (firstname,lastname) from person.person p
       where p.BusinessEntityID=ed.BusinessEntityID) Person_detail,
	   (select nationalidnumber from HumanResources.employee e
	   where e.BusinessEntityID=ed.businessentityid) Nat_ID,
	   (select concat(name,groupname) from HumanResources.Department d
	   where d.departmentid= ed.departmentid) Grp_detail
 from HumanResources.EmployeeDepartmentHistory ed;

 --2)display first name, lastname,department,shift time
select (select concat_ws (' ',firstname,lastname) from person.person p
       where p.BusinessEntityID=ed.BusinessEntityID) Person_detail,
	   (select concat_ws(starttime, ' ', endtime) from HumanResources.shift s
	   where s.ShiftID=ed.ShiftID ) shift_time,
	   (select name from HumanResources.Department d
	   where d.departmentid= ed.departmentid) Grp_detail
 from HumanResources.EmployeeDepartmentHistory ed;

--3)display product name and product review based on production schema
select Comments ,
(select Name from Production.Product p where p.ProductID=r.ProductID) Name355
from Production.ProductReview r;

select 
(select Name from Production.Product p where p.ProductID=r.ProductID) Name355,
Comments 
from Production.ProductReview r;

--4) find the employees name,job title,card detils whose credit card
--expire in month 11 and year 2008
select *from Sales.PersonCreditCard;
select *from Sales.CreditCard;

select 
	(select firstname from person.person p
	where p.BusinessEntityID=pc.businessentityid) Emp_name,
	(select jobtitle from HumanResources.Employee e
	where e.BusinessEntityID=pc.businessentityid) job_title,
	(select concat_ws(' ',cc.cardtype,cc.expmonth,cc.expyear) from sales.creditcard cc
	where cc.CreditCardID=pc.CreditCardID) Credit_card
from Sales.PersonCreditCard pc
where pc.CreditCardID in 
		(select CreditCardID from sales.CreditCard crd
		where crd.expmonth=11 and crd.expyear=2008);

--5) display records from currency rate from USD to AUD
select *from sales.CurrencyRate 
where FromCurrencyCode='USD' and ToCurrencyCode='AUD';

--6)display empname,territory name,group,saleslastyear,salesquota,bonus
select *from sales.SalesTerritory;
select *from sales.SalesPerson;

select 
	(select firstname from person.person p
	where p.BusinessEntityID=sp.BusinessEntityID) EMP_name,
	(select name from sales.SalesTerritory st
	where st.TerritoryID=sp.territoryid) NAME,
	(select [Group] from sales.SalesTerritory st
	where st.TerritoryID=sp.territoryid) group12,
	saleslastyear,salesquota,bonus 
from sales.SalesPerson sp


--7) display empname,territory name,group,saleslastyear,salesquota,bonus from germany and united kingdom
select 
	(select firstname from person.person p
	where p.BusinessEntityID=sp.BusinessEntityID) EMP_name,
	(select name from sales.SalesTerritory st
	where st.TerritoryID=sp.territoryid) NAME,
	(select [Group] from sales.SalesTerritory st
	where st.TerritoryID=sp.territoryid) group12,
	saleslastyear,salesquota,bonus 
from sales.SalesPerson sp
where TerritoryID in 
		(select TerritoryID from sales.SalesTerritory st
		where name='Germany' or name='United Kingdom');

--8)find all employees who worked in all north america territory
select 
	(select firstname from Person.person p
	where p.BusinessEntityID=sp.BusinessEntityID) NAME,
	(select [group] from sales.SalesTerritory st
	where st.TerritoryID=sp.TerritoryID) group_name
from sales.SalesPerson sp
where TerritoryID in
	(select TerritoryID from Sales.SalesTerritory
	where [group]='North America');

--9) find the product details in cart
select *from sales.ShoppingCartItem

select sc.*,
	(select name from Production.Product p
	where p.ProductID=sc.ProductID) PRODUCT_NAME
from sales.ShoppingCartItem sc

--10)find the prodcut with special offer
select *from sales.SpecialOffer
select *from sales.SpecialOfferProduct

select sp.*,
	(select ProductID from Sales.SpecialOffer so
	where so.SpecialOfferID=sp.SpecialOfferID) PR_ID
from Sales.SpecialOfferProduct sp