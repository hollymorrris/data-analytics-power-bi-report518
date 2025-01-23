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
### Creating a Date Table

### Building the Star Schema Data Model
<img width="761" alt="Screenshot 2025-01-23 at 21 07 17" src="https://github.com/user-attachments/assets/242b4d3d-c6ec-42be-8199-428c5e091b14" />

### Creating a Measures Table

### Creating Key Measures

### Creating Date and Geography Hierarchies


## Building the Customer Details Page

## Creating an Executive Summary Page 

## Creating a Product Detail Page 

## Creating a Stores Map Page 

## Cross-Filtering and Navigation 

## Creating Metrics for Users Outside the Company Using SQL
