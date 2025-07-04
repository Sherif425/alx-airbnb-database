-- Write a query using an INNER JOIN to retrieve all bookings and the respective users who made those bookings.
SELECT * 
FROM booking b
INNER JOIN users u
ON u.user_id=b.user_id;


-- Write a query using aLEFT JOIN to retrieve all properties and their reviews, including properties that have no reviews.
SELECT * 
FROM property p
LEFT JOIN review r
ON p.property_id=r.property_id;

-- Write a query using a FULL OUTER JOIN to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.
SELECT *
FROM Users u
FULL OUTER JOIN Booking b ON u.user_id = b.user_id;
