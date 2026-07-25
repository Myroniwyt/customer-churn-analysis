USE customer_churn_analysis;

SELECT COUNT(*) AS current_rows
FROM status;

INSERT INTO status (
    status_id,
    customer_id,
    customer_count,
    quarter,
    satisfaction_score,
    customer_status,
    churn_label,
    churn_value,
    churn_score,
    cltv,
    churn_category,
    churn_reason
)
SELECT
    status_id,
    customer_id,
    CAST(customer_count AS UNSIGNED),
    quarter,
    CAST(satisfaction_score AS UNSIGNED),
    customer_status,
    churn_label,
    CAST(churn_value AS UNSIGNED),
    CAST(churn_score AS UNSIGNED),
    CAST(cltv AS UNSIGNED),
    NULLIF(TRIM(churn_category), ''),
    NULLIF(TRIM(churn_reason), '')
FROM status_staging;
