CREATE DATABASE product;
USE product;
CREATE TABLE Products (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    productCode VARCHAR(20),
    productName VARCHAR(100),
    productPrice DECIMAL(15,2),
    productAmount INT,
    productDescription VARCHAR(255),
    productStatus VARCHAR(20)
);
INSERT INTO Products
(productCode, productName, productPrice, productAmount, productDescription, productStatus)
VALUES
('SP001', 'Laptop Dell Inspiron', 15000000, 10, 'Laptop Dell dành cho sinh viên', 'Active'),
('SP002', 'Laptop Asus Vivobook', 18000000, 8, 'Laptop Asus văn phòng', 'Active'),
('SP003', 'Laptop Acer Nitro', 25000000, 5, 'Laptop gaming Acer', 'Active'),
('SP004', 'Chuột Logitech G102', 500000, 30, 'Chuột gaming Logitech', 'Active'),
('SP005', 'Bàn phím cơ AKKO', 1500000, 15, 'Bàn phím cơ AKKO', 'Active'),
('SP006', 'Tai nghe Sony', 1200000, 20, 'Tai nghe Sony Bluetooth', 'Active'),
('SP007', 'Màn hình Samsung 24 inch', 3500000, 12, 'Màn hình Samsung Full HD', 'Active'),
('SP008', 'Ổ cứng SSD Samsung 1TB', 2200000, 18, 'SSD Samsung 1TB', 'Active'),
('SP009', 'RAM Kingston 16GB', 1300000, 25, 'RAM DDR4 16GB', 'Inactive'),
('SP010', 'Webcam Logitech C920', 1800000, 7, 'Webcam Full HD', 'Active');
EXPLAIN
SELECT *
FROM Products
WHERE productCode = 'SP005';
CREATE UNIQUE INDEX idx_productCode
ON Products(productCode);
EXPLAIN
SELECT *
FROM Products
WHERE productCode = 'SP005';
CREATE INDEX idx_productName_price
ON Products(productName, productPrice);
EXPLAIN
SELECT *
FROM Products
WHERE productName = 'Laptop Acer Nitro'
AND productPrice = 25000000;
CREATE VIEW product_view AS
SELECT
    productCode,
    productName,
    productPrice,
    productStatus
FROM Products;
CREATE OR REPLACE VIEW product_view AS
SELECT
    productCode,
    productName,
    productPrice,
    productAmount,
    productStatus
FROM Products;
DROP VIEW product_view;
DELIMITER //

CREATE PROCEDURE GetAllProducts()
BEGIN
    SELECT *
    FROM Products;
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE AddProduct(
    IN p_productCode VARCHAR(20),
    IN p_productName VARCHAR(100),
    IN p_productPrice DECIMAL(15,2),
    IN p_productAmount INT,
    IN p_productDescription VARCHAR(255),
    IN p_productStatus VARCHAR(20)
)
BEGIN

    INSERT INTO Products
    (
        productCode,
        productName,
        productPrice,
        productAmount,
        productDescription,
        productStatus
    )
    VALUES
    (
        p_productCode,
        p_productName,
        p_productPrice,
        p_productAmount,
        p_productDescription,
        p_productStatus
    );

END //

DELIMITER ;
CALL AddProduct(
    'SP011',
    'Laptop Lenovo LOQ',
    27000000,
    6,
    'Laptop gaming Lenovo',
    'Active'
);
DELIMITER //

CREATE PROCEDURE UpdateProduct(
    IN p_id INT,
    IN p_productCode VARCHAR(20),
    IN p_productName VARCHAR(100),
    IN p_productPrice DECIMAL(15,2),
    IN p_productAmount INT,
    IN p_productDescription VARCHAR(255),
    IN p_productStatus VARCHAR(20)
)
BEGIN

    UPDATE Products
    SET
        productCode = p_productCode,
        productName = p_productName,
        productPrice = p_productPrice,
        productAmount = p_productAmount,
        productDescription = p_productDescription,
        productStatus = p_productStatus
    WHERE Id = p_id;

END //

DELIMITER ;
CALL UpdateProduct(
    1,
    'SP001',
    'Laptop Dell Inspiron Updated',
    16000000,
    15,
    'Laptop Dell phiên bản mới',
    'Active'
);
DELIMITER //

CREATE PROCEDURE DeleteProduct(
    IN p_id INT
)
BEGIN

    DELETE FROM Products
    WHERE Id = p_id;

END //

DELIMITER ;