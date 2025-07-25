# **Instacart Market Basket Analysis – SQL Database Documentation**

# **Overview**

This project involves creating and analyzing a SQL database using Instacart’s transaction data. The aim is to explore customer behavior, identify top products, track ordering patterns, and generate insights that can inform better decision-making in retail and e-commerce.

## **Task 1: Database Creation & Setup**

### **1.1 Database Creation**

A dedicated SQL database was created to store and analyze the Instacart dataset.

### **1.2 Data Importation**

**Small Tables (Flat File Import):**

* Aisles  
* Departments  
* Orders

These were successfully imported using the Import Flat File tool in SQL Server Management Studio (SSMS). Data types were confirmed, and checks for duplicates and nulls were completed.

**Large Tables (Manual Schema \+ Bulk Insert):**

* Order\_Products\_Prior  
* Order\_Products\_Train  
* Products

Due to their size, these tables couldn't be imported directly. Instead:

* Table schemas were created manually to define the correct data types.  
* Data was imported using the BULK INSERT method.  
* All tables were validated to ensure no duplicate or null entries in key fields.

  ### **1.3 Constraints & Indexing**

**Primary Keys:**

* Each table was assigned a primary key to ensure data integrity.  
* Composite keys were used for the order-product tables (order ID \+ product ID).  
* All primary key fields were set to NOT NULL.

**Foreign Keys:**

* Relationships were defined between tables using foreign key constraints.  
* Referential integrity was enforced by checking for any orphaned records.

**Indexing:**

* An index was created on the user ID column in the Orders table to optimize customer-related queries.

  ### **1.4 Entity Relationship Diagram (ERD)**

An ERD was created using the SSMS Database Diagram Tool. It visually represents:

* The structure of each table (entities and attributes)  
* Relationships between tables via primary and foreign keys  
   This helped in understanding how data connects across the system.

## **Task 2: Understanding the Dataset**

### **2.1 Table Overview**

The dataset includes millions of records across different tables such as Orders, Products, Order History, Aisles, and Departments.

### **Total Number of Rows in Each Table:**

* Aisles: 134  
* Departments: 21  
* Order Products Train: 1,384,617  
* Order Products Prior: 32,434,489  
* Orders: 3,421,083  
* Products: 49,688

  ### **2.2 Key Variables**

* **Product Details** are stored in the **Products** table, which contains product names, product IDs, and links to aisle and department IDs.  
* **Customer Order Information** is found in the **Orders** table, storing order details such as order ID, user ID, day of the week (order\_dow), and order hour.  
* **Order History** is available in two tables:  
  * Order\_Products\_Prior: Contains past order details for all users.  
  * Order\_Products\_Train: A subset of past orders used for training

**2.3 Key Identifiers (Primary Keys and Foreign Keys)**

**Primary Keys:**

* Aisles — aisle\_id  
* Departments — department\_id  
* Products — product\_id  
* Orders — order\_id  
* Order\_Products\_Prior — (order\_id, product\_id)  
* Order\_Products\_Train — (order\_id, product\_id)

**Foreign Keys:**

* Products.aisle\_id — Aisles.aisle\_id  
* Products.department\_id — Departments.department\_id  
* Order\_Products\_Prior.order\_id — Orders.order\_id  
* Order\_Products\_Prior.product\_id — Products.product\_id  
* Order\_Products\_Train.order\_id — Orders.order\_id  
* Order\_Products\_Train.product\_id — Products.product\_id

  ### **2.4 Exploratory Data Analysis (EDA)**

**Order Time Analysis:**

* Orders are placed throughout the day, with the average order hour at 1:00 PM.  
* Earliest Order Hour **—** 12:00 AM (Midnight)  
* Latest Order Hour **—** 11:00 PM

**Top Purchased Products:**

* The most frequently bought items include bananas, organic strawberries, baby spinach, and avocado.  
* Organic and fresh produce dominate shopping carts.

**Popular Aisles & Departments:**

* Fresh fruits and vegetables are the top-selling aisles.  
* The produce department sees the highest number of purchases, followed by dairy, snacks, and beverages.

**Customer Behavior:**

* Customers typically order about 10 unique items per order.  
* Over half of all purchases are repeat orders, suggesting strong product loyalty.  
* Most customers prefer shopping in the late morning to early afternoon.

**Task 3: Data Analysis & Insights**

### **3.1 Customer Segmentation**

#### **Categorizing Customers Based on Total Spend**

Customers were segmented based on the number of orders they placed:

* **Frequent Buyers**: Customers who have placed **more than 50 orders**.  
* **Regular Buyers**: Customers who have placed **between 21 and 49 orders**.  
* **Occasional Buyers**: Customers who have placed **20 or fewer orders**.

This segmentation helps in identifying high-value customers who regularly shop, allowing targeted marketing campaigns to boost engagement and retention.

**By Reorder Behavior:**

* Loyal Customers: Reorder rate above 50%  
* Occasional Reorderers: Reorder rate between 20% and 50%  
* New Shoppers: Reorder rate below 20%

This segmentation helps in identifying key customer groups for marketing and retention strategies.

### **3.2 Product Association Rules**

**Frequently Bought Together:**

* Customers tend to pair bananas with other organic produce like avocados, strawberries, and spinach.  
* These product pairs were added to carts together tens of thousands of times.

**Weekend vs Weekday Preferences:**

* Fresh and organic items are more likely to be bought on weekends.  
* This may reflect customers stocking up for the week or weekend meal prepping.

  ### **3.3 Seasonal Trends**

**Day of the Week:**

* Sunday is the busiest shopping day.  
* Thursday sees the lowest activity.

**Monthly Patterns:**

* January has the highest order volume, potentially tied to New Year resolutions or restocking.  
* December has the lowest, possibly due to holiday habits or data limitations.

  ### **3.4 Customer Churn Prediction**

* 369,323 users had not placed an order in the last 30 days.  
* A churn rate of 0.00% was initially reported, but this may require reevaluation depending on how churn is defined.  
* More accurate churn analysis would need clearer date labels and retention criteria.

**Final Insights & Recommendations**

* **Personalization**: Use product pair patterns and reorder behavior to offer personalized recommendations.  
* **Retention**: Focus on loyal and frequent customers with loyalty programs or subscription models.  
* **Marketing**: Target weekend shoppers with bundles or special deals.  
* **Churn Risk**: Monitor users with declining order activity and re-engage them via reminders or offers.  
* **Operational Efficiency**: Stock and promote the most reordered and first-added items.