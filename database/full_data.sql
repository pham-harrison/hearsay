USE hearsay_db;

-- Insert Genres
INSERT INTO genre (genre_name, description) VALUES
('Business', 'Entrepreneurship and business strategies'),
('Comedy', 'Humorous and entertaining content'),
('Education', 'Educational and informative content'),
('Gaming', 'Video game news, reviews, and discussions'),
('Health', 'Health, fitness, and wellness topics'),
('History', 'Historical events and stories'),
('Interview', 'Conversational interviews with guests'),
('News', 'Current events and news analysis'),
('Politics', 'Political commentary and analysis'),
('Science', 'Scientific topics and discoveries'),
('Self-Improvement', 'Personal development and growth'),
('Sports', 'Sports news and commentary'),
('Technology', 'Tech news, reviews, and discussions'),
('True Crime', 'Real-life crime stories and investigations');

-- Insert Languages
INSERT INTO language (language_name) VALUES
('English'),
('French'),
('German'),
('Hindi'),
('Italian'),
('Japanese'),
('Korean'),
('Mandarin'),
('Portuguese'),
('Spanish');

-- Insert Platforms
INSERT INTO platform (platform_name, is_subscription_req, subscription_monthly_cost) VALUES
('Spotify', TRUE, 11.99),
('Apple Podcasts', 0, NULL),
('Audible', TRUE, 7.95),
('YouTube', 0, NULL);

-- Insert Hosts
INSERT INTO host (first_name, last_name, bio) VALUES
('Joe', 'Rogan', 'Comedian, podcaster, and UFC commentator'),
('Guy', 'Raz', 'Host of inspiring entrepreneurial and storytelling podcasts'),
('Conan', "O'Brien", 'Comedian and former late-night talk show host'),
('Manoush', 'Zomorodi', 'Journalist exploring technology and culture topics'),
('Daemon', 'Hatfield', 'Video game journalist and reviewer'),
('Jay', 'Shetty', 'Motivational speaker and personal growth coach'),
('Dominic', 'Sandbrook', 'Historian and bestselling author'),
('Michael', 'Barbaro', 'Host of The New York Times Daily podcast'),
('Ira', 'Flatow', 'Science journalist and radio host'),
('Dan', 'Katz', 'Sports analyst and media personality');

INSERT INTO guest (first_name, last_name, bio) VALUES
('Brian', 'Redban', 'Co-founder and early producer of The Joe Rogan Experience'),
('Ari', 'Shaffir', 'Comedian known for stand-up and podcasting'),
('John', 'Heffron', 'Comedian and former Last Comic Standing winner'),
('Sara', 'Blakely', 'Founder of Spanx and self-made entrepreneur'),
('Kevin', 'Systrom', 'Co-founder of Instagram and tech entrepreneur'),
('Mike', 'Kreiger', 'Co-founder of Instagram and software engineer'),
('Cathy', 'Hughes', 'Media entrepreneur and founder of Urban One'),
('Gary', 'Erickson', 'Entrepreneur, founder of Clif Bar'),
('Will', 'Ferrell', 'Actor, comedian, and film producer'),
('Kristen', 'Bell', 'Actress, producer, and advocate'),
('Bill', 'Burr', 'Actor, comedian, and podcast host'),
('Dax', 'Shepard', 'Actor, comedian, and podcast host'),
('Nick', 'Offerman', 'Actor, comedian, and woodworker'),
('Megan', 'Mullally', 'Actress and comedian, known for Will & Grace'),
('Radhi', 'Devlukia', 'Entrepreneur and wellness expert'),
('Russell', 'Brand', 'Comedian, actor, and political commentator'),
('Novak', 'Djokovic', 'Professional tennis player, Grand Slam champion'),
('Mike', 'Posner', 'Singer-songwriter and music producer'),
('Zach', 'Efron', 'Actor and singer in film and television'),
('RJ', 'Hampton', 'Professional basketball player in NBA'),
('Jeff', 'Ross', 'Comedian known for celebrity roasts'),
('Blake', 'Griffin', 'Professional basketball player and sports personality'),
('Manny', 'Pacquiao', 'Professional boxer, politician, and philanthropist');


-- Insert Podcasts
INSERT INTO podcast (name, description, release_date) VALUES
('The Joe Rogan Experience', 'Long-form conversations with diverse, thought-provoking guests', '2009-12-24'),
('How I Built This', 'Entrepreneurs share stories behind building successful companies', '2016-09-12'),
("Conan O'Brien Needs A Friend", 'Conan seeks genuine friendships through funny celebrity interviews', '2018-11-18'),
("TED Radio Hour", 'Ideas and stories inspired by TED talks', "2012-04-27"),
("Game Scoop!", 'Weekly video game news, reviews, and discussions', "2006-07-20"),
("On Purpose with Jay Shetty", 'Insights on mindfulness, purpose, and personal growth', "2019-02-13"),
("The Rest is History", 'Historical events explored with humor and insight', "2020-11-02"),
('The Daily', 'Daily news analysis from The New York Times', '2017-02-01'),
("Science Friday", 'Science news, discoveries, and expert interviews', "1991-10-01"),
("Pardon My Take", 'Humorous sports commentary and interviews with athletes', "2016-02-29");

-- Insert episodes into Joe Rogan
INSERT INTO episode (episode_num, name, description, duration, release_date, podcast_id) VALUES
(1, "Brian Redban", "Joe sits down with Brian Redban", 125, "2009-12-24", 1),
(2, "Brian Redban", "Joe sits down with Brian Redban", 155, "2009-12-29", 1),
(3, "Ari Shaffir", "Joe sits down with Ari Shaffir", 138, "2010-01-06", 1),
(4, "Brian Redban", "Joe sits down with Brian Redban", 128, "2009-01-13", 1),
(5, "John Heffron, Ari Shaffir", "Joe sits down with John Heffron and Ari Shaffir", 143, "2010-01-21", 1);

-- Insert episodes into How I Built This
INSERT INTO episode (episode_num, name, description, duration, release_date, podcast_id) VALUES
(1, "Introducing: How I Built This With Guy Raz", "Guy Raz interviews the world’s best-known entrepreneurs to learn how they built their iconic brands", 117, "2016-09-02", 2),
(2, "Spanx: Sara Blakely", "At 27, Sara Blakely was selling fax machines and desperate to reinvent her life", 26, "2016-09-12", 2),
(3, "Instagram: Kevin Systrom & Mike Kreiger", "Kevin Systrom and Mike Krieger launched their photo-sharing app with a server that crashed every other hour", 28, "2016-09-19", 2),
(4, "Radio One: Cathy Hughes", "As a kid, Cathy Hughes practiced her DJ routine while her siblings banged on the bathroom door", 32, "2016-09-26", 2),
(5, 'Clif Bar: Gary Erickson', '"Gary Erickson asked his mom, "Can you make a cookie without butter, sugar or oil?"', 28, "2016-10-03", 2);

-- Insert episodes into Conan O'Brien Needs a Friend
INSERT INTO episode (episode_num, name, description, duration, release_date, podcast_id) VALUES
(1, "Will Ferrell", "Comedian and actor Will Ferrell feels awkward about being Conan O’Brien’s friend", 47, "2018-11-19", 3),
(2, "Kristen Bell", "Actress Kristen Bell feels supercharged about being Conan O’Brien’s friend!", 49, "2018-11-26", 3),
(3, "Bill Burr", "Comedian Bill Burr feels great about being Conan’s friend", 52, "2018-12-03", 3),
(4, "Dax Shepard", "Actor Dax Shepard feels very optimistic about being Conan O’Brien’s friend", 49, "2018-12-10", 3),
(5, "Nick Offerman and Megan Mullally", "Actors and comedic couple Nick Offerman and Megan Mullally feel ambivalent, yet hopeful about being Conan O’Brien’s friends", 50, "2018-12-17", 3);

-- Insert episodes into TED Radio Hour
INSERT INTO episode (episode_num, name, description, duration, release_date, podcast_id) VALUES
(1, "Peering Into Space", "Gazing up at the night sky is simultaneously humbling and utterly thrilling", 52, "2014-07-03", 4),
(2, "The Hackers", 'Science and technology now allow us to "hack" solutions to the biggest challenges of our time', 51, "2014-07-11", 4),
(3, "Disruptive Leadership", "Is leadership only reserved for the extraordinary few?", 50, "2014-07-25", 4),
(4, "The Violence Within Us", "Violence and brutality are grim realities of life", 50, "2014-08-08", 4),
(5, "Simply Happy", "We all want to find happiness, but it seems elusive", 50, "2014-08-15", 4);

-- Insert episodes into Game Scoop!
INSERT INTO episode (episode_num, name, description, duration, release_date, podcast_id) VALUES
(1, "Comic-Con Wrap-up", "We partied with celebrities, saw Scott Pilgrim, and even made love connections", 71, "2010-07-28", 5),
(2, "Halo, SOCOM, & Castlevania", "Your favorite IGN Editors always have the Scoop! on your favorite games", 59, "2010-07-31", 5),
(3, "Fave Games of the Year", "2010 is only half over and we already have more great games than we know what to do with", 59, "2010-08-06", 5),
(4, "BioShocker", "BioShock Infinite, Rage, Scott Pilgrim, Lara Croft, and hot Japanese girls", 54, "2010-08-14", 5),
(5, "The Best 58 Minutes of Your Life", "Unless you're a ninja. In that case, this will probably be a let down", 60, "2010-08-27", 5);

-- Insert episodes into On Purpose with Jay Shetty
INSERT INTO episode (episode_num, name, description, duration, release_date, podcast_id) VALUES
(1, "Jay Shetty Interviews His Wife for the First Time", "On the first episode of On Purpose, I have an extremely special guest for you", 153, "2019-02-14", 6),
(2, "Russell Brand", "You may think you know Russell Brand - the actor, the comedian, etc... but that’s only a small part of who he truly is", 44, "2019-02-15", 6),
(3, "Novak Djokovic", "Most people, even non-sports fans are inspired by world class athletes like Novak... but why?", 60, "2019-02-18", 6),
(4, "3 Lessons I Learned From My Ex", "Breakups are hard there’s no doubt about that, but sometimes break-ups lead to break-throughs", 28, "2019-02-22", 6),
(5, "Mike Posner", "Mike Posner is the musician behind the hit songs I Took A Pill In Ibiza and Cooler Than Me", 84, "2019-02-25", 6);

-- Insert episodes into The Rest is History
INSERT INTO episode (episode_num, name, description, duration, release_date, podcast_id) VALUES
(1, "Greatness", "How did certain people come to be called 'the Great'?", 30, "2020-11-02", 7),
(2, "Civil War", "What are the conditions needed for a civil war to start?", 36, "2020-11-02", 7),
(3, "Is Trump Caesar or Nixon?", "We ask if Donald Trump is a modern day Caesar, willing to do anything to stay in power?", 36, "2020-11-09", 7),
(4, "We're all so 17th Century", "Plague, pestilence and statue smashing are back in business", 34, "2020-11-09", 7),
(5, "1981", "We look back at the year many Britons consider the worst in living memory", 38, "2020-11-16", 7);

-- Insert episodes into The Daily
INSERT INTO episode (episode_num, name, description, duration, release_date, podcast_id) VALUES
(1, "Wednesday, Feb 1, 2017", "President Trump announced his Supreme Court nominee: Neil M. Gorsuch", 20, "2017-02-01", 8),
(2, "Thursday, Feb 2, 2017", "Who is influencing our new president’s views of Islam and radical Islamic terrorism?", 23, "2017-02-02", 8),
(3, "Friday, Feb 3, 2017", "The biggest story in sports meets the biggest story in politics", 17, "2017-02-03", 8),
(4, "Monday, Feb 6, 2017", "His name is Gary D. Cohn", 20, "2017-02-06", 8),
(5, "Tueday, Feb 7, 2017", "The nomination of Betsy DeVos for Secretary of Education", 20, "2017-02-07", 8);

-- Insert episodes into Science Friday
INSERT INTO episode (episode_num, name, description, duration, release_date, podcast_id) VALUES
(1, "Celebrating '2001: A Space Odyssey' and Whales", "On April 3, 1968, hundreds of audience members walked out of the premier of a sci-fi film", 47, "2018-04-06", 9),
(2, "Levee Wars, New Neurons, Animal Farts", "The mighty Mississippi is shackled and constrained by a series of channels, locks, and levees", 47, "2018-04-07", 9),
(3, "House Science Committee, Superbloom, Snowpack", "There’s been a changing of the guard in the U.S. House of Representative", 48, "2019-03-22", 9),
(4, "How Do Animals Understand Death?", "Throughout history, humans have given a lot of thought to death", 19, "2024-10-24", 9),
(5, "Did Dinosaur Flight Evolve More Than Once?", "The ancient footprints found in South Korea show flight may have evolved in multiple dinosaur lineages", 31, "2024-10-25", 9);

-- Insert episodes into Pardon My Take
INSERT INTO episode (episode_num, name, description, duration, release_date, podcast_id) VALUES
(1, "NBA Finals Live Watch", "We're back in NYC and the NBA Finals are set", 93, "2019-05-28", 10),
(2, "Zac Efron and RJ Hampton", "The Bruins won SCF Game 1 if anyone was still wondering how Tuesday's episode ended", 105, "2019-05-29", 10),
(3, "Comedian Jeff Ross", "NBA Finals Game 1 and Kevin Durant is smiling", 102, "2019-05-31", 10),
(4, "Blake Griffin, NBA Finals", "NBA Finals Game 2 and the Championship Warriors showed up", 95, "2019-06-03", 10),
(5, "Manny Pacquiao", "Kevin Durant is out for Game 3 and Kawhi is the weirdest guy on planet earth", 96, "2019-06-04", 10);

-- Insert Platform to Podcast (each podcast on multiple platforms)
INSERT INTO platform_to_podcast (podcast_id, platform_name) VALUES
(1, 'Spotify'), (1, 'Apple Podcasts'), (1, 'YouTube'), (1, 'Audible'),
(2, 'Spotify'), (2, 'Apple Podcasts'), (2, 'YouTube'), (2, 'Audible'),
(3, 'Spotify'), (3, 'Apple Podcasts'), (3, 'YouTube'), (3, 'Audible'),
(4, 'Spotify'), (4, 'Apple Podcasts'), (4, 'YouTube'), (4, 'Audible'),
(5, 'Spotify'), (5, 'Apple Podcasts'), (5, 'YouTube'), (5, 'Audible'),
(6, 'Spotify'), (6, 'Apple Podcasts'), (6, 'YouTube'), (6, 'Audible'),
(7, 'Spotify'), (7, 'Apple Podcasts'), (7, 'YouTube'), (7, 'Audible'),
(8, 'Spotify'), (8, 'Apple Podcasts'), (8, 'YouTube'), (8, 'Audible'),
(9, 'Spotify'), (9, 'Apple Podcasts'), (9, 'YouTube'), (9, 'Audible'),
(10, 'Spotify'), (10, 'Apple Podcasts'), (10, 'YouTube'), (10, 'Audible');

-- Insert Genre to Podcast
INSERT INTO genre_to_podcast (podcast_id, genre_name) VALUES
(1, 'Comedy'), (1, 'Interview'),
(2, "Business"), (2, "Education"),
(3, "Comedy"), (3, "Interview"),
(4, "Education"), (4, "Technology"),
(5, "Gaming"),
(6, "Health"), (6, "Self-Improvement"),
(7, "History"), (7, "Education"),
(8, "News"), (8, "Interview"),
(9, "Science"), (9, "News"),
(10, "Sports");

-- Insert Episode to Host
INSERT INTO episode_to_host (podcast_id, episode_num, host_id) VALUES
(1, 1, 1), (1, 2, 1), (1, 3, 1), (1, 4, 1), (1, 5, 1),
(2, 1, 2), (2, 2, 2), (2, 3, 2), (2, 4, 2), (2, 5, 2),
(3, 1, 3), (3, 2, 3), (3, 3, 3), (3, 4, 3), (3, 5, 3),
(4, 1, 4), (4, 2, 4), (4, 3, 4), (4, 4, 4), (4, 5, 4),
(5, 1, 5), (5, 2, 5), (5, 3, 5), (5, 4, 5), (5, 5, 5),
(6, 1, 6), (6, 2, 6), (6, 3, 6), (6, 4, 6), (6, 5, 6),
(7, 1, 7), (7, 2, 7), (7, 3, 7), (7, 4, 7), (7, 5, 7),
(8, 1, 8), (8, 2, 8), (8, 3, 8), (8, 4, 8), (8, 5, 8),
(9, 1, 9), (9, 2, 9), (9, 3, 9), (9, 4, 9), (9, 5, 9),
(10, 1, 10), (10, 2, 10), (10, 3, 10), (10, 4, 10), (10, 5, 10);

-- Insert Episode to Guest
INSERT INTO episode_to_guest (podcast_id, episode_num, guest_id) VALUES
(1, 1, 1), (1, 2, 1), (1, 3, 2), (1, 4, 1), (1, 5, 2), (1, 5, 3),
(2, 2, 4), (2, 3, 5), (2, 3, 6), (2, 4, 7), (2, 5, 8),
(3, 1, 9), (3, 2, 10), (3, 3, 11), (3, 4, 12), (3, 5, 13), (3, 5, 14),
(6, 1, 15), (6, 2, 16), (6, 3, 17), (6, 5, 18),
(10, 2, 19), (10, 2, 20), (10, 3, 21), (10, 4, 22), (10, 5, 23);


-- Insert Language to Podcast
INSERT INTO language_to_podcast (podcast_id, language_name) VALUES
(1, 'English'),
(2, 'English'),
(3, 'English'),
(4, 'English'),
(5, 'English'),
(6, 'English'),
(7, 'English'),
(8, 'English'),
(9, 'English'),
(10, 'English');

-- Host
INSERT INTO host (first_name, last_name, bio) VALUES
-- 11
('Nilay', 'Patel', 'Nilay Patel is the co-founder and editor-in-chief of The Verge, a Vox Media tech and culture brand'),
('David', 'Pierce', 'David Pierce is The Verge’s Editor-at-Large'),
-- 12
('Ashley', 'Flowers', 'Host & Producer of Crime Junkie & Full Body Chills, Producer & Guest on CounterClock & Host of It\'s a Wonderful Lie & The Deck'),
('Brit', 'Pawat', 'Host & Producer of Crime Junkie'),
-- 13
('Ira', 'Glass', 'Host, Producer & Editor of This American Life & Host of This American Life Archive'),
-- 14
('Imane', 'Anys', 'Imane Anys is better known by her online alias Pokimane'),
('Lily', 'Ki', 'Lily Ki, better known as LilyPichu, is an American online streamer, voice actress, artist and YouTuber'),
-- 15
('Pete', 'Holmes', 'Pete Holmes, born,  March 30, 1979, is an American comedian, actor, writer, and podcaster known for his affable personality and sharp wit'),
-- 16
('Brady', 'Swenson', 'Brady Swenson is the host of the Citizen Bitcoin podcast'),
-- 17
('Mark', 'Rosewater', 'Mark Rosewater is the head designer for Magic: The Gathering and host of Magic: The Gathering Drive to Work Podcast'),
-- 18
('Andrew', 'Steven', 'Andrew Steven is an award-winning podcaster, producer, and writer'),
-- 19
('Karen', 'Kilgariff', 'Karen Kilgariff is an American writer, comedian, singer, author, actor, television producer'),
('Georgia', 'Hardstark', 'Georgia Miriam Hardstark is an American television host and podcast personality'),
-- 20
('Jack', 'Rhysider', 'Jack Rhysider is a veteran to the security world');

-- Guest
INSERT INTO guest (first_name, last_name, bio) VALUES
--    11
-- 24
('Allison', 'Johnson', 'Allison Johnson is a senior reviewer with over a decade of experience writing about consumer tech'), -- p 11 ep 960
-- 25
('Victoria', 'Song', 'Victoria Song reviews all things wearables and fitness tech for The Verge'), -- p 11 ep 960

-- 36
('Thomas', 'Paul Mann', 'Thomas Paul Mann is the co-founder and CEO of Raycast'), -- p 11 ep 959

-- 26
('Nick', 'Thompson', 'Nick Thompson is the CEO of The Atlantic, and Author of "The Running Ground"'), -- p 11 ep 958


--    13
-- 27
('Mike', 'Birbiglia', 'Mike Birbiglia is an American stand-up comedian, actor, writer, and director'), -- p13 ep 5

--    15
-- 28
('Kumail', 'Nanjiani', 'Kumail Nanjiani is a Pakistani-American actor, comedian, and writer known for his sharp wit and diverse talent'),
-- 29
('TJ', 'Miller', 'Todd Joseph "TJ" Miller is an American actor and comedian'),
-- 30
('Demetri', 'Martin', 'Demitri Martin is an American comedian, actor, and writer'),
-- 31
('Dave', 'Coulier', 'David Coulier is an American stand-up comedian, actor, voice actor'),
-- 32
('Chelsea', 'Peretti', 'Chelsea Peretti is an American comedian, actress, and writer'),

--   17
-- 33
('Matt', 'Cavotta', 'Matt Cavotta is an American artist and writer'),
--   18
-- 34
('Dan', 'Harmon', 'Daniel James Harmon is an American television writer, producer, animator, and actor'),
-- 35
('Rainn', 'Wilson', 'Rainn Percival Dietrich Wilson is an Emmy-nominated actor, comedian, writer, producer, director, and podcaster');

-- Podcast
INSERT INTO podcast (name, description, release_date) VALUES
-- 11
('The Vergecast', 'The Vergecast is the flagship podcast from The Verge about small gadgets, Big Tech, and everything in between.', '2014-01-01'),
-- 12
('Crime Junkie', 'Dive into your next mystery with Crime Junkie', '2017-12-18'),
-- 13
('This American Life', 'A weekly Society and Culture podcast featuring Ira Glass', '2001-01-05'),
-- 14
('Sweet n Sour Podcast', 'A weekly podcast created and hosted by pokimane and lilypichu', '2024-09-13'),
-- 15
('You Made It Weird with Pete Holmes', 'Everybody has secret weirdness, Pete Holmes gets comedians to share theirs', '2011-10-25'),
-- 16
('Citizen Bitcoin', 'Podcasting the dawn of the Bitcoin Renaissance', '2018-02-18'),
-- 17
('Magic: The Gathering Drive to Work Podcast', 'Join Magic: The Gathering Head Designer Mark Rosewater as he shares stories, insights, and more while driving to work', '2012-10-01'),
-- 18
('The History of Standup', 'Comedian and professor Wayne Federman has spent his life studying the art and history of standup comedy', '2015-10-26'),
-- 19
('My Favorite Murder', 'My Favorite Murder is a true crime comedy podcast hosted by Karen Kilgariff and Georgia Hardstark', '2025-09-22'),
-- 20
('Darknet Diaries', 'Explore true stories of the dark side of the Internet with host Jack Rhysider', '2017-09-01');

-- Episode
INSERT INTO episode (episode_num, name, description, duration, release_date, podcast_id) VALUES
-- 11 (The Vergecast)
(960, 'Apple gadgets, ranked', 
'Apple makes a lot of gadgets. You\'ve probably heard of some of them. Most of them are very good!',
 80, '2025-12-02', 11),
(959, 'I just want AI to rename my photos', 
'Raycast is an unusual app with an unusual amount of access: it\'s a launcher and application platform that can directly interact with all the files and apps on your computer.', 
63, '2025-11-30', 11),
(958, 'The geek\'s guide to running faster', 
'It\'s a holiday week for many of us, which means a lot of Turkey Trots and a lot of TV.',
77, '2025-11-25', 11),
(957, 'Version History: Vine', 
'Vine was the original short-form video platform, and pioneered so many of the ideas we now take for granted in reels and TikToks.', 
81, '2025-11-23', 11),
(956, 'AI agents are invading your PC', 
'Like it or not, you may not be able to avoid the AI agents for long.', 
97, '2025-11-21', 11);

INSERT INTO episode (episode_num, name, description, duration, release_date, podcast_id) VALUES
-- 12
(1, 'MISSING: Niqui McCown', 
'The story of an Indiana woman who disappears from a laundry mat only weeks before her wedding',
30, '2017-12-18', 12),
(2, 'MURDERED: Laci Peterson Part 1', 
'In part one we cover Laci’s disappearance and the suspicion that fell on her husband Scott Peterson',
45, '2017-12-18', 12),
(3, 'MURDERED: Laci Peterson Part 2', 
'In part two, we discuss the continued focus on Scott as a suspect in the disappearance and murder of his wife, Laci',
33, '2017-12-25', 12),
(4, 'SERIAL KILLER: The West Mesa Serial Killer', 
'Happy New Year! For our first episode of 2018, we outline the still-unsolved murders of the West Mesa Serial Killer',
34, '2018-01-01', 12),
(5, 'WANTED: Robert Fisher', 
'Robert William Fisher is an American fugitive wanted for the murder of his wife and two children',
44, '2018-01-08', 12);

INSERT INTO episode (episode_num, name, description, duration, release_date, podcast_id) VALUES
-- 13
(1, 'Babysitting',
'What goes on while mom and dad are away, that mom and dad never find out about',
61, '2001-01-05', 13),
(2, 'Switched at Birth',
'On a summer day in 1951, two baby girls were born in a hospital in small-town Wisconsin',
60, '2008-07-25', 13),
(3, 'Fiasco! (2013)',
'Stories of when things go wrong',
57, '2013-11-03', 13),
(4, '552: Need To Know Basis',
'Even when you\'re not trying to get one over on someone, it can be useful to keep the truth to yourself',
64, '2015-05-28', 13),
(5, '01 - Error at First Base',
'Ira Glass and Mike Birbiglia introduce Do Listen Twice',
17, '2016-11-04', 13);

INSERT INTO episode (episode_num, name, description, duration, release_date, podcast_id) VALUES
-- 14
(1, 'starting another Podcast with LILY!!',
'yipeee. Lily and Poki talk about well lots of things including why they started a new podcast',
 84, '2024-09-13', 14),
(2, 'Unhinged fan stories, nexon cash, & controversies',
'crazy fan interactions, Lily\'s sf6 struggle, nexon cash, and controversies',
 59, '2024-09-21', 14),
(3, 'unhinged poki, dating stories, more yapping',
'more yappings, this one is unhinged',
 79, '2024-09-28', 14),
(4, 'Ratatouille is Pixar\'s Magnum Opus, urinals, and michael reeves',
'A very yapping podcast about what not to do in the urinal and how',
 77, '2024-10-05', 14),
(5, 'our first BIG fight and lily gets injured',
'Lily gets injured on video ... not clickbait',
 71, '2024-10-12', 14);
 
 INSERT INTO episode (episode_num, name, description, duration, release_date, podcast_id) VALUES
-- 15
(1 , 'Kumail Nanjiani',
'There\'s plenty weird about my hilarious friend Kumail Nanjiani',
 60, '2011-10-25', 15),
(2 , 'TJ Miller',
'It gets REAL weird with my longtime friend/movie star/rapper/weirdo T.J. Miller',
 74, '2011-10-27', 15),
(3 , 'Demetri Martin',
'Demetri and I get weird talking about how God is a bouncing ball',
 90, '2011-11-01', 15),
(4 , 'Dave Coulier',
'BONUS EPISODE! What\'s weirder than a long talk with Dave Coulier?',
 81, '2011-11-03', 15),
(5 , 'Chelsea Peretti',
'What\'s weirder than offending Pete\'s good friend Chelsea?',
74 , '2011-11-08', 15);

INSERT INTO episode (episode_num, name, description, duration, release_date, podcast_id) VALUES  
-- 16
(1 , 'Mining Bullish, Bitcoin Dinosaurs, Lightning Network',
'Tommy and Brady discuss bitcoin news from the past week',
29 , '2018-02-18', 16),
(2 , 'Energy Usage, Time Preference, Petro and Telegram',
'Tommy and Brady discuss Bitcoin\'s energy usage',
 27, '2018-02-18', 16),
(3 , 'Bitcoin is Ridiculous and The Bullish Case for Bitcoin',
'Tommy and Brady discuss two opposing articles about bitcoin',
 33, '2018-02-18', 16),
(4 , 'The Bitcoin Standard, Bitcoin Scaling, Sidechains',
'Tommy and Brady discuss tweets that caught our attention this week',
 40, '2018-02-18', 16),
(5 , 'Basis and Stable Coins, Hodl Waves, Global Fiat Debt Record',
'Tommy and Brady discuss Basis\' critique of Bitcoin',
 29, '2018-02-18', 16);
 
 INSERT INTO episode (episode_num, name, description, duration, release_date, podcast_id) VALUES
-- 17
(1 , 'Drive to Work #1 - Tempest',
'In his very first podcast, Maro talks about leading his very first design, Tempest',
28 , '2012-10-01', 17),
(2 , 'Drive to Work #2 - Zendikar',
'Maro explains how his idea for a "land set" turned into one of the best selling sets of all time',
31 , '2012-10-08', 17),
(3 , 'Drive to Work #3 - Planeswalkers',
'Maro carpools with Matt Cavotta as the two talk about how the planeswalker card type came to be',
31 , '2012-10-15', 17),
(4 , 'Drive to Work #4 - Invasion',
'Mark Rosewater talks about the Invasion set',
29 , '2012-10-15', 17),
(5 , 'Drive to Work #5 - Ravnica',
'Mark Rosewater talks about the Ravnica set',
27 , '2012-10-15', 17);

INSERT INTO episode (episode_num, name, description, duration, release_date, podcast_id) VALUES
-- 18
(1 , 'Pilot',
'It\'s the Pilot episode of The Seeso Seeshow',
8 , '2015-10-26', 18),
(2 , 'Saturday Night Live Stories',
'For the better part of 40 years, Saturday Night Live have been a staple of comedy',
27 , '2015-11-02', 18),
(3 , 'Stand Up Special',
'They say if you have to explain a joke, you\'ve ruined it',
31 , '2015-11-09', 18),
(4 , 'How To Write A Story with Dan Harmon',
'This week Dan Harmon (Community, Rick & Morty, and HarmonQuest) takes us on a journey',
35 , '2015-11-16', 18),
(5 , 'The Office Theme Song',
'What goes in to choosing a theme song?',
19 , '2015-11-23', 18);

INSERT INTO episode (episode_num, name, description, duration, release_date, podcast_id) VALUES
-- 19
(1 , 'MFM Minisode',
'This week’s hometowns include a sorority stalker and unhinged team-building questions',
30 , '2025-09-22', 19),
(2 , 'First Live Show in 6 Years',
'Karen and Georgia are back on tour!',
 120, '2025-09-24', 19),
(3 , 'Rewind with Karen & Georgia',
'It\'s time to Rewind with Karen & Georgia',
 80, '2025-09-25', 19),
(4 , 'Knot for Naught',
'On today’s 500th (!!) episode, Karen covers the Lost Women of Highway 20',
84 , '2025-09-29', 19),
(5 , 'MFM Minisode 456',
'This week’s hometowns include the shadow figures of Davis and an apartment squatter',
22 , '2025-10-01', 19);

INSERT INTO episode (episode_num, name, description, duration, release_date, podcast_id) VALUES
-- 20
 (1 , 'The Phreaky World of PBX Hacking',
'Farhan Arshad and Noor Aziz Uddin were captured 2 years after being placed on the FBI\'s Cyber\'s Most Wanted list for PBX hacking',
14 , '2017-09-01', 20),
(2 , 'The Peculiar Case of the VTech Hacker',
'VTech makes toy tablets, laptops, and watches for kids. In 2015, they were breached',
 23, '2017-09-01', 20),
(3 , 'DigiNotar, You are the Weakest Link, Good Bye!',
'The 2011 DigiNotar breach changed the way browsers do security',
 25, '2017-09-01', 20),
(4 , 'Panic! at the TalkTalk Board Room',
'Mobile provider TalkTalk suffered a major breach in 2015',
 38, '2017-09-01', 20),
(5 , '#ASUSGATE',
'Security researcher Kyle Lovett bought a new Asus router in 2013',
 25, '2017-09-01', 20);

-- Episode to host
INSERT INTO episode_to_host (podcast_id, episode_num, host_id) VALUES
-- 11
(11, 960, 11), (11, 960, 12), 
(11, 959, 11), (11, 959, 12),
(11, 958, 11), (11, 958, 12),
(11, 957, 11), (11, 957, 12),
(11, 956, 11), (11, 956, 12);

INSERT INTO episode_to_host (podcast_id, episode_num, host_id) VALUES
-- 12
(12, 1, 13), (12, 1, 14),
(12, 2, 13), (12, 2, 14),
(12, 3, 13), (12, 3, 14),
(12, 4, 13), (12, 4, 14),
(12, 5, 13), (12, 5, 14);

INSERT INTO episode_to_host (podcast_id, episode_num, host_id) VALUES
-- 13
(13, 1, 15), (13, 2, 15), (13, 3, 15), (13, 4, 15), (13, 5, 15);

INSERT INTO episode_to_host (podcast_id, episode_num, host_id) VALUES
-- 14
(14, 1, 16), (14, 2, 16),(14, 3, 16),(14, 4, 16),(14, 5, 16),
(14, 1, 17), (14, 2, 17),(14, 3, 17),(14, 4, 17),(14, 5, 17);

INSERT INTO episode_to_host (podcast_id, episode_num, host_id) VALUES
-- 15
(15, 1, 18), (15, 2, 18), (15, 3, 18), (15, 4, 18), (15, 5, 18);

INSERT INTO episode_to_host (podcast_id, episode_num, host_id) VALUES
-- 16
(16, 1, 19), (16, 2, 19), (16, 3, 19), (16, 4, 19), (16, 5, 19);

INSERT INTO episode_to_host (podcast_id, episode_num, host_id) VALUES
-- 17
(17, 1, 20), (17, 2, 20), (17, 3, 20), (17, 4, 20), (17, 5, 20);

INSERT INTO episode_to_host (podcast_id, episode_num, host_id) VALUES
-- 18
(18, 1, 21), (18, 2, 21), (18, 3, 21), (18, 4, 21), (18, 5, 21);

INSERT INTO episode_to_host (podcast_id, episode_num, host_id) VALUES
-- 19
(19, 1, 22), (19, 2, 22), (19, 3, 22), (19, 4, 22), (19, 5, 22), 
(19, 1, 23), (19, 2, 23), (19, 3, 23), (19, 4, 23), (19, 5, 23);

INSERT INTO episode_to_host (podcast_id, episode_num, host_id) VALUES
-- 20
(20, 1, 24), (20, 2, 24), (20, 3, 24), (20, 4, 24), (20, 5, 24);


-- Episode to guest
INSERT INTO episode_to_guest (podcast_id, episode_num, guest_id) VALUES
-- 11
(11, 960, 24), (11, 960, 25), (11, 959, 26), (11, 958, 36),
-- 13
(13, 5, 27),
-- 15
(15, 1, 28), (15, 2, 29), (15, 3, 30), (15, 4, 31), (15, 5, 32),
-- 17
(17, 3, 33),
-- 18
(18, 4, 34), (18, 5, 35);
 
-- Platform to podcast
INSERT INTO platform_to_podcast (podcast_id, platform_name) VALUES
-- 11
(11, 'Spotify'), (11, 'YouTube'), (11, 'Apple Podcasts'), (11, 'Audible'),
-- 12
(12, 'Spotify'), (12, 'YouTube'), (12, 'Apple Podcasts'), (12, 'Audible'),
-- 13
(13, 'Spotify'), (13, 'YouTube'), (13, 'Apple Podcasts'), (13, 'Audible'),
-- 14
(14, 'Spotify'), (14, 'YouTube'), (14, 'Apple Podcasts'),
-- 15
(15, 'Spotify'), (15, 'YouTube'), (15, 'Apple Podcasts'), (15, 'Audible'),
-- 16
(16, 'Spotify'), (16, 'Apple Podcasts'),
-- 17
(17, 'Spotify'), (17, 'YouTube'), (17, 'Apple Podcasts'), (17, 'Audible'),
-- 18
(18, 'Spotify'), (18, 'YouTube'), (18, 'Apple Podcasts'), (18, 'Audible'),
-- 19
(19, 'Spotify'), (19, 'YouTube'), (19, 'Apple Podcasts'), (19, 'Audible'),
-- 20
(20, 'Spotify'), (20, 'YouTube'), (20, 'Apple Podcasts'), (20, 'Audible');

-- Genre to podcast
INSERT INTO genre_to_podcast (podcast_id, genre_name) VALUES
-- 11
(11, 'News'), (11, 'Technology'),
-- 12
(12, 'True Crime'),
-- 13
(13, 'News'), (13, 'History'),
-- 14
(14, 'Comedy'),
-- 15
(15, 'Comedy'), (15, 'Self-Improvement'), (15 , 'Health'),
-- 16
(16, 'Business'), (16, 'Technology'), (16, 'Education'),
-- 17
(17, 'Gaming'),
-- 18
(18, 'Comedy'), (18, 'History'),
-- 19
(19, 'Technology'),
-- 20
 (20, 'Technology'), (20, 'Science');
-- Insert Language to Podcast
INSERT INTO language_to_podcast (podcast_id, language_name) VALUES
-- 11
(11, 'English'),
-- 12
(12, 'English'),
-- 13
(13, 'English'),
-- 14
(14, 'English'),
-- 15
(15, 'English'),
-- 16
(16, 'English'),
-- 17
(17, 'English'),
-- 18
(18, 'English'),
-- 19
(19, 'English'),
-- 20
(20, 'English');