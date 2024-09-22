WITH customer_stats AS (
    SELECT
        customer_id,
        SUM(quantity * list_price * (1 - discount)) AS total_spent,
        COUNT(DISTINCT orders.order_id) AS total_orders,
        DATEDIFF(DAY, MAX(orders.order_date), '2018-12-29') AS days_since_last_purchase
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
    CASE WHEN days_since_last_purchase < 90 THEN 'recent buyer'
         ELSE 'not recent buyer'
         END AS purchase_recency,
    COUNT(*) AS Total
FROM
    customer_stats
GROUP BY
    CASE WHEN days_since_last_purchase < 90 THEN 'recent buyer'
         ELSE 'not recent buyer'
         END;
