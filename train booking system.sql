CREATE DATABASE IF NOT EXISTS TrainBookingSystem;
USE TrainBookingSystem;

CREATE TABLE IF NOT EXISTS Users(
UserID INT PRIMARY KEY AUTO_INCREMENT,
Username VARCHAR(50) UNIQUE,
PasswordHash VARCHAR(255),
Email VARCHAR(100),
Phone VARCHAR(15));

CREATE TABLE IF NOT EXISTS
Stations (
StationID INT PRIMARY KEY AUTO_INCREMENT,
StationName VARCHAR(100),
StationCode VARCHAR(10),
Location VARCHAR(100));

CREATE TABLE IF NOT EXISTS
Trains(
TrainID INT PRIMARY KEY AUTO_INCREMENT,
TrainName Varchar(100),
Capacity INT,
EconomyCapacity INT,
FirstClassCapacity INT);

CREATE TABLE IF NOT EXISTS
Routes(
RouteID INT PRIMARY KEY AUTO_INCREMENT,
TrainID INT,
StartingStationID INT,
EndingStationID INT,
Duration TIME,
DepartureTime DATETIME,
ArrivalTime DATETIME,
FOREIGN KEY (TrainID)
REFERENCES Trains(TrainID),
FOREIGN KEY (StartingStationID)
REFERENCES Stations(StationID),
FOREIGN KEY (EndingStationID)
REFERENCES Stations (StationID));

CREATE TABLE IF NOT EXISTS
TicketPricing(
PricingID INT PRIMARY KEY AUTO_INCREMENT,
RouteID INT,
TravelClass VARCHAR(20),
Price DECIMAL(10, 2),
FOREIGN KEY (RouteID)
REFERENCES Routes(RouteID));

CREATE TABLE IF NOT EXISTS
Passengers(
PassengerID INT PRIMARY KEY AUTO_INCREMENT,
FirstName VARCHAR(100),
LastName VARCHAR(100),
Email VARCHAR(100),
Phone VARCHAR(15));

CREATE TABLE IF NOt EXISTS
Bookings(
BookingId INT PRIMARY KEY AUTO_INCREMENT,
PassengerID INT,
RouteID INT,
SeatNumber VARCHAR(10),
TravelClass VARCHAR(20),
BookingDate DATETIME,
Price DECIMAL(10, 2),
Status VARCHAR(20) DEFAULT
'Booked', 
FOREIGN KEY
(PassengerID) REFERENCES
Passengers(PassengerID),
FOREIGN KEY (RouteID)
REFERENCES Routes(RouteID));

CREATE TABLE IF NOT EXISTS
Feedback(
FeedbackID INT PRIMARY KEY AUTO_INCREMENT,
BookingID INT,
Rating INT,
Comment TEXT,
FeedbackDate DATETIME,
FOREIGN KEY(BookingID)
REFERENCES Bookings(BookingID));

CREATE TABLE IF NOT EXISTS
TrainStatus (
StatusID INT PRIMARY KEY AUTO_INCREMENT,
TrainID INT,
Status VARCHAR(50),
Timestamp DATETIME,
FOREIGN KEY (TrainID)
REFERENCES Trains(TrainID));

CREATE TABLE IF NOT EXISTS
Seats(
SeatID INT PRIMARY KEY AUTO_INCREMENT,
TrainID INT,
RouteID INT,
SeatNumber VARCHAR(10),
IsOccupied BOOLEAN DEFAULT FALSE,
FOREIGN KEY (TrainID)
REFERENCES Trains (TrainID),
FOREIGN KEY (RouteID)
REFERENCES Routes(RouteID));

CREATE TABLE IF NOT EXISTS
Payments(
PaymentID INT PRIMARY KEY AUTO_INCREMENT,
BookingID INT,
Amount DECIMAL (10, 2),
PaymentDate DATETIME,
PaymentStatus VARCHAR(50),
FOREIGN KEY (BookingID)
REFERENCES Bookings(BookingID));

CREATE TABLE IF NOT EXISTS
Discounts(
DiscountID INT PRIMARY KEY AUTO_INCREMENT,
Code VARCHAR (20) UNIQUE,
DiscountPercentage INT,
ValidUntil DATETIME);


INSERT INTO
 Stations (StationName, StationCode, Location)
 VALUES 
 ('Mombasa Terminus', 'MBS', 'Mombasa'),
 ('Mariakani', 'MRI', 'Kilifi'),
 ('Voi', 'VOI', 'Taita Taveta'),
 ('Mtito Andei', 'MTA', 'Makueni'),
 ('Athi River', 'ATR', 'Machakos'),
 ('Nairobi Terminus', 'NRB', 'Nairobi');
 
 INSERT INTO
 Trains (TrainName, Capacity, EconomyCapacity, FirstClassCapacity)
 VALUES
 ('Madaraka Express', 1200, 1000, 200),
 ('Intercounty Train', 800, 600, 200);
 
 INSERT INTO Routes (TrainID, StartingStationID, EndingStationID, Duration, DepartureTime, ArrivalTime)
VALUES 
    (1, 1, 6, '05:00:00', '2025-01-10 08:00:00', '2025-01-10 13:00:00'), -- Mombasa to Nairobi
    (2, 6, 1, '05:30:00', '2025-01-11 07:00:00', '2025-01-11 12:30:00'); 
    
    INSERT INTO TicketPricing (RouteID, TravelClass, Price)
VALUES 
    (1, 'Economy', 1000.00),
    (1, 'First Class', 3000.00),
    (2, 'Economy', 1000.00),
    (2, 'First Class', 3000.00);

INSERT INTO Passengers (FirstName, LastName, Email, Phone)
VALUES 
    ('Steph', 'Sifa', 'stephsifa@gmail.com', '+254115772948'),
    ('Sifa', 'Steph', 'sifasteph@gmail.com', '+254715453007');

INSERT INTO Bookings (PassengerID, RouteID, SeatNumber, TravelClass, BookingDate, Price)
VALUES 
    (1, 1, 'A1', 'Economy', NOW(), 1000.00),
    (2, 2, 'B2', 'First Class', NOW(), 3000.00);

INSERT INTO Feedback (BookingID, Rating, Comment, FeedbackDate)
VALUES 
    (1, 5, 'Excellent service and comfortable ride!', NOW()),
    (2, 4, 'Good, but the train was delayed by 15 minutes.', NOW());
    
    INSERT INTO TrainStatus (TrainID, Status, Timestamp)
VALUES 
    (1, 'On Time', NOW()),
    (2, 'Delayed', NOW());

INSERT INTO Seats (TrainID, RouteID, SeatNumber, IsOccupied)
VALUES 
    (1, 1, 'A1', TRUE),
    (2, 2, 'B2', FALSE);

INSERT INTO Payments (BookingID, Amount, PaymentDate, PaymentStatus)
VALUES 
    (1, 1000.00, NOW(), 'Paid'),
    (2, 3000.00, NOW(), 'Paid');

INSERT INTO Discounts (Code, DiscountPercentage, ValidUntil)
VALUES 
    ('NEWYEAR2025', 20, '2025-12-31 23:59:59');


SELECT * FROM Trains;
SELECT * FROM Routes;
SELECT * FROM TicketPricing;
SELECT * FROM Passengers;
SELECT * FROM Bookings;
SELECT * FROM Feedback;
SELECT * FROM TrainStatus;
SELECT * FROM Seats;
SELECT * FROM Payments;
SELECT * FROM Discounts; 
