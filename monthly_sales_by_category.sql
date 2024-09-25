WITH product_categories AS (
    SELECT
        product_id,
        category_name
    FROM
        [Bike_Store_Relation].[dbo].[products]
    INNER JOIN
        [Bike_Store_Relation].[dbo].[categories]
    ON
        products.category_id = categories.category_id
),

product_sales_ym AS (
    SELECT
        YEAR(order_date) AS year,
        MONTH(order_date) AS month,
        product_id,
        SUM(quantity) AS units_sold
    FROM
        [Bike_Store_Relation].[dbo].[orders]
    INNER JOIN
        [Bike_Store_Relation].[dbo].[order_items]
    ON
        orders.order_id = order_items.order_id
    GROUP BY
        YEAR(order_date), MONTH(order_date), product_id
)

SELECT
    month,
    category_name,
    AVG(units_sold) AS avg_units_sold
FROM
    product_sales_ym
INNER JOIN
    product_categories
ON
    product_sales_ym.product_id = product_categories.product_id
GROUP BY
    month, category_name;
WITH product_categories AS (
    SELECT
        product_id,
        category_name
    FROM
        products
    INNER JOIN
        categories
    ON
        products.category_id = categories.category_id
),

product_sales_ym AS (
    SELECT
        YEAR(order_date) AS year,
        MONTH(order_date) AS month,
        product_id,
        SUM(quantity) AS units_sold
    FROM
        orders
    INNER JOIN
        order_items
    ON
        orders.order_id = order_items.order_id
    GROUP BY
        YEAR(order_date), MONTH(order_date), product_id
)

SELECT
    month,
    category_name,
    AVG(units_sold) AS avg_units_sold
FROM
    product_sales_ym
INNER JOIN
    product_categories
ON
    product_sales_ym.product_id = product_categories.product_id
GROUP BY
    month, category_name;
