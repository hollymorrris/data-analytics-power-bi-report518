SELECT 
    store_type,
    SUM(dim_products.sale_price * orders.product_quantity) AS total_revenue

FROM
    orders
INNER JOIN  
    dim_stores ON orders.store_code = dim_stores.store_code
INNER JOIN
    dim_products ON orders.product_code = dim_products.product_code
INNER JOIN
    dim_date ON orders.order_date = dim_date.date

WHERE 
    dim_stores.country = 'Germany' AND dim_date.year = 2022

GROUP BY    
    dim_stores.store_type

ORDER BY 
    total_revenue DESC

LIMIT
    1;

