-- Project: Restaurant Delivery Performance Analysis
-- Objective: Categorize delivery speeds and identify customer/restaurant trends.

-- 1. Categorizing Delivery Speed
-- This query segments deliveries into 'Fast', 'Normal', or 'Slow' based on time.
SELECT 
    delivery_id, 
    delivery_time,
    CASE 
        WHEN delivery_time < 30 THEN 'Fast'
        WHEN delivery_time BETWEEN 30 AND 60 THEN 'Normal'
        ELSE 'Slow'
    END AS delivery_type
FROM deliveries
ORDER BY delivery_time ASC;

-- 2. Identifying High-Performing Restaurants
-- Uses a subquery to find restaurants that have never had a 'Slow' delivery.
SELECT restaurant_name 
FROM restaurants
WHERE restaurant_id NOT IN (
    SELECT restaurant_id 
    FROM deliveries 
    WHERE delivery_time > 60
);

-- 3. Top Spending Customers (Using CTE)
-- Identifies customers whose total spend is above the average.
WITH CustomerSpend AS (
    SELECT customer_id, SUM(order_amount) as total_spent
    FROM orders
    GROUP BY customer_id
)
SELECT customer_id, total_spent
FROM CustomerSpend
WHERE total_spent > (SELECT AVG(total_spent) FROM CustomerSpend);

-- 4. Restaurant Performance Ranking (Using Window Functions)
-- Ranks restaurants within their category based on average delivery time.
-- This helps identify top-performing vendors for potential promotional partnerships.
SELECT 
    r.restaurant_name,
    r.category,
    ROUND(AVG(d.delivery_time), 2) AS avg_speed,
    RANK() OVER (PARTITION BY r.category ORDER BY AVG(d.delivery_time) ASC) AS category_rank
FROM restaurants r
JOIN deliveries d ON r.restaurant_id = d.restaurant_id
GROUP BY r.restaurant_name, r.category;

-- 5. Peak Hour Performance Analysis
-- Identifies time blocks where delivery delays are most frequent.
-- This data is essential for optimizing driver dispatch and managing customer expectations.
SELECT 
    EXTRACT(HOUR FROM order_time) AS hour_of_day,
    COUNT(order_id) AS total_orders,
    ROUND(AVG(delivery_time), 2) AS avg_delivery_time,
    MAX(delivery_time) AS slowest_delivery
FROM deliveries d
JOIN orders o ON d.order_id = o.order_id
GROUP BY hour_of_day
ORDER BY avg_delivery_time DESC;
