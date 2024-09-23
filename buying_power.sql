-- Customer Segmentation
WITH customer_stats AS (
    SELECT
        customer_id,
        SUM(quantity * list_price * (1 - discount)) AS total_spent,
        COUNT(DISTINCT orders.order_id) AS total_orders,
        DATEDIFF(DAY, MAX(orders.order_date), CAST('2018-12-29' AS DATE)) AS days_since_last_purchase
    FROM
        [Bike_Store_Relation].[dbo].[orders] orders
    INNER JOIN
        [Bike_Store_Relation].[dbo].[order_items] order_items
    ON
        orders.order_id = order_items.order_id
    GROUP BY
        customer_id
)
SELECT
    CASE 
        WHEN total_spent / max_total_spent >= .65 THEN 'big spender'
        WHEN total_spent / max_total_spent <= .30 THEN 'low spender'
        ELSE 'average spender' 
    END AS buying_power,
    COUNT(*) AS Total
FROM
    customer_stats
CROSS JOIN (
    SELECT MAX(total_spent) AS max_total_spent FROM customer_stats
) AS max_stats
GROUP BY 
    CASE 
        WHEN total_spent / max_total_spent >= .65 THEN 'big spender'
        WHEN total_spent / max_total_spent <= .30 THEN 'low spender'
        ELSE 'average spender' 
    END;
