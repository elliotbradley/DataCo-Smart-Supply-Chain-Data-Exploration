#Initialize DB
CREATE DATABASE DataCoSmart;
USE DataCoSmart;

#Create Table for Import
CREATE Table DCSCD(
type varchar(30),
DFSreal int,
DFSscheduled int)

#Back-up Copy of table
CREATE TABLE dcscdBack LIKE dcscd;
INSERT INTO dcscdBack
SELECT *
FROM dcscd

#NAME CHANGES
#Category Name --> CategoryName
#Late_delivery_risk --> LateDeliveryRisk
#Customer Country --> CustomerCountry
#Customer City --> CUstomerCity

#Check How Many Records Successfully Uploaded
SELECT * FROM dcsc
SELECT COUNT(Type) FROM dcscd

# Updating the OrderDate Column
UPDATE dcscd
SET OrderDate = REPLACE(OrderDate, '/', '-');
UPDATE dcscd
SET OrderDate = SUBSTRING_INDEX(OrderDate, ' ', 1);
UPDATE dcscd
SET OrderDate = CONCAT(SUBSTRING_INDEX(OrderDate, '-', -1),'-',SUBSTRING_INDEX(OrderDate, '-', 2))
UPDATE dcscd
SET OrderDate = CONVERT(OrderDate,DATE)

#Task 1
CREATE TABLE Task1 AS
SELECT OrderDate, SUM(Sales) AS Sales FROM dcscd
GROUP BY OrderDate
SELECT COUNT(OrderDate) FROM Task1
SELECT * FROM Task1
ORDER BY OrderDate

#Task 2
CREATE TABLE Task2 AS
SELECT CategoryName, SUM(Sales) AS Sales FROM dcscd
GROUP BY CategoryName
SELECT * FROM Task2

#Task 3
CREATE TABLE Task3 AS
SELECT CategoryName, SUM(LateDeliveryRisk)/COUNT(LateDeliveryRisk) AS LatenessFrequency FROM dcscd
GROUP BY CategoryName
SELECT * FROM Task3

#Task 4
CREATE TABLE Task4 AS
SELECT CustomerCountry, CustomerCity, SUM(LateDeliveryRisk)/COUNT(LateDeliveryRisk) AS LatenessFrequency FROM dcscd
GROUP BY CustomerCity
ORDER BY CustomerCity
SELECT * FROM Task4

#Task 5
#SELECT * FROM DataDescription
SELECT Market, SUM(Sales) AS Sales, SUM(LateDeliveryRisk)/COUNT(LateDeliveryRisk) AS LatenessFrequency FROM dcscd
GROUP BY 

