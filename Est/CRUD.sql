-- Create
-- Add a user
INSERT INTO USER (university_id, email, password_hash, first_name, last_name, phone, is_verified)
VALUES (1, 'john.doe@example.com', 'hashed_password_123', 'John', 'Doe', '123-456-7890', 1);

-- Add an unverified user
INSERT INTO USER (university_id, email, password_hash, first_name, last_name)
VALUES (2, 'jane.smith@example.com', 'hashed_password_456', 'Jane', 'Smith');

-- Create a new textbook listing
INSERT INTO LISTING (seller_id, primary_category_id, title, description, condition, price, campus_id)
VALUES (1, 1, 'Calculus Textbook 5th Edition', 'Excellent condition calculus textbook, barely used', 'Like New', 45.99, 1);


-- Read
-- Retrieve all active listings with seller information
SELECT l.listing_id, l.title, l.price, l.condition, u.first_name, u.last_name
FROM LISTING l
JOIN USER u ON l.seller_id = u.user_id
WHERE l.status = 'active'
ORDER BY l.created_at DESC; -- 降序; ASC为升序

-- Get user wishlist items with listing details
SELECT w.wishlist_id, l.title, l.price, l.condition
FROM WISHLIST w
JOIN LISTING l ON w.listing_id = l.listing_id
WHERE w.user_id = 1
AND l.status = 'active';


-- Update
-- Mark user as verified and update status
UPDATE USER
SET is_verified = 1,
    status = 'active'
WHERE user_id = 2 AND email = 'jane.smith@student.edu';

-- Update user binding and verified status
UPDATE USER
SET phone = '13800138002', is_verified = 1
WHERE user_id = 1;

-- Update listing price for a specific item
UPDATE LISTING
SET price = 39.99,
    description = 'Price reduced! Calculus textbook in excellent condition'
WHERE listing_id = 1;


--Delete
-- Remove an item from user's wishlist
DELETE FROM WISHLIST
WHERE user_id = 1 AND listing_id = 3;

-- Delete testing user which is unverified.
DELETE FROM USER
WHERE is_verified = 0 AND join_date < date('now', '-7 days');

-- Delete a delivery address for a user
DELETE FROM DELIVERY_ADDRESS
WHERE address_id = 2 AND user_id = 1;