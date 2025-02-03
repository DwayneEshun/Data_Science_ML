DECLARE @Age INT --Declaring a variable
SET @Age = 10 --Assignig a value to the variable
IF @Age >= 18
BEGIN
	PRINT 'Eligible to vote'
END
ELSE
BEGIN
	PRINT 'Not Eligible to vote'
END


--SWITCH statement
DECLARE @person INT = 20
SELECT
	CASE
		WHEN @person >= 18 THEN 'You are eligible to vote'
		ELSE 'You are not Eligible'
END AS Eligibility



--Check for Even Numbers
DECLARE @potentialEven INT = 21

SELECT
	CASE
		WHEN @potentialEven % 2 = 0
		THEN 'Number Is Even'
		ELSE 'Number is odd'
END AS Result



--WHILE LOOPS
DECLARE @attempts INT = 0
DECLARE @MaxAttempts INT = 3
WHILE @attempts < @MaxAttempts
BEGIN
	PRINT 'Provide Password'
	SET @attempts += 1
END
IF @attempts = @MaxAttempts
BEGIN
	PRINT 'Phone locked'
END



--Creating Functions
CREATE FUNCTION addNum(@num1 INT, @num2 INT)
RETURNS INT 
AS
BEGIN
	DECLARE @result INT = @num1 + @num2
	RETURN @result
END

SELECT dbo.addNum(10, 10)

--Create a function to get the paerson name, age, salary, region and print it
CREATE FUNCTION person(@Name VARCHAR(50), @Age INT, @Salary FLOAT, @region VARCHAR(25))
RETURNS TABLE
	RETURN SELECT @name AS FullName, @Age AS Age, @Salary AS Salary, @region AS Region


SELECT * 
FROM dbo.info('Kwame', 21, 100000, 'Germany')