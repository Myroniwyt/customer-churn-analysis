USE customer_churn_analysis;

SELECT COUNT(*) AS current_rows
FROM population;

INSERT INTO population (
    population_id,
    zip_code,
    population
)
SELECT
    population_id,
    CAST(zip_code AS CHAR(10)),
    CAST(REPLACE(population, ',', '') AS UNSIGNED)
FROM population_staging;