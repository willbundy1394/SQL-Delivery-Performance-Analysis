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
```
### Advanced Analytics Logic
* **Window Functions:** Used `RANK() OVER` to benchmark restaurant performance within specific categories, allowing for fair "apples-to-apples" comparisons.
* **Time-Series Analysis:** Leveraged `EXTRACT(HOUR)` to identify peak-hour bottlenecks and delivery latency trends.
* **Data Integrity:** Implemented multi-table `JOIN` logic to sync order timestamps with delivery completion data for accurate KPI tracking.
### Business Insights
* **Operational Efficiency:** Identified specific "Peak Hours" where delivery times increase by X%, suggesting a need for increased driver staffing during those windows.
* **Vendor Management:** The Ranking Analysis highlights underperforming restaurants that consistently fall below their category average, providing data for partner coaching.
