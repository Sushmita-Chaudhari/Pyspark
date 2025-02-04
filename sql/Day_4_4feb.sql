use AdventureWorks2022;

select * from Sales.Currency;
select *from Sales.CurrencyRate;

select CurrencyCode from Sales.Currency
where name='Australian Dollar'

-- Q 1.find the average currency rate conversion from USD to Algerian Dinar  
--and Australian Doller  
select FromCurrencyCode,ToCurrencyCode, AverageRate ,name
from Sales.CurrencyRate cr, Sales.Currency c
where cr.FromCurrencyCode=c.currencycode
and FromCurrencyCode='USD' and ToCurrencyCode in ('DZD','AUD')
group by FromCurrencyCode,ToCurrencyCode, AverageRate,name

select FromCurrencyCode,ToCurrencyCode,avg(averagerate)
from Sales.CurrencyRate cr, Sales.Currency c
where FromCurrencyCode='USD' and ToCurrencyCode in ('DZD','AUD')
group by FromCurrencyCode,ToCurrencyCode

--Q 2. Find the products having offer on it and display product name , 
--safety Stock Level, Listprice,  and product model id, 
--type of discount,  percentage of discount,  offer start date and offer end date 
select * from Sales.SpecialOffer;
select * from sales.SpecialOfferProduct;
select * from Production.Product;


select  p.name,p.SafetyStockLevel,p.ListPrice,so.Type,so.DiscountPct,so.StartDate,so.EndDate
from Production.Product p, Sales.SpecialOffer so,
sales.SpecialOfferProduct sop
where so.specialofferid=sop.specialofferid and
sop.productid=p.productid

--Q 4 find out the vendor for product   paint, Adjustable Race and blade
select * from Purchasing.ProductVendor
select * from purchasing.Vendor

select p.name as product_name, v.name as vendor_name 
from Production.Product p, Purchasing.ProductVendor pv,Purchasing.Vendor v
where p.ProductID=pv.ProductID
and pv.BusinessEntityID=v.BusinessEntityID and 
(p.name like'%paint%' or p.Name like '%adjustable race%' or p.name like '%blade%')

--Q 5. find product details shipped through ZY - EXPRESS 
select * from Production.Product
select * from Purchasing.ShipMethod
select * from Purchasing.PurchaseOrderDetail
select * from Purchasing.PurchaseOrderHeader

select distinct(p.name) as product_name,sm.Name as shift_name
from Purchasing.PurchaseOrderHeader poh,
Purchasing.ShipMethod sm,Purchasing.PurchaseOrderDetail pod,
Production.Product p
where p.ProductID=pod.ProductID 
and poh.PurchaseOrderID=pod.PurchaseOrderID 
and sm.ShipMethodID=poh.ShipMethodID
and sm.name='ZY - EXPRESS'

--Q 6)find the tax amt for products where order date and ship date are on the same day 
select poh.ShipDate,soh.OrderDate,soh.TaxAmt,poh.TaxAmt
from Purchasing.PurchaseOrderHeader poh, Sales.SalesOrderHeader soh
where poh.ShipMethodID=soh.ShipMethodID
and soh.OrderDate=poh.ShipDate

--Q 7) find the average days required to ship the product based on shipment type. 
select * from sales.SalesOrderHeader
select * from Purchasing.PurchaseOrderHeader

select s.name as ship_name,AVG(datediff(day,h.orderdate,h.shipdate)) avgdayship
from Purchasing.PurchaseOrderHeader h,Purchasing.ShipMethod s
where h.ShipMethodID=s.ShipMethodID 
group by s.Name

--Q 8 find the name of employees working in day shift 
select distinct(firstname),LastName ,s.Name
from Person.Person p, HumanResources.Shift s ,HumanResources.EmployeeDepartmentHistory h
where p.BusinessEntityID=h.BusinessEntityID
and s.ShiftID=h.ShiftID
and s.name='day'

--Q 9)based on product and product cost history find the name , 
--service provider time and average Standardcost
select * from Production.Product
select * from Production.ProductCostHistory

select name,avg(ch.StandardCost) avg_std_cst,sum(DATEDIFF(day,ch.StartDate,ch.EndDate)) service_provider
from Production.Product p,Production.ProductCostHistory ch
where p.ProductID=ch.ProductID
group by name

--Q 10)find products with average cost more than 500 
select name ,avg (standardcost) average_cost
from Production.Product 
group by name 
having avg(standardcost)>=500
order by average_cost

--Q11) find the employee who worked in multiple territory 
select * from sales.SalesTerritoryHistory
select *from Person.Person
select *from Sales.SalesTerritory

select p.FirstName ,count(*) as cnt
from Sales.SalesTerritory st, Sales.SalesTerritoryHistory sth,
Person.Person p
where p.BusinessEntityID=sth.BusinessEntityID
and st.TerritoryID=sth.TerritoryID
group by p.FirstName
having count(*)>1

--Q 12)ind out the Product model name,  product description for culture as Arabic 
select * from Production.ProductDescription
select *  from Production.ProductModel 
select * from Production.ProductModelProductDescriptionCulture
select * from Production.Culture


select pm.name, pd.description ,pd.ProductDescriptionID,pc.CultureID
from production.ProductDescription pd, Production.ProductModel pm
,Production.ProductModelProductDescriptionCulture pc
where pm.ProductModelID=pc.ProductModelID
and pd.ProductDescriptionID=pc.ProductDescriptionID
and pc.CultureID like '%ar%'

 













 select *,(select p.[name] from Production.ProductModel p
where Pr.ProductModelID=p.ProductModelID) put
from Production.ProductModelProductDescriptionCulture pr