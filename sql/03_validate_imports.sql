USE customer_churn_analysis;

SELECT COUNT(*) AS total_customers
FROM demographics;

SELECT *
FROM demographics
LIMIT 10;

SELECT COUNT(*) AS total_locations
FROM location;

SELECT *
FROM location
LIMIT 10;

SELECT COUNT(*) AS customers_without_demographics
FROM location AS l
LEFT JOIN demographics AS d
    ON l.customer_id = d.customer_id
WHERE d.customer_id IS NULL;

SELECT COUNT(*) AS total_population_rows
FROM population;

SELECT *
FROM population
LIMIT 10;

SELECT COUNT(*) AS locations_without_population
FROM location AS l
LEFT JOIN population AS p
    ON l.zip_code = p.zip_code
WHERE p.zip_code IS NULL;

SELECT COUNT(*) AS total_service_rows
FROM services;

SELECT *
FROM services
LIMIT 10;

SELECT COUNT(*) AS customers_without_services
FROM demographics AS d
LEFT JOIN services AS s
    ON d.customer_id = s.customer_id
WHERE s.customer_id IS NULL;

SELECT COUNT(*) AS revenue_mismatches
FROM services
WHERE ABS(
    total_revenue -
    (
        total_charges
        + total_extra_data_charges
        + total_long_distance_charges
        - total_refunds
    )
) > 0.01;

SELECT COUNT(*) AS total_status_rows
FROM status;

SELECT *
FROM status
LIMIT 10;

SELECT COUNT(*) AS customers_without_status
FROM demographics AS d
LEFT JOIN status AS s
    ON d.customer_id = s.customer_id
WHERE s.customer_id IS NULL;

SELECT COUNT(*) AS inconsistent_churn_flags
FROM status
WHERE
    (churn_label = 'Yes' AND churn_value <> 1)
    OR
    (churn_label = 'No' AND churn_value <> 0);

SELECT COUNT(*) AS churned_without_reason
FROM status
WHERE churn_value = 1
    AND (
        churn_reason IS NULL
        OR TRIM(churn_reason) = ''
    );
    
SELECT 'demographics' AS table_name, COUNT(*) AS row_count
FROM demographics

UNION ALL

SELECT 'location', COUNT(*)
FROM location

UNION ALL

SELECT 'population', COUNT(*)
FROM population

UNION ALL

SELECT 'services', COUNT(*)
FROM services

UNION ALL

SELECT 'status', COUNT(*)
FROM status;

SELECT COUNT(*) AS fully_joined_customer_rows
FROM demographics AS d
INNER JOIN location AS l
    ON d.customer_id = l.customer_id
INNER JOIN services AS sv
    ON d.customer_id = sv.customer_id
INNER JOIN status AS st
    ON d.customer_id = st.customer_id
INNER JOIN population AS p
    ON l.zip_code = p.zip_code;
