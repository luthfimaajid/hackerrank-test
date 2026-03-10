SELECT
    e.employee_id,
    e.full_name,
    CASE 
        WHEN e.performance_score < 50 THEN 'Needs Improvement'
        WHEN e.performance_score < 75 THEN 'Meets Expectations'
        WHEN e.performance_score < 90 THEN 'Exceeds Expectations'
        ELSE 'Outstanding'
    END AS performance_rating
FROM employee e 
