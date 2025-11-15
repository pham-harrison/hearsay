CREATE DATABASE IF NOT EXISTS hearsay_db;
USE hearsay_db;

CREATE TABLE user (
	id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(32) UNIQUE NOT NULL,
    username VARCHAR(32) UNIQUE NOT NULL,
    password_hash VARCHAR(32) NOT NULL,
    first_name VARCHAR(32) NOT NULL,
    last_name VARCHAR(32) NOT NULL,
    bio VARCHAR(255) 			-- Optional
);

CREATE TABLE host (
	id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(32) NOT NULL,
    last_name VARCHAR(32) NOT NULL,
    bio VARCHAR(255) 		  	-- Optional
);

CREATE TABLE guest (
	id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(32) NOT NULL,
    last_name VARCHAR(32) NOT NULL,
    bio VARCHAR(255) 			-- Optional
);

CREATE TABLE platform (
	name VARCHAR(32) PRIMARY KEY,
    is_subscription_req BOOL NOT NULL,
    subscription_monthly_cost DECIMAL(10,2),
    CONSTRAINT subscription_check CHECK (
		(is_subscription_req = 1 AND subscription_monthly_cost IS NOT NULL) OR
		(is_subscription_req = 0 AND subscription_monthly_cost IS NULL)
	)
);

CREATE TABLE genre (
	name VARCHAR(32) PRIMARY KEY,
    description VARCHAR(255)     -- Optional
);

CREATE TABLE podcast (
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(32) NOT NULL,
    description VARCHAR(255),    -- Optional
    release_date DATE NOT NULL
);

CREATE TABLE episode (
	episode_num INT NOT NULL,
    name VARCHAR(32) NOT NULL,
    description VARCHAR(255),	-- Optional
    duration INT NOT NULL,		-- Duration in minutes
    release_date DATE NOT NULL,
    
    -- podcast contains episodes
    podcast_id INT NOT NULL,
    FOREIGN KEY (podcast_id) REFERENCES podcast(id)
    ON UPDATE CASCADE ON DELETE CASCADE,
    
    PRIMARY KEY (podcast_id, episode_num)
);

CREATE TABLE playlist (
	user_id INT NOT NULL,
	name VARCHAR(32) UNIQUE,
    description VARCHAR(255),  -- Optional
    FOREIGN KEY (user_id) REFERENCES user(id)
    ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (user_id, name)
);

CREATE TABLE episode_review (
	user_id INT NOT NULL,
    podcast_id INT NOT NULL,
    episode_num INT NOT NULL,
	rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    text VARCHAR(255),
    created_at DATE NOT NULL DEFAULT (CURRENT_DATE),
    FOREIGN KEY (user_id) REFERENCES user(id)
    ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (podcast_id, episode_num) REFERENCES episode(podcast_id, episode_num)
    ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (user_id, podcast_id, episode_num)
);

CREATE TABLE podcast_review (
	user_id INT NOT NULL,
    podcast_id INT NOT NULL,
	rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    text VARCHAR(255),
    created_at DATE NOT NULL DEFAULT (CURRENT_DATE),
    FOREIGN KEY (user_id) REFERENCES user(id)
    ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (podcast_id) REFERENCES podcast(id)
    ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (user_id, podcast_id)
);

CREATE TABLE language (
	name VARCHAR(32) PRIMARY KEY
);

CREATE TABLE user_to_user (
	-- user1 adds user2 as a friend
	id1 INT NOT NULL,
    id2 INT NOT NULL,
    date_added DATE NOT NULL,   -- Relational attribute
    status ENUM("pending", "accepted") NOT NULL,
    FOREIGN KEY (id1) REFERENCES user(id)
    ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id2) REFERENCES user(id)
    ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (id1, id2)
);

CREATE TABLE platform_to_podcast (
	-- platforms offer podcasts
	podcast_id INT NOT NULL,
	platform_name VARCHAR(32) NOT NULL,
    FOREIGN KEY (podcast_id) REFERENCES podcast(id)
    ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (platform_name) REFERENCES platform(name)
    ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (podcast_id, platform_name)
);

CREATE TABLE genre_to_podcast (
	-- podcasts categorized_by genres
	podcast_id INT NOT NULL,
	genre_name VARCHAR(32) NOT NULL,
    FOREIGN KEY (podcast_id) REFERENCES podcast(id)
    ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (genre_name) REFERENCES genre(name)
    ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (podcast_id, genre_name)
);

CREATE TABLE episode_to_playlist (
	user_id INT NOT NULL,
	podcast_id INT NOT NULL,
	episode_num INT NOT NULL,
    playlist_name VARCHAR(32) NOT NULL,
    FOREIGN KEY (user_id, playlist_name) REFERENCES playlist(user_id, name)
    ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (podcast_id, episode_num) REFERENCES episode(podcast_id, episode_num)
    ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (podcast_id, episode_num, user_id, playlist_name)
);

CREATE TABLE episode_to_host (
	-- hosts host episodes
    podcast_id INT NOT NULL,
	episode_num INT NOT NULL,
    host_id INT NOT NULL,
    FOREIGN KEY (podcast_id, episode_num) REFERENCES episode(podcast_id, episode_num)
    ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (host_id) REFERENCES host(id)
    ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (podcast_id, episode_num, host_id)
);

CREATE TABLE episode_to_guest (
	-- episodes may invite guests
    podcast_id INT NOT NULL,
	episode_num INT NOT NULL,
    guest_id INT NOT NULL,
    FOREIGN KEY (podcast_id, episode_num) REFERENCES episode(podcast_id, episode_num)
    ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (guest_id) REFERENCES guest(id)
    ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (podcast_id, episode_num, guest_id)
);

CREATE TABLE language_to_podcast (
	-- podcast language options
    podcast_id INT NOT NULL,
    language_name VARCHAR(32),
    FOREIGN KEY (podcast_id) REFERENCES podcast(id)
    ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (language_name) REFERENCES language(name)
    ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (podcast_id, language_name)
);