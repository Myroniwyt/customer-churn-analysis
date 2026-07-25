USE customer_churn_analysis;

CREATE TABLE demographics (
    customer_id VARCHAR(20) PRIMARY KEY,
    customer_count INT,
    gender VARCHAR(10),
    age INT,
    under_30 VARCHAR(3),
    senior_citizen VARCHAR(3),
    married VARCHAR(3),
    dependents VARCHAR(3),
    number_of_dependents INT
);

DROP TABLE location;

CREATE TABLE location (
    location_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL UNIQUE,
    customer_count INT,
    country VARCHAR(50),
    state VARCHAR(50),
    city VARCHAR(100),
    zip_code VARCHAR(10),
    lat_long VARCHAR(50),
    latitude DECIMAL(10, 6),
    longitude DECIMAL(10, 6)
);

USE customer_churn_analysis;

CREATE TABLE population (
    population_id INT PRIMARY KEY,
    zip_code VARCHAR(10) NOT NULL UNIQUE,
    population INT NOT NULL
);

CREATE TABLE services (
    service_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL UNIQUE,
    customer_count INT,
    quarter VARCHAR(5),
    referred_a_friend VARCHAR(3),
    number_of_referrals INT,
    tenure_in_months INT,
    offer VARCHAR(20),
    phone_service VARCHAR(3),
    avg_monthly_long_distance_charges DECIMAL(10, 2),
    multiple_lines VARCHAR(3),
    internet_service VARCHAR(3),
    internet_type VARCHAR(30),
    avg_monthly_gb_download INT,
    online_security VARCHAR(3),
    online_backup VARCHAR(3),
    device_protection_plan VARCHAR(3),
    premium_tech_support VARCHAR(3),
    streaming_tv VARCHAR(3),
    streaming_movies VARCHAR(3),
    streaming_music VARCHAR(3),
    unlimited_data VARCHAR(3),
    contract VARCHAR(30),
    paperless_billing VARCHAR(3),
    payment_method VARCHAR(30),
    monthly_charge DECIMAL(10, 2),
    total_charges DECIMAL(12, 2),
    total_refunds DECIMAL(12, 2),
    total_extra_data_charges DECIMAL(12, 2),
    total_long_distance_charges DECIMAL(12, 2),
    total_revenue DECIMAL(12, 2)
);

CREATE TABLE status (
    status_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL UNIQUE,
    customer_count INT,
    quarter VARCHAR(5),
    satisfaction_score INT,
    customer_status VARCHAR(20),
    churn_label VARCHAR(3),
    churn_value TINYINT,
    churn_score INT,
    cltv INT,
    churn_category VARCHAR(50),
    churn_reason VARCHAR(255)
);