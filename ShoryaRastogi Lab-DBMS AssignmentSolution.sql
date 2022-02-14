create schema if not exists ecom;
 
use ecom;

/* Q:1*/
CREATE TABLE IF NOT EXISTS Supplier (
    SUPP_ID INT PRIMARY KEY AUTO_INCREMENT,
    SUPP_NAME VARCHAR(50) NULL DEFAULT NULL,
    SUPP_CITY VARCHAR(50),
    SUPP_PHONE BIGINT
);
CREATE TABLE IF NOT EXISTS Customer (
    CUS_ID INT PRIMARY KEY AUTO_INCREMENT,
    CUS_NAME VARCHAR(50) NULL DEFAULT NULL,
    CUS_PHONE BIGINT,
    CUS_CITY VARCHAR(50),
    CUS_GENDER VARCHAR(20)
);
CREATE TABLE IF NOT EXISTS Category (
    CAT_ID INT PRIMARY KEY AUTO_INCREMENT,
    CAT_NAME VARCHAR(50) NULL DEFAULT NULL
);
CREATE TABLE IF NOT EXISTS Product (
    PRO_ID INT PRIMARY KEY AUTO_INCREMENT,
    PRO_NAME VARCHAR(20) NULL DEFAULT NULL,
    PRO_DESC VARCHAR(50) NULL DEFAULT NULL,
    CAT_ID INT,
    FOREIGN KEY (CAT_ID)
        REFERENCES Category (CAT_ID)
);
CREATE TABLE IF NOT EXISTS ProductDetails (
    PROD_ID INT PRIMARY KEY AUTO_INCREMENT,
    PRO_ID INT NOT NULL,
    SUPP_ID INT NOT NULL,
    PRICE FLOAT NOT NULL,
    FOREIGN KEY (PRO_ID)
        REFERENCES Product (PRO_ID),
    FOREIGN KEY (SUPP_ID)
        REFERENCES Supplier (SUPP_ID)
);
CREATE TABLE IF NOT EXISTS Orders (
    ORD_ID INT PRIMARY KEY AUTO_INCREMENT,
    ORD_AMOUNT FLOAT NOT NULL,
    ORD_DATE DATE,
    CUS_ID INT NOT NULL,
    PROD_ID INT NOT NULL,
    FOREIGN KEY (PROD_ID)
        REFERENCES ProductDetails (PROD_ID),
    FOREIGN KEY (CUS_ID)
        REFERENCES Customer (CUS_ID)
);
CREATE TABLE IF NOT EXISTS Rating (
    RAT_ID INT PRIMARY KEY AUTO_INCREMENT,
    CUS_ID INT NOT NULL,
    SUPP_ID INT NOT NULL,
    RAT_RATSTARS INT,
    FOREIGN KEY (CUS_ID)
        REFERENCES Customer (CUS_ID),
    FOREIGN KEY (SUPP_ID)
        REFERENCES Supplier (SUPP_ID)
);


/* Q:2*/
insert into  Supplier ( SUPP_NAME, SUPP_CITY, SUPP_PHONE) values ('Rajesh Retails', 'Delhi', 1234567890);
insert into  Supplier ( SUPP_NAME, SUPP_CITY, SUPP_PHONE) values ('Appario Ltd.', 'Mumbai', 25689631470);
insert into  Supplier ( SUPP_NAME, SUPP_CITY, SUPP_PHONE) values ('Knome Products', 'Banglore', 9785462315);
insert into  Supplier ( SUPP_NAME, SUPP_CITY, SUPP_PHONE) values ('Bansal Retails', 'Kochi', 8975463285);
insert into  Supplier ( SUPP_NAME, SUPP_CITY, SUPP_PHONE) values ('Mittal Ltd.', 'Lucknow', 7898456532);

insert into  Customer ( CUS_NAME, CUS_PHONE, CUS_CITY, CUS_GENDER) values ('AAKASH',9999999999,'DELHI','M');
insert into  Customer ( CUS_NAME, CUS_PHONE, CUS_CITY, CUS_GENDER) values ('AMAN',9785463215,'NOIDA','M');
insert into  Customer ( CUS_NAME, CUS_PHONE, CUS_CITY, CUS_GENDER) values ('NEHA',9999999999,'MUMBAI','F');
insert into  Customer ( CUS_NAME, CUS_PHONE, CUS_CITY, CUS_GENDER) values ('MEGHA',9994562399,'KOLKATA','F');
insert into  Customer ( CUS_NAME, CUS_PHONE, CUS_CITY, CUS_GENDER) values ('PULKIT',7895999999,'LUCKNOW','M');

insert into Category (CAT_NAME) values ('BOOKS');
insert into Category (CAT_NAME) values ('GAMES');
insert into Category (CAT_NAME) values ('GROCERIES');
insert into Category (CAT_NAME) values ('ELECTRONICS');
insert into Category (CAT_NAME) values ('CLOTHES'); 

insert into Product (PRO_NAME, PRO_DESC ,CAT_ID) values ('GTA V', 'DFJDJFDJFDJFDJFJF',2);
insert into Product (PRO_NAME, PRO_DESC ,CAT_ID) values ('TSHIRT', 'DFDFJDFJDFKFD',5);
insert into Product (PRO_NAME, PRO_DESC ,CAT_ID) values ('ROG LAPTOP', 'DFNTTNTNTERND',4);
insert into Product (PRO_NAME, PRO_DESC ,CAT_ID) values ('OATS', 'REYRENTBTOTH',3);
insert into Product (PRO_NAME, PRO_DESC ,CAT_ID) values ('HARRY POTTER', 'NBEMCTHTJTH',1);

insert into ProductDetails (PRO_ID, SUPP_ID, PRICE) values (1,2,1500);
insert into ProductDetails (PRO_ID, SUPP_ID, PRICE) values (3,5,30000);
insert into ProductDetails (PRO_ID, SUPP_ID, PRICE) values (5,1,3000);
insert into ProductDetails (PRO_ID, SUPP_ID, PRICE) values (2,3,2500);
insert into ProductDetails (PRO_ID, SUPP_ID, PRICE) values (4,1,1000);

insert into Orders (ORD_AMOUNT, ORD_DATE, CUS_ID, PROD_ID) values (1500,'2021-10-12',3,5);
insert into Orders (ORD_AMOUNT, ORD_DATE, CUS_ID, PROD_ID) values (30500,'2021-09-16',5,2);
insert into Orders (ORD_AMOUNT, ORD_DATE, CUS_ID, PROD_ID) values (2000,'2021-10-05',1,1);
insert into Orders (ORD_AMOUNT, ORD_DATE, CUS_ID, PROD_ID) values (3500,'2021-08-06',4,3);
insert into Orders (ORD_AMOUNT, ORD_DATE, CUS_ID, PROD_ID) values (2000,'2021-10-06',2,1);


insert into Rating (CUS_ID, SUPP_ID, RAT_RATSTARS) values (2,2,4);
insert into Rating (CUS_ID, SUPP_ID, RAT_RATSTARS) values (3,4,3);
insert into Rating (CUS_ID, SUPP_ID, RAT_RATSTARS) values (5,1,5);
insert into Rating (CUS_ID, SUPP_ID, RAT_RATSTARS) values (1,3,2);
insert into Rating (CUS_ID, SUPP_ID, RAT_RATSTARS) values (4,5,4);



/* Q:3*/
SELECT 
    Customer.CUS_GENDER, COUNT(Customer.CUS_GENDER) AS Count
FROM
    Customer
        INNER JOIN
    Orders ON Customer.CUS_ID = Orders.CUS_ID
WHERE
    ORD_AMOUNT >= 3000
GROUP BY CUS_GENDER;


/* Q:4*/
SELECT 
    Orders.*, Product.PRO_NAME
FROM
    Orders,
    Product,
    ProductDetails
WHERE
    Orders.CUS_ID = 2
        AND Orders.PROD_ID = ProductDetails.PROD_ID
        AND ProductDetails.PRO_ID = Product.PRO_ID;


/* Q:5*/
SELECT 
    Supplier.*
FROM
    Supplier,
    ProductDetails
WHERE
    Supplier.SUPP_ID IN (SELECT 
            ProductDetails.SUPP_ID
        FROM
            ProductDetails
        GROUP BY ProductDetails.SUPP_ID
        HAVING COUNT(ProductDetails.SUPP_ID) > 1)
GROUP BY SUPP_ID;


/* Q:6*/
SELECT 
    Category.*
FROM
    Orders
        INNER JOIN
    ProductDetails ON Orders.PROD_ID = ProductDetails.PROD_ID
        INNER JOIN
    Product ON Product.PRO_ID = ProductDetails.PRO_ID
        INNER JOIN
    Category ON Category.CAT_ID = Product.CAT_ID
HAVING MIN(Orders.ORD_AMOUNT);


/* Q:7*/
SELECT 
    Product.PRO_ID, Product.PRO_NAME
FROM
    Orders
        INNER JOIN
    ProductDetails ON ProductDetails.PROD_ID = Orders.PROD_ID
        INNER JOIN
    Product ON Product.PRO_ID = ProductDetails.PRO_ID
WHERE
    Orders.ORD_DATE > '2021-10-05';


/* Q:8*/
SELECT 
    Customer.CUS_NAME, Customer.CUS_NAME, Customer.CUS_GENDER
FROM
    Customer
WHERE
    Customer.CUS_NAME LIKE '%A'
        OR Customer.CUS_NAME LIKE 'A%';
																																	
/* Q:9 */
DELIMITER $$
USE ecom $$ 
CREATE PROCEDURE PROC_1()
BEGIN
SELECT Supplier.SUPP_ID , Supplier.SUPP_NAME ,Rating. RAT_RATSTARS, 
CASE 
WHEN Rating. RAT_RATSTARS > 4 THEN "Genuine Supplier"
WHEN Rating. RAT_RATSTARS > 2 THEN "Average Supplier"
ELSE "Supplier should not be considered"
END
AS VERDICT FROM Rating INNER JOIN Supplier ON Supplier.SUPP_ID = Rating.SUPP_ID;
END $$
CALL PROC_1;  
                                                                                                              