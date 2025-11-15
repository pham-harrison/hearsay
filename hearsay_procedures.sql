USE hearsay_db;

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Create user (should be func? should return success or fail?)
DROP PROCEDURE IF EXISTS create_user;
DELIMITER $$
CREATE PROCEDURE create_user
(
	email VARCHAR(32),
    username VARCHAR(32),
    password_hash VARCHAR(32),
    first_name VARCHAR(32),
    last_name VARCHAR(32)
)
BEGIN
	IF email NOT IN (SELECT user.email FROM user) THEN
		INSERT INTO user(email, username, password_hash, first_name, last_name) VALUES (email, username, password_hash, first_name, last_name);
	END IF;
END $$
DELIMITER ;

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Get user
DROP PROCEDURE IF EXISTS get_user;
DELIMITER $$
CREATE PROCEDURE get_user
(
	username VARCHAR(32),
    password_hash VARCHAR(32)
)
BEGIN
	SELECT id FROM user WHERE user.email = email AND user.password_hash = password_hash;
END $$
DELIMITER ;

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Update bio
DROP PROCEDURE IF EXISTS update_bio;
DELIMITER $$
CREATE PROCEDURE update_bio
(
	user_id INT,
    bio VARCHAR(255)
)
BEGIN
	UPDATE user
    SET user.bio = bio WHERE user.id = user_id;
END $$
DELIMITER ;

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------