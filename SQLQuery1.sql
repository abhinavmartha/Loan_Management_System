create table tbl_Employee
(
EmpId int constraint PK_tbl_Employee primary key identity(1,1),
EmpName nvarchar(50),
ContactNumber int not null unique,
Email nvarchar(50) not null unique,
EmpPassword nvarchar(50),
DOB datetime ,
PAN nvarchar(50) not null unique,
Aadhar int not null unique,
DateCreated DateTime
)
alter table tbl_Employee alter column DateCreated datetime
alter table tbl_Employee alter column DOB date

insert into tbl_Employee values('Kamal prathap singh',7899809892,'kamalprathap@gmail.com','Siristhebest','23-JUN-1990','898297EIU9',167676718881,SYSDATETIME())
insert into tbl_Employee values('Parmanand Sir',7890989985,'paramanandsir@gmail.com','Siristhebestofbest','23-DEC-1988','897298RT5',637873893893,'26-07-2021 10:34:09 PM')
create table tbl_Customer
(
CustomerId int constraint PK_tbl_Customer primary key identity(1,1),
CustomerName nvarchar(50),
ContactNumber int not null unique ,
Email nvarchar(50) not null unique,
CustomerPassword nvarchar(50),
DOB datetime,
PAN nvarchar(50) not null unique,
Aadhar int not null unique,
DateCreated DateTime,
CreatedBy nvarchar(50)
)

create table tbl_LoanDetails
(
LoanId int constraint PK_tbl_LoanDetails  primary key identity(1,1),
LoanType int constraint FK_tbl_LoanDetails_LoanType foreign key  references tbl_LoanType(LoanType),
CustomerId int constraint FK_tbl_LoanDetails_CustomerId foreign key  references tbl_Customer(CustomerId),
EmpId int constraint FK_tbl_LoanDetails_EmpId foreign key  references tbl_Employee(EmpId),
StatusId int constraint FK_tbl_LoanDetails_StatusId foreign key  references tbl_LoanStatus(StatusId),
CibilScoreId int constraint FK_tbl_LoanDetails_CibilScoreId foreign key  references tbl_CibilScore(CibilScoreId),

LoanAmount int,
SanctionedAmount int,
SanctionedDate DateTime,
EMIAmount int,

EMIStartDate	DateTime,
EMIEndDate	DateTime,
RemainingLoan	int,

DateCreated	DateTime,

)


create table tbl_LoanType
(
LoanType	int constraint PK_tbl_LoanType Primary Key Identity (1,1),
LoanTypeName	Nvarchar(50),
InterestRate	decimal
)
insert into tbl_LoanType values ('Home Loan',12.00)
insert into tbl_LoanType values ('Vehicle Loan',8.00)
insert into tbl_LoanType values ('Educational Loan',10.00)
select * from tbl_LoanType





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
CibilScoreId	Int constraint PK_tbl_CibilScore Primary Key Identity (1,1),
CibilRange	Nvarchar(50)
)
insert into tbl_CibilScore values ('Good')
insert into tbl_CibilScore values ('Average')
insert into tbl_CibilScore values ('Poor')
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
@ContactNumber int,
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
@ContactNumber int,
@Email nvarchar(50),
@DOB date,
@PAN nvarchar(50),
@Aadhar int

AS
Begin
insert into tbl_Customer values (@CustomerName,@ContactNumber,@Email
,@DOB,@PAN,@Aadhar)

END

