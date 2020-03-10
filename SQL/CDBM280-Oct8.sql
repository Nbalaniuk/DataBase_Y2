--LO4 and LO5 DDL

--Create a basic table with no constraints
--Crtl Enter to run the command your cursor is in or the big play button
--The small play button runs all scripts

CREATE TABLE Project (
  projectID NUMBER(4),
  projName VARCHAR2(25),
  department VARCHAR2(100),
  maxHours Number (6,1)
);


--Describe the table
DESC Project;

--Select form table
SELECT * FROM Project;

DROP TABLE Project;

--Create table exercise


--October 10th

CREATE TABLE SalesPeople (
  salesPersonNum NUMBER(4)CONSTRAINT SalesPeople_salesPersonNum PRIMARY KEY,
  salesPName VARCHAR2(15) CONSTRAINT SalesPeople_salesPName_nn NOT NULL,
  salesPCity VARCHAR2(15),
  commission NUMBER(3,2)DEFAULT 0.10 
                        CONSTRAINT SalesPeople_commision_cc CHECK((commission <1) AND (commission > 0))
                        
);

--Customer Table Create

CREATE TABLE Customer(
  customerNum NUMBER(4) CONSTRAINT Customer_customerNum PRIMARY KEY,
  cusName VARCHAR2(15) CONSTRAINT Customer_cusName_nn NOT NULL,
  cusCity VARCHAR2(15),
  cusRating NUMBER(3),
  salesPersonNum NUMBER(4) CONSTRAINT Customer_salesPersonNum_fk REFERENCES SalesPeople(salesPersonNum)
  
);

--Orders Table
CREATE TABLE Orders(
  orderNum NUMBER(4) CONSTRAINT Orders_orderNum PRIMARY KEY,
  orderAmount NUMBER(9,2) CONSTRAINT Orders_orderAmount_nn NOT NULL,
  orderDate DATE CONSTRAINT Orders_orderDate_nn NOT NULL,
  customerNum NUMBER(4) CONSTRAINT Orders_customerNum_fk REFERENCES Customer(customerNum)
                        CONSTRAINT Orders_customerNum_nn NOT NULL,
  salesPersonNum NUMBER(4) CONSTRAINT Orders_salesPersonNum_fk REFERENCES SalesPeople(salesPersonNum)                      

);


--EX1 P2#1
ALTER TABLE Orders ADD CONSTRAINT orders_cust_sales_uk UNIQUE(customerNum, salesPersonNum);
ALTER TABLE Orders DROP CONSTRAINT orders_cust_sales_uk;



--Ex1 A-T 1
ALTER TABLE SalesPeople DROP COLUMN commision;

--EX1 A-T 2
ALTER TABLE SalesPeople Add (maxSale NUMBER(8,2) DEFAULT 0);

--EX1 A-T 3
SELECT * FROM User_Constraints WHERE TABLE_NAME = 'SALESPEOPLE';
ALTER TABLE SalesPeople DROP CONSTRAINT salespeople_pname_nn;

--Ex1 A-T 4
ALTER TABLE Orders MODIFY (orderDate Date DEFAULT '01-JAN-12');


