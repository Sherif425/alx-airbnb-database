EXPLAIN
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.status,
    b.created_at AS booking_created_at,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.role,
    p.property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight,
    pay.payment_id,
    pay.amount,
    pay.payment_date,
    pay.payment_method
FROM Booking b
INNER JOIN Users u ON b.user_id = u.user_id
INNER JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id
WHERE b.status = 'confirmed' AND b.start_date >= '2025-07-01'
ORDER BY b.created_at DESC;


-- Creating index on Booking.user_id for JOIN and WHERE clauses
CREATE INDEX idx_booking_user_id ON Booking(user_id);

-- Creating composite index on Property for GROUP BY columns
CREATE INDEX idx_property_group_by ON Property(name, location, pricepernight);

-- Creating index on Booking.created_at for ORDER BY optimization
CREATE INDEX idx_booking_created_at ON Booking(created_at);

-- Creating composite index on Booking(status, start_date) for WHERE clause optimization
CREATE INDEX idx_booking_status_start_date ON Booking(status, start_date);


EXPLAIN
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.status,
    b.created_at AS booking_created_at,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.role,
    p.property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight,
    pay.payment_id,
    pay.amount,
    pay.payment_date,
    pay.payment_method
FROM Booking b
INNER JOIN Users u ON b.user_id = u.user_id
INNER JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id
WHERE b.status = 'confirmed' AND b.start_date >= '2025-07-01'
ORDER BY b.created_at DESC;
