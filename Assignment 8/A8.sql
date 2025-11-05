create database A8;
-- LIBRARY TRIGGER PROJECT (MySQL Full Script)

-- Step 1: Create main table (Library)
CREATE TABLE Library (
    book_id INT PRIMARY KEY,
    title VARCHAR(50),
    author VARCHAR(50),
    price DECIMAL(10,2)
);

-- Step 2: Create audit table (Library_Audit)
CREATE TABLE Library_Audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    title VARCHAR(50),
    author VARCHAR(50),
    price DECIMAL(10,2),
    action_type VARCHAR(20),
    action_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Step 3: BEFORE UPDATE trigger
DELIMITER //
CREATE TRIGGER before_Library_update
BEFORE UPDATE ON Library
FOR EACH ROW
BEGIN
    INSERT INTO Library_Audit (book_id, title, author, price, action_type)
    VALUES (OLD.book_id, OLD.title, OLD.author, OLD.price, 'UPDATE');
END;
//
DELIMITER ;

-- Step 4: BEFORE DELETE trigger
DELIMITER //
CREATE TRIGGER before_Library_delete
BEFORE DELETE ON Library
FOR EACH ROW
BEGIN
    INSERT INTO Library_Audit (book_id, title, author, price, action_type)
    VALUES (OLD.book_id, OLD.title, OLD.author, OLD.price, 'DELETE');
END;
//
DELIMITER ;

-- Step 5: Insert sample data
INSERT INTO Library (book_id, title, author, price) VALUES
(1, 'DBMS', 'Korth', 600.00),
(2, 'OS', 'Galvin', 700.00),
(3, 'CNS', 'Tanenbaum', 800.00),
(4, 'AI', 'Russell', 900.00);

-- Step 6: Test Update and Delete operations
UPDATE Library SET price = 550.50 WHERE book_id = 1;

DELETE FROM Library WHERE book_id = 2;

-- Step 7: View Results
SELECT * FROM Library;
SELECT * FROM Library_Audit;
