CREATE TABLE Branch (
    BranchID INT PRIMARY KEY,
    Name VARCHAR(30) NOT NULL,
    Address VARCHAR(50) NOT NULL,
    PhoneNum VARCHAR(20) NOT NULL
);

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(30) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender CHAR(1) NOT NULL CHECK (Gender IN ('M','F')), -- F OR M
    Address VARCHAR(30) NOT NULL,
    PhoneNum VARCHAR(20) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    AccountID INT UNIQUE NOT NULL,
	-- FOREIGN KEY (AccountID) REFERENCES Account(AccountID)
);


CREATE TABLE Customer_Branch(
        CustomerID INT FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
		BranchID INT FOREIGN KEY (BranchID) REFERENCES Branch(BranchID),
		PRIMARY KEY (CustomerID,BranchID)
);


CREATE TABLE Account (
    AccountID INT PRIMARY KEY,
    CustomerID INT UNIQUE,
    AccountType VARCHAR(50) NOT NULL,
    Balance MONEY NOT NULL,
    OpenDate DATE NOT NULL,
    ManagerID INT, 
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    -- FOREIGN KEY (ManagerID) REFERENCES Employee(EmployeeID)
);


CREATE TABLE Transactions (
    TransactionID INT,
    AccountID INT,
    TransactionDate DATE NOT NULL,
    TransactionType VARCHAR(50) NOT NULL,
    Amount MONEY NOT NULL,
    PRIMARY KEY (TransactionID, AccountID),
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID)
);


CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Role VARCHAR(100) NOT NULL,
    PhoneNum VARCHAR(20) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    BranchID INT NOT NULL,
    FOREIGN KEY (BranchID) REFERENCES Branch(BranchID)
);


CREATE TABLE Loans (
    LoanID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    LoanType VARCHAR(50) NOT NULL,
    LoanAmount MONEY NOT NULL,
    InterestRate MONEY NOT NULL,
    LoanStatus VARCHAR(50)NOT NULL CHECK(LoanStatus IN ('Successful','Failed','Pending')),
    EmployeeID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);




