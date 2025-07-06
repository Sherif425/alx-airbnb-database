-- Creating index on Booking.user_id for JOIN and WHERE clauses
CREATE INDEX idx_booking_user_id ON Booking(user_id);

-- Creating composite index on Property for GROUP BY columns
CREATE INDEX idx_property_group_by ON Property(name, location, pricepernight);
