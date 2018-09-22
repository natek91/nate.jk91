DROP TABLE tblProductLab9;
DROP TABLE tblVendorLab9;

DROP SEQUENCE seq_ProductID_PK;

CREATE TABLE tblVendorLab9
(
VendorID Number(38) Primary Key,
VendorName VARCHAR2(35) NOT NULL,
VendorContact VARCHAR2(30),
VendorContactPhone VARCHAR2(14)
)
;

CREATE TABLE tblProductLab9
(
ProductID Number(38) Primary Key,
VendorID Number(38),
ProductDesc VARCHAR2(30) NOT NULL UNIQUE,
ProductCost Number(6,2) CHECK(ProductCost >0),
ProductSell Number(6,2),
Constraint SellGreaterThanCost CHECK(ProductSell >= ProductCost),
CONSTRAINT fk_tblProduct_VendorID FOREIGN KEY (VendorID) REFERENCES tblVendorLab9(VendorID)
)
;





-- Create a sequence with the following properties:
/*
Name: seq_ProductID_PK
Starting value: 1
Increment value: 1
Maximum value: None
Cache: None
*/
CREATE SEQUENCE seq_ProductID_PK
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCACHE;


-- Add the following data to the Vendor table
/*VendorID: 1
VendorName: Acme Corp.
VendorContact: Bob Smith
VendorContactPhone: 416-555-9087

VendorID: 2
VendorName: Hewlett Packard
VendorContact:
VendorPhone: 416-555-3234*/

INSERT ALL
    INTO tblVendorLab9 VALUES (1, 'Acme Copr.', 'Bob Smith', '416-557-9087')
    INTO tblVendorLab9 VALUES (2, 'Hewlett Packard', NULL, '416-555-3234')
SELECT * FROM dual;



-- Use the sequence created in question 1 to poulate the Product table
/*ProductID: use sequence
VendorID: 1
ProductDesc: Dell Mouse
ProductCost: 25
ProductSell: 50

ProductID: use sequence
VendorID: 2
ProductDesc: HP Pavilion
ProductCost: 230
ProductSell: 670

ProductID: use sequence
VendorID: 1
ProductDesc: Acer HD Monitor
ProductCost: 55
ProductSell: 128*/

INSERT INTO tblProductLab9 VALUES (seq_ProductID_PK.NEXTVAL, 1, 'Dell Mouse', 25, 50);


INSERT INTO tblProductLab9 VALUES (seq_ProductID_PK.NEXTVAL, 2, 'HP Pavilion', 230, 670);
    
INSERT INTO tblProductLab9 VALUES (seq_ProductID_PK.NEXTVAL, 1, 'Acer HD Monitor', 55, 128);



/*-- change the cost and sell price of the HP Pavilion product created above to the following.  Use one statement.
ProductCost: 195
ProductSell: 650
*/
UPDATE tblProductLab9
SET ProductCost = 195,
	ProductSell = 650
WHERE ProductID = 2;


-- To reset the sequence value to 1
SELECT seq_ProductID_PK.CURRVAL FROM dual;

-- we need to then decrement it by -2 to reset its value to 1:
ALTER SEQUENCE seq_ProductID_PK
INCREMENT BY -2;

--Run this command to check the sequence:
SELECT last_number FROM user_sequences WHERE sequence_name='SEQ_PRODUCTID_PK';

--Run this command to reset the sequence:
SELECT seq_ProductID_PK.NEXTVAL FROM dual;

--And then, restore the increment of the sequence to 'by 1' again:
ALTER SEQUENCE seq_ProductID_PK
INCREMENT BY 1;


INSERT INTO tblProductLab9 VALUES (seq_ProductID_PK.NEXTVAL, 1, 'Dell Mouse', 25, 50);


SELECT last_number FROM user_sequences WHERE sequence_name='SEQ_PRODUCTID_PK';

SELECT * FROM tblProductLab9;
SELECT * FROM tblVendorLab9;