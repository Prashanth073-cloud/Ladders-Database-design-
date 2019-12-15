--dropping customer TABLE--
DROP TABLE tp_ladder;

--creating ladder TABLE
CREATE TABLE tp_ladder(
ladder_id         INTEGER,
ladder_type       VARCHAR(50),
ladder_name       VARCHAR(50) NOT NULL,
ladder_discount   DECIMAL(3,2),
ladder_price      DECIMAL(8,2) NOT NULL,
ladder_weight     DECIMAL(5,2),
ladder_height     DECIMAL(5,2),
ladder_rating     DECIMAL(10,2),
warehouse_id      INTEGER
);

--creating primary key for ladder table
ALTER TABLE tp_ladder
ADD CONSTRAINT tp_ladder_ladder_id
PRIMARY KEY(ladder_id);

--giving constraint to discount so that they can enter only values between o and 100
ALTER TABLE tp_ladder
ADD CONSTRAINT tp_ladder_ladder_discount_ck
CHECK(ladder_discount BETWEEN 0 AND 100);

--giving constraint to ladder_rating so that they can enter only data between 0 and 10
ALTER TABLE tp_ladder
ADD CONSTRAINT tp_ladder_ladder_rating_ck
CHECK(ladder_rating BETWEEN 0 AND 10);





--dropping warehouse table
DROP TABLE tp_warehouse;

--create warehouse table
CREATE TABLE tp_warehouse(
warehouse_id        INTEGER,
warehouse_name      VARCHAR(60),
warehouse_country   VARCHAR(40),
warehouse_state     VARCHAR(40),
warehouse_city      VARCHAR(40),
warehouse_zipcode   VARCHAR(40)
);

--adding  primary key to warehouse table
ALTER TABLE tp_warehouse
ADD CONSTRAINT tp_warehouse_warehouse_id
PRIMARY KEY(warehouse_id);

-- inserting tables into warehouse table
INSERT INTO tp_warehouse
VALUES(101,'Prashanth ClimbHigh Ladders private limited','Canda','Ontario','Sarnia','N7T859'),
      (102,'Prashanth ClimbHigh Ladders private limited','Canda','Ontario','Toronto','P7T459');
    
-- selecing all values from warehouse_table
SELECT * FROM tp_warehouse;





--adding foreign key for ladders table
ALTER TABLE tp_ladder
ADD CONSTRAINT tp_ladder_warehouse_id_fk
FOREIGN KEY(warehouse_id)
REFERENCES tp_warehouse(warehouse_id);

--inserting values into ladder table
INSERT INTO tp_ladder
VALUES(1,'Attic Ladder','Attic',0,1000,12,10,5,101);

--inserting values into ladder table
INSERT INTO tp_ladder
VALUES(2,'Step Ladder','Step',0,1000,12,10,5,102);

--inserting values into ladder table
INSERT INTO tp_ladder
VALUES(3,'Extension Ladder','Extension',0,1000,12,10,5,102);

--inserting values into ladder table
INSERT INTO tp_ladder
VALUES(4,'Multi position Ladder','Mutli position',0,1000,12,10,5,102);

--inserting values into ladder table
INSERT INTO tp_ladder
VALUES(5,'Orchard Ladder','Orchard',0,1000,12,10,5,102);

--inserting values into ladder table
INSERT INTO tp_ladder
VALUES(6,'Platform Ladder','Platform',0,1000,12,10,5,102),
      (7,'Rolling Ladder','Rolling',0,1000,12,10,5,102),
      (8,'Safety Ladder','Safety',0,1000,12,10,5,102),
      (9,'Telescoping Ladder','Telescoping',0,1000,12,10,5,102),
      (10,'Twin StepLadder','Twin',0,1000,12,10,5,102);

--selecting all values from ladder table
SELECT * FROM tp_ladder;




--dropping customers table
DROP TABLE tp_customer;
--creating customer table
CREATE TABLE tp_customer(
customer_id                 INTEGER,
customer_number             DECIMAL(10,0),
customer_international_code VARCHAR(5),
ladder_id                   INTEGER,
order_id                    INTEGER
);

--creating primary key for the customer table
ALTER TABLE tp_customer
ADD CONSTRAINT tp_customer_customer_id_pk
PRIMARY KEY(customer_id);

--creating foreign key in customer table which references to ladder table
ALTER TABLE tp_customer
ADD CONSTRAINT tp_customer_ladder_id_fk
FOREIGN KEY(ladder_id)
REFERENCES tp_ladder(ladder_id);



--dropping order table
DROP TABLE tp_order;
--creating order table
CREATE TABLE tp_order(
order_id        INTEGER,
order_date      DATE NOT NULL,
order_total     DECIMAL(20,2) NOT NULL,
order_quantity  INTEGER NOT NULL,
order_tax       DECIMAL(5,2),
ladder_id       INTEGER        
);

--creating primary key for the order table
ALTER TABLE tp_order
ADD CONSTRAINT tp_order_order_id_pk
PRIMARY KEY(order_id);

--creating foreign key for the order table
ALTER TABLE tp_order
ADD CONSTRAINT tp_order_ladder_id_fk
FOREIGN KEY(ladder_id)
REFERENCES tp_ladder(ladder_id);

--inserting values into the order table
INSERT INTO tp_order
VALUES(201,'2019-10-23',1000,2,10,1),
      (202,'2019-10-24',2000,3,10,2),
      (203,'2019-11-23',3000,2,10,1),
      (204,'2019-12-23',1000,2,10,1),
      (205,'2019-10-20',1000,2,10,1),
      (206,'2019-10-13',1000,2,10,1),
      (207,'2019-10-16',1000,2,10,1),
      (208,'2019-10-19',1000,2,10,1),
      (209,'2019-10-10',1000,2,10,1),
      (210,'2019-05-23',1000,2,10,1);
 
--selecting all values from order table
SELECT * FROM tp_order;



--creating foreign key in customer table which references to order table
ALTER TABLE tp_customer
ADD CONSTRAINT tp_customer_order_id_fk
FOREIGN KEY(order_id)
REFERENCES tp_order(order_id);

--inserting values into customer table
INSERT INTO tp_customer
VALUES(301,1234567890,'+1',1,201),
      (302,1534567890,'+1',1,201),
      (303,1834567890,'+1',1,201),
      (304,1534567880,'+1',1,201),
      (305,1534567870,'+1',1,201);

--selecting all values from the customer table
SELECT * FROM tp_customer;





--dropping intersection table of order and ladder
DROP TABLE tp_ladder_order;
--creating intersection table of order and ladder
CREATE TABLE tp_ladder_order(
order_id      INTEGER,
ladder_id      INTEGER
);

--creating primary keys for the intersection table of order and ladder
ALTER TABLE tp_ladder_order
ADD CONSTRAINT tp_ladder_order_ladder_id_order_id_pk
PRIMARY KEY(order_id,ladder_id);

--creating ladder id foreign for the intersection table of order and ladder
ALTER TABLE tp_ladder_order
ADD CONSTRAINT tp_ladder_order_ladder_id_fk
FOREIGN KEY(ladder_id)
REFERENCES tp_ladder(ladder_id);

--creating order id foreign for the intersection table of order and ladder
ALTER TABLE tp_ladder_order
ADD CONSTRAINT tp_ladder_order_order_id_fk
FOREIGN KEY(order_id)
REFERENCES tp_order(order_id);

--Inserting values into intersection table of order and ladder
INSERT INTO tp_ladder_order
VALUES(201,1),
      (201,2);
INSERT INTO tp_ladder_order
VALUES(202,1),
      (202,2),
      (203,1),
      (203,2),
      (204,1),
      (204,2),
      (205,1),
      (205,2),
      (206,1),
      (206,2),
      (207,1),
      (207,2),
      (208,1),
      (208,2),
      (209,1),
      (209,2),
      (210,1),
      (210,2);
 
    
--selecting all values from intersection table of order and ladder
SELECT * FROM tp_ladder_order;




--dropping customer and ladder intersection table
DROP TABLE tp_customer_ladder;
--creating customer and ladder intersection table
CREATE TABLE tp_customer_ladder(
customer_id       INTEGER,
ladder_id         INTEGER
);

--creating primary keys for customer and ladder intersection table
ALTER TABLE tp_customer_ladder
ADD CONSTRAINT tp_customer_ladder_customer_id_ladder_id_pk
PRIMARY KEY(customer_id,ladder_id);

--creating ladder id foreign key for the intersection table of customer and ladder
ALTER TABLE tp_customer_ladder
ADD CONSTRAINT tp_customer_ladder_ladder_id_fk
FOREIGN KEY(ladder_id)
REFERENCES tp_ladder(ladder_id);

--creating customer  id foreign key for the intersection table of customer and ladder
ALTER TABLE tp_customer_ladder
ADD CONSTRAINT tp_customer_ladder_customer_id_fk
FOREIGN KEY(customer_id)
REFERENCES tp_customer(customer_id);


--inserting into customer and ladder intersection table
INSERT INTO tp_customer_ladder
VALUES(301,1),
      (301,2),
      (301,3);

--selecting all values from customer and ladder intersection table
SELECT * FROM tp_customer_ladder;






--dropping intersection table of ladder and warehouse
DROP TABLE tp_ladder_warehouse;
--creating intersection table of ladder and warehouse
CREATE TABLE tp_ladder_warehouse(
ladder_id       INTEGER,
warehouse_id    INTEGER
);

--creating primary keys for intersection table of ladder and warehouse
ALTER TABLE tp_ladder_warehouse
ADD CONSTRAINT tp_ladder_warehouse_ladder_id_warehouse_id_pk
PRIMARY KEY(ladder_id,warehouse_id);

--creating foreign key for the intersection table of ladder and warehouse
ALTER TABLE tp_ladder_warehouse
ADD CONSTRAINT tp_ladder_warehouse_ladder_id_fk
FOREIGN KEY(ladder_id)
REFERENCES tp_ladder(ladder_id);

--creating foreign key for the intersection table of ladder and warehouse
ALTER TABLE tp_ladder_warehouse
ADD CONSTRAINT tp_ladder_warehouse_warehouse_id_fk
FOREIGN KEY(warehouse_id)
REFERENCES tp_warehouse(warehouse_id);

--inserting values into intersection table of ladder and warehouse
INSERT INTO tp_ladder_warehouse
VALUES(1,101),
      (1,102);
    
--selecting all values from intersection table of ladder and waerhouse
SELECT * FROM tp_ladder_warehouse;




--dropping associate table
DROP TABLE tp_associate;
--Creating associate table
CREATE TABLE tp_associate(
associate_id            INTEGER,
associate_name          VARCHAR(50),
associate_addr          VARCHAR(50),
associate_soc_no        INTEGER,
associate_number        DECIMAL(10,0),
associate_joining_date  DATE NOT NULL,
warehouse_id            INTEGER
);

--creating primary key for associate
ALTER TABLE tp_associate
ADD CONSTRAINT tp_associate_associate_id_pk
PRIMARY KEY(associate_id);

--creating foreign key for associate table
ALTER TABLE tp_associate
ADD CONSTRAINT tp_associate_warehouse_id_fk
FOREIGN KEY(warehouse_id)
REFERENCES tp_warehouse(warehouse_id);

--inserting values into associate table
INSERT INTO tp_associate
VALUES(401,'prashanth','alice street',12584,1234569870,'2019-1-12',101),
      (402,'Deepak','alice street',12584,1234569870,'2019-1-12',101),
      (403,'Celeste','alice street',12584,1234569870,'2019-1-12',101);
    
--selecing all values from the associate table
SELECT * FROM tp_associate;









