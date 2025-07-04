
-- Insert sample data into Users table
INSERT INTO Users (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES
('550e8400-e29b-41d4-a716-446655440000', 'John', 'Doe', 'john.doe@example.com', 'hash123', '555-0101', 'host', '2025-06-01 10:00:00'),
('550e8400-e29b-41d4-a716-446655440001', 'Jane', 'Smith', 'jane.smith@example.com', 'hash456', '555-0102', 'guest', '2025-06-01 11:00:00'),
('550e8400-e29b-41d4-a716-446655440002', 'Alice', 'Johnson', 'alice.johnson@example.com', 'hash789', NULL, 'guest', '2025-06-02 09:00:00'),
('550e8400-e29b-41d4-a716-446655440003', 'Bob', 'Williams', 'bob.williams@example.com', 'hash012', '555-0103', 'host', '2025-06-02 10:00:00'),
('550e8400-e29b-41d4-a716-446655440004', 'Emma', 'Brown', 'emma.brown@example.com', 'hash345', '555-0104', 'admin', '2025-06-03 08:00:00');

-- Insert sample data into Property table
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight, created_at, updated_at) VALUES
('a3e2b1c0-7f9d-4b2a-9c1e-8d4f3c2b1a0e', '550e8400-e29b-41d4-a716-446655440000', 'Cozy Beach Cottage', 'A charming cottage by the sea.', 'Miami, FL', 120.00, '2025-06-05 12:00:00', '2025-06-05 12:00:00'),
('a3e2b1c0-7f9d-4b2a-9c1e-8d4f3c2b1a0f', '550e8400-e29b-41d4-a716-446655440000', 'Downtown Loft', 'Modern loft in the city center.', 'New York, NY', 200.00, '2025-06-06 14:00:00', '2025-06-06 14:00:00'),
('a3e2b1c0-7f9d-4b2a-9c1e-8d4f3c2b1a10', '550e8400-e29b-41d4-a716-446655440003', 'Mountain Cabin', 'Rustic cabin with mountain views.', 'Aspen, CO', 150.00, '2025-06-07 10:00:00', '2025-06-07 10:00:00');

-- Insert sample data into Booking table
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, status, created_at) VALUES
('b4e3c2d1-9a0e-4c3b-8d2f-7e604d3c2b1f', 'a3e2b1c0-7f9d-4b2a-9c1e-8d4f3c2b1a0e', '550e8400-e29b-41d4-a716-446655440001', '2025-07-01', '2025-07-05', 'confirmed', '2025-06-10 09:00:00'),
('b4e3c2d1-9a0e-4c3b-8d2f-7e604d3c2b20', 'a3e2b1c0-7f9d-4b2a-9c1e-8d4f3c2b1a0f', '550e8400-e29b-41d4-a716-446655440002', '2025-07-10', '2025-07-12', 'pending', '2025-06-11 11:00:00'),
('b4e3c2d1-9a0e-4c3b-8d2f-7e604d3c2b21', 'a3e2b1c0-7f9d-4b2a-9c1e-8d4f3c2b1a10', '550e8400-e29b-41d4-a716-446655440001', '2025-08-01', '2025-08-03', 'canceled', '2025-06-12 15:00:00');

-- Insert sample data into Payment table
INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method) VALUES
('c5f4d3e2-0b1f-4d4c-9e30-8f705e4d3c2a', 'b4e3c2d1-9a0e-4c3b-8d2f-7e604d3c2b1f', 480.00, '2025-06-10 10:00:00', 'credit_card'),
('c5f4d3e2-0b1f-4d4c-9e30-8f705e4d3c2b', 'b4e3c2d1-9a0e-4c3b-8d2f-7e604d3c2b1f', 50.00, '2025-06-10 10:05:00', 'paypal');

-- Insert sample data into Review table
INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at) VALUES
('d605e4f3-1c2a-4e5d-0f40-90806f5e4d3b', 'a3e2b1c0-7f9d-4b2a-9c1e-8d4f3c2b1a0e', '550e8400-e29b-41d4-a716-446655440001', 4, 'Great stay, very cozy!', '2025-07-06 12:00:00'),
('d605e4f3-1c2a-4e5d-0f40-90806f5e4d3c', 'a3e2b1c0-7f9d-4b2a-9c1e-8d4f3c2b1a0f', '550e8400-e29b-41d4-a716-446655440002', 5, 'Amazing location, highly recommend!', '2025-07-13 14:00:00');

-- Insert sample data into Message table
INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at) VALUES
('e706f504-2d3b-4f6e-1050-0090706f5e4c', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440000', 'Is the cottage available for July?', '2025-06-09 08:00:00'),
('e706f504-2d3b-4f6e-1050-0090706f5e4d', '550e8400-e29b-41d4-a716-446655440000', '550e8400-e29b-41d4-a716-446655440001', 'Yes, it’s available. Please book soon!', '2025-06-09 09:00:00');


