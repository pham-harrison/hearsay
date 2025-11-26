-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
USER PROCEDURES
*/
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
Create user
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS create_user $$
CREATE PROCEDURE create_user
(
	IN email_p VARCHAR(32),
    IN username_p VARCHAR(32),
    IN password_hash_p VARCHAR(255),
    IN first_name_p VARCHAR(32),
    IN last_name_p VARCHAR(32)
)
BEGIN
    IF EXISTS (SELECT * FROM user WHERE email = email_p) THEN 
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT = "Email already registered";
    ELSEIF EXISTS (SELECT * FROM user WHERE username = username_p) THEN
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT = "Username is already taken";
    ELSE
		INSERT INTO user(email, username, password_hash, first_name, last_name) 
        VALUES (email_p, username_p, password_hash_p, first_name_p, last_name_p);
	END IF;
END $$
DELIMITER ;

-- CALL create_user("pham.har@northeastern.edu", "hpham", "root1234", "Harrison", "Pham");
-- SELECT * FROM user;

/*
Get user login details
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS get_user_log_in_details $$
CREATE PROCEDURE get_user_log_in_details(IN username_p VARCHAR(32))
BEGIN
	IF NOT EXISTS (SELECT * FROM user WHERE username = username_p) THEN
		SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT = "Invalid username and/or password";
	ELSE
		SELECT id, username, password_hash FROM user WHERE username = username_p;
	END IF;
END $$
DELIMITER ;

-- CALL get_user_log_in_details("hpfham");



/*
Get user by id
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS get_user_by_id $$
CREATE PROCEDURE get_user_by_id(IN user_id_p INT)
BEGIN
    IF NOT EXISTS (SELECT * FROM user WHERE id = user_id_p) THEN
		SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT="User not found";
	END IF;
    
	SELECT id, username, first_name, last_name, bio FROM user WHERE id = user_id_p;
END $$
DELIMITER ;

-- CALL get_user_by_id(51);

/*
Get user by username
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS get_user_by_username $$
CREATE PROCEDURE get_user_by_username(IN username_p VARCHAR(32))
BEGIN
    IF NOT EXISTS (SELECT * FROM user WHERE username LIKE CONCAT("%", username_p, "%")) THEN
		SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT="No users found";
	END IF; 
	SELECT id, username, email, first_name, last_name, bio FROM user WHERE username LIKE CONCAT("%", username_p, "%");
END $$
DELIMITER ;

-- CALL get_user_by_username("hpham");

/*
Update user bio
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS update_bio $$
CREATE PROCEDURE update_bio(user_id_p INT, bio_p VARCHAR(255))
BEGIN
	IF NOT EXISTS (SELECT * FROM user WHERE id = user_id_p) THEN
		SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT="User not found";
	END IF;
    
	UPDATE user
    SET bio = bio_p WHERE id = user_id_p;
END $$
DELIMITER ;

-- CALL update_bio(51, "My name is Harrison");
-- SELECT * FROM user WHERE id = 51;
-- CALL update_bio(56, "My name is Harrison");

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
USER-FRIEND PROCEDURES
*/
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
Send friend request
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS send_friend_request $$
CREATE PROCEDURE send_friend_request(IN user_id_p INT, IN user_to_request_id_p INT)
BEGIN
	IF user_id_p = user_to_request_id_p THEN
		SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT = "Cannot send friend request to yourself";
	END IF;
    
	IF EXISTS (SELECT * FROM user_to_user 
			   WHERE (id1 = user_id_p AND id2 = user_to_request_id_p)
			       OR (id1 = user_to_request_id_p AND id2 = user_id_p)) THEN
		SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT = "Friend request or friendship already exists";
	END IF;
    
    INSERT INTO user_to_user (id1, id2, status)
    VALUES (user_id_p, user_to_request_id_p, "pending");
END $$
DELIMITER ;

-- CALL send_friend_request(1, 51);

/*
Accept a friend request
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS accept_friend_request $$
CREATE PROCEDURE accept_friend_request(IN user_id_p INT, IN user_to_accept_id_p INT)
BEGIN
	IF EXISTS (
		SELECT * FROM user_to_user
        WHERE id1 = user_to_accept_id_p AND id2 = user_id_p
	) THEN
		UPDATE user_to_user
        SET status = "accepted", date_added = CURRENT_DATE
        WHERE id1 = user_to_accept_id_p AND id2 = user_id_p;
        
        INSERT INTO user_to_user (id1, id2, status, date_added)
        VALUES (user_id_p, user_to_accept_id_p, "accepted", CURRENT_DATE);
	ELSE
		SIGNAL SQLSTATE "45000"
		SET MESSAGE_TEXT="Unable to add friend";
	END IF;
END $$
DELIMITER ;

-- CALL accept_friend_request(51, 1);
-- CALL accept_friend_request(1, 51);

/*
Delete friend
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS delete_friend $$
CREATE PROCEDURE delete_friend(IN user_id_p INT, IN user_to_delete_id_p INT) 
BEGIN
	IF NOT EXISTS (SELECT * FROM user WHERE id = user_id_p) THEN
		SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT = "User ID not found";
	ELSEIF NOT EXISTS (SELECT * FROM user_to_user WHERE id1 = user_id_p AND id2 = user_to_delete_id_p) THEN
		SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT = "Users are not friends";
	END IF;
    
    IF (SELECT status FROM user_to_user WHERE id1 = user_id_p AND id2 = user_to_delete_id_p) = "accepted" THEN
		DELETE FROM user_to_user WHERE id1 = user_to_delete_id_p AND id2 = user_id_p;
	END IF;
    
	DELETE FROM user_to_user WHERE id1 = user_id_p AND id2 = user_to_delete_id_p;
END $$
DELIMITER ;

-- CALL delete_friend(1, 51);

/*
Get friends
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS get_friends $$
CREATE PROCEDURE get_friends(user_id_p INT)
BEGIN
	IF NOT EXISTS (SELECT * FROM user WHERE id = user_id_p) THEN
		SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT="User not found";
	END IF;
    SELECT id, date_added, username, first_name, last_name, bio FROM user_to_user
    JOIN user ON id2 = user.id
    WHERE id1 = user_id_p AND status = "accepted";
END $$
DELIMITER ;

-- CALL get_friends(1);
-- CALL get_friends(51);

/*
Get user friends' reviews
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS get_user_friends_reviews $$
CREATE PROCEDURE get_user_friends_reviews(IN user_id_p INT)
BEGIN
    IF NOT EXISTS (SELECT * FROM user WHERE id = user_id_p) THEN
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT = "User not found";
    END IF;
    
    SELECT user_id, username, first_name, last_name, podcast_id, episode_num, rating, comment, created_at FROM user_to_user 
    JOIN episode_review ON id2 = episode_review.user_id
    JOIN user ON id2 = id
    WHERE id1 = user_id_p AND status = "accepted";
END $$
DELIMITER ;

-- CALL get_user_friends_reviews(1);

CALL get_user_friends_reviews(1);
/*
Get a users podcast reviews
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS get_user_podcast_reviews $$
CREATE PROCEDURE get_user_podcast_reviews(IN user_id_p INT)
BEGIN
    IF NOT EXISTS (SELECT * FROM user WHERE id = user_id_p) THEN
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT = "User not found";
    END IF;
    
    SELECT user_id, username, podcast.name, rating, comment, created_at FROM user AS u
    JOIN podcast_review AS pr ON u.id = pr.user_id
    JOIN podcast USING (podcast_id)
    WHERE pr.user_id = user_id_p
    ORDER BY created_at DESC;
END $$
DELIMITER ;
-- CALL get_user_podcast_reviews(1);

/*
Get a users episode reviews
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS get_user_episode_reviews $$
CREATE PROCEDURE get_user_episode_reviews(IN user_id_p INT)
BEGIN
    IF NOT EXISTS (SELECT * FROM user WHERE id = user_id_p) THEN
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT = "User not found";
    END IF;
    
    SELECT user_id, username, podcast.name, episode_num, rating, comment, created_at FROM user AS u
    JOIN episode_review AS er ON u.id = er.user_id
    JOIN podcast USING (podcast_id)
    WHERE er.user_id = user_id_p
    ORDER BY created_at DESC;
END $$
DELIMITER ;



/*
Get all friend reviews of a podcast
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS get_user_friends_podcast_reviews $$
CREATE PROCEDURE get_user_friends_podcast_reviews(IN user_id_p INT, IN podcast_id_p INT)
BEGIN
    IF NOT EXISTS (SELECT * FROM user WHERE id = user_id_p) THEN
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT = "User not found";
    END IF;
    
    IF NOT EXISTS (SELECT * FROM podcast WHERE podcast_id = podcast_id_p) THEN
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT = "Podcast not found";
    END IF;
    
    SELECT id2 AS id, rating, comment, created_at, username, first_name, last_name FROM user_to_user
    JOIN podcast_review ON id2 = podcast_review.user_id
    JOIN user ON id = id2
    WHERE id1 = user_id_p AND podcast_id = podcast_id_p;
END $$
DELIMITER ;

-- CALL get_user_friends_podcast_reviews(1, 2);


/*
Get all friend reviews of an episode
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS get_user_friends_episode_review $$
CREATE PROCEDURE get_user_friends_episode_review(IN user_id_p INT, IN podcast_id_p INT, IN episode_num_p INT)
BEGIN
    IF NOT EXISTS (SELECT * FROM user WHERE id = user_id_p) THEN
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT = "User not found";
    END IF;
    
    IF NOT EXISTS (SELECT * FROM podcast WHERE podcast_id = podcast_id_p) THEN
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT = "Podcast not found";
    END IF;
    
    IF NOT EXISTS (SELECT * FROM episode WHERE podcast_id = podcast_id_p AND episode_num = episode_num_p) THEN
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT = "Episode not found";
    END IF;
    
    SELECT id, rating, comment, created_at, username, first_name, last_name FROM user_to_user
    JOIN episode_review ON id2 = user_id
    JOIN user ON id = id2
    WHERE id1 = user_id_p AND podcast_id = podcast_id_p AND episode_num = episode_num_p;
END $$
DELIMITER ;

-- CALL get_user_friends_episode_review(1, 1, 1169);


-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
PODCAST PROCEDURES
*/
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------


/*
Get all hosts
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS get_hosts $$
CREATE PROCEDURE get_hosts()
BEGIN
	SELECT * FROM host;
END $$
DELIMITER ;

-- CALL get_hosts();

/*
Get all guests
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS get_guests $$
CREATE PROCEDURE get_guests()
BEGIN
	SELECT * FROM guest;
END $$
DELIMITER ;

-- CALL get_guests();

/*
Search podcasts
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS search_podcasts $$
CREATE PROCEDURE search_podcasts
(
	IN name_p VARCHAR(32),
    IN genre_p VARCHAR(32),
    IN language_p VARCHAR(32),
    IN platform_p VARCHAR(32),
    IN host_first_p VARCHAR(32),
    IN host_last_p VARCHAR(32),
    IN guest_first_p VARCHAR(32),
    IN guest_last_p VARCHAR(32),
    IN year_p INT
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
    IF name_p IS NULL THEN SET name_flag = 1; END IF;
	IF genre_p IS NULL THEN SET genre_flag = 1; END IF;
	IF language_p IS NULL THEN SET language_flag = 1; END IF;
	IF platform_p IS NULL THEN SET platform_flag = 1; END IF;
	IF host_first_p IS NULL THEN SET host_first_flag = 1; END IF;
	IF host_last_p IS NULL THEN SET host_last_flag = 1; END IF;
	IF guest_first_p IS NULL THEN SET guest_first_flag = 1; END IF;
	IF guest_last_p IS NULL THEN SET guest_last_flag = 1; END IF;
	IF year_p IS NULL THEN SET year_flag = 1; END IF;
	
    -- Return table based on passed filters
    SELECT p.podcast_id, p.name, p.description, p.release_date, GROUP_CONCAT(DISTINCT genre_name) AS genres FROM podcast AS p 
		  LEFT JOIN platform_to_podcast AS ptp USING (podcast_id)
		  LEFT JOIN platform AS pl USING (platform_name)
          LEFT JOIN genre_to_podcast AS gtp USING (podcast_id)
          LEFT JOIN genre AS g USING (genre_name)
          LEFT JOIN language_to_podcast AS ltp USING (podcast_id)
          LEFT JOIN language AS l USING (language_name)
          LEFT JOIN episode_to_host AS eth USING (podcast_id)
          LEFT JOIN host AS h USING (host_id)
          LEFT JOIN episode_to_guest AS etg USING (podcast_id)
          LEFT JOIN guest AS gu USING (guest_id)
    WHERE (p.name LIKE CONCAT('%', name_p, '%') OR name_flag) AND
		  (g.genre_name = genre_p OR genre_flag) AND
          (l.language_name = language_p OR language_flag) AND
          (pl.platform_name = platform_p OR platform_flag) AND
          (h.first_name = host_first_p OR host_first_flag) AND
          (h.last_name = host_last_p OR host_last_flag) AND
          (gu.first_name = guest_first_p OR guest_first_flag) AND 
          (gu.last_name = guest_last_p OR guest_last_flag) AND 
          (YEAR(p.release_date) = year_p OR year_flag)
    GROUP BY p.podcast_id;
END $$
DELIMITER ;

-- CALL search_podcasts
-- (
-- 	NULL, -- name VARCHAR(32),
--     NULL, -- genre VARCHAR(32),
--     NULL, -- language VARCHAR(32),
--     NULL, -- platform VARCHAR(32),
--     NULL, -- host_first VARCHAR(32),
--     NULL, -- host_last VARCHAR(32),
--     NULL, -- guest_first VARCHAR(32),
--     NULL, -- guest_last VARCHAR(32),
--     NULL -- year INT
-- );

-- SELECT * FROM podcast;

/*
Search episodes
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS search_episodes $$
CREATE PROCEDURE search_episodes
(
    IN podcast_id_p INT,
    IN episode_num_p INT,
	IN episode_name_p VARCHAR(32),
    IN host_first_p VARCHAR(32),
    IN host_last_p VARCHAR(32),
    IN guest_first_p VARCHAR(32),
    IN guest_last_p VARCHAR(32),
    IN year_p INT
)
BEGIN
    SELECT * FROM episode
    LEFT JOIN episode_to_host AS eth 
        ON episode.podcast_id = eth.podcast_id
        AND episode.episode_num = eth.episode_num
    LEFT JOIN host USING (host_id)
    LEFT JOIN episode_to_guest AS etg 
        ON episode.podcast_id = etg.podcast_id
        AND episode.episode_num = etg.episode_num
    LEFT JOIN guest USING (guest_id)
    WHERE ((episode.podcast_id = podcast_id_p)
        AND (episode_num_p IS NULL OR episode.episode_num = episode_num_p)
        AND (episode_name_p IS NULL OR episode.name LIKE CONCAT('%', episode_name_p, '%'))
        AND (host_first_p IS NULL OR host.first_name = host_first_p)
        AND (host_last_p IS NULL OR host.last_name = host_last_p)
        AND (guest_first_p IS NULL OR guest.first_name = guest_first_p)
        AND (guest_last_p IS NULL OR guest.last_name = guest_last_p)
        AND (year_p IS NULL OR YEAR(episode.release_date) = year_p));
END $$
DELIMITER ;

-- CALL search_episodes
-- (
--     5, -- IN podcast_id_p INT,
--     NULL, -- IN episode_num_p INT,
-- 	NULL, -- IN episode_name_p VARCHAR(32),
--     NULL, -- IN host_first_p VARCHAR(32),
--     NULL, -- IN host_last_p VARCHAR(32),
--     "Michelle", -- IN guest_first_p VARCHAR(32),
--     "Obama", -- IN guest_last_p VARCHAR(32),
--     NULL -- IN year_p INT
-- );

-- SELECT * FROM episode WHERE podcast_id = 1;

/*
Get a podcast
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS get_podcast $$
CREATE PROCEDURE get_podcast(IN podcast_id_p INT)
BEGIN
    IF NOT EXISTS (SELECT * FROM podcast WHERE podcast_id = podcast_id_p) THEN
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT = "Podcast not found";
    END IF;
    
    SELECT name, description, release_date FROM podcast WHERE podcast_id = podcast_id_p;
END $$
DELIMITER ;

-- CALL get_podcast(5);

/*
Get a podcast
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS get_episode $$
CREATE PROCEDURE get_episode(IN podcast_id_p INT, IN episode_num_p INT)
BEGIN
    IF NOT EXISTS (SELECT * FROM podcast WHERE podcast_id = podcast_id_p) THEN
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT = "Podcast not found";
    ELSEIF NOT EXISTS (SELECT * FROM episode WHERE podcast_id = podcast_id AND episode_num = episode_num_p) THEN 
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT = "Episode not found";
    END IF;
    
    SELECT * FROM episode WHERE podcast_id = podcast_id_p and episode_num = episode_num_p;
END $$
DELIMITER ;

-- CALL get_episode(1, 1555);

/*
Get all genres 
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS get_all_genres $$
CREATE PROCEDURE get_all_genres()
BEGIN
    SELECT genre_name FROM genre;
END $$
DELIMITER ;

-- CALL get_all_genres();

/*
Get all languages
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS get_all_languages $$
CREATE PROCEDURE get_all_languages()
BEGIN
    SELECT language_name FROM language;
END $$
DELIMITER ;

-- CALL get_all_languages();


/*
Get all platforms
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS get_all_platforms $$
CREATE PROCEDURE get_all_platforms()
BEGIN
    SELECT platform_name FROM platform;
END $$
DELIMITER ;

-- CALL get_all_platforms();

/*
Get all hosts
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS get_all_hosts $$
CREATE PROCEDURE get_all_hosts()
BEGIN
    SELECT first_name, last_name FROM host;
END $$
DELIMITER ;

-- CALL get_all_hosts();


/*
Get all guests
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS get_all_guests $$
CREATE PROCEDURE get_all_guests()
BEGIN
    SELECT first_name, last_name FROM guest;
END $$
DELIMITER ;

-- CALL get_all_guests();


/*
Get all podcast hosts
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS get_podcast_hosts $$
CREATE PROCEDURE get_podcast_hosts(IN podcast_id_p INT)
BEGIN
    SELECT DISTINCT first_name, last_name FROM episode_to_host
    JOIN host USING (host_id)
    WHERE podcast_id = podcast_id_p;
END $$
DELIMITER ;

-- CALL get_podcast_hosts(5);

/*
Get all podcast guests
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS get_podcast_guests $$
CREATE PROCEDURE get_podcast_guests(IN podcast_id_p INT)
BEGIN
    SELECT DISTINCT first_name, last_name FROM episode_to_guest
    JOIN guest USING (guest_id)
    WHERE podcast_id = podcast_id_p;
END $$
DELIMITER ;

-- CALL get_podcast_guests(5);
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
PODCAST-REVIEW PROCEDURES
*/
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
Get a user's rating of a podcast
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS get_podcast_review $$
CREATE PROCEDURE get_podcast_review(IN user_id_p INT, IN podcast_id_p INT)
BEGIN
    SELECT rating, comment, created_at
    FROM podcast_review
    WHERE user_id = user_id_p AND podcast_id = podcast_id_p;
END $$
DELIMITER ;

-- CALL get_podcast_review(1, 1);
-- CALL get_podcast_review(51, 1);


/*
Insert podcast review
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS insert_podcast_review $$
CREATE PROCEDURE insert_podcast_review(IN user_id_p INT, IN podcast_id_p INT, IN rating_p INT, IN comment_p VARCHAR(255))
BEGIN
    IF NOT EXISTS (SELECT * FROM podcast WHERE podcast_id = podcast_id_p) THEN
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT="Podcast not found";
    ELSEIF NOT EXISTS (SELECT * FROM user WHERE id = user_id_p) THEN
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT="User not found";
    END IF;
    
    INSERT INTO podcast_review (user_id, podcast_id, rating, comment) 
    VALUES (user_id_p, podcast_id_p, rating_p, comment_p);
END $$
DELIMITER ;

-- CALL insert_podcast_review(51, 1, 4, "Decent");
-- CALL insert_podcast_review(51, 5, 5, "Conan is amazing"); 
-- SELECT * FROM podcast_review WHERE user_id = 51;


/*
Update podcast review
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS update_podcast_review $$
CREATE PROCEDURE update_podcast_review(IN user_id_p INT, IN podcast_id_p INT, IN rating_p INT, IN comment_p VARCHAR(255))
BEGIN
    IF NOT EXISTS (SELECT * FROM podcast WHERE podcast_id = podcast_id_p) THEN
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT="Podcast not found";
    ELSEIF NOT EXISTS (SELECT * FROM user WHERE id = user_id_p) THEN
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT="User not found";
    END IF;

    UPDATE podcast_review
    SET rating = rating_p, comment = comment_p, created_at = CURRENT_DATE
    WHERE user_id = user_id_p AND podcast_id = podcast_id_p;
END $$
DELIMITER ;

-- CALL update_podcast_review(51, 1, 5, "better than I remember");

/*
Delete podcast review
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS delete_podcast_review $$
CREATE PROCEDURE delete_podcast_review (IN user_id_p INT, IN podcast_id_p INT)
BEGIN
    DELETE FROM podcast_review 
    WHERE user_id = user_id_p 
    AND podcast_id = podcast_id_p;
END $$
DELIMITER ;

-- CALL delete_podcast_review(51, 1);

/*
Get a user's review of an episode
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS get_episode_review $$
CREATE PROCEDURE get_episode_review(IN user_id_p INT, IN podcast_id_p INT, IN episode_num_p INT)
BEGIN
	SELECT rating, comment, created_at
    FROM episode_review
    WHERE user_id = user_id_p AND podcast_id = podcast_id_p AND episode_num = episode_num_p;
END $$
DELIMITER ;

-- CALL get_episode_review(51, 1, 1555);

/*
Insert episode review
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS insert_episode_review $$
CREATE PROCEDURE insert_episode_review(IN user_id_p INT, IN podcast_id_p INT, IN episode_num_p INT, IN rating_p INT, IN comment_p VARCHAR(255))
BEGIN
    IF NOT EXISTS (SELECT * FROM podcast WHERE podcast_id = podcast_id_p) THEN
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT="Podcast not found";
    ELSEIF NOT EXISTS (SELECT * FROM episode WHERE podcast_id = podcast_id_p AND episode_num = episode_num_p) THEN
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT="Episode not found";
    ELSEIF NOT EXISTS (SELECT * FROM user WHERE id = user_id_p) THEN
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT="User not found";
    END IF;

    INSERT INTO episode_review (user_id, podcast_id, episode_num, rating, comment) 
    VALUES (user_id_p, podcast_id_p, episode_num_p, rating_p, comment_p);
END $$
DELIMITER ;

-- CALL insert_episode_review(51, 1, 1555, 5, NULL);

/*
Update episode review
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS update_episode_review $$
CREATE PROCEDURE update_episode_review(IN user_id_p INT, IN podcast_id_p INT, IN episode_num_p INT, IN rating_p INT, IN comment_p VARCHAR(255))
BEGIN
    IF NOT EXISTS (SELECT * FROM podcast WHERE podcast_id = podcast_id_p) THEN
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT="Podcast not found";
    ELSEIF NOT EXISTS (SELECT * FROM episode WHERE podcast_id = podcast_id_p AND episode_num = episode_num_p) THEN
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT="Episode not found";
    ELSEIF NOT EXISTS (SELECT * FROM user WHERE id = user_id_p) THEN
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT="User not found";
    END IF;

    UPDATE episode_review
    SET rating = rating_p, comment = comment_p, created_at = CURRENT_DATE
    WHERE user_id = user_id_p AND podcast_id = podcast_id_p AND episode_num = episode_num_p;
END $$
DELIMITER ;

-- CALL update_episode_review(51, 1, 1555, 5, "Forgot to add a comment");



/*
Delete episode review
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS delete_episode_review $$
CREATE PROCEDURE delete_episode_review
(
	IN user_id_p INT,
    IN podcast_id_p INT,
    IN episode_num_p INT
)
BEGIN
    DELETE FROM episode_review 
    WHERE user_id = user_id_p 
    AND podcast_id = podcast_id_p
    AND episode_num = episode_num_p;
END $$
DELIMITER ;


-- CALL delete_episode_review(51, 1, 1555);


/*
Get global podcast average rating
*/
DELIMITER $$
DROP FUNCTION IF EXISTS get_global_podcast_avg_rating $$
CREATE FUNCTION get_global_podcast_avg_rating(podcast_id_p INT)
RETURNS DECIMAL(2,1)
DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE podcast_rating DECIMAL(2,1);
    
	SELECT AVG(rating) INTO podcast_rating
    FROM podcast_review
    WHERE podcast_id = podcast_id_p;
    
    RETURN podcast_rating;
END $$
DELIMITER ;

-- SELECT get_global_podcast_avg_rating(2);
-- SELECT * FROM podcast_review where podcast_id = 2;


/*
Get global podcast average rating by episode
*/
DELIMITER $$
DROP FUNCTION IF EXISTS get_global_podcast_avg_rating_by_episode $$
CREATE FUNCTION get_global_podcast_avg_rating_by_episode(podcast_id_p INT)
RETURNS DECIMAL(2,1)
DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE podcast_rating DECIMAL(2,1);
    
	SELECT AVG(rating) INTO podcast_rating
    FROM episode_review
    WHERE podcast_id = podcast_id_p;
    
    RETURN podcast_rating;
END $$
DELIMITER ;

-- SELECT * FROM episode_review WHERE podcast_id = 2;
-- SELECT get_global_podcast_avg_rating_by_episode(2);

/*
Get the user's friends' average rating of a podcast
*/
DELIMITER $$
DROP FUNCTION IF EXISTS get_user_friends_podcast_avg_rating $$
CREATE FUNCTION get_user_friends_podcast_avg_rating(user_id_p INT, podcast_id_p INT)
RETURNS DECIMAL(2,1)
DETERMINISTIC READS SQL DATA
BEGIN
	DECLARE friends_avg_rating DECIMAL(2,1);
    
    SELECT AVG(rating) INTO friends_avg_rating
    FROM user_to_user
    JOIN podcast_review ON id2 = podcast_review.user_id
    WHERE id1 = user_id_p AND podcast_id = podcast_id_p;
    
    RETURN friends_avg_rating;
END $$
DELIMITER ;

-- SELECT * FROM podcast_review WHERE user_id = 51;
-- SELECT * FROM podcast;
-- CALL create_user("testuser@email.com", "testUser", "root1234", "Test", "User");
-- CALL send_friend_request(1, 52);
-- CALL accept_friend_request(52, 1);
-- CALL get_friends(1);
-- CALL insert_podcast_review(52, 1, 3, NULL);
-- CALL get_user_podcast_review(52, 1);
-- SELECT * FROM user_to_user JOIN podcast_review ON id2 = user_id WHERE id1 = 1 AND podcast_id = 1;
-- SELECT get_user_friends_podcast_avg_rating(1, 1);


/*
Get user's friends' average podcast rating by episode
*/
DELIMITER $$
DROP FUNCTION IF EXISTS get_user_friends_podcast_avg_rating_by_episode $$
CREATE FUNCTION get_user_friends_podcast_avg_rating_by_episode(user_id_p INT, podcast_id_p INT)
RETURNS DECIMAL(2,1)
DETERMINISTIC READS SQL DATA
BEGIN
	DECLARE friends_avg_rating_by_episode DECIMAL(2,1);
    
	SELECT AVG(rating) INTO friends_avg_rating_by_episode
    FROM user_to_user
    JOIN episode_review ON id2 = episode_review.user_id
    WHERE id1 = user_id_p AND podcast_id = podcast_id_p;
    
    RETURN friends_avg_rating_by_episode;
END $$
DELIMITER ;

-- SELECT * FROM episode_review WHERE user_id = 51;
-- CALL insert_episode_review(52, 1, 1555, 1, NULL);
-- SELECT * FROM episode_review WHERE user_id = 52;
-- SELECT * FROM user_to_user JOIN episode_review ON episode_review.user_id = id2 WHERE id1 = 1 AND podcast_id = 1;
-- SELECT get_user_friends_podcast_avg_rating_by_episode(1, 1);

/*
Get an episode's global average rating
*/
DELIMITER $$
DROP FUNCTION IF EXISTS get_global_episode_avg_rating $$
CREATE FUNCTION get_global_episode_avg_rating(podcast_id_p INT, episode_num_p INT)
RETURNS DECIMAL (2,1)
DETERMINISTIC READS SQL DATA
BEGIN
	DECLARE episode_rating DECIMAL(2,1);

	SELECT AVG(rating) INTO episode_rating
    FROM episode_review
    WHERE podcast_id = podcast_id_p AND episode_num = episode_num_p;
    
    RETURN episode_rating;
END $$
DELIMITER ;

-- SELECT * FROM episode_review WHERE podcast_id = 1;
-- SELECT get_global_episode_avg_rating(1, 1555);



/*
Get an episode's average rating from a user's friends
*/
DELIMITER $$
DROP FUNCTION IF EXISTS get_user_friends_episode_avg_rating $$
CREATE FUNCTION get_user_friends_episode_avg_rating(user_id_p INT, podcast_id_p INT, episode_num_p INT)
RETURNS DECIMAL(2,1) 
DETERMINISTIC READS SQL DATA
BEGIN
	DECLARE friends_rating DECIMAL(2,1);
    
	SELECT AVG(rating) INTO friends_rating
    FROM user_to_user
    JOIN episode_review ON id2 = episode_review.user_id
    WHERE id1 = user_id_p AND podcast_id = podcast_id_p AND episode_num = episode_num_p;
    
    RETURN friends_rating;
END $$
DELIMITER ;

-- SELECT * FROM user_to_user WHERE id1 = 1;
-- SELECT get_user_friends_episode_avg_rating(1, 1, 1555);

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
PLAYLIST PROCEDURES
*/
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
Create a playlist
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS create_playlist $$
CREATE PROCEDURE create_playlist (IN user_id_p INT, IN playlist_name_p VARCHAR(32), IN description_p VARCHAR(32))
BEGIN
	IF playlist_name_p NOT IN (SELECT name FROM playlist AS pl WHERE pl.user_id = user_id_p) THEN
		INSERT INTO playlist(user_id, name, description) VALUES (user_id_p, playlist_name_p, description_p);
    ELSE 
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT="Playlist already exists";
    END IF;
END $$
DELIMITER ;

-- CALL create_playlist(51, "Real G tunes", "For Real Gs by Real Gs");
-- SELECT * FROM playlist;

/*
Get a playlist
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS get_playlists $$
CREATE PROCEDURE get_playlists (IN user_id_p INT)
BEGIN
	SELECT * FROM playlist WHERE user_id = user_id_p;
END $$
DELIMITER ;

-- CALL get_playlists(51);

/*
Delete a playlist
*/
DROP PROCEDURE IF EXISTS delete_playlist;
DELIMITER $$
CREATE PROCEDURE delete_playlist(IN user_id_p INT, IN playlist_name_p VARCHAR(32))
BEGIN
	IF playlist_name_p IN (SELECT name FROM playlist WHERE user_id = user_id_p) THEN
		DELETE FROM playlist AS pl 
        WHERE pl.user_id = user_id_p
        AND name = playlist_name_p;
    ELSE
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT = "Playlist not found";
	END IF;
END $$
DELIMITER ;

-- CALL delete_playlist(51, "Real G tunes");

/*
Get episodes in playlist
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS get_episodes_in_playlist $$
CREATE PROCEDURE get_episodes_in_playlist(IN user_id_p INT, IN playlist_name_p VARCHAR(32))
BEGIN
    SELECT p.podcast_id AS podcast_id, p.name AS podcast_name, episode_num FROM episode_to_playlist AS etp
    JOIN podcast AS p ON p.podcast_id = etp.podcast_id
    WHERE etp.user_id = user_id_p AND playlist_name = playlist_name_p;
END $$
DELIMITER ;

-- CALL get_episodes_in_playlist(1, "Morning Commute");


/*
Add episode to playlist
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS add_episode_to_playlist $$
CREATE PROCEDURE add_episode_to_playlist
(
	IN user_id_p INT,
    IN podcast_id_p INT,
    IN episode_num_p INT,
    IN playlist_name_p VARCHAR(32)
)
BEGIN
	IF playlist_name_p IN (SELECT name FROM playlist AS pl WHERE pl.user_id = user_id_p) THEN
		INSERT INTO episode_to_playlist(user_id, podcast_id, episode_num, playlist_name) 
            VALUES(user_id_p, podcast_id_p, episode_num_p, playlist_name_p);
    ELSE
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT = "Playlist not found";
    END IF;
END $$
DELIMITER ;

-- CALL add_to_playlist(51, 1, 1555, "Real G tunes");

/*
Remove an episode from a playlist
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS remove_episode_from_playlist $$
CREATE PROCEDURE remove_episode_from_playlist
(
	IN user_id_p INT,
    IN podcast_id_p INT,
    IN episode_num_p INT,
    IN playlist_name_p VARCHAR(32)
)
BEGIN
	IF playlist_name_p IN (SELECT name FROM playlist AS pl WHERE pl.user_id = user_id_p) THEN
		DELETE FROM episode_to_playlist AS etp 
        WHERE user_id_p = etp.user_id 
            AND playlist_name_p = etp.playlist_name 
            AND podcast_id_p = etp.podcast_id 
            AND episode_num_p = etp.episode_num;
    ELSE 
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT = "Playlist not found";
    END IF;
END $$
DELIMITER ;

-- CALL remove_episode_from_playlist(51, 1, 1555, "Real G tunes");

-- SELECT * FROM episode_review;
-- SELECT * FROM user_to_user WHERE id1 = 1;