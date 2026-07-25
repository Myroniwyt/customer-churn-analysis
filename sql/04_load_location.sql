USE customer_churn_analysis;

INSERT INTO location (
    location_id,
    customer_id,
    customer_count,
    country,
    state,
    city,
    zip_code,
    lat_long,
    latitude,
    longitude
)
SELECT
    location_id,
    customer_id,
    customer_count,
    country,
    state,
    city,
    CAST(zip_code AS CHAR(10)),
    lat_long,
    latitude,
    longitude
FROM location_staging;
