USE MovieRentalsDB
GO

DROP VIEW IF EXISTS VallCustomersPerCity

CREATE VIEW VallCustomersPerCity AS
	SELECT Name , City
	FROM Customers

DROP VIEW IF EXISTS VRentals_Per_Store

CREATE VIEW VRentals_Per_Store AS
SELECT COUNT(Rentals.ID) AS Rentals_Per_Store , Store.Location
FROM Rentals JOIN Store ON Rentals.StoreID = Store.ID
GROUP BY Store.Location

DROP VIEW IF EXISTS Vemployee_On_Store

CREATE VIEW Vemployee_On_Store AS
SELECT Employees.Name , Store.Location
FROM Store JOIN Employees ON Store.ID = Employees.StoreID

DROP VIEW IF EXISTS Vincome_And_Orders_per_Store

CREATE VIEW Vincome_And_Orders_per_Store AS
SELECT COUNT(Rentals.ID) AS Num_Of_Orders , SUM(Movies.Price) AS Income, Store.Location
FROM Rentals JOIN Movies ON Rentals.MovieID = Movies.ID JOIN Store ON Rentals.StoreID = Store.ID
GROUP BY Store.Location


