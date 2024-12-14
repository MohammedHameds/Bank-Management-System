CREATE FUNCTION GetAccountBalance(@account_id INT)
RETURNS TABLE 
AS 
RETURN
( 
  SELECT  AccountID, Balance,CustomerID
  FROM Account
  WHERE AccountID = @account_id
);


CREATE FUNCTION CalculateLoanInterest(@loan_id INT)
RETURNS FLOAT
BEGIN
    DECLARE @loan_interest FLOAT,@loan_amount FLOAT, @interest_rate FLOAT
	

	SELECT  @loan_amount = LoanAmount , @interest_rate= InterestRate 
	FROM Loans
	WHERE LoanID = @loan_id;

	SET @loan_interest = @loan_amount * (@interest_rate / 100);

    RETURN @loan_interest;
END;



CREATE PROCEDURE DepositMoney(@account_id INT,@amount MONEY)
AS
BEGIN
  IF @account_id = (SELECT AccountID FROM Account WHERE AccountID = @account_id)
	BEGIN TRANSACTION 
	BEGIN TRY
	  UPDATE Account
    SET Balance= Balance + @amount
    WHERE AccountID= @account_id;
   
    INSERT INTO Transactions(AccountID, TransactionType, Amount, TransactionDate)
    VALUES (@account_id, 'Deposit', @amount, GETDATE());
    COMMIT; 
	END TRY

	BEGIN CATCH
	 ROLLBACK 
	END CATCH
END;
	


CREATE PROCEDURE WithdrawMoney(@account_id INT,@amount MONEY)
AS
BEGIN TRANSACTION

    DECLARE @current_balance MONEY ;    
    
    SELECT @current_balance = Balance 
    FROM Account
    WHERE AccountID = @account_id;
    
    IF @current_balance >= @amount 
        BEGIN 
		 UPDATE Account
         SET Balance= Balance- @amount
         WHERE AccountID= @account_id;
	 
	     INSERT INTO Transactions(AccountID, TransactionType, Amount, TransactionDate)
	     VALUES (@account_id, 'Withdrawal', @amount, GETDATE());		
         COMMIT
        END;
	
	    ELSE
	     RAISERROR ('YOUR BALANCE IS LESS THAN THE AMOUNT',16,1);
		 

