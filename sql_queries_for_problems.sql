CREATE DATABASE heart_disease;
USE heart_disease;
-- List of Problems

-- 1.Problem: How many patients are available in the hospital dataset?
SELECT COUNT(*) AS total_patients
FROM heart_disease_risk;

-- 2.Problem: How many patients have been diagnosed with heart disease?
SELECT COUNT(*) AS heart_disease_patients
FROM heart_disease_risk
WHERE has_heart_disease = 1;

-- 3.Problem: What percentage of the total patients are diagnosed with heart disease?
SELECT
ROUND(SUM(has_heart_disease)*100.0/COUNT(*),2) AS disease_percentage
FROM heart_disease_risk;

-- 4.Problem: What is the distribution of patients based on gender?
SELECT
sex,
COUNT(*) AS total_patients
FROM heart_disease_risk
GROUP BY sex;


-- 5.Problem: Which age group has the highest number of heart disease cases?
SELECT
CASE
    WHEN age < 30 THEN 'Below 30'
    WHEN age BETWEEN 30 AND 45 THEN '30-45'
    WHEN age BETWEEN 46 AND 60 THEN '46-60'
    ELSE 'Above 60'
END AS age_group,
COUNT(*) AS heart_disease_cases
FROM heart_disease_risk
WHERE has_heart_disease = 1
GROUP BY age_group
ORDER BY heart_disease_cases DESC;

-- 6.Problem: Does smoking status influence the occurrence of heart disease?
SELECT
smoker_status,
COUNT(*) AS patients,
SUM(has_heart_disease) AS heart_disease_cases
FROM heart_disease_risk
GROUP BY smoker_status;

-- 7.Problem: Which Body Mass Index (BMI) category has the highest prevalence of heart disease?
SELECT
CASE
    WHEN bmi < 18.5 THEN 'Underweight'
    WHEN bmi < 25 THEN 'Normal'
    WHEN bmi < 30 THEN 'Overweight'
    ELSE 'Obese'
END AS bmi_category,
COUNT(*) AS patients,
SUM(has_heart_disease) AS heart_disease_cases
FROM heart_disease_risk
GROUP BY bmi_category;

-- 8.Problem: What is the average cholesterol level among patients with and without heart disease?
SELECT
has_heart_disease,
ROUND(AVG(cholesterol_total),2) AS avg_cholesterol
FROM heart_disease_risk
GROUP BY has_heart_disease;

-- 9.Problem: How does stress level differ between patients with heart disease and those without?
SELECT 
    has_heart_disease, ROUND(AVG(stress_score), 2) AS avg_stress
FROM
    heart_disease_risk
GROUP BY has_heart_disease;

-- 10.Problem: Which patients exhibit multiple risk factors such as obesity, high cholesterol, smoking, and high stress?
SELECT
patient_id,
age,
bmi,
cholesterol_total,
stress_score,
smoker_status
FROM heart_disease_risk
WHERE bmi > 30
  AND cholesterol_total > 240
  AND stress_score >= 7
  AND smoker_status = 'Current';


-- 11.Problem: How does weekly physical exercise vary between patients with and without heart disease?
SELECT
has_heart_disease,
ROUND(AVG(exercise_minutes_per_week),2) AS avg_exercise_minutes
FROM heart_disease_risk
GROUP BY has_heart_disease;

-- 12.Problem: What is the relationship between daily walking activity (daily steps) and heart disease?
SELECT
has_heart_disease,
ROUND(AVG(daily_steps),2) AS avg_daily_steps
FROM heart_disease_risk
GROUP BY has_heart_disease;

-- 13.Problem: Which age group has the highest average cholesterol level?
SELECT
CASE
    WHEN age < 30 THEN 'Below 30'
    WHEN age BETWEEN 30 AND 45 THEN '30-45'
    WHEN age BETWEEN 46 AND 60 THEN '46-60'
    ELSE 'Above 60'
END AS age_group,
ROUND(AVG(cholesterol_total),2) AS avg_cholesterol
FROM heart_disease_risk
GROUP BY age_group;

-- 14.Problem: Which combinations of lifestyle factors (smoking and alcohol consumption) are most common among patients diagnosed with heart disease?
SELECT
smoker_status,
family_history,
COUNT(*) AS patient_count
FROM heart_disease_risk
WHERE has_heart_disease=1
GROUP BY smoker_status,family_history
ORDER BY patient_count DESC;
-- 15.Problem: Who are the top 10 patients with the highest cardiovascular risk based on BMI and cholesterol levels?
SELECT
patient_id,
age,
bmi,
cholesterol_total
FROM heart_disease_risk
ORDER BY bmi DESC, cholesterol_total DESC
LIMIT 10;