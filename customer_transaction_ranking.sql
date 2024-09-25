SELECT 
    c.first_name + ' ' + c.last_name AS customer_name,  -- Use '+' for concatenation in SQL Server
    COUNT(s.order_id) AS total_transactions,
    RANK() OVER (ORDER BY COUNT(s.order_id) DESC) AS rank
FROM
    orders s
INNER JOIN
    customers c 
ON 
    s.customer_id = c.customer_id
GROUP BY
    c.first_name, c.last_name
ORDER BY
    total_transactions DESC;
