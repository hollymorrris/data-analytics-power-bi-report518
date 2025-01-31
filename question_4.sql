CREATE VIEW store_types_view AS
SELECT
    dim_stores.store_type,
    SUM(dim_products.sale_price * orders.product_quantity) AS total_sales,
    SUM(dim_products.sale_price * product_quantity) * 100.0 / 
        (SELECT 
            SUM(dim_products.sale_price * product_quantity) 
        FROM 
            orders
        INNER JOIN
            dim_products ON orders.product_code = dim_products.product_code) AS total_sales_percentage,
    COUNT(index) AS order_count

FROM 
    orders
INNER JOIN
    dim_stores ON orders.store_code = dim_stores.store_code
INNER JOIN
    dim_products ON orders.product_code = dim_products.product_code

GROUP BY 
    dim_stores.store_type;

SELECT * FROM store_types_view;