-- JOIN Challenges

-- Add entity descriptions: Return each application with: application_id, entity_type, entity_description, Use the applications table and the entity_types table.

SELECT a.application_id, a.entity_type, e.entity_description FROM onboarding-practice-sql-python.onboarding.applications AS a JOIN onboarding-practice-sql-python.onboarding.entity_types AS e ON a.entity_type = e.entity_type; 

-- For applications that have any fraud review (not “not_reviewed”), return: application_id, fraud_flag_type, risk_severity. Join applications with fraud_flags.

SELECT a.application_id, a.fraud_flag_type, f.risk_severity FROM onboarding-practice-sql-python.onboarding.applications AS a JOIN onboarding-practice-sql-python.onboarding.fraud_flags as f ON a.fraud_flag_type = f.fraud_flag_type WHERE a.fraud_status != 'not_reviewed';

-- Using applications + fraud_flags, return one row per risk_severity showing: risk_severity, number of applications in that severity, Include only applications that have a fraud review.

SELECT COUNT(a.application_id) AS application_count, f.risk_severity FROM onboarding-practice-sql-python.onboarding.applications AS a JOIN onboarding-practice-sql-python.onboarding.fraud_flags as f ON a.fraud_flag_type = f.fraud_flag_type WHERE a.fraud_status != 'not_reviewed 'GROUP BY f.risk_severity;

-- Using applications + decision_categories, return for declined applications: decision_category, number of declined applications in that category. One row per decision_category.

SELECT COUNT(a.application_id) AS application_count, d.decision_category FROM onboarding-practice-sql-python.onboarding.applications AS a JOIN onboarding-practice-sql-python.onboarding.decision_categories AS d ON a.decline_reason = d.decline_reason WHERE a.final_decision = 'declined' GROUP BY d.decision_category;

-- Build a query that returns a risk overview per declined application, including: application_id, entity_type, entity_description, fraud_flag_type, risk_severity, decline_reason,  decision_category. Use whatever JOINs you need across the four tables.

SELECT a.application_id, a.entity_type, e.entity_description, a.fraud_flag_type, f.risk_severity, a.decline_reason,  d.decision_category FROM onboarding-practice-sql-python.onboarding.applications AS a JOIN onboarding-practice-sql-python.onboarding.entity_types AS e ON a.entity_type = e.entity_type JOIN onboarding-practice-sql-python.onboarding.fraud_flags as f ON a.fraud_flag_type = f.fraud_flag_type JOIN onboarding-practice-sql-python.onboarding.decision_categories AS d ON a.decline_reason = d.decline_reason WHERE a.final_decision = 'declined';

