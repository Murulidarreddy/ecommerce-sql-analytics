-- Customers
INSERT INTO Customers (name, email, phone, address) VALUES
('Rahul Sharma', 'rahul@example.com', '9876543210', 'Delhi, India'),
('Ananya Gupta', 'ananya@example.com', '9876501234', 'Mumbai, India'),
('Rohit Kumar', 'rohit@example.com', '9876598765', 'Bangalore, India');

-- Products
INSERT INTO Products (product_name, category, price, stock_quantity) VALUES
('Laptop', 'Electronics', 55000.00, 50),
('Smartphone', 'Electronics', 25000.00, 100),
('Headphones', 'Accessories', 2000.00, 200),
('Shoes', 'Fashion', 3500.00, 150);

-- Orders
INSERT INTO Orders (customer_id, order_date, total_amount) VALUES
(1, '2025-08-01', 57500.00),
(2, '2025-08-05', 25000.00),
(3, '2025-08-10', 5500.00);

-- Order Items
INSERT INTO Order_Items (order_id, product_id, quantity, item_price) VALUES
(1, 1, 1, 55000.00),
(1, 3, 1, 2500.00),
(2, 2, 1, 25000.00),
(3, 4, 1, 3500.00),
(3, 3, 1, 2000.00);

-- Payments
INSERT INTO Payments (order_id, payment_date, payment_method, payment_status) VALUES
(1, '2025-08-01', 'UPI', 'Completed'),
(2, '2025-08-05', 'Card', 'Completed'),
(3, '2025-08-10', 'COD', 'Pending');

-- Shipping
INSERT INTO Shipping (order_id, shipping_address, shipping_date, delivery_status) VALUES
(1, 'Delhi, India', '2025-08-03', 'Delivered'),
(2, 'Mumbai, India', '2025-08-08', 'Shipped'),
(3, 'Bangalore, India', '2025-08-12', 'Processing');
