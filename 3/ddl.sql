CREATE TABLE accounts (
    id       SERIAL PRIMARY KEY,
    username VARCHAR(255),
    email    VARCHAR(255)
);

CREATE TABLE tariffs (
    id   SERIAL PRIMARY KEY,
    name VARCHAR(1) CHECK (name IN ('A', 'B', 'C', 'D', 'E')),
    cost DECIMAL(4,3)
);

CREATE TABLE readings (
    account_id INT REFERENCES accounts(id),
    tariff_id  INT REFERENCES tariffs(id),
    amount     SMALLINT
);

INSERT INTO accounts (username, email) VALUES
('john_doe', 'john@example.com'),
('jane_smith', 'jane@example.com'),
('bob_johnson', 'bob@example.com'),
('alice_williams', 'alice@example.com'),
('charlie_brown', 'charlie@example.com');

INSERT INTO tariffs (name, cost) VALUES
('A', 1.500),
('B', 2.250),
('C', 3.100),
('D', 4.750),
('E', 5.999);

INSERT INTO readings (account_id, tariff_id, amount) VALUES
(1, 1, 100),
(1, 2, 150),
(1, 3, 200),
(1, 4, 175),
(1, 5, 220),
(2, 1, 300),
(2, 2, 250),
(2, 3, 180),
(2, 4, 310),
(2, 5, 290),
(3, 1, 400),
(3, 2, 320),
(3, 3, 270),
(3, 4, 350),
(3, 5, 410),
(4, 1, 190),
(4, 2, 230),
(4, 3, 160),
(4, 4, 280),
(4, 5, 340),
(5, 1, 450),
(5, 2, 380),
(5, 3, 310),
(5, 4, 420),
(5, 5, 390),
(1, 1, 120),
(1, 3, 210),
(2, 2, 270),
(3, 4, 330),
(4, 5, 360),
(5, 1, 480),
(1, 2, 140),
(2, 4, 295),
(3, 1, 415),
(4, 3, 175),
(5, 5, 405),
(1, 5, 235),
(2, 3, 195),
(3, 2, 340),
(4, 4, 265),
(5, 2, 370),
(1, 4, 185),
(2, 5, 315),
(3, 3, 285),
(4, 1, 200),
(5, 3, 325),
(1, 3, 165),
(2, 1, 320),
(3, 5, 395),
(4, 2, 245);