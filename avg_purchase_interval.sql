SELECT
    customer_id,
    AVG(DATEDIFF(DAY, prev_order_date, order_date)) AS avg_days_between_purchases
FROM 
    (
     SELECT
         o.customer_id,
         o.order_date,
         LAG(o.order_date) OVER (PARTITION BY o.customer_id ORDER BY o.order_date) AS prev_order_date
     FROM
         [Bike_Store_Relation].[dbo].[orders] o
     INNER JOIN
         [Bike_Store_Relation].[dbo].[customers] c ON o.customer_id = c.customer_id
    ) subquery
WHERE 
    prev_order_date IS NOT NULL
GROUP BY
    customer_id;
