-- Assignment3.sql
--


DROP TABLE IF EXISTS tblAccount;	-- Tells you which Hospital the product was sold to
DROP TABLE IF EXISTS tblProduct;	-- Tells you which Product was sold
DROP TABLE IF EXISTS tblTerritory;	-- Tells you which Sales Rep should get credit
DROP TABLE IF EXISTS tblSales; 		-- Tells you what hospital bought which Product and which Territory/Sales Rep gets the Credit 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE tblAccount
(
  Accountid 	int PRIMARY KEY NOT NULL,
  AccountName 	VARCHAR NOT NULL,
  Address 	VARCHAR,
  City 		VARCHAR,
  State 	VARCHAR,
  Zip 		VARCHAR
);

INSERT INTO tblAccount ( Accountid, AccountName, Address, City, State, Zip ) VALUES ( 191043400, 'The Hospital of the University of Pennsylvania', '3400 Spruce Street', 'Philadelphia', 'PA', '19104' );
INSERT INTO tblAccount ( Accountid, AccountName, Address, City, State, Zip ) VALUES ( 90095757, 'Ronald Reagan UCLA Medical Center', '757 Westwood Plaza', 'Los Angeles', 'CA', '90095');
INSERT INTO tblAccount ( Accountid, AccountName, Address, City, State, Zip ) VALUES ( 752463501, 'Baylor University Medical Center', '3501 Junius Street', 'Dallas', 'TX', '75246');
INSERT INTO tblAccount ( Accountid, AccountName, Address, City, State, Zip ) VALUES ( 60611251, 'Northwestern Memorial Hospital', '251 East Huron Street', 'Chicago', 'IL', '60611');

SELECT * FROM tblAccount;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE tblProduct
(
  Productid 	int PRIMARY KEY NOT NULL,
  ProductName 	VARCHAR NOT NULL,
  GenericName 	VARCHAR NOT NULL,
  Indication 	VARCHAR,
  Strength	FLOAT,
  Price 	FLOAT 
);

INSERT INTO tblProduct ( Productid , ProductName, GenericName, Indication, Strength, Price) VALUES ( 1, 'Aldara', 'Imiquimod', 'Actinic Keratosis',3.75, 181.93 );
INSERT INTO tblProduct ( Productid , ProductName, GenericName, Indication, Strength, Price) VALUES ( 2, 'Zyclara', 'Imiquimod Topical', 'Actinic Keratosis',2.5, 1106.15 );
INSERT INTO tblProduct ( Productid , ProductName, GenericName, Indication, Strength, Price) VALUES ( 3, 'Carac Topical', 'FLUOROURACIL', 'Multiple actinic or solar keratoses',0.05, 888.23 );
INSERT INTO tblProduct ( Productid , ProductName, GenericName, Indication, Strength, Price) VALUES ( 4, 'Fluorouracil Topical', 'FLUOROURACIL', 'Multiple actinic or solar keratoses',2.5 ,86.18);
INSERT INTO tblProduct ( Productid , ProductName, GenericName, Indication, Strength, Price) VALUES ( 5, 'Efudex Topical', 'FLUOROURACIL', 'Multiple actinic or solar keratoses',3.5, 96.23);


SELECT * FROM tblProduct;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE tblTerritory
(
  Zip 		 VARCHAR PRIMARY KEY NOT NULL,
  City 		 VARCHAR,
  STATE 	 VARCHAR,
  TerritoryID 	 VARCHAR,
  TerritoryName VARCHAR
 );

 INSERT INTO tblTerritory(Zip, City, State, TerritoryID, TerritoryName) VALUES (19104, 'Philadelphia', 'PA', 1011, 'TriState');
 INSERT INTO tblTerritory(Zip, City, State, TerritoryID, TerritoryName) VALUES (90095, 'Los Angeles', 'CA', 2011, 'California');
 INSERT INTO tblTerritory(Zip, City, State, TerritoryID, TerritoryName) VALUES (75246, 'Dallas', 'TX', 3011, 'Texas');
 INSERT INTO tblTerritory(Zip, City, State, TerritoryID, TerritoryName) VALUES (60611, 'Chicago', 'IL', 4011, 'MidWest');
 
     
 SELECT * FROM tblTerritory;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE TABLE tblSales
(
  SalesID	 int PRIMARY KEY NOT NULL,
  SalesDate	 date,
  ProductID 	 int,
  Accountid 	 int,
  Quantity 	 int
 );

 INSERT INTO tblSales(SalesID, SalesDate, ProductID, Accountid, Quantity) VALUES (1,  '1/5/2014',  1, 191043400, 10);
 INSERT INTO tblSales(SalesID, SalesDate, ProductID, Accountid, Quantity) VALUES (2,  '3/5/2014',  5, 90095757 , 8);
 INSERT INTO tblSales(SalesID, SalesDate, ProductID, Accountid, Quantity) VALUES (3,  '4/9/2014',  3, 752463501, 6);
 INSERT INTO tblSales(SalesID, SalesDate, ProductID, Accountid, Quantity) VALUES (4,  '5/3/2014',  1, 90095757 , 10);
 INSERT INTO tblSales(SalesID, SalesDate, ProductID, Accountid, Quantity) VALUES (5,  '5/12/2014', 2, 191043400, 5);
 INSERT INTO tblSales(SalesID, SalesDate, ProductID, Accountid, Quantity) VALUES (6,  '6/13/2014', 5, 752463501, 3);
 INSERT INTO tblSales(SalesID, SalesDate, ProductID, Accountid, Quantity) VALUES (7,  '7/1/2014',  5, 752463501, 2);
 INSERT INTO tblSales(SalesID, SalesDate, ProductID, Accountid, Quantity) VALUES (8,  '8/2/2014',  3, 191043400, 3);
 INSERT INTO tblSales(SalesID, SalesDate, ProductID, Accountid, Quantity) VALUES (9,  '9/1/2014',  4, 60611251 , 20);
 INSERT INTO tblSales(SalesID, SalesDate, ProductID, Accountid, Quantity) VALUES (10, '10/11/2014',3, 191043400, 30);
 INSERT INTO tblSales(SalesID, SalesDate, ProductID, Accountid, Quantity) VALUES (11, '11/26/2014',1, 60611251 , 8);
 
     
 SELECT * FROM tblSales;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


select Territoryname,  ta.accountname, ta.address, ta.city, ta.zip, tp.productname, sum(quantity)as Quanity, Sum(quantity*price) as TotalPrice
from tblSales ts 
inner join tblaccount ta on ts.accountid = ta.accountid  
inner join tblProduct tp on ts.productid = tp.productid
inner join tblTerritory tt on ta.zip = tt.zip
group by Territoryname, ta.accountname, ta.address, ta.city, ta.zip, tp.productname
order by Territoryname, accountname, productname
