-- =========================================
-- 1. TOTAL REVENUE
-- =========================================
SELECT SUM(payment_value) AS total_revenue
FROM df_Payments;


-- =========================================
-- 2. REVENUE BY PRODUCT CATEGORY
-- =========================================
SELECT 
    p.product_category_name AS category,
    ROUND(SUM(oi.price + oi.shipping_charges), 2) AS total_revenue
FROM df_OrderItems oi
JOIN df_Products p ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_revenue DESC;


-- =========================================
-- 3. TOP 10 BEST-SELLING PRODUCTS
-- =========================================
SELECT 
    oi.product_id,
    COUNT(*) AS total_sales
FROM df_OrderItems oi
GROUP BY oi.product_id
ORDER BY total_sales DESC
LIMIT 10;


-- =========================================
-- 4. REPEAT CUSTOMERS (Retention Analysis)
-- =========================================
SELECT 
    o.customer_id,
    COUNT(o.order_id) AS total_orders
FROM df_Orders o
GROUP BY o.customer_id
HAVING COUNT(o.order_id) > 1
ORDER BY total_orders DESC;


-- =========================================
-- 5. AVERAGE ORDER VALUE (AOV)
-- =========================================
SELECT 
    ROUND(AVG(payment_value), 2) AS avg_order_value
FROM df_Payments;


-- =========================================
-- 6. ORDER STATUS DISTRIBUTION
-- =========================================
SELECT 
    order_status,
    COUNT(*) AS total_orders
FROM df_Orders
GROUP BY order_status
ORDER BY total_orders DESC;


-- =========================================
-- 7. MONTHLY SALES TREND
-- =========================================
SELECT 
    DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS month,
    COUNT(order_id) AS total_orders
FROM df_Orders
GROUP BY month
ORDER BY month;


-- =========================================
-- 8. TOP CITIES BY ORDERS
-- =========================================
SELECT 
    c.customer_city,
    COUNT(o.order_id) AS total_orders
FROM df_Orders o
JOIN df_Customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_city
ORDER BY total_orders DESC
LIMIT 10;


-- =========================================
-- 9. PAYMENT METHOD ANALYSIS
-- =========================================
SELECT 
    payment_type,
    COUNT(*) AS usage_count,
    ROUND(SUM(payment_value), 2) AS total_value
FROM df_Payments
GROUP BY payment_type
ORDER BY total_value DESC;


-- =========================================
-- 10. DELIVERY DELAY ANALYSIS
-- =========================================
SELECT 
    AVG(DATEDIFF(order_delivered_timestamp, order_estimated_delivery_date)) AS avg_delay_days
FROM df_Orders
WHERE order_delivered_timestamp IS NOT NULL;