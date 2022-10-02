
DROP DATABASE IF EXISTS health_insurance_company;
CREATE DATABASE health_insurance_company;
USE health_insurance_company;

CREATE TABLE Role
(
  RoleID INT NOT NULL AUTO_INCREMENT,
  RoleName VARCHAR(10) NOT NULL,
  PRIMARY KEY (RoleID)
);

CREATE TABLE Customer
(
  Cid CHAR(14) NOT NULL,
  FName VARCHAR(50) NOT NULL,
  LName VARCHAR(50) NOT NULL,
  PlanID INT UNIQUE,
  Address VARCHAR(100) NOT NULL,
  DateOfBirth VARCHAR(20) NOT NULL,
  E_Mail VARCHAR(50) NOT NULL UNIQUE,
  Password VARCHAR(50) NOT NULL,
  RoleID INT NOT NULL DEFAULT 1,
  FOREIGN KEY (RoleID) REFERENCES Role(RoleID),
  PRIMARY KEY (Cid)
);

CREATE TABLE Hospital
(
  Hid INT NOT NULL AUTO_INCREMENT,
  Hname VARCHAR(50) NOT NULL,
  PhoneNo CHAR(11) NOT NULL,
  PRIMARY KEY (Hid),
  UNIQUE(Hname, PhoneNo)
);

CREATE TABLE PlanType
(
  TypeID INT NOT NULL AUTO_INCREMENT,
  TypeName VARCHAR(10) NOT NULL,
  PlanPrice float NOT NULL,
  PRIMARY KEY (TypeID)
);

CREATE TABLE Enrolled
(
  TypeID INT NOT NULL,
  Hid INT NOT NULL,
  PRIMARY KEY (TypeID, Hid),
  FOREIGN KEY (TypeID) REFERENCES PlanType(TypeID),
  FOREIGN KEY (Hid) REFERENCES Hospital(Hid)
);

CREATE TABLE Hospital_Location
(
  Location VARCHAR(100) NOT NULL,
  Hid INT NOT NULL,
  PRIMARY KEY (Location, Hid),
  FOREIGN KEY (Hid) REFERENCES Hospital(Hid)
);

CREATE TABLE Plan
(
  PlanID INT NOT NULL AUTO_INCREMENT,
  Cid CHAR(14) NOT NULL,
  TypeID INT NOT NULL,
  PlanName varchar(30),
  PRIMARY KEY (PlanID, Cid),
  FOREIGN KEY (Cid) REFERENCES Customer(Cid),
  FOREIGN KEY (TypeID) REFERENCES PlanType(TypeID)
);

CREATE TABLE Relationship
(
  RelID INT NOT NULL AUTO_INCREMENT,
  RelType VARCHAR(20) NOT NULL,
  PRIMARY KEY(RelID)
);

CREATE TABLE Dependents
(
  Did CHAR(14) NOT NULL,
  RelID INT NOT NULL,
  DName VARCHAR(50) NOT NULL,
  DateOfBirth VARCHAR(20) NOT NULL,
  Address VARCHAR(100),
  PlanID INT,
  Cid CHAR(14) NOT NULL,
  CONSTRAINT `dependents_chk_1` CHECK (`did` <> `cid`),
  PRIMARY KEY (Did),
  FOREIGN KEY (PlanID, Cid) REFERENCES Plan(PlanID, Cid),
  FOREIGN KEY (RelID) REFERENCES Relationship(RelID)
);

CREATE TABLE PhoneNo
(
  PhoneNumber CHAR(11) NOT NULL,
  Did CHAR(14) ,
  Cid CHAR(14) ,
  PRIMARY KEY (PhoneNumber),
  FOREIGN KEY (Did) REFERENCES Dependents(Did),
  FOREIGN KEY (Cid) REFERENCES Customer(Cid)
);

CREATE TABLE Claim
(
  Cost FLOAT NOT NULL,
  Details VARCHAR(300) NOT NULL,
  ClaimID INT NOT NULL AUTO_INCREMENT,
  Date VARCHAR(20) NOT NULL,
  Resolved BOOLEAN NOT NULL DEFAULT 0,
  BenificiaryID CHAR(14) NOT NULL,
  PlanID INT NOT NULL,
  Cid CHAR(14) NOT NULL,
  Hid INT NOT NULL,
  PRIMARY KEY (ClaimID),
  FOREIGN KEY (PlanID, Cid) REFERENCES Plan(PlanID, Cid),
  FOREIGN KEY (Hid) REFERENCES Hospital(Hid)
);

ALTER TABLE customer ADD FOREIGN KEY (PlanID) REFERENCES Plan(PlanID);

INSERT INTO `role` VALUES (1,'User'),(2,'Admin');
INSERT INTO `relationship` VALUES (1,'Brother'),(2,'Sister'),(3,'Father'),(4,'Mother'),(5,'Cousin'),(5,'Son'),(5,'Daughter'),(5,'Grand Father'),(5,'Grand Mother')
,(5,'Uncle'),(5,'Aunt'),(5,'Spouse');
INSERT INTO relationship(RelType) VALUES('Son'), ('Daughter'), ('Grand Father'), ('Grand Mother'), ('Uncle'), ('Aunt'),('Spouse');
INSERT INTO `plantype` VALUES (1,'Basic',1000),(2,'Premium',3000),(3,'Golden',5000);
INSERT INTO `customer` VALUES ('12121212121212','Adnan','Tawakol',NULL,'ali bek','16/11/1999','adnan@gmail.com','adnan',2),('12121212123333','Mohamed','Tawakol',NULL,'ali bek','16/11/2006','Mohamed@gmail.com','Mohamed',1),('33333333333333','Diaa','Eltaiby',NULL,'elhelw st','12/12/2012','Diaa@gmail.com','password123',1),('44444444444444','Ali','Osama',NULL,'elhelw','13/13/2013','Ali@yahoo.com','password',1);
INSERT INTO `plan` VALUES (1,'12121212121212',1,NULL),(2,'33333333333333',3,NULL),(3,'12121212121212',3,NULL);
INSERT INTO `dependents` VALUES ('21111111111111',1,'Tawakol','16/11/2006','Ali Bek',1,'12121212121212'),('22222222222222',1,'Belal Eltaiby','1/1/2000','saeed st',NULL,'33333333333333'),('2333333333333',5,'Samer Tawakol','1997','Omar ebn abdelaziz',3,'12121212121212');
UPDATE customer set PlanID = 1 where Cid = '12121212121212';
UPDATE customer set PlanID = 2 where Cid = '33333333333333';
INSERT INTO hospital(Hname,PhoneNo) Values('Nile Hospital Tanta','01005259054'),('American Hospital','0403312692'),('Tiba Hospital','0403270273'),('Delta International Hospital','0403315001')
											,('Ibn Sina specialized hospital','01144680000'),('Shorouk Hospital','0403271836'),('Abou Rayah Hospital','0403283508'),('Dar El Shefaa Hospital','0403274001');
INSERT INTO enrolled VALUES (1,1),(1,2),(1,3),(2,3),(2,4),(2,5),(3,5),(3,6),(3,7),(3,8),(3,3);
INSERT INTO hospital_location VALUES ('Omar Ibn Abd El-Aziz, street, Gharbia Governorate 31111',1),('Saeed St, Tanta Qism 2, Tanta, Gharbia Governorate',2),('Tout Aankh Amoun, Tanta Qism 2, Tanta, Gharbia Governorate',3),('Dawaran Kotshnr، Tanta Qism 2, EL GHARBEYA، Gharbia Governorate',4)
									,('El-Gaish, Tanta Qism 2, Tanta, Gharbia Governorate',5),('Ali Bek Al Kabir, Tanta Qism 2, Tanta, Gharbia Governorate',6),('Tout Aankh Amoun, Tanta Qism 2, Tanta, Gharbia Governorate',7),('Moawya St, Tanta Qism 2, Tanta, Gharbia Governorate',8)