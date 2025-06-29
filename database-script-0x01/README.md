Based on the normalized AirBnB database schema from the previous response, I’ll create SQL Data Definition Language (DDL) statements to define the database schema, including `CREATE TABLE` statements for each entity (User, Property, Booking, Payment, Review, Message). The schema will incorporate the normalization adjustment (removing `total_price` from the Booking table to ensure 3NF compliance) and include all specified constraints (primary keys, foreign keys, unique constraints, check constraints, and ENUM-like constraints using CHECK). Additionally, I’ll create indexes as specified for optimal performance.

The output will be a Markdown file containing the SQL DDL statements, wrapped in an artifact tag, with explanations of the design choices.

```sql

-- Creating the User table
CREATE TABLE User (
    user_id UUID PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    role VARCHAR(10) NOT NULL CHECK (role IN ('guest', 'host', 'admin')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uk_user_email UNIQUE (email)
);

-- Creating the Property table
CREATE TABLE Property (
    property_id UUID PRIMARY KEY,
    host_id UUID NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    pricepernight DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_property_host FOREIGN KEY (host_id) REFERENCES User(user_id) ON DELETE RESTRICT
);

-- Creating the Booking table
CREATE TABLE Booking (
    booking_id UUID PRIMARY KEY,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(10) NOT NULL CHECK (status IN ('pending', 'confirmed', 'canceled')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_booking_property FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE RESTRICT,
    CONSTRAINT fk_booking_user FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE RESTRICT,
    CONSTRAINT chk_dates CHECK (end_date > start_date)
);

-- Creating the Payment table
CREATE TABLE Payment (
    payment_id UUID PRIMARY KEY,
    booking_id UUID NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(20) NOT NULL CHECK (payment_method IN ('credit_card', 'paypal', 'stripe')),
    CONSTRAINT fk_payment_booking FOREIGN KEY (booking_id) REFERENCES Booking(booking_id) ON DELETE RESTRICT
);

-- Creating the Review table
CREATE TABLE Review (
    review_id UUID PRIMARY KEY,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_review_property FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE RESTRICT,
    CONSTRAINT fk_review_user FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE RESTRICT
);

-- Creating the Message table
CREATE TABLE Message (
    message_id UUID PRIMARY KEY,
    sender_id UUID NOT NULL,
    recipient_id UUID NOT NULL,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_message_sender FOREIGN KEY (sender_id) REFERENCES User(user_id) ON DELETE RESTRICT,
    CONSTRAINT fk_message_recipient FOREIGN KEY (recipient_id) REFERENCES User(user_id) ON DELETE RESTRICT
);

-- Creating additional indexes for performance
CREATE INDEX idx_user_email ON User(email);
CREATE INDEX idx_property_property_id ON Property(property_id);
CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_booking_booking_id ON Booking(booking_id);
CREATE INDEX idx_payment_booking_id ON Payment(booking_id);

```

### Explanation of Design Choices
1. **Data Types**:
   - **UUID**: Used for primary keys (`user_id`, `property_id`, etc.) as specified, ensuring unique identifiers.
   - **VARCHAR**: Used for text fields like `first_name` (50), `last_name` (50), `email` (100), `location` (255), and `name` (100) with reasonable length limits. `password_hash` uses VARCHAR(255) to accommodate secure hash lengths.
   - **TEXT**: Used for `description` (Property), `comment` (Review), and `message_body` (Message) to allow longer text.
   - **DECIMAL(10,2)**: Used for `pricepernight` and `amount` to store monetary values with two decimal places.
   - **TIMESTAMP**: Used for `created_at`, `updated_at`, `payment_date`, and `sent_at` with `DEFAULT CURRENT_TIMESTAMP` for automatic timestamping.
   - **DATE**: Used for `start_date` and `end_date` in Booking to store dates without time components.
   - **INTEGER**: Used for `rating` in Review with a CHECK constraint (1-5).

2. **Constraints**:
   - **Primary Keys**: Each table has a UUID primary key, automatically indexed.
   - **Foreign Keys**: 
     - `host_id` in Property references `User(user_id)`.
     - `property_id` and `user_id` in Booking reference `Property(property_id)` and `User(user_id)`.
     - `booking_id` in Payment references `Booking(booking_id)`.
     - `property_id` and `user_id` in Review reference `Property(property_id)` and `User(user_id)`.
     - `sender_id` and `recipient_id` in Message reference `User(user_id)`.
     - All foreign keys use `ON DELETE RESTRICT` to prevent deletion of referenced records, ensuring referential integrity.
   - **Unique Constraint**: `email` in User has a `UNIQUE` constraint.
   - **NOT NULL**: Applied to required fields as specified (e.g., `first_name`, `email`, `name`, `description`).
   - **CHECK Constraints**:
     - `role` in User is restricted to 'guest', 'host', 'admin' (simulating ENUM with CHECK).
     - `status` in Booking is restricted to 'pending', 'confirmed', 'canceled'.
     - `payment_method` in Payment is restricted to 'credit_card', 'paypal', 'stripe'.
     - `rating` in Review is restricted to 1-5.
     - Added `chk_dates` in Booking to ensure `end_date > start_date` for logical consistency.

3. **Indexes**:
   - Primary keys are automatically indexed.
   - Additional indexes:
     - `idx_user_email` on `User(email)` for fast email lookups (unique constraint also creates an index, but explicitly listed for clarity).
     - `idx_property_property_id` on `Property(property_id)` (redundant due to primary key but included as per specification).
     - `idx_booking_property_id` on `Booking(property_id)` for efficient joins with Property.
     - `idx_booking_booking_id` on `Booking(booking_id)` (redundant due to primary key but included as per specification).
     - `idx_payment_booking_id` on `Payment(booking_id)` for efficient joins with Booking.

4. **Normalization**:
   - The schema reflects the 3NF adjustment from the previous response, with `total_price` removed from the Booking table to eliminate the transitive dependency on `Property.pricepernight`.

5. **Assumptions**:
   - The database is assumed to be PostgreSQL-compatible due to UUID support and CHECK constraints for ENUM-like behavior. If another DBMS is required (e.g., MySQL, which has limited CHECK support), adjustments may be needed.
   - `ON DELETE RESTRICT` is used to prevent accidental deletion of referenced records. `ON DELETE CASCADE` could be used if deletion propagation is desired.
   - VARCHAR lengths (e.g., 50, 100, 255) are chosen based on typical use cases but can be adjusted if specific requirements are provided.

### Usage
- Copy the SQL code from the artifact and execute it in a SQL database (e.g., PostgreSQL) to create the tables and indexes.
- The schema supports the AirBnB application’s requirements, with tables for users, properties, bookings, payments, reviews, and messages, all in 3NF.

If you need the DDL in a different SQL dialect, additional constraints, or a script to populate sample data, let me know!
