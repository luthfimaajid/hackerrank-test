CREATE TABLE customers (
    id   SMALLINT PRIMARY KEY,
    iban VARCHAR(255),
    name VARCHAR(255)
);

CREATE TABLE balances (
    customer_id SMALLINT REFERENCES customers(id),
    amount      DECIMAL(5,2)
);

CREATE TABLE transactions (
    id                 SERIAL PRIMARY KEY,
    customer_id        SMALLINT REFERENCES customers(id),
    transaction_amount DECIMAL(5,2),
    transaction_date   DATE
);

INSERT INTO customers (id, iban, name) VALUES
(1, 'GB29NWBK60161331926819', 'John Doe'),
(2, 'DE89370400440532013000', 'Jane Smith'),
(3, 'FR7630006000011234567890189', 'Bob Johnson'),
(4, 'ES9121000418450200051332', 'Alice Williams'),
(5, 'IT60X0542811101000000123456', 'Charlie Brown');

INSERT INTO balances (customer_id, amount) VALUES
(1, -150.50),
(2, 200.00),
(3, -75.25),
(4, -320.00),
(5, 50.75);

INSERT INTO transactions (customer_id, transaction_amount, transaction_date) VALUES
(1, -50.00, '2024-01-15'),
(1, -100.50, '2024-02-10'),
(1, 30.00, '2024-03-05'),
(2, 200.00, '2024-01-20'),
(2, -50.00, '2024-02-15'),
(3, -25.00, '2024-01-10'),
(3, -50.25, '2024-02-20'),
(4, -100.00, '2024-01-25'),
(4, -120.00, '2024-02-28'),
(4, -100.00, '2024-03-15'),
(5, 100.00, '2024-01-30'),
(5, -49.25, '2024-02-25');
