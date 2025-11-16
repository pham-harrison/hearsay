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
	user_id INT
)
BEGIN
	SELECT * FROM user WHERE id = user_id;
END $$
DELIMITER ;

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Log in user
DROP PROCEDURE IF EXISTS log_in_user;
DELIMITER $$
CREATE PROCEDURE log_in_user
(
	username VARCHAR(32),
    password_hash VARCHAR(255)
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
-- Get friends
DROP PROCEDURE IF EXISTS get_friends;
DELIMITER $$
CREATE PROCEDURE get_friends
(
	user_id INT
)
BEGIN
	SELECT * FROM user_to_user WHERE id1 = user_id AND status = "accepted";
END $$
DELIMITER ;

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Delete friend
DROP PROCEDURE IF EXISTS delete_friend;
DELIMITER $$
CREATE PROCEDURE delete_friend
(
	user_id INT,
    user_to_delete_id INT
) 
BEGIN
	DELETE FROM user_to_user WHERE id1 = user_id AND id2 = user_to_delete_id AND status = "accepted";
END $$
DELIMITER ;

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Search podcasts
DROP PROCEDURE IF EXISTS search_podcasts;
DELIMITER $$
CREATE PROCEDURE search_podcasts
(
	name VARCHAR(32),
    genre VARCHAR(32),
    language VARCHAR(32),
    platform VARCHAR(32),
    host_first VARCHAR(32),
    host_last VARCHAR(32),
    guest_first VARCHAR(32),
    guest_last VARCHAR(32),
    year DATE
)
BEGIN
	-- Declare flags for filters
	DECLARE name_flag TINYINT DEFAULT 0;
    DECLARE genre_flag TINYINT DEFAULT 0;
    DECLARE language_flag TINYINT DEFAULT 0;
    DECLARE platform_flag TINYINT DEFAULT 0;
    DECLARE host_first_flag TINYINT DEFAULT 0;
    DECLARE host_last_flag TINYINT DEFAULT 0;
    DECLARE guest_first_flag TINYINT DEFAULT 0;
    DECLARE guest_last_flag TINYINT DEFAULT 0;
    DECLARE year_flag TINYINT DEFAULT 0;
    
    -- Set flags to disable check if filter is null
    IF name IS NULL THEN SET name_flag = 1; END IF;
	IF genre IS NULL THEN SET genre_flag = 1; END IF;
	IF language IS NULL THEN SET language_flag = 1; END IF;
	IF platform IS NULL THEN SET platform_flag = 1; END IF;
	IF host_first IS NULL THEN SET host_first_flag = 1; END IF;
	IF host_last IS NULL THEN SET host_last_flag = 1; END IF;
	IF guest_first IS NULL THEN SET guest_first_flag = 1; END IF;
	IF guest_last IS NULL THEN SET guest_last_flag = 1; END IF;
	IF year IS NULL THEN SET year_flag = 1; END IF;
	
    -- Return table based on passed filters
    SELECT * FROM podcast AS p JOIN platform_to_podcast AS ptp ON p.id = ptp.podcast_id
						   JOIN platform AS pl ON ptp.platform_name = pl.name
                           JOIN genre_to_podcast AS gtp ON p.id = gtp.podcast_id
                           JOIN genre AS g ON gtp.genre_name = g.name
                           JOIN language_to_podcast AS ltp ON p.id = ltp.podcast_id
                           JOIN language AS l ON ltp.language_name = l.name
                           JOIN 
	WITH H AS (SELECT * FROM podcast JOIN 
    WHERE (p.name = name OR name_flag) AND
		  (p.genre = genre OR genre_flag) AND
          (p.language = language OR language_flag) AND
          (p.platform = platform OR platform_flag) AND
          (p.host_first = host_first OR host_first_flag) AND
END $$
DELIMITER ;