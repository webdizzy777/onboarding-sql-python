-- Show the first 10 applications
SELECT application_id, customer_id, entity_type, application_submitted_at FROM `onboarding-practice-sql-python.onboarding.applications` LIMIT 10;

-- Filter for only “sole_prop” applicants
SELECT application_id, entity_type, application_submitted_at FROM  `onboarding-practice-sql-python.onboarding.applications` WHERE entity_type = 'sole_prop';

-- Find all applications submitted in the first week of April
SELECT application_id, application_submitted_at FROM `onboarding-practice-sql-python.onboarding.applications` WHERE application_submitted_at >= '2024-04-01' AND application_submitted_at < '2024-04-08';

-- Show all applications that were declined
SELECT application_id, final_decision, decline_reason, final_decision_at FROM `onboarding-practice-sql-python.onboarding.applications` WHERE final_decision = 'declined';

-- Show fraud-reviewed applications
SELECT application_id, fraud_status, fraud_flag_type, fraud_review_completed_at FROM `onboarding-practice-sql-python.onboarding.applications` WHERE fraud_status IN ('confirmed_fraud', 'cleared_after_review');

-- Return all applications with timestamps in a single specific day.
SELECT application_id, application_submitted_at, final_decision FROM `onboarding-practice-sql-python.onboarding.applications` WHERE application_submitted_at BETWEEN '2024-04-15 00:00:00' AND '2024-04-15 23:59:59';

-- Show all applications where the KYC status is anything other than “cleared.”
SELECT application_id, kyc_status FROM `onboarding-practice-sql-python.onboarding.applications` WHERE kyc_status NOT IN('cleared', 'not_required');

-- Return all applications where the KYB review was completed.
SELECT application_id, kyb_status FROM `onboarding-practice-sql-python.onboarding.applications` WHERE kyb_status = 'cleared' OR kyb_status = 'failed';

-- Show all applications where a fraud flag exists and print only: application_id, fraud_flag_type, fraud_status
SELECT application_id, fraud_flag_type, fraud_status FROM `onboarding-practice-sql-python.onboarding.applications` WHERE fraud_status != 'not_reviewed';

-- Return all applications where the final decision happened more than 24 hours after submission.
SELECT application_id, application_submitted_at, final_decision, final_decision_at, TIMESTAMP_DIFF(final_decision_at, application_submitted_at, HOUR) AS hours_to_process FROM `onboarding-practice-sql-python.onboarding.applications` WHERE TIMESTAMP_DIFF(final_decision_at, application_submitted_at, HOUR) > 24;

-- Write a query that returns the 25 most recently submitted applications, ordered so that the newest application appears first.
SELECT application_id, application_submitted_at FROM `onboarding-practice-sql-python.onboarding.applications` ORDER BY application_submitted_at DESC LIMIT 25;

-- Write a query that returns, for each entity type, the number of applications that ended up in each final decision category.
SELECT entity_type, count(final_decision) AS count_of_decision, final_decision FROM `onboarding-practice-sql-python.onboarding.applications` GROUP BY final_decision, entity_type;

-- Write a query that returns the average number of hours it took to reach a final decision across all applications per decision type.
SELECT final_decision, ROUND(AVG(TIMESTAMP_DIFF(final_decision_at, application_submitted_at, HOUR)), 0) AS avg_hours FROM `onboarding-practice-sql-python.onboarding.applications` GROUP BY final_decision; 

-- Write a query that returns all applications where: KYC did not succeed and the fraud status does not indicate confirmed fraud.
SELECT application_id, kyc_status, fraud_status, final_decision, decline_reason FROM `onboarding-practice-sql-python.onboarding.applications` WHERE kyc_status ='failed' AND fraud_status != 'confirmed_fraud';

-- Write a query that returns applications that went through: some form of KYC review, some form of KYB review, some form of fraud review
SELECT application_id, entity_type, kyc_status, kyb_status, fraud_status FROM `onboarding-practice-sql-python.onboarding.applications` WHERE kyc_status != 'not_required' AND kyb_status NOT IN ('not_applicable', 'not_required') AND fraud_status != 'not_reviewed';
