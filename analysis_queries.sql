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
