SELECT
    a.username,
    a.email,
    (
        SELECT t2.name
        FROM readings r2
        JOIN tariffs t2 ON t2.id = r2.tariff_id
        WHERE r2.account_id = a.id
        GROUP BY t2.name
        ORDER BY COUNT(*) DESC
        LIMIT 1
    ) AS most_frequent_tariff,
    SUM(r.amount) AS total_consumption,
    ROUND(SUM(r.amount * t.cost) / COUNT(r.amount), 2) AS average_cost_per_reading
FROM accounts a
LEFT JOIN readings r
    ON r.account_id = a.id
LEFT JOIN tariffs t
    ON t.id = r.tariff_id
GROUP BY a.id
ORDER BY a.username ASC;