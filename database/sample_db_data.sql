USE hearsay_db;

-- Insert Users (50 total)
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
('avery.walker@email.com', 'averyw', 'hashooozzz', 'Avery', 'Walker', 'Documentary podcast lover'),
('ella.young@email.com', 'ellay', 'hashppp111', 'Ella', 'Young', 'Self-improvement podcasts'),
('samuel.allen@email.com', 'samuala', 'hashqqq222', 'Samuel', 'Allen', NULL),
('scarlett.king@email.com', 'scarletk', 'hashrrr333', 'Scarlett', 'King', 'Food and cooking podcasts'),
('sebastian.wright@email.com', 'sebastianw', 'hashsss444', 'Sebastian', 'Wright', 'Travel podcast adventurer'),
('victoria.scott@email.com', 'victorias', 'hashttt555', 'Victoria', 'Scott', NULL),
('owen.torres@email.com', 'owent', 'hashuuu666', 'Owen', 'Torres', 'Finance and investing podcasts'),
('grace.nguyen@email.com', 'gracen', 'hashvvv777', 'Grace', 'Nguyen', 'Meditation and mindfulness'),
('jack.hill@email.com', 'jackh', 'hashwww888', 'Jack', 'Hill', NULL),
('chloe.flores@email.com', 'chloef', 'hashxxx999', 'Chloe', 'Flores', 'Design and creativity podcasts'),
('wyatt.green@email.com', 'wyattg', 'hashyyy000', 'Wyatt', 'Green', 'Space and astronomy fan'),
('lily.adams@email.com', 'lilya', 'hashzzz111', 'Lily', 'Adams', NULL),
('nathan.nelson@email.com', 'nathann', 'hash123zzz', 'Nathan', 'Nelson', 'Sports commentary listener'),
('zoey.baker@email.com', 'zoeyb', 'hash456yyy', 'Zoey', 'Baker', 'Parenting podcast enthusiast'),
('caleb.hall@email.com', 'calebh', 'hash789xxx', 'Caleb', 'Hall', NULL),
('hannah.rivera@email.com', 'hannahr', 'hashabc789', 'Hannah', 'Rivera', 'Language learning podcasts'),
('isaac.campbell@email.com', 'isaacc', 'hashdef012', 'Isaac', 'Campbell', 'History and war stories'),
('addison.mitchell@email.com', 'addisonm', 'hashghi345', 'Addison', 'Mitchell', NULL),
('luke.carter@email.com', 'lukec', 'hashjkl678', 'Luke', 'Carter', 'Conspiracy theory podcasts'),
('lillian.roberts@email.com', 'lillianr', 'hashmno901', 'Lillian', 'Roberts', 'Fashion and lifestyle'),
('gabriel.gomez@email.com', 'gabrielg', 'hashpqr234', 'Gabriel', 'Gomez', 'Latin music and culture');

-- Insert Hosts (15 total)
INSERT INTO host (first_name, last_name, bio) VALUES
('Joe', 'Rogan', 'Comedian and UFC commentator'),
('Marc', 'Maron', 'Stand-up comedian and interviewer'),
('Ira', 'Glass', 'Radio personality and producer'),
('Sarah', 'Koenig', 'Investigative journalist'),
('Conan', 'OBrien', 'Former late night host and comedian'),
('Terry', 'Gross', 'Legendary interviewer'),
('Roman', 'Mars', 'Design and architecture storyteller'),
('Hrishikesh', 'Hirway', 'Musician and podcast creator'),
('Dax', 'Shepard', 'Actor and comedian'),
('Tim', 'Ferriss', 'Entrepreneur and author'),
('Guy', 'Raz', 'Storyteller and journalist'),
('Anna', 'Faris', 'Actress and comedian'),
('Bill', 'Simmons', 'Sports analyst and media personality'),
('Sam', 'Harris', 'Neuroscientist and philosopher'),
('Dan', 'Carlin', 'Historian and podcaster');

-- Insert Guests (20 total)
INSERT INTO guest (first_name, last_name, bio) VALUES
('Elon', 'Musk', 'CEO of Tesla and SpaceX'),
('Michelle', 'Obama', 'Former First Lady'),
('Neil', 'deGrasse Tyson', 'Astrophysicist and science communicator'),
('Brene', 'Brown', 'Research professor and author'),
('Malcolm', 'Gladwell', 'Author and journalist'),
('Tim', 'Ferriss', 'Entrepreneur and author'),
('Stephen', 'King', 'Horror novelist'),
('Yuval', 'Harari', 'Historian and philosopher'),
('Oprah', 'Winfrey', 'Media mogul and philanthropist'),
('Bill', 'Gates', 'Microsoft founder and philanthropist'),
('LeBron', 'James', 'NBA superstar'),
('Taylor', 'Swift', 'Singer-songwriter'),
('Trevor', 'Noah', 'Comedian and former Daily Show host'),
('Serena', 'Williams', 'Tennis champion'),
('Mark', 'Zuckerberg', 'Facebook founder'),
('Alexandria', 'Ocasio-Cortez', 'US Congresswoman'),
('Keanu', 'Reeves', 'Actor'),
('Dolly', 'Parton', 'Country music legend'),
('Gordon', 'Ramsay', 'Celebrity chef'),
('Jane', 'Goodall', 'Primatologist and anthropologist');

-- Insert Platforms
INSERT INTO platform (platform_name, is_subscription_req, subscription_monthly_cost) VALUES
('Spotify', 0, NULL),
('Apple Podcasts', 0, NULL),
('Audible', 1, 7.95),
('Stitcher Premium', 1, 4.99),
('Luminary', 1, 7.99),
('YouTube', 0, NULL),
('Google Podcasts', 0, NULL),
('Wondery Plus', 1, 4.99),
('Patreon', 1, 5.00);

-- Insert Genres
INSERT INTO genre (genre_name, description) VALUES
('Comedy', 'Humorous and entertaining content'),
('True Crime', 'Real-life crime stories and investigations'),
('Technology', 'Tech news, reviews, and discussions'),
('History', 'Historical events and stories'),
('Science', 'Scientific topics and discoveries'),
('Business', 'Entrepreneurship and business strategies'),
('Health', 'Health, fitness, and wellness topics'),
('News', 'Current events and news analysis'),
('Education', 'Educational and informative content'),
('Interview', 'Conversational interviews with guests'),
('Sports', 'Sports news and commentary'),
('Self-Improvement', 'Personal development and growth'),
('Music', 'Music discussion and analysis'),
('Politics', 'Political commentary and analysis'),
('Food', 'Cooking and culinary content');

-- Insert Languages
INSERT INTO language (language_name) VALUES
('English'),
('Spanish'),
('French'),
('German'),
('Mandarin'),
('Japanese'),
('Portuguese'),
('Italian'),
('Korean'),
('Hindi');

-- Insert Podcasts (20 total)
INSERT INTO podcast (name, description, release_date) VALUES
('The Joe Rogan Experience', 'Long-form conversations with fascinating people', '2009-12-24'),
('WTF with Marc Maron', 'Interviews from a garage in Los Angeles', '2009-09-01'),
('This American Life', 'Stories of everyday life with unexpected twists', '1995-11-17'),
('Serial', 'Investigative journalism in serial format', '2014-10-03'),
('Conan Needs A Friend', 'Conan talks to interesting people', '2018-11-18'),
('Fresh Air', 'In-depth interviews with cultural figures', '1975-01-01'),
('99% Invisible', 'Design and architecture stories', '2010-09-29'),
('Song Exploder', 'Musicians break down their songs', '2014-01-10'),
('Armchair Expert', 'Dax Shepard interviews celebrities', '2018-02-14'),
('The Tim Ferriss Show', 'Deconstructing world-class performers', '2014-04-08'),
('How I Built This', 'Stories behind successful companies', '2016-09-05'),
('Unqualified', 'Anna Faris gives relationship advice', '2015-11-09'),
('The Bill Simmons Podcast', 'Sports and pop culture commentary', '2016-10-03'),
('Making Sense', 'Sam Harris on consciousness and morality', '2013-11-01'),
('Hardcore History', 'Deep dives into historical events', '2006-04-28'),
('Crime Junkie', 'True crime stories told weekly', '2017-12-17'),
('Stuff You Should Know', 'Explaining how things work', '2008-04-01'),
('The Daily', 'News from the New York Times', '2017-01-30'),
('Radiolab', 'Curiosity and wonder about the world', '2002-05-01'),
('My Favorite Murder', 'Comedy meets true crime', '2016-01-13');

-- Insert Episodes for The Joe Rogan Experience (podcast_id = 1)
INSERT INTO episode (episode_num, name, description, duration, release_date, podcast_id) VALUES
(1255, 'Elon Musk Returns', 'Elon discusses Tesla, SpaceX, and more', 165, '2019-05-01', 1),
(1169, 'Elon Musk on AI', 'Conversation about artificial intelligence', 142, '2018-09-07', 1),
(1309, 'Naval Ravikant', 'Entrepreneur discusses wealth and happiness', 120, '2019-06-04', 1),
(1470, 'Elon Musk Round Three', 'Third appearance discussing Neuralink', 135, '2020-05-07', 1),
(1555, 'Neil deGrasse Tyson', 'Astrophysics and the cosmos', 148, '2020-09-08', 1);

-- Insert Episodes for WTF with Marc Maron (podcast_id = 2)
INSERT INTO episode (episode_num, name, description, duration, release_date, podcast_id) VALUES
(613, 'President Barack Obama', 'Historic interview with President Obama', 58, '2015-06-22', 2),
(1051, 'Conan OBrien', 'Comedy legends talk shop', 90, '2019-09-12', 2),
(822, 'Robin Williams Classic', 'Memorable conversation with Robin', 75, '2017-08-14', 2),
(1200, 'Taylor Swift', 'Rare interview with Taylor', 67, '2021-09-07', 2);

-- Insert Episodes for This American Life (podcast_id = 3)
INSERT INTO episode (episode_num, name, description, duration, release_date, podcast_id) VALUES
(1, 'New Beginnings', 'Stories about starting over', 60, '1995-11-17', 3),
(355, 'The Giant Pool of Money', 'The housing crisis explained', 59, '2008-05-09', 3),
(515, 'Good Guys', 'Stories about being good', 58, '2014-02-14', 3),
(680, 'The Test', 'Stories about testing limits', 62, '2019-04-05', 3);

-- Insert Episodes for Serial (podcast_id = 4)
INSERT INTO episode (episode_num, name, description, duration, release_date, podcast_id) VALUES
(1, 'The Alibi', 'Introduction to the Adnan Syed case', 53, '2014-10-03', 4),
(2, 'The Breakup', 'Examining the relationship', 42, '2014-10-03', 4),
(12, 'What We Know', 'Season one conclusion', 38, '2014-12-18', 4);

-- Insert Episodes for Conan Needs A Friend (podcast_id = 5)
INSERT INTO episode (episode_num, name, description, duration, release_date, podcast_id) VALUES
(1, 'Will Ferrell', 'Conan chats with Will Ferrell', 62, '2018-11-18', 5),
(50, 'Michelle Obama', 'Former First Lady opens up', 55, '2019-12-02', 5),
(125, 'Stephen King', 'Horror master tells stories', 68, '2021-09-13', 5),
(180, 'Bill Gates', 'Tech pioneer discusses innovation', 71, '2022-06-20', 5);

-- Insert Episodes for Fresh Air (podcast_id = 6)
INSERT INTO episode (episode_num, name, description, duration, release_date, podcast_id) VALUES
(1, 'Terry Talks Books', 'Discussion of new literature', 45, '1975-01-01', 6),
(5420, 'Yuval Noah Harari', 'Author discusses Sapiens', 40, '2015-02-09', 6),
(6200, 'Malcolm Gladwell', 'The Tipping Point revisited', 38, '2020-11-15', 6);

-- Insert Episodes for 99% Invisible (podcast_id = 7)
INSERT INTO episode (episode_num, name, description, duration, release_date, podcast_id) VALUES
(1, 'Architectural Wonders', 'Unseen design elements', 15, '2010-09-29', 7),
(400, 'Structural Integrity', 'How buildings stay standing', 30, '2020-04-21', 7),
(500, 'Urban Planning', 'City design principles', 28, '2022-01-10', 7);

-- Insert Episodes for Song Exploder (podcast_id = 8)
INSERT INTO episode (episode_num, name, description, duration, release_date, podcast_id) VALUES
(1, 'The Postal Service', 'Such Great Heights breakdown', 18, '2014-01-10', 8),
(200, 'Billie Eilish', 'Bad Guy dissected', 22, '2019-12-04', 8),
(250, 'Fleetwood Mac', 'Dreams analyzed', 20, '2021-08-18', 8);

-- Insert Episodes for Armchair Expert (podcast_id = 9)
INSERT INTO episode (episode_num, name, description, duration, release_date, podcast_id) VALUES
(1, 'Ashton Kutcher', 'First episode with Ashton', 75, '2018-02-14', 9),
(100, 'Brene Brown', 'Vulnerability and courage', 82, '2019-11-04', 9),
(250, 'Oprah Winfrey', 'Life lessons from Oprah', 90, '2021-08-30', 9);

-- Insert Episodes for The Tim Ferriss Show (podcast_id = 10)
INSERT INTO episode (episode_num, name, description, duration, release_date, podcast_id) VALUES
(1, 'Jamie Foxx', 'Actor and musician', 95, '2014-04-08', 10),
(500, 'LeBron James', 'Basketball and business', 88, '2020-12-15', 10),
(600, 'Jane Goodall', 'Conservation and hope', 92, '2022-03-22', 10);

-- Insert Episodes for How I Built This (podcast_id = 11)
INSERT INTO episode (episode_num, name, description, duration, release_date, podcast_id) VALUES
(1, 'Spanx Sara Blakely', 'Building a billion dollar brand', 52, '2016-09-05', 11),
(200, 'Airbnb Brian Chesky', 'From air mattresses to empire', 48, '2020-05-11', 11),
(350, 'Instagram Kevin Systrom', 'Photo sharing revolution', 45, '2022-10-03', 11);

-- Insert Episodes for Unqualified (podcast_id = 12)
INSERT INTO episode (episode_num, name, description, duration, release_date, podcast_id) VALUES
(1, 'Chris Pratt', 'Relationship advice with Chris', 55, '2015-11-09', 12),
(150, 'Gwyneth Paltrow', 'Love and wellness', 60, '2019-03-18', 12);

-- Insert Episodes for The Bill Simmons Podcast (podcast_id = 13)
INSERT INTO episode (episode_num, name, description, duration, release_date, podcast_id) VALUES
(1, 'NBA Season Preview', 'Basketball predictions', 70, '2016-10-03', 13),
(500, 'Super Bowl Recap', 'Football analysis', 65, '2020-02-03', 13),
(800, 'March Madness', 'College basketball breakdown', 68, '2022-03-15', 13);

-- Insert Episodes for Making Sense (podcast_id = 14)
INSERT INTO episode (episode_num, name, description, duration, release_date, podcast_id) VALUES
(1, 'The Nature of Consciousness', 'Philosophy of mind', 85, '2013-11-01', 14),
(250, 'Ethics and AI', 'Artificial intelligence morality', 78, '2020-06-10', 14);

-- Insert Episodes for Hardcore History (podcast_id = 15)
INSERT INTO episode (episode_num, name, description, duration, release_date, podcast_id) VALUES
(1, 'Alexander vs Hitler', 'Comparing conquerors', 240, '2006-04-28', 15),
(50, 'Blueprint for Armageddon I', 'World War I begins', 198, '2013-10-29', 15),
(70, 'Supernova in the East I', 'Japan in WWII', 220, '2018-07-12', 15);

-- Insert Episodes for Crime Junkie (podcast_id = 16)
INSERT INTO episode (episode_num, name, description, duration, release_date, podcast_id) VALUES
(1, 'MURDERED Kacie Woody', 'First case investigation', 35, '2017-12-17', 16),
(150, 'MISSING Asha Degree', 'Mysterious disappearance', 40, '2020-02-24', 16),
(250, 'SERIAL KILLER Israel Keyes', 'Deadly travels', 45, '2021-06-07', 16);

-- Insert Episodes for Stuff You Should Know (podcast_id = 17)
INSERT INTO episode (episode_num, name, description, duration, release_date, podcast_id) VALUES
(1, 'How Spam Works', 'Email and meat', 30, '2008-04-01', 17),
(1500, 'How Bitcoin Works', 'Cryptocurrency explained', 48, '2019-12-10', 17),
(2000, 'How Black Holes Work', 'Space mysteries', 52, '2022-08-15', 17);

-- Insert Episodes for The Daily (podcast_id = 18)
INSERT INTO episode (episode_num, name, description, duration, release_date, podcast_id) VALUES
(1, 'Trump Takes Office', 'Inauguration day coverage', 25, '2017-01-30', 18),
(1000, 'The Pandemic Begins', 'COVID-19 emerges', 28, '2020-03-15', 18),
(1500, 'Afghanistan Withdrawal', 'US leaves Afghanistan', 30, '2021-08-30', 18);

-- Insert Episodes for Radiolab (podcast_id = 19)
INSERT INTO episode (episode_num, name, description, duration, release_date, podcast_id) VALUES
(1, 'Numbers', 'The world of mathematics', 27, '2002-05-01', 19),
(200, 'Colors', 'How we see color', 32, '2012-05-21', 19),
(400, 'CRISPR', 'Gene editing revolution', 35, '2017-06-05', 19);

-- Insert Episodes for My Favorite Murder (podcast_id = 20)
INSERT INTO episode (episode_num, name, description, duration, release_date, podcast_id) VALUES
(1, 'Looking Like A Suspect', 'First murders discussed', 78, '2016-01-13', 20),
(100, 'Live at The Wilbur', 'Boston live show', 85, '2017-10-26', 20),
(250, 'The 2019 Wrap-Up', 'Year in review', 92, '2019-12-19', 20);

-- Insert Playlists
INSERT INTO playlist (user_id, name, description) VALUES
(1, 'Morning Commute', 'Energizing podcasts for my drive'),
(1, 'Weekend Listening', 'Long-form interviews for relaxation'),
(2, 'True Crime Favorites', 'Best crime investigations'),
(3, 'Comedy Gold', 'Funniest episodes ever'),
(5, 'History Lessons', 'Educational historical content'),
(7, 'Science Deep Dives', 'Complex science topics'),
(10, 'Business Inspiration', 'Entrepreneur stories'),
(12, 'Daily News', 'Current events'),
(15, 'Sports Talk', 'All things sports'),
(18, 'Self Growth', 'Personal development'),
(20, 'Evening Relaxation', 'Calming content for nighttime'),
(25, 'Tech Trends', 'Latest technology news'),
(30, 'Mystery Hour', 'Crime and mystery podcasts'),
(35, 'Music Discovery', 'New music and interviews'),
(40, 'Philosophy Hour', 'Deep thinking content');

-- Insert Episode Reviews (50 reviews)
INSERT INTO episode_review (user_id, podcast_id, episode_num, rating, text, created_at) VALUES
(1, 1, 1255, 5, 'Absolutely mind-blowing conversation!', '2019-05-02'),
(2, 4, 1, 5, 'Hooked from the first minute', '2014-10-05'),
(3, 2, 1051, 4, 'Two legends together, great chemistry', '2019-09-15'),
(4, 5, 1, 5, 'Will Ferrell is hilarious as always', '2018-11-20'),
(5, 3, 355, 5, 'Best explanation of the financial crisis', '2008-05-15'),
(1, 4, 2, 4, 'Getting more interesting', '2014-10-10'),
(2, 1, 1169, 5, 'Elon is always fascinating', '2018-09-10'),
(6, 9, 100, 5, 'Brene Brown is incredible', '2019-11-06'),
(7, 10, 500, 5, 'LeBron shares amazing insights', '2020-12-17'),
(8, 16, 1, 4, 'Great start to a great podcast', '2017-12-20'),
(9, 18, 1000, 5, 'Important coverage of the pandemic', '2020-03-17'),
(10, 11, 1, 5, 'Sara Blakely is so inspiring', '2016-09-07'),
(11, 15, 50, 5, 'Dan Carlin is a master storyteller', '2013-11-01'),
(12, 20, 1, 4, 'Perfect mix of comedy and crime', '2016-01-15'),
(13, 13, 500, 5, 'Best Super Bowl analysis', '2020-02-05'),
(14, 19, 400, 5, 'CRISPR explained perfectly', '2017-06-08'),
(15, 17, 1500, 4, 'Finally understand Bitcoin', '2019-12-12'),
(16, 14, 250, 5, 'Important ethical discussion', '2020-06-12'),
(17, 7, 500, 4, 'Makes me appreciate urban design', '2022-01-12'),
(18, 8, 250, 5, 'Dreams is such a perfect song', '2021-08-20'),
(19, 12, 150, 4, 'Gwyneth is surprisingly relatable', '2019-03-20'),
(20, 6, 6200, 5, 'Malcolm never disappoints', '2020-11-17'),
(21, 1, 1555, 5, 'Neil makes science accessible', '2020-09-10'),
(22, 5, 180, 4, 'Bill Gates perspective is valuable', '2022-06-22'),
(23, 3, 680, 5, 'Powerful storytelling', '2019-04-07'),
(24, 2, 1200, 5, 'Taylor opens up like never before', '2021-09-09'),
(25, 11, 200, 5, 'Airbnb story is amazing', '2020-05-13'),
(26, 16, 250, 4, 'Chilling case', '2021-06-09'),
(27, 10, 600, 5, 'Jane Goodall is a hero', '2022-03-24'),
(28, 9, 250, 5, 'Oprah wisdom at its finest', '2021-09-01'),
(29, 15, 70, 5, 'Best history podcast ever', '2018-07-14'),
(30, 20, 100, 4, 'Live shows are always fun', '2017-10-28'),
(31, 18, 1500, 5, 'Critical journalism', '2021-09-01'),
(32, 17, 2000, 4, 'Black holes explained well', '2022-08-17'),
(33, 13, 800, 5, 'March Madness breakdown', '2022-03-17'),
(34, 19, 200, 4, 'Colors are fascinating', '2012-05-23'),
(35, 4, 12, 5, 'Satisfying conclusion', '2014-12-20'),
(36, 7, 400, 4, 'Engineering is art', '2020-04-23'),
(37, 8, 200, 5, 'Billie Eilish is genius', '2019-12-06'),
(38, 14, 1, 4, 'Deep philosophical content', '2013-11-03'),
(39, 12, 1, 3, 'Good start but gets better', '2015-11-11'),
(40, 11, 350, 5, 'Instagram origin story', '2022-10-05'),
(41, 6, 1, 4, 'Classic Terry Gross', '1975-01-15'),
(42, 9, 1, 5, 'Ashton and Dax are great together', '2018-02-16'),
(43, 10, 1, 4, 'Jamie Foxx is talented', '2014-04-10'),
(44, 16, 150, 5, 'Heartbreaking case', '2020-02-26'),
(45, 3, 1, 5, 'Started my podcast journey', '1995-11-20'),
(46, 5, 50, 5, 'Michelle Obama is amazing', '2019-12-04'),
(47, 1, 1309, 5, 'Naval wisdom is pure gold', '2019-06-06'),
(48, 20, 250, 4, 'Year recap was fun', '2019-12-21'),
(49, 18, 1, 5, 'Historic moment captured', '2017-02-01'),
(50, 15, 1, 5, 'Changed how I see history', '2006-05-01');

-- Insert Podcast Reviews (40 reviews)
INSERT INTO podcast_review (user_id, podcast_id, rating, text, created_at) VALUES
(1, 1, 5, 'Best podcast out there, so much variety', '2020-01-15'),
(2, 4, 5, 'Changed how I think about journalism', '2015-03-20'),
(3, 2, 4, 'Marc is a great interviewer', '2019-08-10'),
(4, 5, 5, 'Conan is naturally funny and curious', '2019-06-15'),
(5, 3, 5, 'A masterclass in storytelling', '2018-12-01'),
(1, 6, 4, 'Terry Gross is legendary', '2020-05-22'),
(2, 7, 4, 'Makes me see the world differently', '2021-02-14'),
(6, 9, 5, 'Dax creates a comfortable space', '2019-12-10'),
(7, 10, 5, 'Tim asks the best questions', '2021-03-15'),
(8, 16, 5, 'Best true crime podcast', '2019-07-20'),
(9, 18, 5, 'Essential daily listening', '2020-11-05'),
(10, 11, 5, 'Inspiring entrepreneur stories', '2021-01-18'),
(11, 15, 5, 'Dan Carlin is unmatched', '2019-09-22'),
(12, 20, 4, 'Comedy and crime done right', '2018-05-30'),
(13, 13, 5, 'Best sports commentary', '2020-08-14'),
(14, 19, 5, 'Science storytelling at its best', '2018-11-28'),
(15, 17, 4, 'Learn something every episode', '2020-03-09'),
(16, 14, 5, 'Challenging and thought-provoking', '2021-07-16'),
(17, 8, 5, 'Music lovers must listen', '2020-09-23'),
(18, 12, 3, 'Fun but inconsistent', '2019-04-11'),
(19, 7, 5, 'Design perspective is unique', '2021-11-03'),
(20, 6, 5, 'Terry is the best interviewer', '2019-10-17'),
(21, 1, 5, 'Never miss an episode', '2021-04-22'),
(22, 5, 4, 'Conan brings the laughs', '2020-07-08'),
(23, 3, 5, 'Radio at its finest', '2019-02-28'),
(24, 2, 5, 'Raw and honest conversations', '2021-05-19'),
(25, 11, 5, 'Business inspiration weekly', '2020-12-30'),
(26, 16, 5, 'Crime Junkie is addictive', '2021-08-11'),
(27, 10, 4, 'Great guests and questions', '2021-10-25'),
(28, 9, 5, 'Honest and vulnerable', '2020-06-17'),
(29, 15, 5, 'History comes alive', '2019-03-13'),
(30, 20, 4, 'Murderinos unite', '2020-01-09'),
(31, 18, 5, 'News done right', '2021-12-14'),
(32, 17, 4, 'Educational and fun', '2020-10-21'),
(33, 13, 5, 'Bill knows his stuff', '2021-03-06'),
(34, 19, 5, 'Mind-expanding content', '2019-08-27'),
(35, 4, 5, 'Serial started it all', '2015-01-14'),
(36, 8, 5, 'Musical deconstruction magic', '2021-09-30'),
(37, 14, 4, 'Philosophy for everyone', '2020-11-19'),
(38, 12, 4, 'Celebrity advice is entertaining', '2019-12-02'),
(39, 7, 5, 'Eye-opening design stories', '2021-06-24');

-- Insert User to User (Friendships) - 60 friendships
INSERT INTO user_to_user (id1, id2, date_added, status) VALUES
(1, 2, '2020-01-15', 'accepted'),
(1, 3, '2020-02-20', 'accepted'),
(2, 3, '2020-03-10', 'pending'),
(3, 4, '2020-04-05', 'accepted'),
(4, 5, '2020-05-12', 'accepted'),
(1, 5, '2020-06-18', 'accepted'),
(2, 4, '2020-07-22', 'pending'),
(6, 7, '2020-08-14', 'accepted'),
(7, 8, '2020-09-01', 'accepted'),
(8, 9, '2020-10-03', 'accepted'),
(9, 10, '2020-11-11', 'accepted'),
(10, 11, '2020-12-25', 'accepted'),
(11, 12, '2021-01-08', 'accepted'),
(12, 13, '2021-02-14', 'accepted'),
(13, 14, '2021-03-17', 'pending'),
(14, 15, '2021-04-20', 'accepted'),
(15, 16, '2021-05-05', 'accepted'),
(16, 17, '2021-06-12', 'accepted'),
(17, 18, '2021-07-19', 'pending'),
(18, 19, '2021-08-23', 'accepted'),
(19, 20, '2021-09-30', 'accepted'),
(20, 21, '2021-10-15', 'accepted'),
(21, 22, '2021-11-01', 'accepted'),
(22, 23, '2021-12-08', 'pending'),
(23, 24, '2022-01-14', 'accepted'),
(24, 25, '2022-02-20', 'accepted'),
(25, 26, '2022-03-25', 'accepted'),
(26, 27, '2022-04-10', 'accepted'),
(27, 28, '2022-05-18', 'pending'),
(28, 29, '2022-06-22', 'accepted'),
(29, 30, '2022-07-29', 'accepted'),
(30, 31, '2022-08-15', 'accepted'),
(31, 32, '2022-09-11', 'accepted'),
(32, 33, '2022-10-05', 'pending'),
(33, 34, '2022-11-19', 'accepted'),
(34, 35, '2022-12-01', 'accepted'),
(35, 36, '2023-01-07', 'accepted'),
(36, 37, '2023-02-14', 'accepted'),
(37, 38, '2023-03-20', 'pending'),
(38, 39, '2023-04-25', 'accepted'),
(39, 40, '2023-05-30', 'accepted'),
(40, 41, '2023-06-15', 'accepted'),
(41, 42, '2023-07-22', 'accepted'),
(42, 43, '2023-08-10', 'pending'),
(43, 44, '2023-09-18', 'accepted'),
(44, 45, '2023-10-25', 'accepted'),
(45, 46, '2023-11-12', 'accepted'),
(46, 47, '2023-12-03', 'accepted'),
(47, 48, '2024-01-15', 'pending'),
(48, 49, '2024-02-20', 'accepted'),
(49, 50, '2024-03-28', 'accepted'),
(1, 10, '2024-04-10', 'accepted'),
(5, 15, '2024-05-17', 'accepted'),
(10, 20, '2024-06-24', 'pending'),
(15, 25, '2024-07-30', 'accepted'),
(20, 30, '2024-08-15', 'accepted'),
(25, 35, '2024-09-22', 'accepted'),
(30, 40, '2024-10-18', 'pending'),
(35, 45, '2024-11-05', 'accepted'),
(40, 50, '2024-11-12', 'accepted');

-- Insert Platform to Podcast (each podcast on multiple platforms)
INSERT INTO platform_to_podcast (podcast_id, platform_name) VALUES
(1, 'Spotify'), (1, 'Apple Podcasts'), (1, 'YouTube'),
(2, 'Spotify'), (2, 'Apple Podcasts'),
(3, 'Spotify'), (3, 'Apple Podcasts'), (3, 'Google Podcasts'),
(4, 'Spotify'), (4, 'Apple Podcasts'),
(5, 'Spotify'), (5, 'Apple Podcasts'),
(6, 'Spotify'), (6, 'Apple Podcasts'),
(7, 'Spotify'), (7, 'Apple Podcasts'), (7, 'Stitcher Premium'),
(8, 'Spotify'), (8, 'Apple Podcasts'),
(9, 'Spotify'), (9, 'Apple Podcasts'), (9, 'YouTube'),
(10, 'Spotify'), (10, 'Apple Podcasts'),
(11, 'Spotify'), (11, 'Apple Podcasts'), (11, 'Stitcher Premium'),
(12, 'Spotify'), (12, 'Apple Podcasts'),
(13, 'Spotify'), (13, 'Apple Podcasts'), (13, 'YouTube'),
(14, 'Spotify'), (14, 'Apple Podcasts'), (14, 'Patreon'),
(15, 'Spotify'), (15, 'Apple Podcasts'), (15, 'YouTube'),
(16, 'Spotify'), (16, 'Apple Podcasts'), (16, 'Wondery Plus'),
(17, 'Spotify'), (17, 'Apple Podcasts'), (17, 'Google Podcasts'),
(18, 'Spotify'), (18, 'Apple Podcasts'), (18, 'Google Podcasts'),
(19, 'Spotify'), (19, 'Apple Podcasts'), (19, 'Stitcher Premium'),
(20, 'Spotify'), (20, 'Apple Podcasts'), (20, 'Wondery Plus');

-- Insert Genre to Podcast
INSERT INTO genre_to_podcast (podcast_id, genre_name) VALUES
(1, 'Comedy'), (1, 'Interview'),
(2, 'Comedy'), (2, 'Interview'),
(3, 'News'), (3, 'Education'),
(4, 'True Crime'), (4, 'News'),
(5, 'Comedy'), (5, 'Interview'),
(6, 'Interview'), (6, 'News'),
(7, 'Education'),
(8, 'Education'), (8, 'Music'),
(9, 'Comedy'), (9, 'Interview'),
(10, 'Business'), (10, 'Self-Improvement'), (10, 'Interview'),
(11, 'Business'), (11, 'Education'),
(12, 'Comedy'), (12, 'Interview'),
(13, 'Sports'), (13, 'News'),
(14, 'Education'), (14, 'Politics'),
(15, 'History'), (15, 'Education'),
(16, 'True Crime'),
(17, 'Education'), (17, 'Science'),
(18, 'News'), (18, 'Politics'),
(19, 'Science'), (19, 'Education'),
(20, 'True Crime'), (20, 'Comedy');

-- Insert Episode to Playlist
INSERT INTO episode_to_playlist (user_id, podcast_id, episode_num, playlist_name) VALUES
(1, 1, 1255, 'Morning Commute'),
(1, 2, 1051, 'Weekend Listening'),
(1, 3, 355, 'Weekend Listening'),
(2, 4, 1, 'True Crime Favorites'),
(2, 4, 2, 'True Crime Favorites'),
(2, 16, 1, 'True Crime Favorites'),
(3, 2, 1051, 'Comedy Gold'),
(3, 5, 1, 'Comedy Gold'),
(5, 3, 355, 'History Lessons'),
(5, 6, 5420, 'History Lessons'),
(5, 15, 50, 'History Lessons'),
(7, 19, 400, 'Science Deep Dives'),
(7, 17, 2000, 'Science Deep Dives'),
(10, 11, 1, 'Business Inspiration'),
(10, 11, 200, 'Business Inspiration'),
(10, 10, 500, 'Business Inspiration'),
(12, 18, 1, 'Daily News'),
(12, 18, 1000, 'Daily News'),
(15, 13, 500, 'Sports Talk'),
(15, 13, 800, 'Sports Talk'),
(18, 9, 100, 'Self Growth'),
(18, 10, 600, 'Self Growth'),
(20, 7, 400, 'Evening Relaxation'),
(25, 1, 1555, 'Tech Trends'),
(25, 17, 1500, 'Tech Trends'),
(30, 16, 250, 'Mystery Hour'),
(30, 20, 100, 'Mystery Hour'),
(35, 8, 200, 'Music Discovery'),
(35, 8, 250, 'Music Discovery'),
(40, 14, 1, 'Philosophy Hour');

-- Insert Episode to Host
INSERT INTO episode_to_host (podcast_id, episode_num, host_id) VALUES
(1, 1255, 1), (1, 1169, 1), (1, 1309, 1), (1, 1470, 1), (1, 1555, 1),
(2, 613, 2), (2, 1051, 2), (2, 822, 2), (2, 1200, 2),
(3, 1, 3), (3, 355, 3), (3, 515, 3), (3, 680, 3),
(4, 1, 4), (4, 2, 4), (4, 12, 4),
(5, 1, 5), (5, 50, 5), (5, 125, 5), (5, 180, 5),
(6, 1, 6), (6, 5420, 6), (6, 6200, 6),
(7, 1, 7), (7, 400, 7), (7, 500, 7),
(8, 1, 8), (8, 200, 8), (8, 250, 8),
(9, 1, 9), (9, 100, 9), (9, 250, 9),
(10, 1, 10), (10, 500, 10), (10, 600, 10),
(11, 1, 11), (11, 200, 11), (11, 350, 11),
(12, 1, 12), (12, 150, 12),
(13, 1, 13), (13, 500, 13), (13, 800, 13),
(14, 1, 14), (14, 250, 14),
(15, 1, 15), (15, 50, 15), (15, 70, 15);

-- Insert Episode to Guest
INSERT INTO episode_to_guest (podcast_id, episode_num, guest_id) VALUES
(1, 1255, 1), (1, 1169, 1), (1, 1470, 1), (1, 1555, 3),
(2, 1051, 5), (2, 1200, 12),
(3, 355, 3),
(5, 50, 2), (5, 125, 7), (5, 180, 10),
(6, 5420, 8), (6, 6200, 5),
(9, 100, 4), (9, 250, 9),
(10, 1, 6), (10, 500, 11), (10, 600, 20),
(11, 200, 15),
(12, 1, 17), (12, 150, 18),
(13, 500, 11), (13, 800, 14),
(14, 250, 8),
(15, 50, 3),
(18, 1000, 10),
(19, 400, 3);

-- Insert Language to Podcast
INSERT INTO language_to_podcast (podcast_id, language_name) VALUES
(1, 'English'),
(2, 'English'),
(3, 'English'), (3, 'Spanish'),
(4, 'English'),
(5, 'English'),
(6, 'English'),
(7, 'English'),
(8, 'English'),
(9, 'English'),
(10, 'English'),
(11, 'English'),
(12, 'English'),
(13, 'English'),
(14, 'English'),
(15, 'English'),
(16, 'English'),
(17, 'English'), (17, 'Spanish'),
(18, 'English'),
(19, 'English'),
(20, 'English');