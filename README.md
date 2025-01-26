# E-Commerse Power BI Report 
## Importing the Data into Power BI 
### Orders Table 
This is the main fact table. It contains information about each order, including the order and shipping dates, the customer, store and product IDs for associating with dimension tables, and the amount of each product ordered. Each order in this table consists of an order of a single product type, so there is only one product code per order.

Connected to an Azure SQL Database to import the Orders table. 

Cleaned and organised data in table:
  * Removed Card Number column to ensure data privacy.
  * Split the Order Date and Shipping Date columns into two distinct date and time columns for each.
  * Removed rows containg missing or null values in the Order Date column to maintain data integrity.
  * Renamed columns to ensure consistency. 

### Products Table 
This table contains information about each product sold by the company, including the product code, name, category, cost price, sale price, and weight.

Connected to web-hosted CSV file to import Products table. 

Cleaned and organised data in table:
  * Removed duplicate rows based on Product Code column
  * Renamed columns to ensure consistency. 

### Stores Table
This table contains information about each store, including the store code, store type, country, region, and address.

Connected to Azure Blob Storage to import Stores table. 

Cleaned and organised data in table:
  * Replaced values in Region column with correct spelling and consistency. 
  * Renamed columns to ensure consistency. 

### Customers Table 
This table contains information about each customer, including full name, address, country, email, date of birth. 

Connected to folder containing three CSV files, each with the same column format, one for each of the regions in which the company operates. Combined 3 files to import the Customers folder. 

Cleaned and organised data in table:
  * Created a new column (Full Name) by combining columns First Name and Last Name. 
  * Deleted any clearly unused columns. 
  * Renamed columns to ensure consistency. 

## Creating the Data Model
### Dates Table
A continous date table which covers the entire time period of the data is required for Power BI's time intelligence functions. 

Created a date table running from the start of the year containing the earliest Order Date to the end of the year containing the latest Shipping Date:

 Dates = CALENDAR(DATE(YEAR(MIN(Orders[Order Date])), 1, 1), DATE(YEAR(MAX(Orders[Shipping Date])), 12, 31))

Create the following columns for Dates table using DAX expressions:

 * Day of Week
 * Month Number
 * Month Name
 * Quarter
 * Year
 * Start of Year
 * Start of Quarter
 * Start of Month
 * Start of Week
   
### Star Schema Data Model
<img width="761" alt="Screenshot 2025-01-23 at 21 07 17" src="https://github.com/user-attachments/assets/242b4d3d-c6ec-42be-8199-428c5e091b14" />

### Measures Table
Created a measures table for measures to ensure ease of navigation and organisation of data model. 

### Key Measures
 * **Total Orders** = COUNT(Orders[Order Date])
 * **Total Revenue** = SUMX(Orders, Orders[Product Quantity] * RELATED(Products[Sale Price]))
 * **Total Profit** = SUMX(Orders, Orders[Product Quantity] * (RELATED(Products[Sale Price]) - RELATED(Products[Cost Price])))
 * **Total Customers** = DISTINCTCOUNT(Orders[User ID])
 * **Total Quantity** = SUM(Orders[Product Quantity])
 * **Profit YTD** = TOTALYTD([Total Profit], Orders[Order Date])
 * **Revenue YTD** = TOTALYTD([Total Revenue], Orders[Order Date])

### Date and Geography Hierarchies
Created a Date Hierarchy:

<img width="155" alt="Screenshot 2025-01-24 at 16 15 32" src="https://github.com/user-attachments/assets/2b9759bf-2bec-4530-945e-10d1f01255cd" />


Created a Geography Hierarchy:

<img width="171" alt="Screenshot 2025-01-24 at 16 14 59" src="https://github.com/user-attachments/assets/38e7f28e-73e8-4b95-af68-08a287335ccf" />


## Building the Customer Details Page
Created a report page focused on customer level analysis. This includes the following visuals:
 * Card visuals for total distinct customers and revenue per customer.
 * Donut charts showing number of customers by country and number of customers by product category.
 * A line chart of customers by year, quarter and month.
 * A table showing the top 20 customers, including the revenue per customer and number of orders per customer.
 * A set of three card visuals for the name, revenue and order for the top customer by revenue.

(add screenshot)

## Creating an Executive Summary Page 
Created a report page for the high-level executive summary, providing an overview of the company's performance as a whole. This contains the following visuals:
 * Card visuals showing total reveneue, total profit and total orders.
 * A line chart showing revenue against time.
 * Donut charts for revenue by country and store type.
 * A bar chart of orders by product category.
 * KPI visuals for quarterly revenue, quarterly orders and quarterly profit. Required creation of measures for previous quarter revenue, target revenue, previous quarter orders, target orders, previous quarter profit and target profit.

(add screenshot)

## Creating a Product Detail Page 


## Creating a Stores Map Page 

## Cross-Filtering and Navigation 

## Creating Metrics for Users Outside the Company Using SQL
