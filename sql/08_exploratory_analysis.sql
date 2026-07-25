USE customer_churn_analysis;
SELECT
    COUNT(*) AS total_customers,
    SUM(churn_value) AS churned_customers,
    COUNT(*) - SUM(churn_value) AS not_churned_customers,
    ROUND(
        SUM(churn_value) * 100.0 / COUNT(*),
        2
    ) AS churn_rate_pct
FROM status;

-- Insight: 1,869 of 7,043 customers churned, producing an overall churn rate of 26.54%.

SELECT
    customer_status,
    COUNT(*) AS customer_count
FROM status
GROUP BY customer_status
ORDER BY customer_count DESC;

-- Insight: Most customers stayed (4,720), but churned customers (1,869)
-- exceeded newly joined customers (454) by 1,415 in this dataset snapshot.

-- Churn rate by contract type

SELECT
    sv.contract,
    COUNT(*) AS total_customers,
    SUM(st.churn_value) AS churned_customers,
    ROUND(
        SUM(st.churn_value) * 100.0 / COUNT(*),
        2
    ) AS churn_rate_pct
FROM services AS sv
INNER JOIN status AS st
    ON sv.customer_id = st.customer_id
GROUP BY sv.contract
ORDER BY churn_rate_pct DESC;
-- Insight: Month-to-month customers had the highest churn rate at 45.84%,
-- compared with 10.71% for one-year and 2.55% for two-year contracts.
-- Month-to-month customers accounted for 88.55% of all churned customers.

 -- Churn rate by tenure group

SELECT
    CASE
        WHEN sv.tenure_in_months <= 6 THEN '0-6 months'
        WHEN sv.tenure_in_months <= 12 THEN '7-12 months'
        WHEN sv.tenure_in_months <= 24 THEN '13-24 months'
        WHEN sv.tenure_in_months <= 48 THEN '25-48 months'
        ELSE '49+ months'
    END AS tenure_group,
    COUNT(*) AS total_customers,
    SUM(st.churn_value) AS churned_customers,
    ROUND(
        SUM(st.churn_value) * 100.0 / COUNT(*),
        2
    ) AS churn_rate_pct
FROM services AS sv
INNER JOIN status AS st
    ON sv.customer_id = st.customer_id
GROUP BY tenure_group
ORDER BY MIN(sv.tenure_in_months);

SELECT DISTINCT internet_type
FROM services;

SELECT
    internet_type,
    COUNT(*) AS total_customers
FROM services
GROUP BY internet_type
ORDER BY total_customers DESC;

SELECT
    sv.internet_type,
    COUNT(*) AS total_customers,
    SUM(st.churn_value) AS churned_customers,
    ROUND(
        SUM(st.churn_value) * 100.0 / COUNT(*),
        2
    ) AS churn_rate_pct
FROM services AS sv
INNER JOIN status AS st
    ON sv.customer_id = st.customer_id
GROUP BY sv.internet_type
ORDER BY churn_rate_pct DESC;

-- Insight: Fiber Optic customers had the highest churn rate at 40.72%.
-- They represented about 43% of customers but 66% of all churned customers.
-- This is an association and does not prove Fiber Optic directly caused churn.

SELECT
    MIN(monthly_charge) AS lowest_monthly_charge,
    ROUND(AVG(monthly_charge), 2) AS average_monthly_charge,
    MAX(monthly_charge) AS highest_monthly_charge
FROM services;

SELECT
    st.churn_label,
    COUNT(*) AS total_customers,
    ROUND(AVG(sv.monthly_charge), 2) AS average_monthly_charge
FROM services AS sv
INNER JOIN status AS st
    ON sv.customer_id = st.customer_id
GROUP BY st.churn_label;

-- Insight: Churned customers paid an average monthly charge of 74.44,
-- compared with 61.27 for non-churned customers, a difference of 13.17.
-- Higher monthly charges were associated with churn.

SELECT
    churn_category,
    churn_reason
FROM status
WHERE churn_value = 1
LIMIT 10;

SELECT
    churn_category,
    COUNT(*) AS churned_customers
FROM status
WHERE churn_value = 1
GROUP BY churn_category
ORDER BY churned_customers DESC;

SELECT
    churn_reason,
    COUNT(*) AS churned_customers
FROM status
WHERE churn_value = 1
GROUP BY churn_reason
ORDER BY churned_customers DESC
LIMIT 10;

-- Insight: Competitor-related reasons accounted for 841 customers, or 45%
-- of all churn. Better devices and better competitor offers were the two
-- leading specific reasons, accounting for 624 churned customers.

DESCRIBE demographics;
SELECT
    senior_citizen,
    COUNT(*) AS total_customers
FROM demographics
GROUP BY senior_citizen;

SELECT
    d.senior_citizen,
    COUNT(*) AS total_customers,
    SUM(st.churn_value) AS churned_customers,
    ROUND(
        SUM(st.churn_value) * 100.0 / COUNT(*),
        2
    ) AS churn_rate_pct
FROM demographics AS d
INNER JOIN status AS st
    ON d.customer_id = st.customer_id
GROUP BY d.senior_citizen
ORDER BY churn_rate_pct DESC;

-- Insight: Senior citizens had a churn rate of 41.68%, compared with
-- 23.61% for non-senior customers, a difference of 18.07 percentage points.

SELECT
    sv.payment_method,
    COUNT(*) AS total_customers,
    SUM(st.churn_value) AS churned_customers,
    ROUND(
        SUM(st.churn_value) * 100.0 / COUNT(*),
        2
    ) AS churn_rate_pct
FROM services AS sv
INNER JOIN status AS st
    ON sv.customer_id = st.customer_id
GROUP BY sv.payment_method
ORDER BY churn_rate_pct DESC;

-- Insight: Mailed Check had the highest churn rate at 36.88%, while
-- Bank Withdrawal produced the largest churn volume with 1,329 customers.
-- Credit Card customers had the lowest churn rate at 14.48%.

SELECT
    sv.contract,
    sv.internet_type,
    COUNT(*) AS total_customers,
    SUM(st.churn_value) AS churned_customers,
    ROUND(
        SUM(st.churn_value) * 100.0 / COUNT(*),
        2
    ) AS churn_rate_pct
FROM services AS sv
INNER JOIN status AS st
    ON sv.customer_id = st.customer_id
GROUP BY
    sv.contract,
    sv.internet_type
ORDER BY churn_rate_pct DESC;

-- Insight: Month-to-Month Fiber Optic customers had the highest churn
-- rate at 58.82%. Although they represented 26.72% of all customers,
-- they accounted for 59.23% of all churned customers.

SELECT
    l.city,
    COUNT(*) AS total_customers,
    SUM(st.churn_value) AS churned_customers,
    ROUND(
        SUM(st.churn_value) * 100.0 / COUNT(*),
        2
    ) AS churn_rate_pct
FROM location AS l
INNER JOIN status AS st
    ON l.customer_id = st.customer_id
GROUP BY l.city
HAVING COUNT(*) >= 50
ORDER BY churn_rate_pct DESC
LIMIT 10;
