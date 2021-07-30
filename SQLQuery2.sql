Declare @Encrypt varbinary(200)
Declare @Password varchar(200) = 'MyPassword'
Select @Encrypt = ENCRYPTBYPASSPHRASE('key', @Password)
Select Convert(varchar(200), DECRYPTBYPASSPHRASE('key', @Encrypt)) as Decrypt
 Select @Encrypt,@Password

 alter Procedure CustomerLogin
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



  alter Procedure EmployeeLogin
 @EmpId Int,
 @Password nvarchar(200)
 AS  
 BEGIN
	Declare @IsPasswordIncorrectEmp Bit
	Declare @UserNotRegisteredEmp Bit

	If not Exists(Select 1 from tbl_Employee where EmpId = @EmpId)
	Begin
		SET @IsPasswordIncorrectEmp = Cast(0 as bit)
		SET @UserNotRegisteredEmp = Cast(1 as bit)
	END
	ELSE
	BEGIN
		Declare @CurrentPassword nvarchar(200) = 
		(Select password from tbl_Employee where EmpId = @EmpId)

		Declare @Decrypt nvarchar(200) = (Convert(varchar(200), DECRYPTBYPASSPHRASE('key', @CurrentPassword)))
		If (@Decrypt = @Password )
		Begin 
			Set @IsPasswordIncorrectEmp = cast(0 as bit)
			Set @UserNotRegisteredEmp = cast(0 as bit)
		END
		ELSE
		BEGIN
			Set @IsPasswordIncorrectEmp = cast(1 as bit)
			Set @UserNotRegisteredEmp = cast(0 as bit)
		END
	END

	select @IsPasswordIncorrectEmp as 'PasswordIncorrect', @UserNotRegisteredEmp as 'UserNotRegisteredEmp'
 END
 drop procedure EmployeeLogin
 select * from tbl_TransactionDetails