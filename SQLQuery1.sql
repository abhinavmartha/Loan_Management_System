create table tbl_Employee
(
EmpId int constraint PK_tbl_Employee primary key identity(1000,1),
EmpName nvarchar(50),
ContactNumber bigint not null unique,
Email nvarchar(50) not null unique,
PasswordHash nvarchar(50),
DOB date ,
PAN nvarchar(50) not null unique,
Aadhar bigint not null unique,
)


select * from tbl_Employee 
end


insert into tbl_Employee(EmpName,ContactNumber,Email,PAN,Aadhar,DateCreated) values('Vinay',7899809892,'vinay@gmail.com','898297EIU9',167676718881,Default(getdate()))
insert into tbl_Employee values('Harsha',7890989985,'harsha@gmail.com','23-DEC-1988','897298RT5',637873893893,'26-07-2021 10:34:09 PM')

update tbl_Employee
SET
   PasswordHash='Password4'
   where 
   EmpId=1004;
   select * from tbl_Employee

create table tbl_Customer
(
CustomerId int constraint PK_tbl_Customer primary key identity(1,1),
CustomerName nvarchar(50),
ContactNumber bigint not null unique ,
Email nvarchar(50) not null unique,
CustomerPasswordHash nvarchar(50),

PAN nvarchar(50) not null unique,
Aadhar nvarchar(12) not null unique,
CibilScore int
)
insert into tbl_Customer(CustomerName,ContactNumber,Email,CustomerPasswordHash,PAN,Aadhar,CibilScore)
values('Hruthik',9738983798,'hruthik@gmail.com','password','98298EY980','987897982789',725)

insert into tbl_Customer(CustomerName,ContactNumber,Email,CustomerPasswordHash,PAN,Aadhar,CibilScore)
values('Rony',9738983787,'rony@gmail.com','password1','98298EB678','987897982766',753)

insert into tbl_Customer(CustomerName,ContactNumber,Email,CustomerPasswordHash,PAN,Aadhar,CibilScore)
values('Steve',9738983764,'steve@gmail.com','password2','98298EP657','987897987867',759)

insert into tbl_Customer(CustomerName,ContactNumber,Email,CustomerPasswordHash,PAN,Aadhar,CibilScore)
values('Chris',9738983758,'chris@gmail.com','password3','98298EH689','98789798879',761)
insert into tbl_Customer(CustomerName,ContactNumber,Email,CustomerPasswordHash,PAN,Aadhar,CibilScore)
values('Harry',9738983778,'harry@gmail.com','password4','98298ER789','98789798868',758)

insert into tbl_Customer(CustomerName,ContactNumber,Email,CustomerPasswordHash,PAN,Aadhar,CibilScore)
values('Hermoine',9738983756,'hermoine@gmail.com','password5','98298EE987','987897985678',793)

insert into tbl_Customer(CustomerName,ContactNumber,Email,CustomerPasswordHash,PAN,Aadhar,CibilScore)
values('Anna',9738983746,'anna@gmail.com','password6','98298EJH989','987897987576',781)

insert into tbl_Customer(CustomerName,ContactNumber,Email,CustomerPasswordHash,PAN,Aadhar,CibilScore)
values('Maya',9738983779,'maya@gmail.com','password7','98298EW798','987897988789',796)

insert into tbl_Customer(CustomerName,ContactNumber,Email,CustomerPasswordHash,PAN,Aadhar,CibilScore)
values('Dom',9738983776,'dom@gmail.com','password8','98298ER898','987897987989',799)

drop table tbl_Customer

select * from tbl_Customer

	


create table tbl_LoanDetails
(
LoanId int constraint PK_tbl_LoanDetails  primary key identity(1,1),
LoanType int constraint FK_tbl_LoanDetails_LoanType foreign key  references tbl_LoanType(LoanType),
CustomerId int constraint FK_tbl_LoanDetails_CustomerId foreign key  references tbl_Customer(CustomerId),
EmpId int constraint FK_tbl_LoanDetails_EmpId foreign key  references tbl_Employee(EmpId),
StatusId int constraint FK_tbl_LoanDetails_StatusId foreign key  references tbl_LoanStatus(StatusId),


LoanAmount int,
SanctionedAmount int,
SanctionedDate date,
EMIAmount int,

EMIStartDate	date,
EMIEndDate	date,
RemainingLoan	int,

DateCreated	DateTime,

)


create table tbl_LoanType
(
LoanType	int constraint PK_tbl_LoanType Primary Key identity(1,1),
LoanTypeName		Nvarchar(50),
InterestRate	decimal not null
)
insert into tbl_LoanType values ('Home Loan',12.00)
insert into tbl_LoanType values ('Vehicle Loan',8.00)
insert into tbl_LoanType values ('Educational Loan',10.00)
drop table tbl_LoanType
select * from tbl_LoanType
declare @Input varchar(30)='Home Loan'
select InterestRate from tbl_LoanType where LoanTypeName=@Input





create table tbl_LoanStatus
(
StatusId	Int constraint PK_tbl_LoanStatus Primary Key Identity (1,1),
LoanStatusName	Nvarchar(50)
)
insert into tbl_LoanStatus values('Requested')	
insert into tbl_LoanStatus values('Approved')
insert into tbl_LoanStatus values('Rejected')
select * from tbl_LoanStatus


create table tbl_CibilScore
(
CustomerId	Int constraint Fk_tbl_CibilScore_CustomerId Foreign key references tbl_Customer(CustomerId),
CibilRange	Nvarchar(50)
)
insert into tbl_CibilScore(CibilRange) values ('Good')
insert into tbl_CibilScore (CibilRange) values ('Average')
insert into tbl_CibilScore(CibilRange) values('Poor')
select * from tbl_CibilScore


create table tbl_TransactionDetails
(
TransactionId	Int constraint PK_tbl_TransactionDetails Primary Key Identity (1,1),
LoanId	Int constraint FK_tbl_TransactionDetails_LoanId foreign key  references tbl_LoanDetails(LoanId),
AmountPaid	Int,
DateCreated	DateTime,
CreatedBy	Nvarchar(50)
)
create procedure usp_Insert_CustomerDetails

@CustomerId int out,
@CustomerName nvarchar(50),
@ContactNumber bigint,
@Email nvarchar(50),
@CustomerPassword nvarchar(50),
@DOB date,
@PAN nvarchar(50),
@Aadhar int,
@DateCreated Datetime,
@CreatedBy nvarchar(50)
AS
Begin
insert into tbl_Customer values (@CustomerName,@ContactNumber,@Email,@CustomerPassword
,@DOB,@PAN,@Aadhar,@DateCreated,@CreatedBy)
set @CustomerId=SCOPE_IDENTITY();
END
create procedure usp_Display_CustomerDetails
@CustomerId int
As
Begin
Select * from tbl_Customer where CustomerId=@CustomerId;
END

/*create procedure usp_Enquiry_LoanStatus

As 
Begin

when CibilScoreId=1 Then 
return (select LoanStatusName from tbl_LoanStatus where StatusId=1)
when CibilScoreId=2 Then 
return (select LoanStatusName from tbl_LoanStatus where StatusId=2)
when CibilScoreId=3 Then 
return (select LoanStatusName from tbl_LoanStatus where StatusId=3)
END
*/
create procedure usp_Insert_CustomerDetails_Entry

@CustomerName nvarchar(50),
@ContactNumber bigint,
@Email nvarchar(50),
@PAN nvarchar(50),
@Aadhar nvarchar(12)

AS
Begin
insert into tbl_Customer(CustomerName,ContactNumber,Email,PAN,Aadhar) values (@CustomerName,@ContactNumber,@Email
,@DOB,@PAN,@Aadhar)

END

alter procedure usp_Get_Interest_Rate
@LoanType varchar(30) 

As
Begin

select InterestRate from tbl_LoanType where LoanTypeName=@LoanType
End

execute usp_Get_interest_Rate 'Home Loan'
drop procedure usp_Get_Interest_Rate 



create procedure usp_EmployeeTable_Login
@empId int, @password nvarchar(50), @value int out
as
begin
 declare @Name varchar(30)
 set @Name = (select EmpName from tbl_Employee where EmpId=@empId AND PasswordHash=HASHBYTES('SHA2_512',@password+CAST(Salt AS varchar(36))))
 if(@Name is null)
 begin
  SET @Name=(select EmpName from tbl_Employee where EmpId=@empId)
  if(@Name is null)
   set @value = 3
  else
  begin
   set @value = 2
   print @password
  end
 end
 else
 begin
  set @value =1
  print @Name
 end
end

declare @val int
begin
 execute usp_EmployeeTable_Login 1000,'admin-1',@val output
 print @val
end

exec GetLoanDetailsByCustomerId 1



Alter Procedure GetLoanDetailsByCustomerId
@CustomerId Int
As 
Begin
select LoanId, LoanType, LoanAmount, SanctionedAmount,
SanctionedDate, EMIAmount, RemainingLoan, LS.LoanStatusName,
Case 
When C.CibilScore >= 700 and C.CibilScore <= 900 then 'Good'
when C.CibilScore >= 500 and C.CibilScore < 700 then 'Average'
else 'Bad'
End as CibilScore
from tbl_LoanDetails LD
Inner Join tbl_Customer C On LD.CustomerId = C.CustomerId
Inner Join tbl_LoanStatus LS on LD.StatusId = LS.StatusId
END

exec GetLoanDetailsByCustomerId 1



DBCC CheckIdent('tbl_LoanDetails',Reseed,0)

Alter Procedure UpdateLoanStatus
@LoanId Int,
@SanctionedAmount int,
@ApprovalStatus int
AS
Begin
Declare @interestRate int = (Select InterestRate from tbl_LoanType where LoanType = 
(select LoanType from tbl_LoanDetails where LoanId = @LoanId))

Declare @TotalAmount Int = (@SanctionedAmount * (cast(@interestRate as decimal(18,2))/100))

Update tbl_LoanDetails
set SanctionedAmount = @SanctionedAmount,
SanctionedDate = GetUTCDATE(),
EMIAmount = (@TotalAmount + @SanctionedAmount)/36, 
EMIStartDate = cast(DateAdd(day, 1,GETUTCDATE()) as Date),
EMIEndDate = DATEADD(month, 36, cast(GETUTCDATE() as date)),
RemainingLoan = @SanctionedAmount + @TotalAmount,
StatusId = @ApprovalStatus where LoanId = @LoanId

END
create procedure Customer_Loan
@CustomerId int,
@LoanAmount int,
@LoanType int,

insert into tbl_LoanDetails(LoanType,CustomerId,EmpId,StatusId,LoanAmount,DateCreated)
values(1,1,1000,1,10000,GetUTCDATE())

select * from tbl_LoanDetails

exec UpdateLoanStatus 3, 20000, 2

select * from tbl_LoanType
select * from tbl_Employee
DBCC checkIDENT('tbl_Customer',RESEED,0)
Declare @Encrypt varbinary(200)
Declare @Password varchar(200) = 'MyPassword'
Select @Encrypt = ENCRYPTBYPASSPHRASE('key', @Password)
Select Convert(varchar(200), DECRYPTBYPASSPHRASE('key', @Encrypt)) as Decrypt

select * from tbl_Customer


DBCC CheckIDENT('tbl_Customer',RESEED,1000)

alter procedure usp_Insert_CustomerDetails_Entry

@CustomerName nvarchar(50),
@ContactNumber bigint,
@Email nvarchar(50),

@PAN nvarchar(50),
@Aadhar nvarchar(12),
@Password nvarchar(200)

AS
Begin
Declare @CibilScore int
select @CibilScore=900
Declare @Encrypt varbinary(200)
Select @Encrypt = ENCRYPTBYPASSPHRASE('key', @Password)

insert into tbl_Customer(CustomerName,ContactNumber,Email,PAN,Aadhar,CibilScore,password) values (@CustomerName,@ContactNumber,@Email
,@PAN,@Aadhar,@CibilScore,@Encrypt)
select CustomerId from tbl_customer where @PAN=PAN

END

Declare @Encrypt varbinary(200)
Declare @Password varchar(200) = 'Password'
Select @Encrypt = ENCRYPTBYPASSPHRASE('key', @Password)
execute usp_Insert_CustomerDetails_Entry 'don',9839898387,'don@gmail.com','89797978Y9','980897893898',@Encrypt
select * from tbl_Customer
select * from tbl_LoanDetails