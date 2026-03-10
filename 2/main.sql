SELECT
    CONCAT(e.full_name, ' (', e.employee_id, ') has a performance rating of: ',
    CASE 
        WHEN e.performance_score < 50 THEN 'Needs Improvement'
        WHEN e.performance_score < 75 THEN 'Meets Expectations'
        WHEN e.performance_score < 90 THEN 'Exceeds Expectations'
        ELSE 'Outstanding'
    END)
FROM employee e
ORDER BY e.employee_id ASC; 