CREATE TABLE Roles(
	roleID INT IDENTITY(1, 001) PRIMARY KEY NOT NULL,
	roleName VARCHAR(100) NOT NULL,
	SalaryID INT,
	FOREIGN KEY(SalaryID) REFERENCES Salary(SalaryID) ON DELETE CASCADE
)

--inserting into the roles table
INSERT INTO Roles(roleName, SalaryID)
VALUES ('Accountant', 2),
('Senior HR', 5),
('Teacher', 4)

SELECT *
FROM Roles

CREATE TABLE EMPLOYEE(
	EmpID INT PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	fname VARCHAR(200),
	lname VARCHAR(200),
	Gender VARCHAR(7) CHECK (Gender IN('Male', 'Female')),
	Email VARCHAR(100) NOT NULL UNIQUE,
	phoneNumber VARCHAR(12) NOT NULL,
	hire_date DATE,
	DepartmentID INT,
	RoleID INT,
	FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID) ON DELETE CASCADE,
	FOREIGN KEY (RoleID) REFERENCES Roles(RoleID) ON DELETE CASCADE
)

ALTER TABLE EMPLOYEE
ADD Adress VARCHAR(30) NOT NULL

ALTER TABLE Attendance
status VARCHAR(20) CHECK (status IN('Present', 'Absent', 'On Leave'))




INSERT INTO EMPLOYEE
VALUES 
	('Davis','Effie','Female','daref@gmail.com','+233 11111','2021/10/10',3,1,30,'Tema Community 04'),
	('John', 'Doe', 'Male', 'john.doe@ex.com', '+2335551234', '2021-03-15', 1, 1,45,'Tema'),
    ('Jane', 'Smith', 'Female', 'jane.smith@ex.com', '+2335552345', '2020-06-01', 2, 2,30,'Koforidua'),
    ('Mark', 'Johnson', 'Male', 'mark.john@ex.com', '+2335553456', '2019-10-20', 3, 3,23,'Madina'),
    ('Emily', 'Davis', 'Female', 'emily.d@ex.com', '+2335554567', '2022-01-11', 4, 3,21,'Oyibi'),
    ('Michael', 'Brown', 'Male', 'michael.b@ex.com', '+2335555678', '2021-07-22', 2, 3,32,'Tamale'),
    ('Laura', 'Wilson', 'Female', 'laura.w@ex.com', '+2335556789', '2020-11-15', 1, 2,45,'Aburi'),
    ('Chris', 'Evans', 'Male', 'chris.ev@ex.com', '+2335557890', '2019-02-25', 3, 2,41,'Sunyani'),
    ('Emma', 'Taylor', 'Female', 'emma.t@ex.com', '+2335558901', '2021-05-05', 1, 1,28,'Madina'),
    ('David', 'Thomas', 'Male', 'david.t@ex.com', '+2335559012', '2020-08-12', 2, 2,29,'Oyibi'),
    ('Olivia', 'Moore', 'Female', 'olivia.m@ex.com', '+2335550123', '2022-03-10', 3, 1,32,'Wa')
SELECT *
FROM EMPLOYEE

SELECT * 
FROM Department

SELECT *
FROM Attendance


DROP TABLE Attendance


CREATE TABLE Attendance(
	AttID INT PRIMARY KEY IDENTITY(1, 99) NOT NULL,
	EmpID INT NOT NULL,
	FOREIGN KEY (EmpID) REFERENCES EMPLOYEE(EmpID),
	date DATE NOT NULL,
	status VARCHAR(30) CHECK (status IN('Present', 'Absent', 'On Leave'))
)

INSERT INTO Attendance
VALUES  (1, '2024/05/24', 'Present'),
		(2, '2024/05/24', 'On leave'),
		(3, '2024/05/24', 'Absent'),
		(4, '2024/05/24', 'Absent'),
		(5, '2024/05/24', 'Present'),
		(6, '2024/05/24', 'Present'),
		(7, '2024/05/24', 'Present'),
		(8, '2024/05/24', 'Present'),
		(9, '2024/05/24', 'Present'),
		(10, '2024/05/24', 'Present'),
		(11, '2024/05/24', 'Present'),
		(12, '2024/05/24', 'Present')



SELECT (fname +' '+lname) AS Executives, 
		Gender
FROM EMPLOYEE

SELECT CONCAT (Fname, ' ', Lname) AS Executives,
		Gender
FROM EMPLOYEE

--WHERE CLAUSE
SELECT CONCAT (Fname, ' ', Lname) AS Executives, 
		Age,
		Gender
FROM EMPLOYEE
WHERE Gender  = 'Female' AND Age > 20

--JOINS
--INNER JOIN
SELECT CONCAT(employee.fname, ' ', employee.lname) AS Executives,
			  department.DepartmentName
FROM EMPLOYEE AS employee
INNER JOIN Department AS department
ON employee.DepartmentID = department.DepartmentID
GROUP BY department.DepartmentName, CONCAT(employee.Fname, ' ', employee.lname)

SELECT CONCAT(employee.fname, ' ', employee.lname) AS Executives,
			  department.DepartmentName
FROM EMPLOYEE AS employee
LEFT JOIN Department AS department
ON employee.DepartmentID = department.DepartmentID
GROUP BY department.DepartmentName, CONCAT(employee.Fname, ' ', employee.lname)

SELECT CONCAT(employee.fname, ' ', employee.lname) AS Executives,
			  department.DepartmentName
FROM EMPLOYEE AS employee
RIGHT JOIN Department AS department
ON employee.DepartmentID = department.DepartmentID
GROUP BY department.DepartmentName, CONCAT(employee.Fname, ' ', employee.lname)



SELECT CONCAT(e.fname, ' ', e.lname) MEMBER, r.roleName AS 'Role Name'
FROM EMPLOYEE AS e
LEFT JOIN Roles as r
ON e.RoleID = r.roleID
GROUP BY r.roleName, CONCAT(e.Fname, ' ', e.lname)


SELECT CONCAT(e.fname, ' ', e.lname) MEMBER, r.roleName AS 'Role Name'
FROM EMPLOYEE AS e
RIGHT JOIN Roles as r
ON e.RoleID = r.roleID
GROUP BY r.roleName, CONCAT(e.Fname, ' ', e.lname)



--Q1 Which Department has the highest salary
SELECT TOP 10 hrd.Name, eph.Rate
FROM HumanResources.Department AS hrd
JOIN HumanResources.EmployeeDepartmentHistory AS edh
ON hrd.DepartmentID = edh.DepartmentID
JOIN HumanResources.EmployeePayHistory AS eph
ON edh.BusinessEntityID = eph.BusinessEntityID
ORDER BY eph.Rate DESC

---Q2. Find the top 10 customer that do more purchases
SELECT TOP 10 c.CustomerID, sod.OrderQty As Purchases
FROM Sales.Customer AS c
JOIN Sales.SalesOrderHeader AS soh
ON c.CustomerID = soh.CustomerID
JOIN Sales.SalesOrderDetail AS sod
ON soh.SalesOrderID = sod.SalesOrderID
ORDER BY Purchases DESC











--Marital Status

SELECT
  e.Gender, e.MaritalStatus, d.Name,
    COUNT(e.BusinessEntityID) AS Count
FROM 
    HumanResources.Employee AS e
JOIN 
    HumanResources.EmployeeDepartmentHistory AS edh 
	ON e.BusinessEntityID = edh.BusinessEntityID
JOIN 
    HumanResources.Department AS d ON edh.DepartmentID = d.DepartmentID
GROUP BY 
    d.Name, e.Gender, e.MaritalStatus
ORDER BY 
    d.Name




--How much revenue has each sales person generated?





---Q3. What is the average order value by country?

---Q4. What are the total sales for each product category?

---Q5. Which products has the least sales ?





