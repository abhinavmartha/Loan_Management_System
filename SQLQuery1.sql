select * from tbl_Customer
drop table tbl_Customer
alter table tbl_Customer
drop column CustomerPasswordHash
add password varbinary(200)
truncate table tbl_Customer

Declare @Encrypt varbinary(200)
Declare @Password varchar(200) = 'MyPassword'
Select @Encrypt = ENCRYPTBYPASSPHRASE('key', @Password)
Select Convert(varchar(200), DECRYPTBYPASSPHRASE('key', @Encrypt)) as Decrypt
 Select @Encrypt,@Password
insert into tbl_Customer(CustomerName,ContactNumber,Email,password,PAN,Aadhar,CibilScore) values('abcd1',9008378906,'abcd1@gmail.com', @Encrypt,'9897898983978',878793898986,820)
execute CustomerLogin 11,'MyPassword' 
--Declare @Encrypt varbinary(200)
--Select @Encrypt = ENCRYPTBYPASSPHRASE('key', @Password)
sp_helptext usp_Insert_CustomerDetails_Entry



alter procedure usp_Insert_CustomerDetails_Entry  
  
@CustomerName nvarchar(50),  
@ContactNumber bigint,  
@Email nvarchar(50),    
@PAN nvarchar(50),  
@Aadhar nvarchar(12),
@Password nvarchar(50)
  
AS  
Begin 
Declare @Encrypt varbinary(200)
Select @Encrypt = ENCRYPTBYPASSPHRASE('key', @Password)
insert into tbl_Customer(CustomerName,ContactNumber,Email,PAN,Aadhar,password) values (@CustomerName,@ContactNumber,@Email  
,@PAN,@Aadhar,@Encrypt) 
  
END
delete from tbl_Customer where CustomerId=2
DBCC checkIDENT('tbl_Customer',RESEED,0)
Declare @Encrypt varbinary(200)
Declare @Password varchar(200) = 'MyPassword'
Select @Encrypt = ENCRYPTBYPASSPHRASE('key', @Password)
Select Convert(varchar(200), DECRYPTBYPASSPHRASE('key', @Encrypt)) as Decrypt
 Select @Encrypt,@Password
insert into tbl_Customer(CustomerName,ContactNumber,Email,password,PAN,Aadhar,CibilScore) values('Hrithik',9008378906,'abcd1@gmail.com', @Encrypt,'9897898983978',878793898986,750)
 
 select * from tbl_Customer



 DBCC checkIDENT('tbl_Employee',RESEED,1003)
Declare @Encrypt varbinary(200)
Declare @Password varchar(200) = 'Password'
Select @Encrypt = ENCRYPTBYPASSPHRASE('key', @Password)
Select Convert(varchar(200), DECRYPTBYPASSPHRASE('key', @Encrypt)) as Decrypt
insert into tbl_Employee(EmpName,ContactNumber,Email,password,PAN,Aadhar) values('Bharath',9783793883,'bharath@gmail.com',@Encrypt,'983789YP90',7687689788975)
select * from tbl_Employee
alter table tbl_Employee
drop column DOB
select * from tbl_Employee

sp_helptext LoanRegistration

alter procedure LoanRegistration  
 --@LoanId int out,
@CustomerId int,  
@LoanAmount int  
As  
Begin  
insert into tbl_LoanDetails(CustomerId,LoanAmount) values(@CustomerId,@LoanAmount)  
  
  --set @LoanId=SCOPE_IDENTITY();
select LoanId from tbl_LoanDetails where CustomerId=@CustomerId  
End
select * from tbl_LoanDetails



execute LoanRegistration 1,50000
select * from tbl_LoanDetails

create procedure UpdateCustomerDetails
@CustomerId int,
@CustomerName nvarchar(50),
@ContactNumber bigint,
@Email nvarchar(50),
@PAN nvarchar(50),
@Aadhar nvarchar(12)
As
begin
update tbl_Customer set 
CustomerName=@CustomerName,ContactNumber=@ContactNumber,Email=@Email,PAN=@PAN,Aadhar=@Aadhar
where CustomerId=@CustomerId
END
select * from tbl_Customer
sp_helptext GetLoanDetailsByCustomerId


alter Procedure GetLoanDetailsByCustomerId  
@CustomerId Int  
As   
Begin  
select LoanId,LoanType, LoanAmount, SanctionedAmount,  
SanctionedDate, EMIAmount,RemainingLoan,  
Case   
  
When C.CibilScore >= 700 and C.CibilScore <= 900 then 'Good'  
when C.CibilScore >= 500 and C.CibilScore < 700 then 'Average'  
else 'Bad'  
End as CibilScore  
from tbl_LoanDetails LD  
Inner Join tbl_Customer C On LD.CustomerId = C.CustomerId  
--Inner Join tbl_LoanStatus LS on LD.StatusId = LS.StatusId  
where LD.CustomerId = @CustomerId   
END
execute GetLoanDetailsByCustomerId 15
select * from tbl_Customer

select * from tbl_LoanDetails
sp_helptext usp_Get_Interest_Rate
CREATE procedure usp_Get_Interest_Rate  
@LoanType varchar(30)   
  
As  
Begin  
  
select InterestRate from tbl_LoanType where LoanTypeName=@LoanType  
End


alter procedure GetLoanDetails
@CustomerId int
As 
begin

select LD.LoanID,LD.SanctionedAmount,LD.RemainingLoan,LD.EMIAMOUNT,
DATEDIFF(month,LD.EMIStartDate,LD.EMIEndDate) As EMIMonths,
Case
When LD.StatusId=1 then 'Pending'
when LD.StatusId=2 then 'Approved'
else 'Rejected'
END as LoanStatus
from tbl_LoanDetails LD
Inner Join tbl_LoanStatus LS on LD.StatusId=LS.StatusId
where LD.CustomerId=@CustomerId
END
execute GetLoanDetails 15
select * from tbl_LoanDetails

CREATE PROCEDURE UpdateLoanAmount @LoanId int
AS
UPDATE tbl_LoanDetails 
SET RemainingLoan = RemainingLoan - EMIAmount
WHERE LoanId = @LoanId
GO
Select * from tbl_LoanDetails
EXEC UpdateLoanAmount @LoanId = 1;
sp_helptext LoanRegistration
sp_helptext usp_Insert_CustomerDetails_Entry
  
CREATE procedure usp_Insert_CustomerDetails_Entry  
  
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
select CustomerId from tbl_customer where PAN=@PAN  
  
END
select * from tbl_LoanDetails
execute usp_Insert_CustomerDetails_Entry 'Vinay',9787897837,'vinay@gamil.com','OUIPP9089B','782787827876','Vinay'
select * from tbl_LoanDetails
select * from tbl_Customer
sp_helptext CustomerLogin
select * from tbl_Customer
CREATE Procedure CustomerLogin  
 @CustomerId Int,  
 @Password nvarchar(200)  
 AS    
 BEGIN  
 Declare @IsPasswordIncorrect Bit  
 Declare @UserNotRegistered Bit  
  
 If not Exists(Select 1 from tbl_Customer where CustomerId = @CustomerId)  
 Begin  
  SET @IsPasswordIncorrect = Cast(0 as bit)  
  SET @UserNotRegistered = Cast(1 as bit)  
 END  
 ELSE  
 BEGIN  
  Declare @CurrentPassword nvarchar(200) =   
  (Select password from tbl_Customer where CustomerId = @CustomerId)  
  
  Declare @Decrypt nvarchar(200) = (Convert(varchar(200), DECRYPTBYPASSPHRASE('key', @CurrentPassword)))  
  If (@Decrypt = @Password )  
  Begin   
   Set @IsPasswordIncorrect = cast(0 as bit)  
   Set @UserNotRegistered = cast(0 as bit)  
  END  
  ELSE  
  BEGIN   
   Set @IsPasswordIncorrect = cast(1 as bit)  
   Set @UserNotRegistered = cast(0 as bit)  
  END  
 END  
  
 select @IsPasswordIncorrect as 'PasswordIncorrect', @UserNotRegistered as 'UserNotRegistered'  
   
   
 END
 sp_helptext GetLoanDetailsByCustomerId
 CREATE Procedure GetLoanDetailsByCustomerId  
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
where C.CustomerId = @CustomerId   
END
execute GetLoanDetailsByCustomerId 1
select * from tbl_LoanType
select * from tbl_Customer
select* from tbl_LoanDetails
sp_helptext UpdateLoanStatus

CREATE Procedure UpdateLoanStatus  
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