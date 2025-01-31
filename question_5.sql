SELECT 
    category,
    SUM((dim_products.sale_price - dim_products.cost_price) * orders.product_quantity) AS total_profit

FROM
    orders
INNER JOIN  
    dim_stores ON orders.store_code = dim_stores.store_code
INNER JOIN
    dim_products ON orders.product_code = dim_products.product_code
INNER JOIN
    dim_date ON orders.order_date = dim_date.date

WHERE 
    dim_stores.country_region = 'Wiltshire' AND dim_date.year = 2021

GROUP BY    
    category

ORDER BY 
    total_profit DESC

LIMIT
    1;