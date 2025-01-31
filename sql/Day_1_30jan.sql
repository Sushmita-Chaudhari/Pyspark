
use AdventureWorks2022;

select * from HumanResources.Employee;

select * from HumanResources.Employee
where MaritalStatus='M';

select * from HumanResources.Employee
where JobTitle= 'Marketing Specialist';

select * from HumanResources.Employee
where Gender like 'F';

select count(*) from HumanResources.Employee;
select count('MaritialStatus') from HumanResources.Employee;


select count(*) from HumanResources.Employee where Gender='M';

select * from HumanResources.Employee where SalariedFlag=1;
select * from HumanResources.Employee where VacationHours>70;

--vacation hr more than 70 but less than 90
select * from HumanResources.Employee where VacationHours>70 and VacationHours<=90;

--find all jobs having title Designer
select * from HumanResources.Employee where JobTitle like '%Design%';
--find total employee worked as technician

select * from HumanResources.Employee where JobTitle like '%Technician%';

--display data having nation id,job title,maritial status,

select NationalIDNumber,JobTitle,MaritalStatus,Gender from HumanResources.Employee where JobTitle like '%Marketing%';

--find person having max vacation hrs
select MAX(VacationHours) from HumanResources.Employee ;
-- find the less sick leaves
select min(SickLeaveHours)from HumanResources.Employee ;

--find all unique mat=ritial stats
select Distinct MaritalStatus as'unique value' from HumanResources.Employee;

--find all emp from production department
select * from HumanResources.Department where Name='Production';

select BusinessEntityID from HumanResources.EmployeeDepartmentHistory
where DepartmentID=7;

select * from HumanResources.Employee where BusinessEntityID in 
(select BusinessEntityID from HumanResources.EmployeeDepartmentHistory
where DepartmentID=7);

--find all department under reserch and devp
select * from HumanResources.Department where GroupName='Research and Development';

--find all emp under reserch and devp
--select * from HumanResources.Employee where BusinessEntityID in
(select * from HumanResources.EmployeeDepartmentHistory where DepartmentID in
(select DepartmentID from HumanResources.Department where GroupName='Research and Development'));

--find all emp who work in day shift
select * from HumanResources.Shift where Name='Day';

select * from HumanResources.Employee where BusinessEntityID in
(select BusinessEntityID from HumanResources.EmployeeDepartmentHistory where ShiftID =
(select ShiftID from HumanResources.Shift where Name='Day'));


--find all emp where pay frquency is 1
select * from HumanResources.Employee where BusinessEntityID in
(select BusinessEntityID from HumanResources.EmployeePayHistory where PayFrequency=1);

--find all emp /candidate who are not placed
select*from HumanResources.JobCandidate;
select*from HumanResources.JobCandidate where BusinessEntityID is NULL;

select * from HumanResources.Employee where BusinessEntityID in
(select BusinessEntityID from HumanResources.JobCandidate where BusinessEntityID is NULL);

--find the address of emp
select * from Person.Address;

select *from Person.Address where AddressID in
(select AddressID  from Person.BusinessEntityAddress where BusinessEntityID in
(select BusinessEntityID from HumanResources.Employee));

select FirstName,MiddleName, LastName from Person.Person where BusinessEntityID in
(select BusinessEntityID from HumanResources.Department where GroupName='Research and Development');

select FirstName,MiddleName, LastName from Person.Person where BusinessEntityID in
(select BusinessEntityID from HumanResources.EmployeeDepartmentHistory where DepartmentID in
(select DepartmentID from HumanResources.Department where GroupName='Research and Development'));