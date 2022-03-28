USE MovieRentalsDB


--Display all orders by customer name

CREATE PROCEDURE spDisplayAllOrdersByCustomer
@CustomerName VARCHAR(150)
AS
BEGIN
	SELECT TOP 1 Customers.Name, COUNT(Rentals.ID) AS Amount_Of_Orders
	FROM Rentals JOIN Customers ON Rentals.CustomerID = Customers.ID
	WHERE Name = @CustomerName
	GROUP BY Customers.Name
	ORDER BY Amount_Of_Orders DESC
END

-- Count the orders per city by location

CREATE PROCEDURE spDisplayTheOrdersPerCityByLocation
@Location VARCHAR(50)
AS
BEGIN
	SELECT COUNT(Rentals.CustomerID) AS Num_OF_Rentals , Store.Location
	FROM Rentals JOIN Store ON Rentals.StoreID = Store.ID
	WHERE Location = @Location
	GROUP BY Store.Location
END

-- Display the top 3 stores by the munber of rentals
CREATE PROCEDURE spDisplayTheTop3StoresByRentals
AS
BEGIN
SELECT TOP 3 COUNT(Rentals.CustomerID) AS Num_OF_Rentals , Store.Location
	FROM Rentals JOIN Store ON Rentals.StoreID = Store.ID
	GROUP BY Store.Location
	ORDER BY Num_OF_Rentals DESC
END

--Display all the movies names and categorys

CREATE PROCEDURE spDisplayAllTheMoviesNamesAndCategory
AS
BEGIN
	SELECT Movies.MovieName , MoviesCategory.Category
	FROM Movies JOIN MoviesCategory ON Movies.ID = MoviesCategory.MovieID
END

--Display the most rented movie and it's name
CREATE PROCEDURE spDisplayTheMostRentedMovieAndItsName
AS
BEGIN
	SELECT TOP 1 COUNT(Rentals.CustomerID) AS Numbers_Of_Rents , Movies.MovieName 
	FROM Rentals JOIN Movies ON Rentals.MovieID = Movies.ID
	GROUP BY Movies.MovieName 
	ORDER BY Numbers_Of_Rents DESC
END

-- Display the most 3  popular rented categories
CREATE PROCEDURE spDisplayTheMostThreePopularRentedCategoris
AS
BEGIN
	SELECT TOP 3 COUNT(Rentals.CustomerID) AS Numbers_Of_Rents , MoviesCategory.Category
	FROM Rentals JOIN Movies ON Rentals.MovieID = Movies.ID JOIN MoviesCategory ON Movies.ID = MoviesCategory.MovieID
	GROUP BY  Movies.MovieName , MoviesCategory.Category
	ORDER BY Numbers_Of_Rents DESC
END


--Display the cumulative amount per customer from all rentals and the amount of rents , And show the customer name

CREATE PROCEDURE spumClativeAmountPerCustomerFromAllOrdersAmountOfRentsCustomersNames
AS
BEGIN
	SELECT COUNT(Customers.ID) AS Number_Of_Rents , SUM(Movies.Price) Sum_Of_Rents , Customers.Name
	FROM Rentals JOIN Customers ON Rentals.CustomerID = Customers.ID JOIN Movies ON Rentals.MovieID = Movies.ID
	GROUP BY Customers.Name
	ORDER BY Sum_Of_Rents DESC
END


--Display the Number of Employees by stores Locations

ALTER PROCEDURE spDisplayTheNumberOfEmployeesByStore
@StoreName VARCHAR(50)
AS
BEGIN
	SELECT COUNT(Employees.Name) AS Number_Of_Employees , Store.Location 
	FROM Employees JOIN Store ON Employees.StoreID = Store.ID
	WHERE Location = @StoreName
	GROUP BY Store.Location 
	ORDER BY Store.Location 
END


--Display all profits by store

CREATE PROCEDURE spDisplayAllProfitsByStore
@StoreName VARCHAR(50)
AS
BEGIN
SELECT TOP 1 SUM(Movies.Price) AS Profit_From_Store , Store.Location
	FROM Rentals JOIN Movies ON Rentals.MovieID = Movies.ID JOIN Store ON Rentals.StoreID = Store.ID
	WHERE Location = @StoreName
	GROUP BY Store.Location
	ORDER BY Profit_From_Store DESC
END


-- Display the Customer orders between dates

CREATE PROCEDURE spDisplayOrdersByCustomerBetweenDates
@StartDate DATETIME,
@EndDate DATETIME
AS
BEGIN
	SELECT CustomerID , COUNT(ID)
	FROM Rentals
	WHERE RentDate BETWEEN @StartDate AND @EndDate
	GROUP BY CustomerID
END