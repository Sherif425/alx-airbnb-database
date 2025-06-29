To fulfill the task of populating the AirBnB database with sample data, I’ll create SQL `INSERT` statements for the normalized schema (User, Property, Booking, Payment, Review, Message) as defined in the previous DDL response. The sample data will reflect real-world usage, including multiple users (with different roles: guest, host, admin), properties, bookings, payments, reviews, and messages, while respecting all constraints (e.g., foreign keys, unique email, valid ENUM values, rating range). The data will be realistic, with varied names, locations, dates, and relationships to simulate a functional AirBnB system.

The output will be a Markdown file containing the SQL `INSERT` statements, wrapped in an artifact tag, with a brief explanation of the data choices.

```sql

-- Insert sample data into User table
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES
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
('b4e3c2d1-9a0e-4c3b-8d2f-7e6g4d3c2b1f', 'a3e2b1c0-7f9d-4b2a-9c1e-8d4f3c2b1a0e', '550e8400-e29b-41d4-a716-446655440001', '2025-07-01', '2025-07-05', 'confirmed', '2025-06-10 09:00:00'),
('b4e3c2d1-9a0e-4c3b-8d2f-7e6g4d3c2b20', 'a3e2b1c0-7f9d-4b2a-9c1e-8d4f3c2b1a0f', '550e8400-e29b-41d4-a716-446655440002', '2025-07-10', '2025-07-12', 'pending', '2025-06-11 11:00:00'),
('b4e3c2d1-9a0e-4c3b-8d2f-7e6g4d3c2b21', 'a3e2b1c0-7f9d-4b2a-9c1e-8d4f3c2b1a10', '550e8400-e29b-41d4-a716-446655440001', '2025-08-01', '2025-08-03', 'canceled', '2025-06-12 15:00:00');

-- Insert sample data into Payment table
INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method) VALUES
('c5f4d3e2-0b1f-4d4c-9e3g-8f7h5e4d3c2a', 'b4e3c2d1-9a0e-4c3b-8d2f-7e6g4d3c2b1f', 480.00, '2025-06-10 10:00:00', 'credit_card'),
('c5f4d3e2-0b1f-4d4c-9e3g-8f7h5e4d3c2b', 'b4e3c2d1-9a0e-4c3b-8d2f-7e6g4d3c2b1f', 50.00, '2025-06-10 10:05:00', 'paypal');

-- Insert sample data into Review table
INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at) VALUES
('d6g5e4f3-1c2a-4e5d-0f4h-9g8i6f5e4d3b', 'a3e2b1c0-7f9d-4b2a-9c1e-8d4f3c2b1a0e', '550e8400-e29b-41d4-a716-446655440001', 4, 'Great stay, very cozy!', '2025-07-06 12:00:00'),
('d6g5e4f3-1c2a-4e5d-0f4h-9g8i6f5e4d3c', 'a3e2b1c0-7f9d-4b2a-9c1e-8d4f3c2b1a0f', '550e8400-e29b-41d4-a716-446655440002', 5, 'Amazing location, highly recommend!', '2025-07-13 14:00:00');

-- Insert sample data into Message table
INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at) VALUES
('e7h6f5g4-2d3b-4f6e-1g5i-0h9j7g6f5e4c', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440000', 'Is the cottage available for July?', '2025-06-09 08:00:00'),
('e7h6f5g4-2d3b-4f6e-1g5i-0h9j7g6f5e4d', '550e8400-e29b-41d4-a716-446655440000', '550e8400-e29b-41d4-a716-446655440001', 'Yes, it’s available. Please book soon!', '2025-06-09 09:00:00');

```

### Explanation of Sample Data
1. **User Table (5 records)**:
   - Includes two hosts (John Doe, Bob Williams), two guests (Jane Smith, Alice Johnson), and one admin (Emma Brown).
   - Unique `user_id` values (UUIDs) and `email` addresses.
   - `password_hash` is a placeholder (e.g., 'hash123') for brevity.
   - `phone_number` is optional (NULL for Alice).
   - `role` uses valid ENUM values ('guest', 'host', 'admin').
   - `created_at` reflects realistic registration dates in June 2025.

2. **Property Table (3 records)**:
   - Two properties hosted by John Doe (Cozy Beach Cottage, Downtown Loft) and one by Bob Williams (Mountain Cabin).
   - Realistic locations (Miami, New York, Aspen) and `pricepernight` values ($120-$200).
   - `host_id` references valid `user_id` values from the User table.
   - `created_at` and `updated_at` are set to June 2025.

3. **Booking Table (3 records)**:
   - Jane Smith books the Cozy Beach Cottage (confirmed, 4 nights: July 1-5).
   - Alice Johnson books the Downtown Loft (pending, 2 nights: July 10-12).
   - Jane Smith books the Mountain Cabin (canceled, 2 nights: August 1-3).
   - `property_id` and `user_id` reference valid records.
   - `status` uses valid ENUM values ('pending', 'confirmed', 'canceled').
   - `end_date > start_date` satisfies the CHECK constraint.
   - `created_at` reflects booking creation in June 2025.

4. **Payment Table (2 records)**:
   - Two payments for Jane’s confirmed booking (Cozy Beach Cottage):
     - $480 (full amount for 4 nights at $120/night).
     - $50 (partial payment, e.g., deposit).
   - `booking_id` references the confirmed booking.
   - `payment_method` uses valid ENUM values ('credit_card', 'paypal').
   - `payment_date` aligns with booking creation.

5. **Review Table (2 records)**:
   - Jane reviews the Cozy Beach Cottage (rating 4, post-stay).
   - Alice reviews the Downtown Loft (rating 5, post-stay).
   - `property_id` and `user_id` reference valid records.
   - `rating` satisfies the CHECK constraint (1-5).
   - `created_at` is set post-booking (July 2025).

6. **Message Table (2 records)**:
   - Jane (guest) messages John (host) about the Cozy Beach Cottage availability.
   - John responds to Jane.
   - `sender_id` and `recipient_id` reference valid `user_id` values.
   - `sent_at` aligns with pre-booking communication (June 2025).

### Design Choices
- **UUIDs**: Used consistent, unique UUIDs for primary and foreign keys, ensuring referential integrity.
- **Realism**: Data reflects real-world scenarios (e.g., guests booking properties, hosts receiving messages, payments for confirmed bookings).
- **Constraints**: All inserts respect constraints (e.g., unique `email`, valid ENUM values, `rating` between 1-5, `end_date > start_date`).
- **Variety**: Includes multiple users, properties, and booking statuses to simulate diverse usage.
- **Timestamps**: Set in June-July 2025 to align with the current date (June 29, 2025) and future bookings/reviews.

### Usage
- Execute the SQL statements in a PostgreSQL-compatible database after running the DDL from the previous response.
- The data can be used to test queries, such as calculating `total_price` for bookings (e.g., `SELECT pricepernight * (end_date - start_date) FROM Booking JOIN Property ...`).

If you need additional data, specific scenarios (e.g., more bookings or reviews), or queries to test the data, let me know!
