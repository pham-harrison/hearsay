/*
Send friend request
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS send_friend_request $$
CREATE PROCEDURE send_friend_request(IN requester_id_p INT, IN friend_id_p INT)
BEGIN
	IF requester_id_p = friend_id_p THEN
		SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT = "Cannot send friend request to yourself";
	END IF;
    
	IF EXISTS (SELECT * FROM user_to_user 
			   WHERE (id1 = requester_id_p AND id2 = friend_id_p)
			       OR (id1 = friend_id_p AND id2 = requester_id_p)) THEN
		SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT = "Friend request or friendship already exists";
	END IF;
    
    INSERT INTO user_to_user (id1, id2, status)
    VALUES (requester_id_p, friend_id_p, "pending");
END $$
DELIMITER ;
 
CALL send_friend_request(1, 51);
SELECT * FROM user_to_user WHERE id1 = 1;
SELECT * FROM user_to_user WHERE id1 = 51;

/*
Accept a friend request
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS accept_friend_request $$
CREATE PROCEDURE accept_friend_request(IN user_id_p INT, IN requester_id_p INT)
BEGIN
	IF EXISTS (
		SELECT * FROM user_to_user
        WHERE id1 = requester_id_p AND id2 = user_id_p
	) THEN
		UPDATE user_to_user
        SET status = "accepted", date_added = CURRENT_DATE
        WHERE id1 = requester_id_p AND id2 = user_id_p;
        
        INSERT INTO user_to_user (id1, id2, status, date_added)
        VALUES (user_id_p, requester_id_p, "accepted", CURRENT_DATE);
	ELSE
		SIGNAL SQLSTATE "45000"
		SET MESSAGE_TEXT="Unable to add friend";
	END IF;
END $$
DELIMITER ;

CALL accept_friend_request(51, 1);
SELECT * FROM user_to_user WHERE id1 = 51;
SELECT * FROM user_to_user WHERE id2 = 51;



/*
Insert podcast review
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS insert_podcast_review $$
CREATE PROCEDURE insert_podcast_review(IN user_id_p INT, IN podcast_id_p INT, IN rating_p INT, IN text_p VARCHAR(255))
BEGIN
    INSERT INTO podcast_review (user_id, podcast_id, rating, text) 
    VALUES (user_id_p, podcast_id_p, rating_p, text_p);
END $$
DELIMITER ;

INSERT INTO user(email, username, password_hash, first_name, last_name) VALUES ("pham.har@email", "pham-har", "root1234", "Harrison", "Pham");
CALL insert_podcast_review(51, 1, 5, NULL);
CALL insert_podcast_review(51, 4, 2, NULL);
SELECT * FROM podcast_review WHERE user_id = 51;



/*
Update podcast review
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS update_podcast_review $$
CREATE PROCEDURE update_podcast_review(IN user_id_p INT, IN podcast_id_p INT, IN rating_p INT, IN text_p VARCHAR(255))
BEGIN
    UPDATE podcast_review
    SET rating = rating_p, text = text_p
    WHERE user_id = user_id_p AND podcast_id = podcast_id_p;
END $$
DELIMITER ;

CALL update_podcast_review(51, 1, 4, "Not as good as I remember");
SELECT * FROM podcast_review WHERE user_id = 51;



/*
Insert episode review
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS insert_episode_review $$
CREATE PROCEDURE insert_episode_review(IN user_id_p INT, IN podcast_id_p INT, IN episode_num_p INT, IN rating_p INT, IN text_p VARCHAR(255))
BEGIN
    INSERT INTO episode_review (user_id, podcast_id, episode_num, rating, text) 
    VALUES (user_id_p, podcast_id_p, episode_num_p, rating_p, text_p);
END $$
DELIMITER ;

CALL insert_episode_review(51, 1, 1169, 5, "Amazing");
SELECT * FROM episode_review WHERE user_id = 51;



/*
Update episode review
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS update_episode_review $$
CREATE PROCEDURE update_episode_review(IN user_id_p INT, IN podcast_id_p INT, IN episode_num_p INT, IN rating_p INT, IN text_p VARCHAR(255))
BEGIN
    UPDATE episode_review
    SET rating = rating_p, text = text_p
    WHERE user_id = user_id_p AND podcast_id = podcast_id_p AND episode_num = episode_num_p;
END $$
DELIMITER ;

CALL update_episode_review(51, 1, 1169, 2, "Boring");
SELECT * FROM episode_review WHERE user_id = 51;



/*
Get global podcast average rating
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS get_global_podcast_avg_rating $$
CREATE PROCEDURE get_global_podcast_avg_rating(IN podcast_id_p INT)
BEGIN
	SELECT AVG(rating)
    FROM podcast_review
    WHERE podcast_id = podcast_id_p;
END $$
DELIMITER ;

CALL get_global_podcast_avg_rating(1);



/*
Get global podcast avg rating by episode
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS get_global_podcast_avg_rating_by_episode $$
CREATE PROCEDURE get_global_podcast_avg_rating_by_episode(IN podcast_id_p INT)
BEGIN
	SELECT AVG(rating)
    FROM episode_review
    WHERE podcast_id = podcast_id_p;
END $$
DELIMITER ;

CALL get_global_podcast_avg_rating_by_episode(1);



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

SELECT get_user_friends_podcast_avg_rating(1, 4);



/*
Get user's friends' avg podcast rating by episode
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

INSERT INTO episode_review (user_id, podcast_id, episode_num, rating, text) VALUES (51, 4, 1, 1, NULL);
INSERT INTO episode_review (user_id, podcast_id, episode_num, rating, text) VALUES (51, 4, 2, 5, NULL);
SELECT get_user_friends_podcast_avg_rating_by_episode(1, 4);



/*
Get a user's rating of a podcast
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS get_user_podcast_rating $$
CREATE PROCEDURE get_user_podcast_rating(IN user_id_p INT, IN podcast_id_p INT)
BEGIN
    SELECT rating
    FROM podcast_review
    WHERE user_id = user_id_p AND podcast_id = podcast_id_p;
END $$
DELIMITER ;

CALL get_user_podcast_rating(4, 5);



/*
Get a user's rating of an episode
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS get_user_episode_rating $$
CREATE PROCEDURE get_user_episode_rating(IN user_id_p INT, IN podcast_id_p INT, IN episode_num_p INT)
BEGIN
	SELECT rating
    FROM episode_review
    WHERE user_id = user_id_p AND podcast_id = podcast_id_p AND episode_num = episode_num_p;
END $$
DELIMITER ;

CALL get_user_episode_rating(8, 16, 1);



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

SELECT get_global_episode_avg_rating(4, 1);



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

SELECT * FROM episode_review WHERE podcast_id = 4;
SELECT * FROM user_to_user WHERE id1 = 1;
SELECT get_user_friends_episode_avg_rating(1, 4, 1);






/*
ADDING CHECKS TO PROCEDURES
*/

/*
Create user
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS create_user $$
CREATE PROCEDURE create_user
(
	email_p VARCHAR(32),
    username_p VARCHAR(32),
    password_hash_p VARCHAR(255),
    first_name_p VARCHAR(32),
    last_name_p VARCHAR(32)
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

CALL get_user_log_in_details("johndoe");



/*
Get user by id
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS get_user_by_id $$
CREATE PROCEDURE get_user_by_id(IN user_id_p INT)
BEGIN
	SELECT * FROM user WHERE id = user_id_p;
END $$
DELIMITER ;



/*
Get user by username
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS get_user_by_username;
CREATE PROCEDURE get_user_by_username(IN username_p INT)
BEGIN
	SELECT * FROM user WHERE username = username_p;
END $$
DELIMITER ;



/*
Update user bio
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS update_bio $$
CREATE PROCEDURE update_bio(user_id_p INT, bio_p VARCHAR(255))
BEGIN
	IF NOT EXISTS (SELECT * FROM user WHERE user_id = user_id_p) THEN
		SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT="User not found";
	END IF;
    
	UPDATE user
    SET user.bio = bio WHERE user.id = user_id;
END $$
DELIMITER ;



/*
Get friends
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS get_friends $$
CREATE PROCEDURE get_friends(user_id_p INT)
BEGIN
	IF NOT EXISTS (SELECT * FROM user WHERE user_id = user_id_p) THEN
		SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT="User not found";
	END IF;
    SELECT * FROM user WHERE id IN (SELECT id2 FROM user_to_user WHERE id1 = user_id_p);
END $$
DELIMITER ;



/*
Delete friend
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS delete_friend $$
CREATE PROCEDURE delete_friend(IN user_id_p INT, IN user_to_delete_id_p INT) 
BEGIN
	IF NOT EXISTS (SELECT * FROM user_to_user WHERE id = user_id_p) THEN
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



/*

*/

