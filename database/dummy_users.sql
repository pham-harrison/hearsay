USE hearsay_db;
-- Insert Users (30 total)
INSERT INTO user (email, username, password_hash, first_name, last_name, bio) VALUES
('john.doe@email.com', 'johndoe', 'hash123abc', 'John', 'Doe', 'Podcast enthusiast and tech lover'),
('sarah.smith@email.com', 'sarahsmith', 'hash456def', 'Sarah', 'Smith', 'True crime podcast addict'),
('mike.johnson@email.com', 'mikej', 'hash789ghi', 'Mike', 'Johnson', 'Comedy podcasts are my jam'),
('emma.wilson@email.com', 'emmaw', 'hashabc123', 'Emma', 'Wilson', NULL),
('alex.brown@email.com', 'alexb', 'hashdef456', 'Alex', 'Brown', 'History buff and podcast collector'),
('olivia.davis@email.com', 'oliviad', 'hash111aaa', 'Olivia', 'Davis', 'Business podcast junkie'),
('james.miller@email.com', 'jamesm', 'hash222bbb', 'James', 'Miller', 'Science nerd and podcast lover'),
('sophia.garcia@email.com', 'sophiag', 'hash333ccc', 'Sophia', 'Garcia', 'True crime and mystery fan'),
('william.martinez@email.com', 'willm', 'hash444ddd', 'William', 'Martinez', NULL),
('isabella.rodriguez@email.com', 'isabellar', 'hash555eee', 'Isabella', 'Rodriguez', 'Love storytelling podcasts'),
('lucas.hernandez@email.com', 'lucash', 'hash666fff', 'Lucas', 'Hernandez', 'Tech and startup podcasts'),
('mia.lopez@email.com', 'mial', 'hash777ggg', 'Mia', 'Lopez', 'Health and wellness enthusiast'),
('henry.gonzalez@email.com', 'henryg', 'hash888hhh', 'Henry', 'Gonzalez', 'Sports podcast addict'),
('amelia.wilson@email.com', 'ameliaw', 'hash999iii', 'Amelia', 'Wilson', NULL),
('benjamin.anderson@email.com', 'bena', 'hash000jjj', 'Benjamin', 'Anderson', 'News and politics listener'),
('charlotte.thomas@email.com', 'charlottet', 'hashaaakkk', 'Charlotte', 'Thomas', 'Music and culture podcasts'),
('elijah.taylor@email.com', 'elijaht', 'hashbbblll', 'Elijah', 'Taylor', 'Comedy and interview shows'),
('harper.moore@email.com', 'harperm', 'hashcccmmm', 'Harper', 'Moore', NULL),
('alexander.jackson@email.com', 'alexj', 'hashdddnnn', 'Alexander', 'Jackson', 'Educational content lover'),
('evelyn.martin@email.com', 'evelynm', 'hasheeeooo', 'Evelyn', 'Martin', 'Daily news podcast listener'),
('daniel.lee@email.com', 'danlee', 'hashfffppp', 'Daniel', 'Lee', 'Entrepreneurship and business'),
('abigail.perez@email.com', 'abigailp', 'hashgggqqq', 'Abigail', 'Perez', NULL),
('matthew.white@email.com', 'mattw', 'hashhhhaaa', 'Matthew', 'White', 'Gaming and tech podcasts'),
('emily.harris@email.com', 'emilyh', 'hashiiisss', 'Emily', 'Harris', 'Book club podcast fan'),
('joseph.sanchez@email.com', 'josephs', 'hashjjjttt', 'Joseph', 'Sanchez', 'Horror and thriller podcasts'),
('elizabeth.clark@email.com', 'elizc', 'hashkkkuuu', 'Elizabeth', 'Clark', NULL),
('david.ramirez@email.com', 'davidr', 'hashlllvvv', 'David', 'Ramirez', 'Philosophy and deep talks'),
('sofia.lewis@email.com', 'sofial', 'hashmmmwww', 'Sofia', 'Lewis', 'Pop culture enthusiast'),
('jackson.robinson@email.com', 'jacksonr', 'hashnnnxxx', 'Jackson', 'Robinson', NULL),
('avery.walker@email.com', 'averyw', 'hashooozzz', 'Avery', 'Walker', 'Documentary podcast lover');

-- Insert Playlists
INSERT INTO playlist (user_id, name, description) VALUES
(1, 'Morning Commute', 'Energizing podcasts for my drive'),
(1, 'Tech News', 'Latest technology updates'),
(2, 'True Crime Favorites', 'Best crime investigations'),
(2, 'Mystery Hour', 'Unsolved mysteries'),
(3, 'Comedy Gold', 'Funniest episodes ever'),
(5, 'History Lessons', 'Educational historical content'),
(6, 'Business Inspiration', 'Entrepreneur stories'),
(7, 'Science Deep Dives', 'Complex science topics'),
(8, 'Crime Stories', 'True crime collections'),
(10, 'Story Time', 'Narrative podcasts'),
(11, 'Tech Trends', 'Technology and innovation'),
(12, 'Wellness Journey', 'Health and mindfulness'),
(13, 'Sports Talk', 'All things sports'),
(15, 'Daily News', 'Current events'),
(17, 'Laugh Out Loud', 'Comedy podcasts'),
(19, 'Learn Something', 'Educational shows'),
(20, 'News Briefs', 'Quick news updates'),
(23, 'Gaming World', 'Video game podcasts'),
(27, 'Deep Thoughts', 'Philosophy and reflection');

-- Insert Episode Reviews (using correct podcast_id and episode_num from both_data.sql)
INSERT INTO episode_review (user_id, podcast_id, episode_num, rating, comment, created_at) VALUES
-- The Joe Rogan Experience (podcast_id = 1)
(1, 1, 1, 5, 'Great start to an amazing podcast!', '2010-01-10'),
(3, 1, 2, 4, 'Brian and Joe have great chemistry', '2010-01-15'),
(17, 1, 3, 5, 'Ari is hilarious on this episode', '2010-01-20'),
(3, 1, 5, 5, 'Love the multi-guest format', '2010-02-05'),

-- How I Built This (podcast_id = 2)
(6, 2, 2, 5, 'Sara Blakely story is so inspiring!', '2016-09-15'),
(21, 2, 3, 5, 'Instagram origin story is fascinating', '2016-09-22'),
(6, 2, 4, 4, 'Cathy Hughes is a true pioneer', '2016-09-28'),
(21, 2, 5, 5, 'Love the Clif Bar story', '2016-10-05'),

-- Conan O'Brien Needs A Friend (podcast_id = 3)
(3, 3, 1, 5, 'Will Ferrell is comedy gold', '2018-11-20'),
(17, 3, 2, 4, 'Kristen Bell is so genuine', '2018-11-27'),
(3, 3, 3, 5, 'Bill Burr cracks me up', '2018-12-05'),
(17, 3, 4, 5, 'Dax and Conan together is perfect', '2018-12-12'),
(1, 3, 5, 5, 'Nick and Megan are hilarious', '2018-12-20'),

-- TED Radio Hour (podcast_id = 4)
(19, 4, 1, 5, 'Mind-blowing space content', '2014-07-10'),
(7, 4, 2, 4, 'Fascinating hacker stories', '2014-07-15'),
(19, 4, 3, 5, 'Leadership insights are valuable', '2014-07-28'),

-- Game Scoop! (podcast_id = 5)
(23, 5, 1, 5, 'Best gaming podcast ever!', '2010-08-01'),
(23, 5, 3, 5, 'Great game recommendations', '2010-08-10'),
(11, 5, 4, 4, 'BioShock discussion is awesome', '2010-08-16'),
(23, 5, 5, 5, 'Never disappointed with Game Scoop', '2010-08-30'),

-- On Purpose with Jay Shetty (podcast_id = 6)
(12, 6, 1, 5, 'Beautiful and heartfelt', '2019-02-16'),
(12, 6, 2, 5, 'Russell Brand has such depth', '2019-02-18'),
(12, 6, 3, 5, 'Novak is incredibly inspiring', '2019-02-20'),
(27, 6, 4, 4, 'Great life lessons', '2019-02-24'),
(12, 6, 5, 5, 'Mike Posner journey is amazing', '2019-02-27'),

-- The Rest is History (podcast_id = 7)
(5, 7, 1, 5, 'Love how they explain greatness', '2020-11-05'),
(5, 7, 2, 5, 'Civil war analysis is brilliant', '2020-11-06'),
(5, 7, 3, 4, 'Interesting modern comparison', '2020-11-10'),
(5, 7, 4, 5, '17th century parallels are spot on', '2020-11-12'),

-- The Daily (podcast_id = 8)
(15, 8, 1, 5, 'Essential news coverage', '2017-02-02'),
(20, 8, 2, 5, 'Important topic well covered', '2017-02-03'),
(15, 8, 3, 4, 'Sports meets politics perfectly', '2017-02-04'),
(20, 8, 4, 4, 'Informative episode', '2017-02-07'),

-- Science Friday (podcast_id = 9)
(7, 9, 1, 5, '2001 Space Odyssey discussion is amazing', '2018-04-08'),
(7, 9, 2, 4, 'Levee engineering is fascinating', '2018-04-09'),
(19, 9, 3, 5, 'Science committee coverage is important', '2019-03-25'),
(7, 9, 4, 5, 'Animals and death - so thought-provoking', '2024-10-26'),

-- Pardon My Take (podcast_id = 10)
(13, 10, 1, 5, 'Best sports podcast out there', '2019-05-30'),
(13, 10, 2, 4, 'Zac Efron was a fun guest', '2019-05-31'),
(13, 10, 3, 5, 'Jeff Ross is hilarious', '2019-06-02'),
(13, 10, 4, 5, 'Blake Griffin interview is gold', '2019-06-05'),
(13, 10, 5, 5, 'Manny Pacquiao stories are incredible', '2019-06-06'),

-- The Vergecast (podcast_id = 11)
(1, 11, 960, 5, 'Best Apple gadget ranking ever!', '2025-12-03'),
(11, 11, 959, 5, 'Raycast discussion is fascinating', '2025-12-01'),
(1, 11, 958, 4, 'Running and tech - love it', '2025-11-26'),
(11, 11, 956, 5, 'AI agents are coming for us all', '2025-11-22'),

-- Crime Junkie (podcast_id = 12)
(2, 12, 1, 5, 'Hooked from episode one!', '2017-12-20'),
(8, 12, 2, 5, 'Laci Peterson case is heartbreaking', '2017-12-21'),
(2, 12, 3, 5, 'Part 2 is even better', '2017-12-27'),
(8, 12, 4, 4, 'West Mesa case is chilling', '2018-01-03'),
(2, 12, 5, 5, 'Robert Fisher story is crazy', '2018-01-10'),

-- This American Life (podcast_id = 13)
(10, 13, 1, 5, 'Classic storytelling at its best', '2001-01-10'),
(10, 13, 2, 5, 'Switched at Birth is incredible', '2008-07-28'),
(10, 13, 3, 4, 'Fiasco stories are entertaining', '2013-11-05'),
(5, 13, 5, 5, 'Mike Birbiglia is amazing', '2016-11-06'),

-- Sweet n Sour Podcast (podcast_id = 14)
(23, 14, 1, 5, 'Poki and Lily are so funny together!', '2024-09-15'),
(23, 14, 2, 4, 'Unhinged fan stories are wild', '2024-09-23'),
(11, 14, 3, 5, 'More yapping please!', '2024-09-30'),
(23, 14, 4, 5, 'Ratatouille discussion is hilarious', '2024-10-07'),

-- You Made It Weird (podcast_id = 15)
(3, 15, 1, 5, 'Kumail is so funny and deep', '2011-10-27'),
(17, 15, 2, 5, 'TJ Miller gets real weird', '2011-10-29'),
(3, 15, 3, 4, 'Demetri Martin philosophy', '2011-11-03'),
(17, 15, 5, 5, 'Chelsea Peretti is hilarious', '2011-11-10'),

-- Citizen Bitcoin (podcast_id = 16)
(6, 16, 1, 4, 'Great Bitcoin discussion', '2018-02-20'),
(21, 16, 2, 5, 'Energy usage debate is important', '2018-02-22'),
(6, 16, 3, 4, 'Opposing views well presented', '2018-02-24'),

-- Magic: The Gathering Drive to Work (podcast_id = 17)
(23, 17, 1, 5, 'Tempest history is fascinating', '2012-10-03'),
(23, 17, 2, 5, 'Zendikar design insights are amazing', '2012-10-10'),
(23, 17, 3, 5, 'Planeswalker origins explained perfectly', '2012-10-17'),

-- The History of Standup (podcast_id = 18)
(3, 18, 2, 5, 'SNL stories are legendary', '2015-11-04'),
(17, 18, 4, 5, 'Dan Harmon storytelling masterclass', '2015-11-18'),
(3, 18, 5, 4, 'The Office theme song story is cool', '2015-11-25'),

-- My Favorite Murder (podcast_id = 19)
(2, 19, 2, 5, 'First live show is electric!', '2025-09-26'),
(8, 19, 4, 5, '500th episode is special', '2025-10-01'),

-- Darknet Diaries (podcast_id = 20)
(11, 20, 1, 5, 'PBX hacking story is wild', '2017-09-03'),
(11, 20, 2, 5, 'VTech breach is scary', '2017-09-05'),
(1, 20, 3, 4, 'DigiNotar case is important', '2017-09-07'),
(11, 20, 4, 5, 'TalkTalk breach well explained', '2017-09-09');

-- Insert Podcast Reviews (using correct podcast_ids from both_data.sql)
INSERT INTO podcast_review (user_id, podcast_id, rating, comment, created_at) VALUES
(1, 1, 5, 'Best podcast out there, so much variety', '2020-01-15'),
(2, 1, 4, 'Joe Rogan has incredible guests', '2020-02-10'),
(2, 4, 5, 'TED talks in podcast form - brilliant', '2015-03-20'),
(3, 1, 5, 'Long-form conversations are refreshing', '2020-03-05'),
(3, 3, 5, 'Conan is naturally funny and curious', '2019-06-15'),
(4, 1, 4, 'Great variety of topics and guests', '2020-04-12'),
(5, 1, 5, 'Never a dull moment with Joe', '2020-05-18'),
(5, 7, 5, 'A masterclass in history storytelling', '2021-02-14'),
(6, 1, 5, 'Learn something new every episode', '2020-06-22'),
(6, 2, 5, 'Inspiring entrepreneur stories', '2020-05-22'),
(7, 1, 4, 'Interesting conversations on science', '2020-07-14'),
(7, 9, 5, 'Science storytelling at its best', '2020-11-05'),
(8, 1, 5, 'Joe lets guests really open up', '2020-08-20'),
(8, 12, 5, 'Best true crime podcast', '2019-07-20'),
(9, 1, 4, 'Always entertaining and informative', '2020-09-25'),
(10, 1, 5, 'The perfect podcast format', '2020-10-30'),
(10, 13, 5, 'Radio at its finest', '2019-02-28'),
(11, 11, 5, 'Essential tech podcast', '2025-11-15'),
(11, 20, 5, 'Cybersecurity stories are fascinating', '2021-04-10'),
(12, 6, 5, 'Jay Shetty changed my perspective', '2020-08-12'),
(13, 10, 5, 'Best sports commentary', '2020-08-14'),
(15, 8, 5, 'Essential daily listening', '2020-11-05'),
(17, 15, 5, 'Pete Holmes gets people to open up', '2019-12-08'),
(19, 4, 5, 'Mind-expanding content', '2019-08-27'),
(20, 8, 5, 'News done right', '2021-12-14'),
(21, 2, 5, 'Business inspiration weekly', '2020-12-30'),
(23, 5, 5, 'Gaming podcast excellence', '2020-06-18'),
(23, 14, 5, 'Poki and Lily are the best duo', '2024-11-01'),
(23, 17, 5, 'Must-listen for MTG fans', '2021-03-15'),
(27, 6, 4, 'Great for personal growth', '2021-05-20'),
(1, 11, 5, 'Never miss an episode', '2025-11-20'),
(2, 12, 5, 'Crime Junkie is addictive', '2021-08-11'),
(6, 16, 4, 'Good Bitcoin education', '2020-09-15');

-- Insert User to User (Friendships with bidirectional consistency)
-- When user1 adds user2, user2 also adds user1 with the same status
INSERT INTO user_to_user (id1, id2, date_added, status) VALUES
-- User 1 friendships
(1, 2, '2020-01-15', 'accepted'),
(2, 1, '2020-01-15', 'accepted'),
(1, 3, '2020-02-20', 'accepted'),
(3, 1, '2020-02-20', 'accepted'),
(1, 11, '2020-03-10', 'accepted'),
(11, 1, '2020-03-10', 'accepted'),

-- User 2 friendships
(2, 8, '2020-04-05', 'accepted'),
(8, 2, '2020-04-05', 'accepted'),
(2, 3, '2020-05-12', 'pending'),
(3, 2, '2020-05-12', 'pending'),

-- User 3 friendships
(3, 17, '2020-06-18', 'accepted'),
(17, 3, '2020-06-18', 'accepted'),

-- User 5 friendships
(5, 10, '2020-07-22', 'accepted'),
(10, 5, '2020-07-22', 'accepted'),
(5, 19, '2020-08-14', 'accepted'),
(19, 5, '2020-08-14', 'accepted'),

-- User 6 friendships
(6, 21, '2020-09-01', 'accepted'),
(21, 6, '2020-09-01', 'accepted'),

-- User 7 friendships
(7, 9, '2020-10-03', 'accepted'),
(9, 7, '2020-10-03', 'accepted'),
(7, 19, '2020-11-11', 'accepted'),
(19, 7, '2020-11-11', 'accepted'),

-- User 10 friendships
(10, 13, '2020-12-25', 'accepted'),
(13, 10, '2020-12-25', 'accepted'),

-- User 11 friendships
(11, 23, '2021-01-08', 'accepted'),
(23, 11, '2021-01-08', 'accepted'),
(11, 20, '2021-02-14', 'accepted'),
(20, 11, '2021-02-14', 'accepted'),

-- User 12 friendships
(12, 27, '2021-03-17', 'pending'),
(27, 12, '2021-03-17', 'pending'),

-- User 13 friendships
(13, 15, '2021-04-20', 'accepted'),
(15, 13, '2021-04-20', 'accepted'),

-- User 15 friendships
(15, 20, '2021-05-05', 'accepted'),
(20, 15, '2021-05-05', 'accepted'),

-- User 17 friendships
(17, 18, '2021-06-12', 'accepted'),
(18, 17, '2021-06-12', 'accepted'),

-- User 22 friendships
(22, 24, '2021-07-19', 'pending'),
(24, 22, '2021-07-19', 'pending'),

-- User 23 friendships
(23, 24, '2021-08-23', 'accepted'),
(24, 23, '2021-08-23', 'accepted'),

-- User 25 friendships
(25, 26, '2021-09-30', 'accepted'),
(26, 25, '2021-09-30', 'accepted'),

-- User 27 friendships
(27, 28, '2021-10-15', 'accepted'),
(28, 27, '2021-10-15', 'accepted'),

-- User 29 friendships
(29, 30, '2021-11-01', 'accepted'),
(30, 29, '2021-11-01', 'accepted');

-- Insert Episode to Playlist (using correct podcast_id and episode_num)
INSERT INTO episode_to_playlist (user_id, podcast_id, episode_num, playlist_name) VALUES
-- User 1 playlists
(1, 1, 1, 'Morning Commute'),
(1, 11, 960, 'Tech News'),
(1, 11, 959, 'Tech News'),
(1, 20, 3, 'Tech News'),

-- User 2 playlists
(2, 12, 1, 'True Crime Favorites'),
(2, 12, 2, 'True Crime Favorites'),
(2, 12, 3, 'True Crime Favorites'),
(2, 19, 2, 'Mystery Hour'),
(2, 19, 4, 'Mystery Hour'),

-- User 3 playlists
(3, 3, 1, 'Comedy Gold'),
(3, 3, 3, 'Comedy Gold'),
(3, 15, 1, 'Comedy Gold'),
(3, 15, 2, 'Comedy Gold'),

-- User 5 playlists
(5, 7, 1, 'History Lessons'),
(5, 7, 2, 'History Lessons'),
(5, 7, 4, 'History Lessons'),
(5, 13, 2, 'History Lessons'),

-- User 6 playlists
(6, 2, 2, 'Business Inspiration'),
(6, 2, 3, 'Business Inspiration'),
(6, 2, 5, 'Business Inspiration'),
(6, 16, 1, 'Business Inspiration'),

-- User 7 playlists
(7, 9, 1, 'Science Deep Dives'),
(7, 9, 2, 'Science Deep Dives'),
(7, 9, 4, 'Science Deep Dives'),

-- User 8 playlists
(8, 12, 2, 'Crime Stories'),
(8, 12, 4, 'Crime Stories'),
(8, 12, 5, 'Crime Stories'),

-- User 10 playlists
(10, 13, 1, 'Story Time'),
(10, 13, 2, 'Story Time'),
(10, 13, 3, 'Story Time'),

-- User 11 playlists
(11, 11, 956, 'Tech Trends'),
(11, 11, 959, 'Tech Trends'),
(11, 20, 1, 'Tech Trends'),
(11, 20, 2, 'Tech Trends'),

-- User 12 playlists
(12, 6, 1, 'Wellness Journey'),
(12, 6, 2, 'Wellness Journey'),
(12, 6, 3, 'Wellness Journey'),
(12, 6, 5, 'Wellness Journey'),

-- User 13 playlists
(13, 10, 1, 'Sports Talk'),
(13, 10, 3, 'Sports Talk'),
(13, 10, 4, 'Sports Talk'),
(13, 10, 5, 'Sports Talk'),

-- User 15 playlists
(15, 8, 1, 'Daily News'),
(15, 8, 2, 'Daily News'),
(15, 8, 3, 'Daily News'),

-- User 17 playlists
(17, 1, 3, 'Laugh Out Loud'),
(17, 3, 2, 'Laugh Out Loud'),
(17, 3, 4, 'Laugh Out Loud'),
(17, 15, 5, 'Laugh Out Loud'),

-- User 19 playlists
(19, 4, 1, 'Learn Something'),
(19, 4, 3, 'Learn Something'),
(19, 9, 3, 'Learn Something'),

-- User 20 playlists
(20, 8, 2, 'News Briefs'),
(20, 8, 4, 'News Briefs'),

-- User 23 playlists
(23, 5, 1, 'Gaming World'),
(23, 5, 3, 'Gaming World'),
(23, 5, 5, 'Gaming World'),
(23, 17, 1, 'Gaming World'),
(23, 17, 2, 'Gaming World'),

-- User 27 playlists
(27, 6, 4, 'Deep Thoughts'),
(27, 7, 3, 'Deep Thoughts');