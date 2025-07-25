-- Instacart Market Basket Analysis
CREATE DATABASE InstacartDB

-- Using Database
USE InstacartDB

-- Creating Order_Products_Prior Table
CREATE TABLE Order_Products_Prior (
    order_id INT,
    product_id INT,
    add_to_cart_order INT,
    reordered INT
)

-- Inporting Data into Order_Product_Prior
BULK INSERT Order_Products_Prior
FROM "C:\Users\HP-USER\Documents\SQL Project\order_products__prior.csv"
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,  -- Skips the header row
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    TABLOCK
);

--Creating Order_Product_Train Table
CREATE TABLE Order_Product_Train(
    order_id INT,
    product_id INT,
    add_to_cart_order INT,
    reordered INT
);

-- Inserting Into the Order_Product_Train Table
BULK INSERT Order_Product_Train
FROM "C:\Users\HP-USER\Documents\SQL Project\order_products__train.csv"
WITH (
    FORMAT = 'csv',
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '0x0A',
	TABLOCK
);

-- Creating Product table
CREATE TABLE Products(
    Product_ID INT,
    Product_Name VARCHAR(550),
    Aisle_ID INT,
    Department_ID INT,
);

-- Inserting Into the Products Table
BULK INSERT Products
FROM "C:\Users\HP-USER\Documents\SQL Project\products.csv"
WITH (
    FORMAT = 'csv',
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '0x0A',
	TABLOCK
)


-- Adding the Primary Key constraint to the Aisles(Aisle_Id) 
ALTER TABLE Aisles
ADD CONSTRAINT PK_Aisles PRIMARY KEY (Aisle_id)

-- Adding Primary key constraint to the Department(Department_id)
ALTER TABLE Departments
ADD CONSTRAINT PK_Department PRIMARY KEY (Department_id)

-- Checking for duplicate Values in order_id and product_id column In the Order_Product_Train Table
SELECT order_id, product_id, COUNT(*)
FROM order_product_Train
GROUP BY order_id, product_id
HAVING COUNT(*) > 1;

-- Checking if the Order_product_Train(Order_id) has Null Values
SELECT * FROM Order_Product_Train WHERE Order_ID IS NULL

-- Altering Order_Product_Train(Order_id) to NOT NULL
ALTER TABLE Order_Product_Train
ALTER COLUMN Order_id INT NOT NULL

-- Altering Order_Product_Train(Product_id) to NOT NULL
ALTER TABLE Order_Product_Train
ALTER COLUMN Product_id INT NOT NULL

-- Adding Primary key constraint to the Order_Product_Train Table
ALTER TABLE Order_Product_Train
ADD CONSTRAINT PK_Order_Product_Train PRIMARY KEY (Order_id, Product_id)


-- Checking for duplicate Values in order_id and product_id column in the Order_Products_Prior Table
SELECT order_id, product_id, COUNT(*)
FROM order_products_prior
GROUP BY order_id, product_id
HAVING COUNT(*) > 1;

-- Altering order_products_prior(Order_id) to NOT NULL
ALTER TABLE Order_Products_Prior
ALTER COLUMN Order_id INT NOT NULL

-- Altering Order_Product_Prior(Product_id) to NOT NULL
ALTER TABLE Order_Products_Prior
ALTER COLUMN Product_id INT NOT NULL

-- Adding a Composite Primary Key constraint to Order_Products_Prior(order_id, product_id) column
ALTER TABLE Order_products_Prior
ADD CONSTRAINT PK_Order_productS_prior PRIMARY KEY (Order_id, Product_id)

-- Adding Primary key constraint to the Orders(Order_id) column
ALTER TABLE Orders
ADD CONSTRAINT PK_Orders PRIMARY KEY (Order_id)

-- Creating INDEX for the User_ID column (For faster lookup)
CREATE INDEX idx_used_id ON Orders(User_id)

-- Altering the Products(product_id) column to NOT NULL
ALTER TABLE Products
ALTER COLUMN Product_id INT NOT NULL

-- Adding a primary key to the Products(Product_id) column
ALTER TABLE Products
ADD CONSTRAINT PK_Products PRIMARY KEY (Product_id)

-- Adding a Foreign key constraint to the Product(Aisle_id)
ALTER TABLE Products
ADD CONSTRAINT FK_Products 
FOREIGN KEY (Aisle_id) REFERENCES Aisles(aisle_id);

-- Adding a Foreign Key constriant to the Products(Department_id) column
ALTER TABLE Products
ADD CONSTRAINT FK_Product -- A different Product Name
FOREIGN KEY (Department_id) REFERENCES Departments(Department_id);

-- Adding a Foreign Key constraint to the Order_Product_Train(Order_id) column
ALTER TABLE Order_Product_Train
ADD CONSTRAINT FK_Order_Product_Train
FOREIGN KEY (Order_id) REFERENCES Orders(Order_id)

-- Adding a foreign Key constraint to the order_Product_train(Product_id) column
ALTER TABLE Order_Product_Train
ADD CONSTRAINT FK_Order_Product_trains -- A different Object Name
FOREIGN KEY (Product_id) REFERENCES Products(Product_Id)

-- Adding a foreign Key constraint to the Order_Products_prior(Order_id) column
ALTER TABLE Order_Products_Prior
ADD CONSTRAINT FK_Order_products_Prior
FOREIGN KEY (Order_Id) REFERENCES Orders(Order_id)

-- Creating Index for the Order_Products_prior(Order_ID) column [For faster Lookup]
CREATE INDEX idx_order_id ON Order_Products_prior(Order_id)

-- Adding a foreign key constraint to the Order_Products_Prior(Product_id) column
ALTER TABLE Order_Products_prior
ADD CONSTRAINT FK_Order_Product_Prior -- A different object name
FOREIGN KEY (Product_id) REFERENCES Products(Product_id)

-- Creating Index for the Order_Products_prior(product_id) Column [For faster Lookup]
CREATE INDEX idx_Product_id ON Order_products_Prior(Product_id)

-- Verifying foreign key reltionship
SELECT COUNT(*)
FROM Order_Products_prior
WHERE Order_id NOT IN (SELECT Order_id FROM Orders)

-- Checking for duplicate In Aisles Table
SELECT Aisle_id, COUNT(*) AS Duplicate
FROM Aisles
GROUP BY aisle_id
HAVING COUNT(*) > 1
ORDER BY Duplicate DESC

-- Checking for null Values
SELECT * FROM Aisles
WHERE Aisle_id IS NULL

-- Checking for duplicate In Department Table
SELECT Department_id, COUNT(*) AS Duplicate
FROM Departments
GROUP BY department_id
HAVING COUNT(*) > 1
ORDER BY Duplicate

-- Checking for null Values
SELECT * FROM Departments
WHERE department_id IS NULL


-- Checking for duplicate In the Order_Products_Prior Table
SELECT Order_id, Product_id, COUNT(*) AS Duplicate
FROM Order_Products_Prior
GROUP BY Order_id, Product_id
HAVING COUNT(*) > 1
ORDER BY Duplicate DESC

-- Checking for null Values
SELECT * FROM Order_Products_Prior
WHERE order_id IS NULL

-- Checking for duplicate In the Order_Product_Train Table
SELECT Order_id, Product_id, COUNT(*) AS Duplicate
FROM Order_Product_Train
GROUP BY Order_id, Product_id
HAVING COUNT(*) > 1
ORDER BY Duplicate DESC

-- Checking for null Values
SELECT * FROM Order_Product_Train
WHERE Order_id IS NULL

-- Checking for duplicate In Orders Table
SELECT Order_ID, User_id, COUNT(*) AS Duplicate
FROM Orders
GROUP BY Order_id, User_id
HAVING COUNT(*) > 1
ORDER BY Duplicate

-- Checking for null Values
SELECT * FROM Orders
WHERE Order_id IS NULL

-- Checking for duplicate In Product Table
SELECT Product_id, COUNT(*) AS Duplicate
FROM Products
GROUP BY Product_id
HAVING COUNT(*) > 1
ORDER BY Duplicate

-- Checking for null Values
SELECT * FROM Products
WHERE Product_id IS NULL


/*Understanding The data*/

-- Checking column_name and Data_Type
SELECT COLUMN_NAME, DATA_TYPE, TABLE_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME IN ('Aisles', 'Department', 'Order_product_Train', 'Order_products_Prior', 'Orders', 'Products')


-- Get the total Number of rows In each table
SELECT 'Aisles' AS Table_name, COUNT(*) AS Total_Row FROM Aisles
UNION ALL
SELECT 'Department', COUNT(*) FROM Departments
UNION ALL
SELECT 'Order_product_Train', COUNT(*) FROM Order_Product_Train
UNION ALL
SELECT 'Order_Products_Prior', COUNT(*) FROM Order_Products_Prior
UNION ALL
SELECT 'Orders', COUNT(*) FROM Orders
UNION ALL
SELECT 'Products', COUNT(*) FROM Products

-- Earliest, latest, and average order time.
SELECT
      MIN(Order_Hour_of_day) AS Min_order_Hour,
	  MAX(Order_Hour_of_Day) AS Max_Order_Hour,
	  AVG(Order_Hour_of_Day) AS Avg_Order_Hour
FROM Orders;

-- Most common day of the week for orders
SELECT TOP 1
     Order_dow, COUNT(*) AS Count
FROM Orders
GROUP BY order_dow
ORDER BY Count DESC

-- how much order times vary
SELECT 
     ROUND(STDEV(Order_Hour_of_Day),2) AS Std_Dev_Order_Hour,
	 ROUND(VAR(Order_Hour_of_Day), 2) AS Variance_Order_Hour
FROM Orders

-- Top 10 most purchased products
SELECT TOP 10
     P.Product_name,
	 COUNT(OPP.Order_ID) AS Total_Orders
FROM Products P
INNER JOIN Order_Products_Prior OPP
ON P.Product_ID = OPP.product_id
GROUP BY P.Product_Name
ORDER BY Total_Orders DESC

-- Top aisles where products are frequently bought
SELECT TOP 10
     A.Aisle,
	 COUNT(OPP.Order_id) AS Total_Product
FROM Aisles A
INNER JOIN Products P
ON A.aisle_id = P.Aisle_ID
INNER JOIN Order_Products_Prior OPP
ON P.Product_ID = OPP.product_id
GROUP BY A.aisle
ORDER BY Total_Product DESC

-- most popular departments
SELECT TOP 10
     D.Department,
	 COUNT(OPP.Product_id) AS Total_Order
FROM Department D
INNER JOIN Products P
ON D.department_id = P.Department_ID
INNER JOIN Order_Products_Prior OPP
ON P.Product_ID = OPP.product_id
GROUP BY D.department
ORDER BY Total_Order DESC

-- Customer Ordering Behavior (busiest hours for orders)
SELECT 
     Order_Hour_of_day,
	 COUNT(Order_id) AS Total_Order
FROM Orders
GROUP BY order_hour_of_day
ORDER BY Total_Order DESC

-- How Often do customers Reorder
SELECT Reordered,
       COUNT(*) AS Total_reorder 
FROM Order_Products_Prior
GROUP BY reordered
ORDER BY Total_reorder DESC

/*Market Analysis*/

-- Top 10 Most Frequently Purchased Product Pairs
WITH ProductPairs AS
(
   SELECT OPP1.product_id AS Product_1,
          OPP2.Product_id AS Product_2,
		  COUNT(*) AS PairCount
	FROM Order_Products_Prior OPP1
	INNER JOIN Order_Products_Prior OPP2
	ON OPP1.Order_id = OPP2.Order_id
	AND OPP1.product_id < OPP2.product_id -- Prevent duplicate Pairs
	GROUP BY OPP1.product_id, opp2.product_id
)
SELECT TOP 10
     P1.Product_Name AS Product_1,
	 P2.Product_Name AS Product_2,
	 PairCount
FROM ProductPairs PP
INNER JOIN Products P1
ON P1.Product_ID = PP.Product_1
INNER JOIN Products P2
ON P2.Product_ID = PP.Product_2
ORDER BY PairCount DESC;

-- Top 5 Products Added to the Cart First (most often added first in an order)
SELECT TOP 5
       OPP.Product_id,
       P.Product_Name,
	   Count(*) First_Added_Count
FROM Order_Products_Prior OPP
INNER JOIN Products P
ON OPP.product_id = P.Product_ID
WHERE Add_to_cart_order = 1
GROUP BY OPP.product_id, P.Product_Name
ORDER BY First_Added_Count DESC

-- how many unique products a typical order contains.
SELECT 
    AVG(Product_Count) AS Avg_unique_Product_per_Order
FROM (
       SELECT 
	       Order_id,
		   COUNT(DISTINCT Product_id) AS Product_Count
		FROM Order_Products_Prior
		GROUP BY order_id 
	  ) AS Order_Summary


/*Customer Segmentation*/

-- Categorizing Customers Based on Total Spend
SELECT 
    User_id,
	COUNT(Order_id)AS Total_Orders,
	CASE
	    WHEN COUNT(Order_id) > 50 THEN 'Frequent Buyers'
		WHEN COUNT(Order_id) BETWEEN 21 AND 49 THEN 'Regular Buyers'
    ELSE 'Occasional Buyers' END AS Order_frequency
FROM Orders 
GROUP BY User_id
ORDER BY Total_Orders DESC

-- Categorizing Customers Based on Reorder Behavior
SELECT 
      User_Id,
	  COUNT(Reordered) AS Product_Reordered,
	  ROUND(CAST(SUM(Reordered) AS FLOAT) / COUNT(Product_id),2) AS Reorder_Rate,
	  CASE
	      WHEN ROUND(CAST(SUM(Reordered) AS FLOAT) / COUNT(Product_id),2) > 0.5 THEN 'Loyal Customers'
		  WHEN ROUND(CAST(SUM(Reordered) AS FLOAT) / COUNT(Product_id),2) BETWEEN 0.2 AND 0.5 THEN 'Occasional reorderers'
		  ELSE 'New Shoppers' END AS Reorder_Behavior
FROM Orders
JOIN Order_Products_Prior 
ON Order_Products_Prior.order_id = Orders.order_id
GROUP BY user_id
ORDER  BY Reorder_Rate DESC

/*Seasonal Trends Analysis*/

-- Days with the highest and lowest number of orders
SELECT
      Order_Dow,
	  COUNT(Order_id) AS NumOF_Orders
FROM Orders
GROUP BY Order_dow
ORDER BY NumOf_orders DESC


-- Months with the highest order volume
WITH OrderDates AS 
(
   SELECT 
       User_id,
	   Order_id,
	   Order_Number,
	   SUM(Days_Since_Prior_Order) OVER (
	       PARTITION BY User_id ORDER BY Order_Number ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
	   ) AS Estimated_days_since_first_Order
	FROM Orders
)
SELECT 
    FLOOR(Estimated_days_since_first_Order / 30) AS Estimated_Month,
	COUNT(Order_id) as Num_of_Orders
FROM OrderDates
GROUP BY FLOOR(Estimated_days_since_first_order / 30)
ORDER BY Estimated_Month

/*Customer Churn Prediction:*/

-- Customers who haven�t placed an order in the last 30 days
SELECT
     User_id,
	  MAX(days_since_prior_order) AS last_order_gap
FROM Orders 
GROUP BY User_id, Order_Number
HAVING MAX(days_since_prior_order) >= 30
ORDER BY last_order_gap DESC


-- Percentage of customers that have churned in the past quarter
WITH Churned AS 
(  
    SELECT User_id
	FROM Orders
	GROUP BY User_id
	HAVING MAX(Days_Since_prior_Order) >= 90
)
SELECT 
    ROUND(COUNT(Churned.User_id) * 100.0/ COUNT(DISTINCT Orders.User_id), 2) AS Churn_Rate
FROM Orders
LEFT JOIN Churned
ON Orders.user_id = Churned.User_id;


/*Product Association Rules*/

-- Top 5 Most Frequently Purchased Product Pairs
WITH ProductPairs AS
(
    SELECT 
        OPP1.Product_id AS Product_1,
        OPP2.Product_id AS Product_2,
        COUNT(*) AS PairCount
    FROM Order_Products_Prior OPP1
    INNER JOIN Order_Products_Prior OPP2
        ON OPP1.Order_id = OPP2.Order_id
        AND OPP1.Product_id < OPP2.Product_id 
    GROUP BY OPP1.Product_id, OPP2.Product_id
)
SELECT TOP 5
    P1.Product_Name AS Product_1,
    P2.Product_Name AS Product_2,
    PP.PairCount
FROM ProductPairs PP
INNER JOIN Products P1 ON P1.Product_ID = PP.Product_1
INNER JOIN Products P2 ON P2.Product_ID = PP.Product_2
ORDER BY PP.PairCount DESC; 

-- Products Bought Together on Weekends vs. Weekdays
SELECT TOP 5
    O.Order_Dow, 
    P1.Product_Name AS Product_1,
    P2.Product_Name AS Product_2,
    COUNT(*) AS PairCount
FROM Orders O
INNER JOIN Order_Products_Prior OPP1 ON O.Order_ID = OPP1.Order_ID
INNER JOIN Order_Products_Prior OPP2 
    ON OPP1.Order_ID = OPP2.Order_ID
    AND OPP1.Product_ID < OPP2.Product_ID  
INNER JOIN Products P1 
ON P1.Product_ID = OPP1.Product_ID
INNER JOIN Products P2 
ON P2.Product_ID = OPP2.Product_ID
WHERE O.Order_Dow IN (0, 6) 
GROUP BY O.Order_Dow, P1.Product_Name, P2.Product_Name
ORDER BY PairCount DESC;

/* Compute Support (How frequently a product appears) */

-- how many times each product_id appears in the Order_Products_Prior table
WITH ProductSupport AS 
(
    SELECT 
        product_id, 
        COUNT(*) AS product_count
    FROM Order_Products_Prior
    GROUP BY product_id
),
-- Find Frequently Bought Product Pairs
ProductPairs AS (
    SELECT 
        OPP1.product_id AS product_1,
        OPP2.product_id AS product_2,
        COUNT(*) AS pair_count
    FROM Order_Products_Prior OPP1
    JOIN Order_Products_Prior OPP2 
        ON OPP1.order_id = OPP2.order_id 
        AND OPP1.product_id < OPP2.product_id
    GROUP BY OPP1.product_id, OPP2.product_id
)
-- Compute Support & Confidence 
SELECT 
    pp.product_1, p1.product_name AS product_1_name,
    pp.product_2, p2.product_name AS product_2_name,
    pp.pair_count,
    ps1.product_count AS product_1_count,
    ps2.product_count AS product_2_count,
    ROUND(pp.pair_count * 1.0 / (SELECT COUNT(DISTINCT order_id) FROM Order_Products_Prior), 4) AS support, 
    ROUND(pp.pair_count * 1.0 / ps1.product_count, 4) AS confidence_1_to_2,
    ROUND(pp.pair_count * 1.0 / ps2.product_count, 4) AS confidence_2_to_1
FROM ProductPairs pp
JOIN ProductSupport ps1 ON pp.product_1 = ps1.product_id
JOIN ProductSupport ps2 ON pp.product_2 = ps2.product_id
JOIN Products p1 ON pp.product_1 = p1.product_id
JOIN Products p2 ON pp.product_2 = p2.product_id
ORDER BY support DESC