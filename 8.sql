-- Zad 1
Use AdventureWorks2017
GO

Begin
	Declare @tmp as Table(BusinessEntityID int, Rate money);
	
	Insert INTO @tmp (BusinessEntityID, Rate)
	Select HumanResources.EmployeePayHistory.BusinessEntityID, Max(Rate) 
	From HumanResources.EmployeePayHistory 
	Group BY HumanResources.EmployeePayHistory.BusinessEntityID;

	/*Select * From @tmp;*/

	Declare @avg as float;
	Set @avg = 0.0;

	Select @avg = AVG(Rate) From @tmp;

	Print(@avg)
	
	Select * From HumanResources.Employee a join
	(Select HumanResources.EmployeePayHistory.BusinessEntityID, Max(Rate) as 'Rate' 
	From HumanResources.EmployeePayHistory 
	Group BY HumanResources.EmployeePayHistory.BusinessEntityID
	Having Max(Rate) < @avg) b
	on a.BusinessEntityID = b.BusinessEntityID;
End

GO

-- Zad 2

Use AdventureWorks2017
Go

Create or alter function Sales.shipDateByID(@ID AS INT) 
RETURNS datetime 
AS
Begin
    Declare @data as datetime;
	Set @data = '';

	SELECT @data = ShipDate FROM SalesOrderHeader WHERE SalesOrderID = @ID;
	Return @data
End

Go

Select Sales.shipDateByID(43666) As 'ShipDate';

-- Zad 3

USE AdventureWorks2017;  
GO  
CREATE OR ALTER PROCEDURE Production.getProductByName  
    @ProductName nvarchar(50)  
AS    
	SELECT Product.ProductID, ProductNumber, Quantity  
    FROM Product, ProductInventory 
    WHERE Product.ProductID = ProductInventory.ProductID and Product.Name = @ProductName;
GO

Exec Production.getProductByName 'Freewheel'

-- Zad 4

Use AdventureWorks2017
Go

Create or Alter function Sales.cardNumByID(@ID as nvarchar(25))
Returns nvarchar(25)
as
Begin
	Declare @CardNum as nvarchar(25);
	Set @CardNum = '';

	Select @CardNum = CardNumber 
	From CreditCard, SalesOrderHeader
	Where CreditCard.CreditCardID = SalesOrderHeader.CreditCardID 
	and SalesOrderHeader.SalesOrderID  = @ID;

	Return @CardNum;
End

Go

Select Sales.cardNumByID('43664') As 'CardNumber';

-- Zad 5

USE AdventureWorks2017;  
GO 

CREATE OR ALTER PROCEDURE dbo.divide
	@num1 as float,
	@num2 as float
AS  
	Declare @iloraz as float;
	Set @iloraz = 0.0;

	if(@num1 >= @num2 OR @num2 = 0.0)
		Begin
			Set @iloraz = @num1 / @num2
			Print @iloraz;
		End
	Else
		Begin
			Print('Niew³aœciwie zdefiniowa³eœ dane wejœciowe!') 
		End	

GO

EXEC dbo.divide @num1 = 10.0, @num2 = 3.0;

-- Zad 6

USE AdventureWorks2017;  
GO  

CREATE OR ALTER PROCEDURE HumanResources.getEmployeeByNationalID
	@NationalIDNumber as nvarchar(15)
AS  
	Select JobTitle as 'Stanowisko', Ceiling(VacationHours/24.0) as 'LiczbaDniUrlopowych', Ceiling(SickLeaveHours/24.0) as 'LiczbaDniChorobowych'
	From Employee
	Where NationalIDNumber = @NationalIDNumber

GO

EXEC HumanResources.getEmployeeByNationalID @NationalIDNumber = '827686041';

-- Zad 7

USE AdventureWorks2017;  
GO  

CREATE OR ALTER PROCEDURE Sales.currencyCalculator
	@amount as float,
	@date as datetime,
	@currency as nvarchar(50)
AS  
	if(Len(@currency) > 3)
		Begin
			Select @currency = Currency.CurrencyCode From Currency Where Lower(Currency.Name) = Lower(@currency);
		End
	Else
		Begin
			Set @currency = UPPER(@currency);
		End

	Declare @rate as money;
	Declare @fromUSD as money
	Declare @toUSD as money
	Set @rate = 0.0;
	Set @fromUSD = 0.0;
	Set @toUSD = 0.0;

	Select @rate = CurrencyRate.EndOfDayRate From CurrencyRate Where CurrencyRate.CurrencyRateDate = @date and CurrencyRate.ToCurrencyCode = @currency;
	if(@rate != 0.0)
		Begin 
			Set @fromUSD = @amount * @rate;
			Set @toUSD = @amount * (1/@rate);
			Print(Cast(@amount as varchar(25)) + ' ' + @currency + ' -> USD = ' + Cast(@toUSD as Varchar(25)));
			Print(Cast(@amount as varchar(25)) + ' USD -> ' + @currency +  ' = ' + Cast(@fromUSD as Varchar(25)));
		End
	Else
		Begin
			Print('Nie ma podanej waluty w bazie danych!');
		End

GO

EXEC Sales.currencyCalculator @amount = 1400.0, @date = '2011-06-08', @currency = 'gbp';