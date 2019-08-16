/* Mitchell Henry 102661522 */

/*Tour(TourName,Description)
Primary Key (TourName)

Client(ClientID,Surname,GivenName,Gender)
Primary Key (ClientID)

Event(EventYear,EventMonth,EventDay,TourName,Fee)
Foreign Key(TourName) References Tour
PrimaryKey(EventYear,EventMonth,EventDay,TourName)

Booking(ClientID,EventYear,EventMonth,EventDay,TourName,DateBooked,Payment)
Foreign Key (ClientID) References Client
Foreign Key (EventYear,EventMonth,EventDay,TourName) References Event*/
DROP TABLE IF EXISTS Booking;
DROP TABLE IF EXISTS dbo.[Event]
DROP TABLE IF EXISTS Tour;
DROP TABLE IF EXISTS Client;
DROP VIEW IF EXISTS TASK5;


CREATE TABLE Tour(
TourName NVARCHAR(100) PRIMARY KEY,
[Description] NVARCHAR(500)
);

CREATE TABLE Client(
ClientID INT PRIMARY KEY,
Surname NVARCHAR(100) NOT NULL,
GivenName NVARCHAR(100) NOT NULL,
Gender NVARCHAR(1) CHECK(Gender = 'M' OR Gender = 'F' OR Gender = 'I') NULL 
);

CREATE TABLE dbo.[Event](
TourName NVARCHAR(100),
EventMonth NVARCHAR(3) CHECK(EventMonth = 'Jan' OR EventMonth = 'Feb' OR EventMonth = 'Mar' OR EventMonth = 'Apr' OR EventMonth = 'May' OR EventMonth = 'Jun' Or EventMonth = 'Jul' OR EventMonth = 'Aug' OR EventMonth = 'Sep' OR EventMonth = 'Oct' OR EventMonth = 'Nov' OR EventMonth = 'Dec'),
EventDay INT CHECK(EventDay >= 1 AND EventDay <= 31),
EventYear INT CHECK(EventYear >= 1000 AND EventYear < 10000),
Fee MONEY CHECK(Fee > 0)
FOREIGN KEY (TourName) REFERENCES Tour,
PRIMARY KEY (EventMonth,EventDay,EventYear,TourName)
)

CREATE TABLE Booking(
    ClientID INT,
    TourName NVARCHAR(100),
    EventMonth NVARCHAR(3) CHECK(EventMonth = 'Jan' OR EventMonth = 'Feb' OR EventMonth = 'Mar' OR EventMonth = 'Apr' OR EventMonth = 'May' OR EventMonth = 'Jun' Or EventMonth = 'Jul' OR EventMonth = 'Aug' OR EventMonth = 'Sep' OR EventMonth = 'Oct' OR EventMonth = 'Nov' OR EventMonth = 'Dec'),
    EventDay INT CHECK(EventDay >= 1 AND EventDay <= 31),
    EventYear INT CHECK(EventYear >= 1000 AND EventYear < 10000),
    Payment MONEY CHECK(Payment > 0) NULL,
    DateBooked DATE NOT NULL,
    FOREIGN KEY (EventMonth,EventDay,EventYear,TourName) REFERENCES dbo.[Event],
    FOREIGN KEY (ClientID) REFERENCES Client
)

INSERT INTO Tour(TourName,[Description]) VALUES('Montain','Tour Of the Montain'),('Hill','Tour of the hill'),('River','Tour of the River');
INSERT INTO Client(ClientID,Surname,GivenName,Gender) VALUES(102661522,'Henry','Mitchell','M'),(101828493,'Small','Eric','M'),(189472974,'Dowling','Emma','F');
INSERT INTO dbo.[Event](TourName,EventMonth,EventDay,EventYear,Fee) VALUES('Montain','Jan',23,2019,2000),('River','Aug',29,2020,3200),('Hill','May',12,2025,1600);
INSERT INTO Booking(ClientID,TourName,EventMonth,EventDay,EventYear,Payment,DateBooked) VALUES(102661522,'River','Aug',29,2020,1600,'January 1,2020'),(101828493,'Montain','Jan',23,2019,1500,'June 4,2018'),(189472974,'Hill','May',12,2025,1200,'August 2,2017');

 
SELECT C.GivenName,C.Surname,B.TourName,T.[Description],B.EventYear,B.EventMonth,B.EventDay,B.DateBooked,E.Fee
FROM Booking B
INNER JOIN dbo.[Event] E
ON B.EventDay = E.EventDay
INNER JOIN Client C 
ON C.ClientID = B.ClientID
INNER JOIN Tour T 
ON T.TourName = B.TourName

SELECT EventMonth,TourName,COUNT(*) AS 'Num Bookings'
FROM Booking
GROUP BY EventMonth,TourName,DateBooked

SELECT Payment
FROM Booking
WHERE Payment >(Select AVG(Payment)
                        FROM Booking)

CREATE VIEW TASK5 AS
SELECT C.GivenName,C.Surname,B.TourName,T.[Description],B.EventYear,B.EventMonth,B.EventDay,B.DateBooked,E.Fee
FROM Booking B
INNER JOIN dbo.[Event] E
ON B.EventDay = E.EventDay
INNER JOIN Client C 
ON C.ClientID = B.ClientID
INNER JOIN Tour T 
ON T.TourName = B.TourName

SELECT COUNT(*)
FROM Booking;
--THis Query Returns the same number of columns so it appears my first query is correctSELE
SELECT COUNT(DateBooked)
FROM Booking;
--This Query Shows the number of bookings made in total for any event on any day and gives the same amount as query 2
SELECT AVG(Payment)
FROM Booking;
--This shows the values outputed in the third query above are all above the payment average