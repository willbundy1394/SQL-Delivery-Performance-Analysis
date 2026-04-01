# SQL Restaurant Delivery Analytics

## Project Overview
This project demonstrates advanced SQL techniques—including **Subqueries, CTEs, and Case Logic**—to analyze restaurant delivery data. The goal is to provide actionable insights into delivery efficiency and customer spending patterns.

## Key Features
* **Delivery Segmentation:** Created a classification system to monitor logistics performance
* **Efficiency Benchmarking:** Identified top-tier restaurants by filtering out those with delayed delivery histories
* **Customer Analytics:** Leveraged Common Table Expressions (CTEs) to isolate high-value customer segments
## Tools Used
* **Language:** SQL (PostgreSQL/MySQL)
* **Logic:** Window Functions, Subqueries, CTEs, Conditional Logic
## Key Logic Spotlight: Customer Value Segmentation
To identify our most valuable users, I leveraged a **Common Table Expression (CTE)** to aggregate spending before filtering. This approach is more readable and performant than traditional nested subqueries.

```sql
WITH CustomerSpend AS (
    SELECT 
        customer_id, 
        SUM(order_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
)
SELECT * FROM CustomerSpend
WHERE total_spent > 500;
