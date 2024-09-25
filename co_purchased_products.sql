SELECT
    product_a,
    product_b,
    co_purchase_count
FROM 
    (
     SELECT
         p1.product_name AS product_a,
         p2.product_name AS product_b,
         COUNT(*) AS co_purchase_count
     FROM
         [Bike_Store_Relation].[dbo].[order_items] s1
     INNER JOIN
         [Bike_Store_Relation].[dbo].[order_items] s2 ON s1.order_id = s2.order_id AND s1.product_id <> s2.product_id
     INNER JOIN
         [Bike_Store_Relation].[dbo].[products] p1 ON s1.product_id = p1.product_id
     INNER JOIN
         [Bike_Store_Relation].[dbo].[products] p2 ON s2.product_id = p2.product_id
     GROUP BY
         p1.product_name, p2.product_name  -- Use product names instead of IDs
    ) subquery
ORDER BY
    co_purchase_count DESC;
