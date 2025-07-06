-- Creating index on Booking.user_id for JOIN and WHERE clauses
CREATE INDEX idx_booking_user_id ON Booking(user_id);

-- Creating composite index on Property for GROUP BY columns
CREATE INDEX idx_property_group_by ON Property(name, location, pricepernight);

--Before Adding Indexes:
EXPLAIN ANALYZE
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    COUNT(b.booking_id) AS total_bookings
FROM Users u
LEFT JOIN Booking b ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name, u.email;

-- Hypothetical Output (Before Indexes):
GroupAggregate  (cost=100.00..150.00 rows=5 width=150) (actual time=0.050..0.060 rows=5 loops=1)
  Group Key: u.user_id, u.first_name, u.last_name, u.email
  ->  Merge Left Join  (cost=100.00..140.00 rows=5 width=142) (actual time=0.040..0.050 rows=8 loops=1)
        Merge Cond: (u.user_id = b.user_id)
        ->  Seq Scan on Users u  (cost=0.00..20.00 rows=5 width=110) (actual time=0.010..0.015 rows=5 loops=1)
        ->  Seq Scan on Booking b  (cost=0.00..20.00 rows=3 width=32) (actual time=0.010..0.015 rows=3 loops=1)
Planning Time: 0.200 ms
Execution Time: 0.080 ms

-- After Adding Indexes:
EXPLAIN ANALYZE
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    COUNT(b.booking_id) AS total_bookings
FROM Users u
LEFT JOIN Booking b ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name, u.email;

-- Hypothetical Output (After Indexes):

GroupAggregate  (cost=50.00..100.00 rows=5 width=150) (actual time=0.030..0.040 rows=5 loops=1)
  Group Key: u.user_id, u.first_name, u.last_name, u.email
  ->  Merge Left Join  (cost=50.00..90.00 rows=5 width=142) (actual time=0.020..0.030 rows=8 loops=1)
        Merge Cond: (u.user_id = b.user_id)
        ->  Seq Scan on Users u  (cost=0.00..20.00 rows=5 width=110) (actual time=0.010..0.015 rows=5 loops=1)
        ->  Index Scan using idx_booking_user_id on Booking b  (cost=0.00..30.00 rows=3 width=32) (actual time=0.005..0.010 rows=3 loops=1)
Planning Time: 0.150 ms
Execution Time: 0.050 ms
