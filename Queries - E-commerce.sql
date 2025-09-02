-- 1.Top 5 Customers by Spending
SELECT c.name, SUM(o.total_amount) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY total_spent DESC
LIMIT 5;

-- 2.Best-Selling Products
SELECT p.product_name, SUM(oi.quantity) AS total_sold
FROM Order_Items oi
JOIN Products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC
LIMIT 5;

-- 3.Monthly Sales by Category
SELECT p.category, DATE_FORMAT(o.order_date, '%Y-%m') AS month,
       SUM(oi.quantity * oi.item_price) AS monthly_sales
FROM Order_Items oi
JOIN Products p ON oi.product_id = p.product_id
JOIN Orders o ON oi.order_id = o.order_id
GROUP BY p.category, month
ORDER BY month;

-- 4.Inactive Customers (No Orders in Last 6 Months)
SELECT c.customer_id, c.name
FROM Customers c
WHERE c.customer_id NOT IN (
    SELECT DISTINCT o.customer_id
    FROM Orders o
    WHERE o.order_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
);

-- 5.Average Order Value (AOV)
SELECT ROUND(AVG(total_amount), 2) AS avg_order_value
FROM Orders;

-- 6.Payment Method Usage
SELECT payment_method, COUNT(*) AS total_payments
FROM Payments
WHERE payment_status = 'Completed'
GROUP BY payment_method
ORDER BY total_payments DESC;

-- 7.Orders Delivered Late (> 5 Days)
SELECT o.order_id, c.name, o.order_date, s.shipping_date,
       DATEDIFF(s.shipping_date, o.order_date) AS delivery_days
FROM Orders o
JOIN Shipping s ON o.order_id = s.order_id
JOIN Customers c ON o.customer_id = c.customer_id
WHERE DATEDIFF(s.shipping_date, o.order_date) > 5;

-- 8.Customers with High Average Spending
SELECT c.name, ROUND(AVG(o.total_amount), 2) AS avg_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.name
HAVING avg_spent > 10000;

-- 9.Top 3 Customers Per Month (Window Function)
SELECT month, name, total_spent
FROM (
    SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS month,
           c.name,
           SUM(o.total_amount) AS total_spent,
           RANK() OVER (PARTITION BY DATE_FORMAT(o.order_date, '%Y-%m')
                        ORDER BY SUM(o.total_amount) DESC) AS rnk
    FROM Orders o
    JOIN Customers c ON o.customer_id = c.customer_id
    GROUP BY month, c.name
) ranked
WHERE rnk <= 3;

-- 10.Running Total of Monthly Sales
SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS month,
       SUM(o.total_amount) AS monthly_sales,
       SUM(SUM(o.total_amount)) OVER (ORDER BY DATE_FORMAT(o.order_date, '%Y-%m')) AS running_total
FROM Orders o
GROUP BY month
ORDER BY month;














