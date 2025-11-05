-- DATABASE CREATION
DROP DATABASE IF EXISTS car_management;
CREATE DATABASE car_management;
USE car_management;

-- TABLE CREATION (DDL)
-- CAR TABLE
CREATE TABLE Car (
    car_id INT AUTO_INCREMENT PRIMARY KEY,
    make VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    year YEAR NOT NULL,
    daily_rate DECIMAL(10,2) NOT NULL,
    status ENUM('available', 'rented', 'maintenance') DEFAULT 'available'
);

-- CUSTOMER TABLE
CREATE TABLE Customer (
    cust_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    address VARCHAR(255)
);

-- BOOKING TABLE
CREATE TABLE Booking (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    cust_id INT NOT NULL,
    car_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (cust_id) REFERENCES Customer(cust_id) ON DELETE CASCADE,
    FOREIGN KEY (car_id) REFERENCES Car(car_id) ON DELETE CASCADE
);

-- MAINTENANCE TABLE
CREATE TABLE Maintenance (
    maintenance_id INT AUTO_INCREMENT PRIMARY KEY,
    car_id INT NOT NULL,
    service_date DATE NOT NULL,
    details VARCHAR(255),
    cost DECIMAL(10,2),
    FOREIGN KEY (car_id) REFERENCES Car(car_id) ON DELETE CASCADE
);

-- SAMPLE DATA (DML)
-- Cars
INSERT INTO Car (make, model, year, daily_rate, status) VALUES
('Toyota', 'Corolla', 2020, 1500.00, 'available'),
('Honda', 'Civic', 2021, 1800.00, 'available'),
('Ford', 'EcoSport', 2019, 1300.00, 'maintenance');

-- Customers
INSERT INTO Customer (name, email, phone, address) VALUES
('Rahul Sharma', 'rahul@example.com', '9876543210', 'Pune, India'),
('Sneha Patil', 'sneha@example.com', '9898989898', 'Mumbai, India');

-- Bookings
INSERT INTO Booking (cust_id, car_id, start_date, end_date, total_price) VALUES
(1, 1, '2025-10-01', '2025-10-05', 7500.00),
(2, 2, '2025-10-10', '2025-10-13', 5400.00);

-- Maintenance
INSERT INTO Maintenance (car_id, service_date, details, cost) VALUES
(3, '2025-09-20', 'Oil change and brake check', 2000.00);

-- IMPORTANT SQL QUERIES (SELECT / UPDATE / DELETE)
-- List all available cars
SELECT * FROM Car WHERE status = 'available';

-- Update car status after maintenance complete
UPDATE Car SET status = 'available' WHERE car_id = 3;

-- Delete a customer (cascade deletes their bookings)
DELETE FROM Customer WHERE cust_id = 2;

-- JOINS & SUBQUERIES
-- Booking details with join
SELECT b.booking_id, c.name AS customer_name, car.make, car.model, b.total_price
FROM Booking b
JOIN Customer c ON b.cust_id = c.cust_id
JOIN Car car ON b.car_id = car.car_id;

-- Cars that have never been booked
SELECT * FROM Car
WHERE car_id NOT IN (SELECT car_id FROM Booking);

-- Total earnings per car
SELECT car_id, SUM(total_price) AS total_earnings
FROM Booking
GROUP BY car_id;

-- PL/SQL BLOCK (With Exception Handling)
DELIMITER //
BEGIN
    DECLARE v_total DECIMAL(10,2) DEFAULT 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error occurred while calculating total revenue' AS Message;
    END;

    SELECT SUM(total_price) INTO v_total FROM Booking;
    IF v_total IS NULL THEN
        SET v_total = 0;
    END IF;

    SELECT CONCAT('Total booking revenue: ₹', v_total) AS Result;
END;
//
DELIMITER ;

-- STORED PROCEDURE
DELIMITER //
CREATE PROCEDURE GetCustomerTotal(IN customerId INT)
BEGIN
    SELECT c.name, SUM(b.total_price) AS TotalSpent
    FROM Booking b
    JOIN Customer c ON b.cust_id = c.cust_id
    WHERE c.cust_id = customerId
    GROUP BY c.name;
END //
DELIMITER ;

-- FUNCTION
DELIMITER //
CREATE FUNCTION BookingDays(start_date DATE, end_date DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN DATEDIFF(end_date, start_date);
END //
DELIMITER ;

-- TRIGGER

DELIMITER //
CREATE TRIGGER after_booking_insert
AFTER INSERT ON Booking
FOR EACH ROW
BEGIN
    UPDATE Car SET status = 'rented' WHERE car_id = NEW.car_id;
END //
DELIMITER ;