Create Procedure CustomerLogin
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
		(Select CustomerPasswordHash from tbl_Customer where CustomerId = @CustomerId)

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

	select @IsPasswordIncorrect, @UserNotRegistered 
	
 END