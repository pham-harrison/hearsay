USE hearsay_db;

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Create user (should be func? should return success or fail?)
DROP PROCEDURE IF EXISTS create_user;
DELIMITER $$
CREATE PROCEDURE create_user
(
	email VARCHAR(32),
    username VARCHAR(32),
    password_hash VARCHAR(255),
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
    SELECT * FROM podcast AS p 
		  JOIN platform_to_podcast AS ptp USING (podcast_id)
		  JOIN platform AS pl USING (platform_name)
          JOIN genre_to_podcast AS gtp USING (podcast_id)
          JOIN genre AS g USING (genre_name)
          JOIN language_to_podcast AS ltp USING (podcast_id)
          JOIN language AS l USING (language_name)
          JOIN episode_to_host AS eth USING (podcast_id)
          JOIN host AS h USING (host_id)
          JOIN episode_to_guest AS etg USING (podcast_id)
          JOIN guest AS gu USING (guest_id)
    WHERE (p.name = name OR name_flag) AND
		  (g.genre_name = genre OR genre_flag) AND
          (l.language_name = language OR language_flag) AND
          (pl.platform_name = platform OR platform_flag) AND
          (h.first_name = host_first OR host_first_flag) AND
          (h.last_name = host_last OR host_last_flag) AND
          (gu.first_name = guest_first OR guest_first_flag) AND 
          (gu.last_name = guest_last OR guest_last_flag) AND 
          (p.release_date = year OR year_flag);
END $$
DELIMITER ;

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Get hosts
DROP PROCEDURE IF EXISTS get_hosts;
DELIMITER $$
CREATE PROCEDURE get_hosts()
BEGIN
	SELECT first_name, last_name FROM host;
END $$
DELIMITER ;

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Get guests
DROP PROCEDURE IF EXISTS get_guests;
DELIMITER $$
CREATE PROCEDURE get_guests()
BEGIN
	SELECT first_name, last_name FROM guest;
END $$
DELIMITER ;

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Create playlist
DROP PROCEDURE IF EXISTS create_playlist;
DELIMITER $$
CREATE PROCEDURE create_playlist
(
	user_id INT,
    playlist_name VARCHAR(32)
)
BEGIN
	IF playlist_name NOT IN (SELECT name FROM playlist AS pl WHERE pl.user_id = user_id) THEN
		INSERT INTO playlist(user_id, name) VALUES(user_id, playlist_name);
    END IF;
END $$
DELIMITER ;

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Delete playlist
DROP PROCEDURE IF EXISTS delete_playlist;
DELIMITER $$
CREATE PROCEDURE delete_playlist
(
	user_id INT,
    playlist_name VARCHAR(32)
)
BEGIN
	IF playlist_name IN (SELECT playlist_name FROM playlist) THEN
		DELETE FROM playlist AS pl WHERE pl.user_id = user_id AND playlist_name = pl.playlist_name;
	END IF;
END $$
DELIMITER ;

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Add to playlist
DROP PROCEDURE IF EXISTS add_to_playlist;
DELIMITER $$
CREATE PROCEDURE add_to_playlist
(
	user_id INT,
    playlist_name VARCHAR(32),
    podcast_id INT,
    episode_num INT
)
BEGIN
	IF playlist_name IN (SELECT playlist_name FROM playlist AS pl WHERE pl.user_id = user_id) THEN
		INSERT INTO episode_to_playlist(user_id, podcast_id, episode_num, playlist_name) VALUES(user_id, podcast_id, episode_num, playlist_name);
    END IF;
END $$
DELIMITER ;

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Remove from playlist
DROP PROCEDURE IF EXISTS remove_from_playlist;
DELIMITER $$
CREATE PROCEDURE remove_from_playlist
(
	user_id INT,
    playlist_name VARCHAR(32),
    podcast_id INT,
    episode_num INT
)
BEGIN
	IF playlist_name IN (SELECT playlist_name FROM playlist AS pl WHERE pl.user_id = user_id) THEN
		DELETE FROM episode_to_playlist AS etp 
        WHERE user_id = etp.user_id AND 
        playlist_name = etp.playlist_name AND 
        podcast_id = etp.podcast_id AND 
        episode_num = etp.episode_num;
    END IF;
END $$
DELIMITER ;
