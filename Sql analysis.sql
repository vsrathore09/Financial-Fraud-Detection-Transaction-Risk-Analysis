create database fraud_project;
use fraud_project;
select * from fraud_transactions;

-- Calculate the overall fraud percentage
SELECT
COUNT(*) AS total_transactions,
SUM(is_fraud) AS total_fraud_cases,
ROUND(SUM(is_fraud) * 100.0 / COUNT(*),2) AS fraud_percentage
FROM fraud_transactions;

-- Identify transaction types with the highest fraud rate.
SELECT transaction_type,
COUNT(*) AS total_transactions,
SUM(is_fraud) AS fraud_cases,
ROUND(SUM(is_fraud)*100.0/COUNT(*),2) AS fraud_rate
FROM fraud_transactions
GROUP BY transaction_type
ORDER BY fraud_rate DESC;

-- Identify cities with elevated fraud activity.
SELECT city,
COUNT(*) AS total_transactions,
SUM(is_fraud) AS fraud_cases,
ROUND(SUM(is_fraud)*100.0/COUNT(*),2) AS fraud_rate
FROM fraud_transactions
GROUP BY city
ORDER BY fraud_rate DESC;

-- Analyze fraud occurrence by transaction hour.
SELECT
transaction_hour,
COUNT(*) AS total_transactions,
SUM(is_fraud) AS fraud_cases
FROM fraud_transactions
GROUP BY transaction_hour
ORDER BY fraud_cases DESC;

-- Identify customers involved in repeated fraudulent transactions.
SELECT customer_id,
COUNT(*) AS fraud_transactions,
ROUND(SUM(amount),2) AS total_fraud_amount
FROM fraud_transactions
WHERE is_fraud = 1
GROUP BY customer_id
ORDER BY fraud_transactions DESC
LIMIT 10;

-- Compare fraud rates between domestic and international transactions.
SELECT is_international,
COUNT(*) AS total_transactions,
SUM(is_fraud) AS fraud_cases,
ROUND(SUM(is_fraud)*100.0/COUNT(*),2) AS fraud_rate
FROM fraud_transactions
GROUP BY is_international;

-- Identify payment methods most vulnerable to fraud.
SELECT payment_method,
COUNT(*) AS total_transactions,
SUM(is_fraud) AS fraud_cases,
ROUND(SUM(is_fraud)*100.0/COUNT(*),2) AS fraud_rate
FROM fraud_transactions
GROUP BY payment_method
ORDER BY fraud_rate DESC;