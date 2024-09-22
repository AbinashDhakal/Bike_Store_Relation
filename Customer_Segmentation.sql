 -- Customer Segmentation
WITH customer_stats AS (
    SELECT
        customer_id,
        SUM(quantity * list_price * (1 - discount)) AS total_spent,
        COUNT(DISTINCT orders.order_id) AS total_orders,
        DATEDIFF(DAY, MAX(orders.order_date), '2018-12-29')  AS days_since_last_purchase
    FROM
        [Bike_Store_Relation].[dbo].[orders]
    INNER JOIN
        [Bike_Store_Relation].[dbo].[order_items]
    ON
        orders.order_id = order_items.order_id
    GROUP BY
        customer_id
)

SELECT
    customer_id,
    CASE WHEN total_orders > 1 THEN 'repeat buyer'
         ELSE 'one-time buyer'
         END AS purchase_frequency,
    CASE WHEN days_since_last_purchase < 90 THEN 'recent buyer'
         ELSE 'not recent buyer'
         END AS purchase_recency,
    CASE WHEN total_spent/(SELECT MAX(total_spent) FROM customer_stats) >= .65 THEN 'big spender'
         WHEN total_spent/(SELECT MAX(total_spent) FROM customer_stats) <= .30 THEN 'low spender'
         ELSE 'average spender' 
         END AS buying_power
FROM
    customer_stats