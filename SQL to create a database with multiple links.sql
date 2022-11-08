/*This table has been created to store the customers main details*/
CREATE TABLE Customer (  
customerID int AUTO_INCREMENT,
customerFirstName varchar(50),
customerLastName varchar(50),  
customerEmail varchar(50),
 customerPostCode char(8), 
 customerTelephone varchar(20), 
 CONSTRAINT PRIMARY KEY (customerID) ); /*this is the primary key which will be used through the database as a reference */
 
DROP TABLE Customer;/*this is to show/test if the drop command works*/

CREATE TABLE Customer ( 
customerID int AUTO_INCREMENT, 
customerFirstName varchar(50),
customerLastName varchar(50), 
customerEmail varchar(50),
 customerPostCode char(8), 
 customerTelephone varchar(20), 
 CONSTRAINT PRIMARY KEY (customerID) ); 

 
CREATE TABLE Enquiry ( /*this table has been created for any enquiry the customer has made, this can then be changed into a reservation if they wanted to proceed to make one*/
enquiryID int AUTO_INCREMENT,
 customerID int,
 enquiryDetails LONGTEXT, 
 CONSTRAINT PRIMARY KEY (enquiryID), 
 FOREIGN KEY (customerID) REFERENCES Customer(customerID) );/*this is using the primary key from the customer table in order to connect them to the enquiry they made*/

CREATE TABLE Reservation(
reservationID INT PRIMARY KEY,
customerID INT,
reservsationStatus varchar(20),
CONSTRAINT customerID_FK  FOREIGN KEY (customerID) REFERENCES Customer (customerID));

CREATE TABLE Rental_Record(
rentalID INT PRIMARY KEY,
boatID VARCHAR(25),
rentalDate DATE,
rentalDuePeriod varchar(10),
rentalDueBack DATE,
rentalDueBackActual DATE,
rentalTotalPrice DECIMAL(5,2),
customerID INT,
reservationID INT,
CONSTRAINT reservationID_FK  FOREIGN KEY (reservationID) REFERENCES Reservation (reservationID),
CONSTRAINT customerID_FKFK FOREIGN KEY (customerID) REFERENCES Customer (customerID));

CREATE TABLE Dealer ( 
dealerID INT PRIMARY KEY AUTO_INCREMENT, 
dealerName VARCHAR(50), 
dealerTeleNo VARCHAR(20), 
dealerAddress VARCHAR(100), 
dealerEmail VARCHAR(50) ); 


CREATE TABLE ManufacturerAndSupplier( 
    mAnds_ID INT PRIMARY KEY AUTO_INCREMENT, 
    orderlineID_FK INT,
    mAnds_name VARCHAR(50),
    mAnds_teleNo VARCHAR(20),
    mAnds_address VARCHAR(100),
    mAnds_email VARCHAR(50)); 


CREATE TABLE Disposal_Record ( 
disposalID INT PRIMARY KEY AUTO_INCREMENT,
 dealerID INT,
 CONSTRAINT dealerID_FK FOREIGN KEY (dealerID) REFERENCES Dealer(dealerID),
 disposalDate DATE,
 disposalSalePrice DECIMAL(10,2) );     
    
CREATE TABLE Boat_Record ( boatID INT PRIMARY KEY AUTO_INCREMENT,
mAnds_ID INT,
CONSTRAINT manufactureID_FK  FOREIGN KEY (mAnds_ID) REFERENCES ManufacturerAndSupplier(mAnds_ID),
disposalID INT,
CONSTRAINT disposal_ID_FK  FOREIGN KEY (disposalID) REFERENCES Disposal_Record(disposalID),
 boatInitialPrice DECIMAL(10,2),
 boatPurchaseDate Date, 
 boatLastService DATE, 
 boatClassification VARCHAR(30),
 boatSize VARCHAR(20),
 boatModel VARCHAR(20));
 
 
 
CREATE TABLE Parts_Stock( 
 partsID INT PRIMARY KEY AUTO_INCREMENT,
 partName VARCHAR(50),
 partsQuantity INT );
 

CREATE TABLE Parts_Required( 
partsRequestID INT AUTO_INCREMENT PRIMARY KEY,
 partQuantity INT,
 quantityRequired INT, 
 partsID INT,
 CONSTRAINT partsID_FK FOREIGN KEY (partsID) REFERENCES Parts_Stock(partsID) );


CREATE TABLE Maintenance( 
referanceNum INT AUTO_INCREMENT PRIMARY KEY,
 faultDetails LONGTEXT,
 faultDate DATE,
 actionTaken LONGTEXT, 
 actionDate DATE,
 maintenance_priority VARCHAR(50),
 partsRequiredID INT,
 boatID INT,
 CONSTRAINT FK_partsRequiredID FOREIGN KEY (partsRequiredID) REFERENCES Parts_Required(partsRequestID),
 CONSTRAINT FK_boatID FOREIGN KEY (boatID) REFERENCES Boat_Record(boatID) ); 
 
CREATE TABLE Orderr(
    orderID INT PRIMARY KEY AUTO_INCREMENT,
    quantity INT,
    partsID INT,
    CONSTRAINT partsID_FKFK FOREIGN KEY (partsID) REFERENCES Parts_Stock(partsID) );
    
CREATE TABLE Orderline(
orderlineID INT PRIMARY KEY AUTO_INCREMENT, 
orderID INT,
CONSTRAINT orderID_FK FOREIGN KEY (orderID) REFERENCES Orderr(orderID) );

#DROP TABLE IF EXISTS Orderline,Orderr,Maintenance,Parts_Required,Parts_Stock,Boat_Record,Rental_Record,ManufacturerAndSupplier,Dealer,Reservation,Enquiry,Customer;


ALTER TABLE ManufacturerAndSupplier ADD CONSTRAINT orderlineID_FKFK FOREIGN KEY (orderlineID_FK) REFERENCES Orderline(orderlineID);

/*from this point onwards is where I fill the data into the database*/

INSERT INTO Customer(customerFirstName, customerLastName, customerEmail, customerPostCode, customerTelephone) #Appendix D - List of customers
VALUES
	('Dion','Brodnecke','dbroes1d@who.int',null,'07174826351'),
	('Scarlett','Galley','scargr1c@imgur.com',null,'03260476982'),
    ('Sissy','Gadson','sgadson1b@ucoz.com',null,'04924556740'),
    ('Tabby','Minichi','minitabc@imgur.com',null,'07795213673'),
    ('Nellie','Greenmon','nelliegreen12@patch.com',null,'03816078215'),
    ('Hanny','Marsters','hmarsters@netlog.com',null,'07075576685'),
    ('Oswell','Aspinell','OsAspinell@digg.com',null,'09931348133'),
    ('Florance','Baston','FloBar@dirtg.com',null,'07315082134'),
    ('Candice','Tumilson','canditum15@bloomberg.com',null,'01639824657'),
    ('Clair','Bavin','clairBav@sprog.it',null,'06245985897'),
    
    ('Muhammad', 'Qasim','kasim@gmail.com',null,'09987670223'), #Tuples data for this table starts here
    ('Harry','Doe','john@gmail.com',null,'0876123881'),
    ('Poppy','Sissons','poppy@gmail.com',null,'08873487112'),
    ('John','William', 'johnwill@gmail.com', null, '07123231313'),
	('Ken','Harber', 'kenny@gmail.com', null, '07314312312');

#Appendix D - List of Manufacturers
INSERT INTO ManufacturerAndSupplier(mAnds_name,mAnds_teleNo,mAnds_address,mAnds_email)
VALUES('SuperBoat', '01772459666', 'Unit 7 Centurion Court, Leyland, LE10 2DJ', 'admin@superboat.co.uk'),
      ('Explorer Boats UK','01704807654','Meadow Lane, Burscough, BU56 8GH','admin@explorerboats.co.uk'),
      ('The Northwich Boat Company', '01270160160', 'Unit 1 Kings Lock Boatyard Booth Lane, Middlewich, MW67 7GY', 'admin@northwichboats.co.uk'),
      ('Collingwood Boat Builders', '01513742985', '29 Townsend Street, Collingwood, CL27 2DU', 'admin@collingwoodboats.co.uk'),
      ('Elton Moss Boat Builders', '01270760160', 'Unit 4 Kings Lock Boatyard Booth Lane, Middlewich, MW63 8TY', 'admin@eltonmossboats.co.uk'),
      ('Aintree Boat Company Ltd ', '01515239000', 'Brookfield Drive, Liverpool, L1 6GU ', 'admin@aintreeboats.co.uk'),
      ('Braidbar Boats Ltd', '01625873471', 'Lord Vernons Wharf Lyme Road Higher, Poynton, PY12 9TS', 'admin@braidbarboats.co.uk'),
      ('Bourne Boat Builders Ltd', '01785714692', 'Teddesley Road, Penkridge, PE8 7SU', 'admin@bourneboats.co.uk'),
      ('Stoke on Trent Boat Building Co Ltd', '01782813831', 'Longport Wharf Station Street, Stoke-on-Trent, ST6 9GU', 'admin@stokeboats.co.uk'),
      ('MGM Boats Narrowboat Builders', '01162640009', '27 Mill Lane, Leicester, LE6 9FY', 'admin@mgmboats.co.uk'),
      
      ('Johns Super Boats','07768519221','50 Robin Hood Lane, Winnersh",RG41 5NQ','john@superboats.com'), #Tuples data for this table starts here
      ('Michelle Boats For You','08876123881','210 Albert Road, Leyton",E10 6PD','michelle@boatsforyou.com'),
      ('Barrys Best Boats','08876129882','1 Stocks Hill, Manton",LE15 8SY','barry@bestboats.com'),
      ("MR Bean Boats CO Ltd", "07396719638", "22 Stoke Gardens, Ellesmere Port,CH65 0DR", "beanco@gmail.com"),
	  ("Mirage Motorboats Co Ltd","07292628911", "Windyridge, 12 Bath Road, Ashcott,TA7 9QU", "mmmotorboats@gmail.com");
      
      
#Appendix D - List of dealers
INSERT INTO Dealer(dealerName, dealerTeleNo, dealerAddress, dealerEmail)
VALUES("Dalis Vannoort", '07574137463', "77 A828, Appin, AP7 6GU",  "dvannoort0@salon.com"),
("Joe's Junk", '07365534221', "15 Back Lane, Buxton, BX7 5FY J",  "JoesJunk@zdnet.com"),
("Hoebart Kubera", '07874051869', "4 Finedon House, Marine Parade, Littlestone, LS4 6GU",  "hkubera2@who.int"),
("Eva Iacomettii", '07880072148', "8 9 Hartlands, Onslow Road, Newent, NW5 8TU",  "eiacomettii3@admin.ch"),
("Alley Pate", '07822040557', "07610 Arizona Alley, A67 8GU",  "apate4@gnu.org"),
('Korrie Legge', '07380018233', '1076 Evesham Road, Astwood Bank, DT5 8JO', 'klegge5@reference.com'),
('Minne Hinkens' ,'07978390430', '53 Balby Road, Balby, B7 8HK' ,'mhinkens6@smh.com.au'),
('Inigo MacAllaster', '07893419552' ,'1910 Farwell Plaza, G56 9FT', 'imacallaster7@blogspot.com'),
('Linell Skeeles', '07532931207', '57 Great Russell Street, London, NW1 8TU', 'lskeeles8@goo.gl'),
('Sioux Drogan', '07417098738' ,'75 Thomas Parsons Square, Ely, EL6 9GU' ,'sdrogan9@dropbox.com'),

('Curtis Boats','09987130992','2 Shawhurst Croft, Hollywood",B47 5PB','curtisboats@gmail.com'), #Tuples data for this table starts here
('Poppy Parts','09982134882', '10 Ranelagh Drive, Sheffield",S11 9HE','poppy@boatparts.com'),
('Craig Shone','07786238119','21 Borrowdale Avenue, Dunstable",LU6 3PG','craigshone@gmail.com'),
("Charrade junk", "07494623823", "9 Woodgates Close, North Ferriby,HU14 3JS", "charradejunk22@gmail.com"),
("Expired Stuff", "07323742812", "4 Durrington Road, Bournemouth,BH7 6QA", "Expiredboats@gmail.com");

INSERT INTO Disposal_Record (dealerID,disposalDate,disposalSalePrice)
VALUES( 1,'2020-11-30',1500.00);
SELECT *
FROM Disposal_Record;

INSERT INTO Boat_Record(mAnds_ID,disposalID,boatInitialPrice ,boatPurchaseDate , boatLastService, boatClassification,boatSize,boatModel )
VALUES(1,1,3910.00,'2010-11-22','2020-10-22','motorboat','standard', "Explorer");
SELECT *
FROM  Boat_Record;

INSERT INTO Maintenance(faultDetails, faultDate, actionTaken, actionDate, boatID)
VALUES("Chipped propeller","2015-02-15",'Replaced propeller','2015-02-27',1),
("Bilge pumps gone","2015-07-10",'New bilge pumps', '2015-08-27',1),
(null,null,"New head pumps",'2015-08-15',1),
(null,null,"Normal service",'2016-03-20',1),
('Cutless bearing worn through','2016-12-02', "Fit new bearing", "2017-01-27",1);

SELECT *
FROM  Maintenance
WHERE boatID = 1;

INSERT INTO Rental_Record(rentalID, rentalDate, rentalDuePeriod, rentalDueBack, rentalTotalPrice ,rentalDueBackActual)
VALUES(4734,'2019-05-02',"HD",'2019-05-02',125.00,'2019-05-02'),
(4745,'2019-05-03',"HD",'2019-05-03',125.00,'2019-05-03'),
(4812,'2019-05-04',"2D",'2019-05-05',400.00,'2019-05-06'),
(4875,'2019-05-06',"FD",'2019-05-06',200.00,'2019-05-06'),

(4976,'2020-05-01','HD','2020-05-01',125.00,'2020-05-01'), #Tuples data for this table starts here
(4977,'2019-03-02','FD','2019-03-02',200.00,'2019-03-02'),
(4910, '2019-06-06','HD', '2019-06-06',125.00,'2019-06-06'),
(5910, '2020-07-10', 'FD', '2020-07-10', 200.00, '2020-07-10'),
(5911, '2020-07-15', 'HD', '2020-07-15', 125.00, '2020-07-15');



SELECT *
FROM Rental_Record;

INSERT INTO Disposal_Record (dealerID,disposalDate,disposalSalePrice)
VALUES(2,'2019-10-10',1500.00);
SELECT *
FROM Disposal_Record;

INSERT INTO Boat_Record(mAnds_ID,disposalID,boatInitialPrice ,boatPurchaseDate , boatLastService, boatClassification,boatSize)
VALUES(2,2,3240.00,'2015-10-12','2020-01-27','Sail Boat','large');
SELECT *
FROM  Boat_Record;


INSERT INTO Boat_Record(mAnds_ID,boatInitialPrice ,boatPurchaseDate , boatLastService, boatClassification,boatSize,boatModel)
VALUES(2,3840,"2009-10-12","2019-10-08","Sail Boat","Very Large","TurboSail"),
(2,3240,"2015-10-15","2020-10-12", "Sail Boat", "Large","MasterSail"),
(3,2040,"2015-11-12","2020-10-14","Sail Boat", "Small", "SmallSailor"),
(3,2040,"2015-11-12","2020-10-14","Sail Boat", "Small", "SmallSailor"),
(5,5440,"2015-01-14","2020-10-15", "Motorboat", "Large", "Grande"),
(5,5440,"2015-01-14","2020-09-13", "Motorboat", "Large", "Grande"),
(2, 5440.00, "2015-1-14", "2020-09-13", "MotorBoat","Standard", "Turbo Mid"),
(3, 440.00, "2015-1-12", "2020-08-10", "RowingBoat","Large", "RowStream"),
(4, 320.00, "2015-1-12", "2020-09-22", "RowingBoat","Standard", "RowerX"),
(1, 3320.00, "2016-1-10", "2020-03-03", "SailBoat","Large", "Explorer"),
(1, 3320, "2016-1-10", "2020-4-3", "Sail Boat", "Standard", "Navigator"),
(2, 4440, "2018-2-14", "2020-9-14", "Motor Boat", "Standard", "Turbo Mid"),
(2, 4440, "2018-2-14", "2020-9-13", "Motor Boat", "Standard", "Turbo Mid"),
(7, 5440, "2018-1-14", "2019-10-14", "Motor Boat", "Large", "MasterBlaster"),
(8, 340, "2018-1-10", "2020-10-2", "Rowing Boat", "Large", "HappyRower"),
(8, 340, "2018-1-10", "2020-10-2", "Rowing Boat", "Small", "HappyRower"),
(3, 640, "2017-1-9", "2020-10-7", "Rowing Boat", "Very Large", "Streamer"),
(4,650 ,'2019-01-19' , '2020-09-12', 'Rowing boat','Very Large','Great Row'),
(7,7440 ,'2018-01-14' , '2020-08-07', 'MotorBoat','Very Large','SuperBlaster'),
(6,340 ,'2017-01-09' , '2020-10-04', 'Rowing boat','Standard','Lizard'),
(5,5440 ,'2018-02-14' , '2020-09-13', 'MotorBoat','Large','Grande'),
(2,3240 ,'2015-10-12' , '2020-01-27', 'Sail boat','Large','MasterSail'),

(3,4000,'2016-10-13','2020-02-20','Rowing Boat','Very Large','Turbo Mid'), #Tuples data for this table starts here 
(5,56790 ,'2018-06-12' , '2020-01-27', 'Motor boat','Standard','Grande'),
(5,5440.00,'2017-02-04', '2020-10-10', 'Motorboat','Large','TurboMix'),
(7, 5570.00, "2017-7-7", "2020-07-7", "Motorboat","Very Large", "RowerX"),
(4,3200, '2017-10-20', '2017-12-10','Rowing Boat','Large', 'Great Row');



INSERT INTO Maintenance(faultDetails, faultDate, actionTaken, actionDate, boatID)
VALUES("Damaged mast","2016-04-17",'Repair mast','2016-04-27',3),
("Bent Forestay","2017-07-10",'Replace Forestay', '2017-08-22',3),
("Shot Boom","2018-05-18","Replace Boom",'2018-06-06',3),
("Rudderstock Chipped","2019-07-07","Repair Rudderstock",'2019-07-08',3),
(null,null, "Normal Service", "2020-01-27",3),
("Rudderblade busted", "2020-10-19", null, null,3),

('Snapped Forestay','2019-05-20',null,null,2), #Tuples data for this table starts here 
(null,null, "Normal Service", "2020-01-27",2),
("Engine Failure","2019-07-07","Repair Engine",'2019-07-08',2),
(null,null, 'Normal Service','2020-05-12',2),
('Shot Boom', '2020-05-15','Replace Boom', '2020-05-20', 2);


SELECT *
FROM  Maintenance
WHERE boatID = 2;


SELECT *
FROM  Maintenance
WHERE boatID = 3;



SELECT *
FROM Boat_Record;

INSERT INTO Reservation (customerID,ReservationID)
VALUES(1,5344),
(2,5345),
(9,5347),
(4,5346),
(7,5349),
(6,5348),
(2,5350),
(5,5352),
(5,5353),
(9,5354),
(2,5351),
(8,5364),
(9,5355),
(1,5356),
(6,5357),
(7,5385),
(10,5366),
(4,5360),
(8,5361),
(10,5359),
(3,5362),
(3,5365),
(1,5363),
(1,5342),
(4,5341),
(2,5343), 

(3,5544),#Tuples data for this table starts here 
(4,5545),
(5,5546),
(6,5547),
(7,5548);


INSERT INTO Rental_Record(rentalID, customerID,rentalDate,boatID,rentalDuePeriod,rentalTotalPrice,reservationID)
VALUES(4876,1,"2020-10-20",9, "1D", 280.00, 5344),
(4877,2,'2020-10-20', 16, '1D', 220, 5345),
(4878,9,'2020-10-20',7,"1D",240,5347),
(4879,4,'2020-10-20',6,"1D",240,5346),
(4880,7,'2020-10-20',9,"1D",140,5349),
(4881,6, "2020-10-20", 15, "1D", 240.00, 5348),
(4882,2, "2020-10-20", 9, "1D", 180.00, 5350),
(4883,5, "2020-10-20", 16, "1D", 110.00, 5352),
(4884,5, "2020-10-20", 17, "1D", 110.00, 5353),
(4885,9, "2020-10-20", 14, "2D", 400.00, 5354),
(4886,2, "2020-12-20", 11, "1D", 180.00, 5351),
(4887,8, "2020-12-20", 4, "1D", 110.00, 5364),
(4888,9, "2020-12-20", 13, "2D", 400.00, 5355),
(4889,1, "2020-12-20", 8, "1D", 200.00, 5356),
(4890,6, "2020-12-20", 1, "1D", 200.00, 5357),
(4891,7, '2020-10-20', 10, '1D', 120.00, 5385),
(4892,10, '2020-10-20', 21, '1/2D', 80.00, 5366),
(4893,4, '2020-10-20', 20, '1D', 280.00, 5360),
(4894,8, '2020-10-20', 2, '1D', 240.00, 5361),
(4895,10, '2020-10-20', NULL, '1D', 160.00, 5359),
(4896,3,'2020-10-20',NULL,'1D',100,5362),
(4897,3,'2020-10-20',NULL,'1D',120,5365),
(4898,3,'2020-10-20',NULL,'1D',100,5363),
(4899,1,'2020-04-27',16,'1D',180,5342),
(4900,4,'2019-10-20',6,'1D',240,5341),
(4901,2,'2019-12-09',6,'1D',240,5343),

(4092,3,'2020-02-02',5,'1D',100.00,5544), #Tuples data for this table starts here 
(5100,7,'2020-12-19', 12,'1D', 200.00, 5548),
(4903,5,'2020-09-10',3,'1D',200.00,5546),
(4969,4,'2021-12-09',6,'1D',100,5545),
(4970,6,'2017-07-07',7,'2D',777.00,5547);

SELECT *
FROM Rental_Record;








