-- Step 1: Drop existing foreign key constraints referencing Booking
ALTER TABLE Payment DROP CONSTRAINT fk_payment_booking;

-- Step 2: Rename the original Booking table to migrate data later
ALTER TABLE Booking RENAME TO booking_old;

-- Step 3: Create the parent Booking table (partitioned)
CREATE TABLE Booking (
    booking_id UUID NOT NULL,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(10) NOT NULL CHECK (status IN ('pending', 'confirmed', 'canceled')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (booking_id, start_date)
) PARTITION BY RANGE (start_date);

-- Step 4: Create child tables (partitions) for 2024, 2025, 2026, and future
CREATE TABLE booking_2024 PARTITION OF Booking
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE booking_2025 PARTITION OF Booking
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

CREATE TABLE booking_2026 PARTITION OF Booking
    FOR VALUES FROM ('2026-01-01') TO ('2027-01-01');

CREATE TABLE booking_future PARTITION OF Booking
    FOR VALUES FROM ('2027-01-01') TO (MAXVALUE);

-- Step 5: Create indexes on each partition
CREATE INDEX idx_booking_2024_booking_id ON booking_2024 (booking_id);
CREATE INDEX idx_booking_2024_user_id ON booking_2024 (user_id);
CREATE INDEX idx_booking_2024_property_id ON booking_2024 (property_id);
CREATE INDEX idx_booking_2024_status_start_date ON booking_2024 (status, start_date);
CREATE INDEX idx_booking_2024_created_at ON booking_2024 (created_at);

CREATE INDEX idx_booking_2025_booking_id ON booking_2025 (booking_id);
CREATE INDEX idx_booking_2025_user_id ON booking_2025 (user_id);
CREATE INDEX idx_booking_2025_property_id ON booking_2025 (property_id);
CREATE INDEX idx_booking_2025_status_start_date ON booking_2025 (status, start_date);
CREATE INDEX idx_booking_2025_created_at ON booking_2025 (created_at);

CREATE INDEX idx_booking_2026_booking_id ON booking_2026 (booking_id);
CREATE INDEX idx_booking_2026_user_id ON booking_2026 (user_id);
CREATE INDEX idx_booking_2026_property_id ON booking_2026 (property_id);
CREATE INDEX idx_booking_2026_status_start_date ON booking_2026 (status, start_date);
CREATE INDEX idx_booking_2026_created_at ON booking_2026 (created_at);

CREATE INDEX idx_booking_future_booking_id ON booking_future (booking_id);
CREATE INDEX idx_booking_future_user_id ON booking_future (user_id);
CREATE INDEX idx_booking_future_property_id ON booking_future (property_id);
CREATE INDEX idx_booking_future_status_start_date ON booking_future (status, start_date);
CREATE INDEX idx_booking_future_created_at ON booking_future (created_at);

-- Step 6: Migrate data from booking_old to the partitioned Booking table
INSERT INTO Booking
SELECT * FROM booking_old;

-- Step 7: Drop the old Booking table
DROP TABLE booking_old;

-- Step 8: Recreate foreign key constraint on Payment
ALTER TABLE Payment
ADD CONSTRAINT fk_payment_booking
FOREIGN KEY (booking_id)
REFERENCES Booking (booking_id)
ON DELETE RESTRICT;
