SELECT
    c.iban,
    b.amount,
    COUNT(t.id) AS transaction_count
FROM customers c
INNER JOIN balances b
    ON b.customer_id = c.id
LEFT JOIN transactions t
    ON t.customer_id = c.id
WHERE b.amount < 0
GROUP BY c.iban, b.amount
ORDER BY b.amount ASC;
