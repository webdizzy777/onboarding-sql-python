-- GROUP BY & HAVING

-- Count applications by entity type. Return one row per entity_type with: entity_type, number of applications
SELECT COUNT(application_id) AS total_apps, entity_type FROM onboarding-practice-sql-python.onboarding.applications GROUP BY entity_type;

-- Return one row per final_decision with: final_decision, number_of_applications. (This should show how many got approved vs declined.)
SELECT COUNT(application_id) AS total_apps, final_decision FROM onboarding-practice-sql-python.onboarding.applications GROUP BY final_decision;

-- Fraud flags with confirmed fraud only, Using applications + fraud_flags, return one row per fraud_flag_type with: fraud_flag_type, risk_severity, number_of_confirmed_fraud_applications. Only count rows where fraud_status indicates confirmed fraud.
SELECT COUNT(application_id) AS number_of_confirmed_fraud_applications, f.fraud_flag_type, f.risk_severity FROM onboarding-practice-sql-python.onboarding.fraud_flags AS f JOIN onboarding-practice-sql-python.onboarding.applications AS a ON f.fraud_flag_type = a.fraud_flag_type WHERE a.fraud_status = 'confirmed_fraud' GROUP BY f.fraud_flag_type, f.risk_severity;

-- Busy days in the funnel. Group by the date of application_submitted_at (not full timestamp), and return: submission_date, number_of_applications. Then keep only days where the count is greater than some threshold you choose (e.g., > 10) using HAVING.
SELECT FORMAT_DATE('%m/%d/%Y', application_submitted_at) AS date_submitted, COUNT(application_id) AS total_apps FROM onboarding-practice-sql-python.onboarding.applications GROUP BY date_submitted HAVING total_apps > 10;

-- Slow decisions by entity type. For each entity_type, return: entity_type, average_hours_to_decision. Use TIMESTAMP_DIFF + AVG with GROUP BY. Optionally, use HAVING to show only entity types where avg hours > 24.
SELECT entity_type, ROUND(AVG(TIMESTAMP_DIFF(final_decision_at, application_submitted_at, HOUR)), 0) AS average_hours_to_decision FROM onboarding-practice-sql-python.onboarding.applications GROUP BY entity_type HAVING average_hours_to_decision > 24;
