SELECT 
    month_name,
    SUM(dim_products.sale_price * orders.product_quantity) AS total_revenue

FROM
    orders
INNER JOIN
    dim_products ON orders.product_code = dim_products.product_code
INNER JOIN
    dim_date ON orders.order_date = dim_date.date

WHERE 
    dim_date.year = 2022

GROUP BY    
    dim_date.month_name

ORDER BY 
    total_revenue DESC

LIMIT
    1;

