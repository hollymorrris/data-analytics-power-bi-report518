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

<img width="791" alt="Screenshot 2025-02-04 at 18 37 14" src="https://github.com/user-attachments/assets/a8b1c3a1-2870-43bf-9ff8-e2366d611dbf" />

## Creating an Executive Summary Page 
Created a report page for the high-level executive summary, providing an overview of the company's performance as a whole. This contains the following visuals:
 * Card visuals showing total reveneue, total profit and total orders.
 * A line chart showing revenue against time.
 * Donut charts for revenue by country and store type.
 * A bar chart of orders by product category.
 * KPI visuals for quarterly revenue, quarterly orders and quarterly profit. Required creation of measures for previous quarter revenue, target revenue, previous quarter orders, target orders, previous quarter profit and target profit.

<img width="791" alt="Screenshot 2025-02-04 at 18 36 32" src="https://github.com/user-attachments/assets/4fda7c35-509a-4caa-a3a6-cc5921d2545e" />

## Creating a Product Detail Page 
Created a product detail page which provides an in-depth look at which products are performing well, with the option of filtering by by product and/or region. The following visuals were created:
 * Gauge visuals to show how the selected category's current revenue, profit and number of orders are performing compared to the quarterly target (based on 10% quarter on quarter growth).
 * An area chart showing relative revenue performance of each category over time.
 * A table for the top 10 products by revenue in the selected context.
 * A scatter graph of quantity of items ordered against profit per item for products in the current context.
 * Card visuals to show which filters are currently selected for product category and country.

<img width="790" alt="Screenshot 2025-02-04 at 18 37 56" src="https://github.com/user-attachments/assets/6fc24e65-8fb5-4c9b-80e2-bd0769e42187" />

Used the bookmarks feature to create a pop-out toolbar which can be accessed from the navigation bar on the left-hand side of the page to allow users to filter by product category and store country.

<img width="154" alt="Screenshot 2025-02-04 at 18 38 56" src="https://github.com/user-attachments/assets/09b724c0-11de-4337-ad77-29b34d1ee829" />

## Creating a Stores Map Page 
Created a stores map page, stores drillthrough page and stores tooltip page to allow viewers to easily track profit and revenue targets of stores by location. The stores drillthrough page contains these visuals:
 * A table showing the top 5 products based on Total Orders, with columns: Description, Profit YTD, Total Orders, Total Revenue.
 * A column chart showing Total Orders by product category for the store.
 * Gauges for Profit YTD against a profit target of 20% year-on-year growth vs. the same period in the previous year.
 * Value field, as the target will change as we move through the year.
 * A Card visual showing the currently selected store.

Stores Map Page

<img width="791" alt="Screenshot 2025-02-04 at 18 39 42" src="https://github.com/user-attachments/assets/cad1bd80-bb2b-4601-b303-dae68832b5a0" />

Stores Drillthrough Page

<img width="790" alt="Screenshot 2025-02-04 at 18 40 06" src="https://github.com/user-attachments/assets/9dff9aa4-5914-4b46-9797-2c6f4fe20291" />

Stores Tooltip Page 

<img width="227" alt="Screenshot 2025-02-04 at 18 40 30" src="https://github.com/user-attachments/assets/4a78070c-9221-4dc2-8edd-10d40465a612" />


## Cross-Filtering and Navigation 
Fixed the cross-filtering between certain visuals by editing interactions:
 * Product Category bar chart and Top 10 Products table to not filter the card visuals or KPIs on the excecutive summary page.
 * Top 20 Customers table to not filter any of the other visuals on customer details page. 
 * Total Customers by Product Category Donut Chart to not affect the Customers line graph on customer details page.
 * Total Customers by Country donut chart to cross-filter Total Customers by Product Category Donut Chart on customer details page.
 * Orders vs. Profitability scatter graph to not affect any other visuals on product details page.
 * Top 10 Products table to not affect any other visuals on product details page.

Added navigation buttons for each of the report pages to enable users to easily and directly move between different report pages. 

<img width="28" alt="Screenshot 2025-02-04 at 18 41 23" src="https://github.com/user-attachments/assets/7906e3ac-301d-484a-9f66-084efe8c47ea" /> Executive Summary Page

<img width="27" alt="Screenshot 2025-02-04 at 18 41 47" src="https://github.com/user-attachments/assets/c9795717-8a62-4126-816e-f65a311285ab" /> Customer Details Page

<img width="28" alt="Screenshot 2025-02-04 at 18 42 03" src="https://github.com/user-attachments/assets/3f62a2a8-c4e1-4236-a4e8-49a657feed2a" /> Products Details Page

<img width="28" alt="Screenshot 2025-02-04 at 18 42 20" src="https://github.com/user-attachments/assets/106c3892-c7d3-48f9-af8a-fdf0bb62df54" /> Stores Map Page 


## Creating Metrics for Users Outside the Company Using SQL
Connected to SQL database stored in Azure. Answered the following questions with SQL queries:
1. How many staff are there in all of the UK stores?
2. Which month in 2022 has had the highest revenue?
3. Which German store type had the highest revenue for 2022?
4. Create a view where the rows are the store types and the columns are the total sales, percentage of total sales and the count of orders
5. Which product category generated the most profit for the "Wiltshire, UK" region in 2021?

Uploaded the corresponding files for exported results and the SQL queries themselves. 

