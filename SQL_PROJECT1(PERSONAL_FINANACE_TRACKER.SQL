--  PERSONAL_FINANCE_TRACKER DATABASE 


-- STEP 1: Create Database 
DROP DATABASE IF EXISTS PERSONAL_FINANCE_TRACKER;
CREATE DATABASE IF NOT EXISTS PERSONAL_FINANCE_TRACKER;
USE PERSONAL_FINANCE_TRACKER;

-- STEP 2: Create Tables
CREATE TABLE Users (
  UserID INT PRIMARY KEY,
  UserName VARCHAR(100),
  Email VARCHAR(100),
  CreatedAt DATE
);

CREATE TABLE Tags (
  TagID INT PRIMARY KEY,
  TagName VARCHAR(50)
);

CREATE TABLE Accounts (
  AccountID INT PRIMARY KEY,
  UserID INT,  FOREIGN KEY (UserID) REFERENCES Users(UserID),
  AccountName VARCHAR(100),
  AccountType VARCHAR(50),
  CurrentBalance DECIMAL(10,2)
);

CREATE TABLE Categories (
  CategoryID INT PRIMARY KEY,
  CategoryName VARCHAR(100),
  CategoryType ENUM('Income','Expense')
);

CREATE TABLE Transactions (
  TransactionID INT PRIMARY KEY,
  UserID INT, FOREIGN KEY (UserID) REFERENCES Users(UserID),
  AccountID INT, FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID),
  CategoryID INT, FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
  Amount DECIMAL(10,2),
  TransactionType ENUM('Income','Expense'),
  TransactionDate DATE,
  Description VARCHAR(255)
);

CREATE TABLE TransactionTags (
  TransactionID INT, FOREIGN KEY (TransactionID) REFERENCES Transactions(TransactionID),
  TagID INT, FOREIGN KEY (TagID) REFERENCES Tags(TagID)
);

CREATE TABLE RecurringTransactions (
  RecurringID INT AUTO_INCREMENT PRIMARY KEY,
  UserID INT, FOREIGN KEY (UserID) REFERENCES Users(UserID),
  AccountID INT, FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID),
  CategoryID INT, FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
  Amount DECIMAL(10,2),
  Frequency VARCHAR(50),
  StartDate DATE,
  NextDueDate DATE,
  EndDate DATE,
  Description VARCHAR(255)
);

CREATE TABLE Budgets (
  BudgetID INT AUTO_INCREMENT PRIMARY KEY,
  UserID INT, FOREIGN KEY (UserID) REFERENCES Users(UserID),
  CategoryID INT, FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
  Month DATE,
  BudgetAmount DECIMAL(10,2),
  CreatedAt DATE
);

CREATE TABLE SavingsGoals (
  GoalID INT AUTO_INCREMENT PRIMARY KEY,
  UserID INT, FOREIGN KEY (UserID) REFERENCES Users(UserID),
  GoalName VARCHAR(100),
  TargetAmount DECIMAL(10,2),
  CurrentAmount DECIMAL(10,2),
  Status VARCHAR(40),
  TargetDate DATE,
  Description VARCHAR(255)
);

-- STEP 3: INSERTION OF RECORDS :
-- Users
INSERT INTO Users (UserID, UserName, Email, CreatedAt) VALUES
(1, 'Amanpreet Kaur', 'amanpreet@example.com', '2024-01-01'),
(2, 'Rahul Mehta', 'rahul@example.com', '2024-01-05'),
(3, 'Priya Sharma', 'priya@example.com', '2024-01-10'),
(4, 'Karan Varma', 'karan@example.com', '2024-01-15'),
(5, 'Neha Singh', 'neha@example.com', '2024-01-20');

-- Tags
INSERT INTO Tags (TagID, TagName) VALUES
(1, 'Groceries'), (2, 'Rent'), (3, 'Fuel'), (4, 'Utilities'), (5, 'Dining'),
(6, 'Medical'), (7, 'Education'), (8, 'Travel'), (9, 'Business'), (10, 'Entertainment');

-- Accounts
INSERT INTO Accounts (AccountID, UserID, AccountName, AccountType, CurrentBalance) VALUES
(1, 1, 'SBI Bank', 'Bank', 50000.00),
(2, 2, 'HDFC Wallet', 'Digital Wallet', 3000.00),
(3, 3, 'ICICI Bank', 'Bank', 45000.00),
(4, 4, 'Axis Savings', 'Bank', 40000.00),
(5, 5, 'Paytm Wallet', 'Digital Wallet', 500.00);

--  Categories
INSERT INTO Categories (CategoryID, CategoryName, CategoryType) VALUES
(1, 'Salary', 'Income'),
(2, 'Freelance', 'Income'),
(3, 'Rent', 'Expense'),
(4, 'Groceries', 'Expense'),
(5, 'Utilities', 'Expense'),
(6, 'Dining Out', 'Expense'),
(7, 'Medical', 'Expense'),
(8, 'Travel', 'Expense'),
(9, 'Education', 'Expense');

-- Transactions
INSERT INTO Transactions (TransactionID, UserID, AccountID, CategoryID, Amount, TransactionType, TransactionDate, Description) VALUES
(1, 1, 1, 1, 30000.00, 'Income', '2025-01-01', 'Salary Jan'),
(2, 1, 1, 4, 3500.00, 'Expense', '2025-01-10', 'Groceries Jan'),
(3, 1, 1, 3, 8500.00, 'Expense', '2025-01-03', 'Rent Jan'),
(4, 1, 1, 1, 30000.00, 'Income', '2025-02-01', 'Salary Feb'),
(5, 1, 1, 4, 3600.00, 'Expense', '2025-02-08', 'Groceries Feb'),
(6, 1, 1, 3, 8500.00, 'Expense', '2025-02-05', 'Rent Feb'),
(7, 1, 1, 1, 31000.00, 'Income', '2025-03-01', 'Salary Mar'),
(8, 1, 1, 4, 3450.00, 'Expense', '2025-03-09', 'Groceries Mar'),
(9, 2, 2, 2, 15000.00, 'Income', '2025-02-01', 'Freelance Feb'),
(10, 2, 2, 5, 1800.00, 'Expense', '2025-02-06', 'Electricity Feb'),
(11, 2, 2, 2, 16000.00, 'Income', '2025-03-01', 'Freelance Mar'),
(12, 2, 2, 5, 1900.00, 'Expense', '2025-03-07', 'Electricity Mar'),
(13, 2, 2, 2, 15500.00, 'Income', '2025-04-01', 'Freelance Apr'),
(14, 2, 2, 5, 2000.00, 'Expense', '2025-04-04', 'Electricity Apr'),
(15, 3, 3, 1, 28000.00, 'Income', '2025-03-01', 'Salary Mar'),
(16, 3, 3, 6, 1600.00, 'Expense', '2025-03-10', 'Dining Mar'),
(17, 3, 3, 1, 29000.00, 'Income', '2025-04-01', 'Salary Apr'),
(18, 3, 3, 6, 1700.00, 'Expense', '2025-04-11', 'Dining Apr'),
(19, 3, 3, 1, 28000.00, 'Income', '2025-05-01', 'Salary May'),
(20, 3, 3, 6, 1650.00, 'Expense', '2025-05-09', 'Dining May'),
(21, 4, 4, 1, 29000.00, 'Income', '2025-04-01', 'Salary Apr'),
(22, 4, 4, 7, 3200.00, 'Expense', '2025-04-11', 'Medical Apr'),
(23, 4, 4, 1, 28500.00, 'Income', '2025-05-01', 'Salary May'),
(24, 4, 4, 7, 3100.00, 'Expense', '2025-05-09', 'Medical May'),
(25, 4, 4, 1, 29000.00, 'Income', '2025-06-01', 'Salary Jun'),
(26, 4, 4, 7, 3300.00, 'Expense', '2025-06-07', 'Medical Jun'),
(27, 5, 5, 1, 27000.00, 'Income', '2025-05-01', 'Salary May'),
(28, 5, 5, 3, 9700.00, 'Expense', '2025-05-05', 'Rent May'),
(29, 5, 5, 4, 4000.00, 'Expense', '2025-05-10', 'Groceries May'),
(30, 5, 5, 1, 27500.00, 'Income', '2025-06-01', 'Salary Jun'),
(31, 5, 5, 3, 9700.00, 'Expense', '2025-06-05', 'Rent Jun'),
(32, 5, 5, 4, 3900.00, 'Expense', '2025-06-11', 'Groceries Jun'),
(33, 5, 5, 1, 28000.00, 'Income', '2025-07-01', 'Salary Jul'),
(34, 5, 5, 3, 9700.00, 'Expense', '2025-07-03', 'Rent Jul'),
(35, 5, 5, 4, 4100.00, 'Expense', '2025-07-08', 'Groceries Jul');


-- Budgets
INSERT INTO Budgets (UserID, CategoryID, Month, BudgetAmount, CreatedAt) VALUES
(1, 4, '2025-01-01', 4000.00, '2025-01-01'),
(1, 3, '2025-01-01', 9000.00, '2025-01-01'),
(2, 5, '2025-02-01', 2000.00, '2025-02-01'),
(3, 6, '2025-03-01', 1500.00, '2025-03-01'),
(4, 7, '2025-04-01', 3000.00, '2025-04-01'),
(5, 3, '2025-05-01', 9000.00, '2025-05-01'),
(5, 4, '2025-05-01', 3500.00, '2025-05-01');

-- TransactionTags
INSERT INTO TransactionTags (TransactionID, TagID) VALUES 
(2,1), (3,2), (5,4), (7,5), (9,6), (11,2), (12,1), (14,8), (16,4), (18,6), 
(20,7), (22,1), (23,3), (24,10), (26,8), (28,9), (29,6), (30,5), (31,1), 
(32,3), (33,10), (34,4), (35,8);


--  RecurringTransactions
INSERT INTO RecurringTransactions 
(UserID, AccountID, CategoryID, Amount, Frequency, StartDate, NextDueDate, EndDate, Description) 
VALUES
(1, 1, 3, 8500.00, 'Monthly', '2024-12-01', '2025-07-25', '2025-12-01', 'House Rent'),
(2, 2, 5, 1800.00, 'Monthly', '2025-02-15', '2025-08-01', '2026-01-15', 'Electricity Bill'),
(3, 3, 6, 1600.00, 'Monthly', '2025-05-10', '2025-07-31', '2025-10-10', 'Restaurant Membership'),
(4, 4, 7, 3200.00, 'Monthly', '2025-03-20', '2025-08-25', '2026-03-20', 'Medical Insurance'),
(5, 5, 3, 9700.00, 'Monthly', '2025-01-01', '2025-07-31', '2025-12-31', 'Rent Payment'),
(1, 1, 4, 3400.00, 'Monthly', '2025-04-05', '2025-08-01', '2025-11-05', 'Grocery Refill'),
(2, 2, 6, 2100.00, 'Quarterly', '2025-01-01', '2025-10-01', '2026-01-01', 'Streaming Subscription'),
(3, 3, 9, 4700.00, 'Quarterly', '2025-04-01', '2025-07-01', '2026-04-01', 'Online Course Payment'),
(4, 4, 1, 29000.00, 'Monthly', '2025-07-01', '2025-08-01', '2026-06-30', 'Salary Crediting'),
(5, 5, 4, 3900.00, 'Monthly', '2025-05-15', '2025-07-27', '2025-12-15', 'Grocery Home Delivery');


--  Insert SavingsGoals
INSERT INTO SavingsGoals (UserID, GoalName, TargetAmount, CurrentAmount, TargetDate, Status, Description) VALUES
(1, 'Buy New Furniture', 40000.00, 15000.00, '2025-08-10', 'Active', 'Furniture upgrade for home'),
(2, 'Trip to Goa', 30000.00, 12000.00, '2025-09-05', 'Active', 'Travel plan with friends'),
(3, 'Home Repair Fund', 50000.00, 20000.00, '2025-08-20', 'Active', 'Renovation of kitchen and roof'),
(1, 'Emergency Fund', 30000.00, 27000.00, '2025-12-31', 'Active', 'Ongoing safety savings'),
(2, 'Car Down Payment', 100000.00, 70000.00, '2025-11-30', 'Active', 'First car plan'),
(3, 'Pet Care Fund', 20000.00, 18000.00, '2025-10-15', 'Active', 'For vet, food, and care'),
(4, 'Gadget Upgrade', 35000.00, 20000.00, '2025-12-01', 'Active', 'Buying tablet/laptop'),
(4, 'Laptop Purchase', 60000.00, 60000.00, '2025-06-01', 'Completed', 'Bought new MacBook'),
(5, 'Emergency Savings', 25000.00, 25000.00, '2025-07-01', 'Completed', 'Fund fully met before date'),
(2, 'Wedding Budget', 120000.00, 25000.00, '2025-03-01', 'Cancelled', 'Postponed wedding'),
(3, 'Stock Market Fund', 50000.00, 18000.00, '2025-04-01', 'Failed', 'Missed deadline'),
(5, 'College Tuition', 90000.00, 20000.00, '2025-05-20', 'Failed', 'Did not save enough');



-
-- STEP 4: Validation Queries

SHOW TABLES;
SELECT * FROM USERS;
SELECT * FROM ACCOUNTS;
SELECT * FROM BUDGETS;
SELECT * FROM CATEGORIES;
SELECT * FROM SAVINGSGOALS;
SELECT * FROM RECURRINGTRANSACTIONS;
SELECT * FROM TRANSACTIONS;
SELECT * FROM TAGS;
SELECT * FROM TRANSACTIONTAGS;

-- STEP 5 :QUERIES

-- QUERY 1
SELECT YEAR(TRANSACTIONDATE), U.USERNAME ,MONTH(T.TRANSACTIONDATE) AS MONTH_NUMBER, MONTHNAME(T.TRANSACTIONDATE) AS MONTH_NAME,
C.CATEGORYNAME AS CATEGORY, SUM(T.AMOUNT) AS TOTAL_EXPENDITURE
FROM TRANSACTIONS T 
INNER JOIN   USERS U ON U.USERID=T.USERID 
INNER JOIN CATEGORIES C ON C.CATEGORYID=T.CATEGORYID
WHERE T.TRANSACTIONTYPE='Expense'AND  T.TRANSACTIONDATE >= CURDATE() - INTERVAL 6 MONTH
GROUP BY YEAR(TRANSACTIONDATE),U.USERNAME ,C.CATEGORYNAME, 
MONTH(T.TRANSACTIONDATE), MONTHNAME(T.TRANSACTIONDATE) 
ORDER BY YEAR(TRANSACTIONDATE),MONTH(T.TRANSACTIONDATE);

-- QUERY 2
SET @LoggedInUSERID=1;
SELECT U.USERNAME,YEAR(T.TRANSACTIONDATE),MONTH(T.TRANSACTIONDATE) AS MONTH_NUMBER, 
MONTHNAME(T.TRANSACTIONDATE) AS MONTH_NAME,(T.TRANSACTIONTYPE),SUM(T.AMOUNT) AS AMOUNT
FROM TRANSACTIONS T
INNER JOIN USERS U ON  U.USERID=T.USERID
WHERE (U.USERID= @LoggedInUSERID)  GROUP BY  U.USERID,YEAR(T.TRANSACTIONDATE), MONTH_NUMBER, MONTHNAME(T.TRANSACTIONDATE) ,T.TRANSACTIONTYPE
ORDER BY YEAR(T.TRANSACTIONDATE),MONTH(T.TRANSACTIONDATE);

-- QUERY 3
SET @loginUSERID = 5;
SELECT U.USERNAME,Sub.MonthName,Sub.YearVal,Sub.CategoryID,
(SELECT SUM(B1.BudgetAmount) FROM Budgets B1
WHERE B1.UserID = @loginUSERID AND B1.CategoryID = Sub.CategoryID
AND MONTH(B1.Month) = Sub.MonthVal AND YEAR(B1.Month) = Sub.YearVal) AS BudgetAmount,
(SELECT SUM(T2.Amount) FROM Transactions T2
WHERE T2.TransactionType = 'Expense' AND T2.UserID = @loginUSERID 
AND T2.CategoryID = Sub.CategoryID AND MONTH(T2.TransactionDate) = Sub.MonthVal
AND YEAR(T2.TransactionDate) = Sub.YearVal) AS Expenditure,
((SELECT SUM(T2.Amount) FROM Transactions T2
WHERE T2.TransactionType = 'Expense' AND T2.UserID = @loginUSERID 
AND T2.CategoryID = Sub.CategoryID AND MONTH(T2.TransactionDate) = Sub.MonthVal 
AND YEAR(T2.TransactionDate) = Sub.YearVal) -
(SELECT SUM(B1.BudgetAmount) FROM Budgets B1
WHERE B1.UserID = @loginUSERID AND B1.CategoryID = Sub.CategoryID 
AND MONTH(B1.Month) = Sub.MonthVal AND YEAR(B1.Month) = Sub.YearVal)) AS ExceededAmount
FROM
(SELECT DISTINCT T.CategoryID,MONTH(T.TransactionDate) AS MonthVal,
YEAR(T.TransactionDate) AS YearVal,MONTHNAME(T.TransactionDate) AS MonthName
FROM Transactions T WHERE  T.UserID = @loginUSERID AND T.TransactionType = 'Expense')
AS Sub, Users U
WHERE 
U.UserID = @loginUSERID AND (
(SELECT SUM(T2.Amount)FROM Transactions T2
WHERE T2.TransactionType = 'Expense' AND T2.UserID = @loginUSERID
AND T2.CategoryID = Sub.CategoryID AND MONTH(T2.TransactionDate) = Sub.MonthVal
AND YEAR(T2.TransactionDate) = Sub.YearVal) >
(SELECT SUM(B1.BudgetAmount)
FROM Budgets B1
WHERE B1.UserID = @loginUSERID
AND B1.CategoryID = Sub.CategoryID
AND MONTH(B1.Month) = Sub.MonthVal
AND YEAR(B1.Month) = Sub.YearVal));

-- QUERY 4
CREATE VIEW NetMonthlyBalanceView AS
SELECT DISTINCT T.USERID, U.USERNAME,
       YEAR(T.TRANSACTIONDATE) AS YEAR,
       MONTHNAME(T.TRANSACTIONDATE) AS MONTH,
       (
         (SELECT SUM(T1.AMOUNT) FROM TRANSACTIONS T1
          WHERE T1.TRANSACTIONTYPE='Income' AND T.USERID=T1.USERID
            AND MONTHNAME(T.TRANSACTIONDATE)=MONTHNAME(T1.TRANSACTIONDATE)
            AND YEAR(T.TRANSACTIONDATE)=YEAR(T1.TRANSACTIONDATE))
         -
         (SELECT SUM(T1.AMOUNT) FROM TRANSACTIONS T1
          WHERE T1.TRANSACTIONTYPE='Expense' AND T.USERID=T1.USERID
            AND MONTHNAME(T.TRANSACTIONDATE)=MONTHNAME(T1.TRANSACTIONDATE)
            AND YEAR(T.TRANSACTIONDATE)=YEAR(T1.TRANSACTIONDATE))
       ) AS NET_BALANCE,
       CASE
         WHEN (
           (SELECT SUM(T1.AMOUNT) FROM TRANSACTIONS T1
            WHERE T1.TRANSACTIONTYPE='Income' AND T.USERID=T1.USERID
              AND MONTHNAME(T.TRANSACTIONDATE)=MONTHNAME(T1.TRANSACTIONDATE)
              AND YEAR(T.TRANSACTIONDATE)=YEAR(T1.TRANSACTIONDATE))
           -
           (SELECT SUM(T1.AMOUNT) FROM TRANSACTIONS T1
            WHERE T1.TRANSACTIONTYPE='Expense' AND T.USERID=T1.USERID
              AND MONTHNAME(T.TRANSACTIONDATE)=MONTHNAME(T1.TRANSACTIONDATE)
              AND YEAR(T.TRANSACTIONDATE)=YEAR(T1.TRANSACTIONDATE))
         ) >= 0
         THEN 'POSITIVE'
         ELSE 'NEGATIVE'
       END AS STATUS
FROM TRANSACTIONS T
INNER JOIN USERS U ON T.USERID = U.USERID;

SELECT * FROM NetMonthlyBalanceView;

-- QUERY 5
SELECT u.username as USERNAME ,ta.tagNAME AS TAGNAME, 
(select sum(T1.amount) from transactions t1,transactiontags tt1 
where  transactiontype='Expense' and t.userid = t1.userid and tt.tagid=tt1.tagid and tt1.transactionid= t1.transactionid 
group by t1.userid having sum(t1.amount)>2000) 
as TOTAL_EXPENSE_AMOUNT
from transactions t 
inner join transactiontags tt on tt.transactionid=t.transactionid
inner join users u on t.userid=u.userid
inner join tags ta on ta.tagid= tt.tagid
WHERE 
T.TRANSACTIONID =TT.TRANSACTIONID AND t.transactiontype="Expense"AND AMOUNT>2000 ;

-- QUERY 6
SELECT U.USERNAME ,A.ACCOUNTNAME , A.ACCOUNTTYPE , 
CASE WHEN (A.CURRENTBALANCE) <1000 THEN 'LOW BALANCE ALERT' ELSE 'SUFFICIENT BALANCE' END AS BALANCE_ALERT_MESSAGE
FROM ACCOUNTS A
INNER JOIN USERS U ON U.USERID=A.USERID;

-- QUERY 7
SELECT U.USERNAME ,S.GOALNAME,   
CASE
WHEN(
S.STATUS ='Active' AND 
TIMESTAMPDIFF(MONTH, CURRENT_DATE(), S.TARGETDATE)  <2 and
S.CURRENTAMOUNT<(S.TARGETAMOUNT*0.5) )
THEN 
'GOAL AT RISK' 
ELSE
'ON TRACK'
END AS SUGGESTION
FROM SAVINGSGOALS S 
INNER JOIN USERS U ON U.USERID= S.USERID
WHERE STATUS ='Active';

-- QUERY 8
SELECT U.USERNAME , R.FREQUENCY,R.NEXTDUEDATE ,R.AMOUNT,R.DESCRIPTION
FROM RECURRINGTRANSACTIONS R
INNER JOIN USERS U ON U.USERID=R.USERID
WHERE( (timestampdiff(DAY,CURRENT_DATE(), NEXTDUEDATE))<=10)
ORDER BY R.NEXTDUEDATE;

-- QUERY 9
WITH MonthlyExpenses AS (
  SELECT U.UserID AS USERID,U.UserName AS USERNAME,YEAR(T.TransactionDate) AS YEAR,MONTH(T.TransactionDate) AS MONTH,
  SUM(T.Amount) AS TotalExpense
  FROM Transactions T
  INNER JOIN Users U ON U.UserID = T.UserID
  WHERE T.TransactionType = 'Expense'
  GROUP BY U.UserID, YEAR(T.TransactionDate), MONTH(T.TransactionDate)),
LaggedExpenses AS (
  SELECT USERID,USERNAME,YEAR,MONTH,
TotalExpense,
    LAG(TotalExpense) OVER (PARTITION BY USERID ORDER BY YEAR, MONTH) AS PrevMonthExpense
  FROM MonthlyExpenses
)
SELECT USERID,USERNAME,YEAR,MONTH,TotalExpense, PrevMonthExpense,
  (TotalExpense - PrevMonthExpense) AS CHANGES,
  CASE
    WHEN (TotalExpense - PrevMonthExpense) > 0 THEN 'Increase'
    WHEN (TotalExpense - PrevMonthExpense) < 0 THEN 'Decrease'
    ELSE 'No Change'
  END AS Trend
FROM LaggedExpenses
WHERE PrevMonthExpense IS NOT NULL;
