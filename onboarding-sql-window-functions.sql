-- Window Functions

-- 1) Rank fastest decisions:
-- Return application_id, entity_type, hours_to_decision, and rank within each entity_type (fastest = rank 1).
SELECT application_id, entity_type, hours_to_decision, RANK() OVER(PARTITION BY entity_type ORDER BY hours_to_decision ASC) as rank_in_entity FROM (SELECT application_id, entity_type, TIMESTAMP_DIFF(final_decision_at, application_submitted_at, HOUR) as hours_to_decision FROM onboarding-practice-sql-python.onboarding.applications) as t;

-- 2) Latest application per entity type:
-- Return only the most recent application for each entity_type (one row per entity_type).
SELECT application_id, entity_type, application_submitted_at FROM (SELECT application_id, entity_type, application_submitted_at, ROW_NUMBER() OVER(PARTITION BY entity_type ORDER BY application_submitted_at DESC) as latest_application FROM onboarding-practice-sql-python.onboarding.applications) as t WHERE latest_application = 1;

-- 3) Running total of applications by day:
-- Group by submission date (date only), then add a running total of applications over time.
SELECT submission_date, number_of_applications_by_date, sum(number_of_applications_by_date) OVER(ORDER BY submission_date ASC) as running_total_by_date FROM (SELECT DATE(application_submitted_at) as submission_date, COUNT(*) as number_of_applications_by_date FROM onboarding-practice-sql-python.onboarding.applications GROUP BY submission_date);

-- 4) Time-to-decision compared to entity average:
-- For each application, return application_id, entity_type, hours_to_decision, avg_hours_for_entity_type, and difference_from_avg.
SELECT application_id, entity_type, hours_to_decision, avg_hours_for_entity_type, (hours_to_decision - avg_hours_for_entity_type) as difference_from_avg FROM (SELECT application_id, entity_type, hours_to_decision, avg(hours_to_decision) OVER(PARTITION BY entity_type) as avg_hours_for_entity_type FROM (SELECT application_id, entity_type, TIMESTAMP_DIFF(final_decision_at, application_submitted_at, HOUR) as hours_to_decision FROM onboarding-practice-sql-python.onboarding.applications) as t1) as t2;
