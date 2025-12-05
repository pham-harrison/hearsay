CREATE DATABASE  IF NOT EXISTS `hearsay_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `hearsay_db`;
-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: hearsay_db
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `episode`
--

DROP TABLE IF EXISTS `episode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `episode` (
  `episode_num` int NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `duration` int NOT NULL,
  `release_date` date NOT NULL,
  `podcast_id` int NOT NULL,
  PRIMARY KEY (`podcast_id`,`episode_num`),
  CONSTRAINT `episode_ibfk_1` FOREIGN KEY (`podcast_id`) REFERENCES `podcast` (`podcast_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `episode`
--

LOCK TABLES `episode` WRITE;
/*!40000 ALTER TABLE `episode` DISABLE KEYS */;
INSERT INTO `episode` VALUES (1,'Brian Redban','Joe sits down with Brian Redban',125,'2009-12-24',1),(2,'Brian Redban','Joe sits down with Brian Redban',155,'2009-12-29',1),(3,'Ari Shaffir','Joe sits down with Ari Shaffir',138,'2010-01-06',1),(4,'Brian Redban','Joe sits down with Brian Redban',128,'2009-01-13',1),(5,'John Heffron, Ari Shaffir','Joe sits down with John Heffron and Ari Shaffir',143,'2010-01-21',1),(1,'Introducing: How I Built This With Guy Raz','Guy Raz interviews the world’s best-known entrepreneurs to learn how they built their iconic brands',117,'2016-09-02',2),(2,'Spanx: Sara Blakely','At 27, Sara Blakely was selling fax machines and desperate to reinvent her life',26,'2016-09-12',2),(3,'Instagram: Kevin Systrom & Mike Kreiger','Kevin Systrom and Mike Krieger launched their photo-sharing app with a server that crashed every other hour',28,'2016-09-19',2),(4,'Radio One: Cathy Hughes','As a kid, Cathy Hughes practiced her DJ routine while her siblings banged on the bathroom door',32,'2016-09-26',2),(5,'Clif Bar: Gary Erickson','\"Gary Erickson asked his mom, \"Can you make a cookie without butter, sugar or oil?\"',28,'2016-10-03',2),(1,'Will Ferrell','Comedian and actor Will Ferrell feels awkward about being Conan O’Brien’s friend',47,'2018-11-19',3),(2,'Kristen Bell','Actress Kristen Bell feels supercharged about being Conan O’Brien’s friend!',49,'2018-11-26',3),(3,'Bill Burr','Comedian Bill Burr feels great about being Conan’s friend',52,'2018-12-03',3),(4,'Dax Shepard','Actor Dax Shepard feels very optimistic about being Conan O’Brien’s friend',49,'2018-12-10',3),(5,'Nick Offerman and Megan Mullally','Actors and comedic couple Nick Offerman and Megan Mullally feel ambivalent, yet hopeful about being Conan O’Brien’s friends',50,'2018-12-17',3),(1,'Peering Into Space','Gazing up at the night sky is simultaneously humbling and utterly thrilling',52,'2014-07-03',4),(2,'The Hackers','Science and technology now allow us to \"hack\" solutions to the biggest challenges of our time',51,'2014-07-11',4),(3,'Disruptive Leadership','Is leadership only reserved for the extraordinary few?',50,'2014-07-25',4),(4,'The Violence Within Us','Violence and brutality are grim realities of life',50,'2014-08-08',4),(5,'Simply Happy','We all want to find happiness, but it seems elusive',50,'2014-08-15',4),(1,'Comic-Con Wrap-up','We partied with celebrities, saw Scott Pilgrim, and even made love connections',71,'2010-07-28',5),(2,'Halo, SOCOM, & Castlevania','Your favorite IGN Editors always have the Scoop! on your favorite games',59,'2010-07-31',5),(3,'Fave Games of the Year','2010 is only half over and we already have more great games than we know what to do with',59,'2010-08-06',5),(4,'BioShocker','BioShock Infinite, Rage, Scott Pilgrim, Lara Croft, and hot Japanese girls',54,'2010-08-14',5),(5,'The Best 58 Minutes of Your Life','Unless you\'re a ninja. In that case, this will probably be a let down',60,'2010-08-27',5),(1,'Jay Shetty Interviews His Wife for the First Time','On the first episode of On Purpose, I have an extremely special guest for you',153,'2019-02-14',6),(2,'Russell Brand','You may think you know Russell Brand - the actor, the comedian, etc... but that’s only a small part of who he truly is',44,'2019-02-15',6),(3,'Novak Djokovic','Most people, even non-sports fans are inspired by world class athletes like Novak... but why?',60,'2019-02-18',6),(4,'3 Lessons I Learned From My Ex','Breakups are hard there’s no doubt about that, but sometimes break-ups lead to break-throughs',28,'2019-02-22',6),(5,'Mike Posner','Mike Posner is the musician behind the hit songs I Took A Pill In Ibiza and Cooler Than Me',84,'2019-02-25',6),(1,'Greatness','How did certain people come to be called \'the Great\'?',30,'2020-11-02',7),(2,'Civil War','What are the conditions needed for a civil war to start?',36,'2020-11-02',7),(3,'Is Trump Caesar or Nixon?','We ask if Donald Trump is a modern day Caesar, willing to do anything to stay in power?',36,'2020-11-09',7),(4,'We\'re all so 17th Century','Plague, pestilence and statue smashing are back in business',34,'2020-11-09',7),(5,'1981','We look back at the year many Britons consider the worst in living memory',38,'2020-11-16',7),(1,'Wednesday, Feb 1, 2017','President Trump announced his Supreme Court nominee: Neil M. Gorsuch',20,'2017-02-01',8),(2,'Thursday, Feb 2, 2017','Who is influencing our new president’s views of Islam and radical Islamic terrorism?',23,'2017-02-02',8),(3,'Friday, Feb 3, 2017','The biggest story in sports meets the biggest story in politics',17,'2017-02-03',8),(4,'Monday, Feb 6, 2017','His name is Gary D. Cohn',20,'2017-02-06',8),(5,'Tueday, Feb 7, 2017','The nomination of Betsy DeVos for Secretary of Education',20,'2017-02-07',8),(1,'Celebrating \'2001: A Space Odyssey\' and Whales','On April 3, 1968, hundreds of audience members walked out of the premier of a sci-fi film',47,'2018-04-06',9),(2,'Levee Wars, New Neurons, Animal Farts','The mighty Mississippi is shackled and constrained by a series of channels, locks, and levees',47,'2018-04-07',9),(3,'House Science Committee, Superbloom, Snowpack','There’s been a changing of the guard in the U.S. House of Representative',48,'2019-03-22',9),(4,'How Do Animals Understand Death?','Throughout history, humans have given a lot of thought to death',19,'2024-10-24',9),(5,'Did Dinosaur Flight Evolve More Than Once?','The ancient footprints found in South Korea show flight may have evolved in multiple dinosaur lineages',31,'2024-10-25',9),(1,'NBA Finals Live Watch','We\'re back in NYC and the NBA Finals are set',93,'2019-05-28',10),(2,'Zac Efron and RJ Hampton','The Bruins won SCF Game 1 if anyone was still wondering how Tuesday\'s episode ended',105,'2019-05-29',10),(3,'Comedian Jeff Ross','NBA Finals Game 1 and Kevin Durant is smiling',102,'2019-05-31',10),(4,'Blake Griffin, NBA Finals','NBA Finals Game 2 and the Championship Warriors showed up',95,'2019-06-03',10),(5,'Manny Pacquiao','Kevin Durant is out for Game 3 and Kawhi is the weirdest guy on planet earth',96,'2019-06-04',10),(956,'AI agents are invading your PC','Like it or not, you may not be able to avoid the AI agents for long.',97,'2025-11-21',11),(957,'Version History: Vine','Vine was the original short-form video platform, and pioneered so many of the ideas we now take for granted in reels and TikToks.',81,'2025-11-23',11),(958,'The geek\'s guide to running faster','It\'s a holiday week for many of us, which means a lot of Turkey Trots and a lot of TV.',77,'2025-11-25',11),(959,'I just want AI to rename my photos','Raycast is an unusual app with an unusual amount of access: it\'s a launcher and application platform that can directly interact with all the files and apps on your computer.',63,'2025-11-30',11),(960,'Apple gadgets, ranked','Apple makes a lot of gadgets. You\'ve probably heard of some of them. Most of them are very good!',80,'2025-12-02',11),(1,'MISSING: Niqui McCown','The story of an Indiana woman who disappears from a laundry mat only weeks before her wedding',30,'2017-12-18',12),(2,'MURDERED: Laci Peterson Part 1','In part one we cover Laci’s disappearance and the suspicion that fell on her husband Scott Peterson',45,'2017-12-18',12),(3,'MURDERED: Laci Peterson Part 2','In part two, we discuss the continued focus on Scott as a suspect in the disappearance and murder of his wife, Laci',33,'2017-12-25',12),(4,'SERIAL KILLER: The West Mesa Serial Killer','Happy New Year! For our first episode of 2018, we outline the still-unsolved murders of the West Mesa Serial Killer',34,'2018-01-01',12),(5,'WANTED: Robert Fisher','Robert William Fisher is an American fugitive wanted for the murder of his wife and two children',44,'2018-01-08',12),(1,'Babysitting','What goes on while mom and dad are away, that mom and dad never find out about',61,'2001-01-05',13),(2,'Switched at Birth','On a summer day in 1951, two baby girls were born in a hospital in small-town Wisconsin',60,'2008-07-25',13),(3,'Fiasco! (2013)','Stories of when things go wrong',57,'2013-11-03',13),(4,'552: Need To Know Basis','Even when you\'re not trying to get one over on someone, it can be useful to keep the truth to yourself',64,'2015-05-28',13),(5,'01 - Error at First Base','Ira Glass and Mike Birbiglia introduce Do Listen Twice',17,'2016-11-04',13),(1,'starting another Podcast with LILY!!','yipeee. Lily and Poki talk about well lots of things including why they started a new podcast',84,'2024-09-13',14),(2,'Unhinged fan stories, nexon cash, & controversies','crazy fan interactions, Lily\'s sf6 struggle, nexon cash, and controversies',59,'2024-09-21',14),(3,'unhinged poki, dating stories, more yapping','more yappings, this one is unhinged',79,'2024-09-28',14),(4,'Ratatouille is Pixar\'s Magnum Opus, urinals, and michael reeves','A very yapping podcast about what not to do in the urinal and how',77,'2024-10-05',14),(5,'our first BIG fight and lily gets injured','Lily gets injured on video ... not clickbait',71,'2024-10-12',14),(1,'Kumail Nanjiani','There\'s plenty weird about my hilarious friend Kumail Nanjiani',60,'2011-10-25',15),(2,'TJ Miller','It gets REAL weird with my longtime friend/movie star/rapper/weirdo T.J. Miller',74,'2011-10-27',15),(3,'Demetri Martin','Demetri and I get weird talking about how God is a bouncing ball',90,'2011-11-01',15),(4,'Dave Coulier','BONUS EPISODE! What\'s weirder than a long talk with Dave Coulier?',81,'2011-11-03',15),(5,'Chelsea Peretti','What\'s weirder than offending Pete\'s good friend Chelsea?',74,'2011-11-08',15),(1,'Mining Bullish, Bitcoin Dinosaurs, Lightning Network','Tommy and Brady discuss bitcoin news from the past week',29,'2018-02-18',16),(2,'Energy Usage, Time Preference, Petro and Telegram','Tommy and Brady discuss Bitcoin\'s energy usage',27,'2018-02-18',16),(3,'Bitcoin is Ridiculous and The Bullish Case for Bitcoin','Tommy and Brady discuss two opposing articles about bitcoin',33,'2018-02-18',16),(4,'The Bitcoin Standard, Bitcoin Scaling, Sidechains','Tommy and Brady discuss tweets that caught our attention this week',40,'2018-02-18',16),(5,'Basis and Stable Coins, Hodl Waves, Global Fiat Debt Record','Tommy and Brady discuss Basis\' critique of Bitcoin',29,'2018-02-18',16),(1,'Drive to Work #1 - Tempest','In his very first podcast, Maro talks about leading his very first design, Tempest',28,'2012-10-01',17),(2,'Drive to Work #2 - Zendikar','Maro explains how his idea for a \"land set\" turned into one of the best selling sets of all time',31,'2012-10-08',17),(3,'Drive to Work #3 - Planeswalkers','Maro carpools with Matt Cavotta as the two talk about how the planeswalker card type came to be',31,'2012-10-15',17),(4,'Drive to Work #4 - Invasion','Mark Rosewater talks about the Invasion set',29,'2012-10-15',17),(5,'Drive to Work #5 - Ravnica','Mark Rosewater talks about the Ravnica set',27,'2012-10-15',17),(1,'Pilot','It\'s the Pilot episode of The Seeso Seeshow',8,'2015-10-26',18),(2,'Saturday Night Live Stories','For the better part of 40 years, Saturday Night Live have been a staple of comedy',27,'2015-11-02',18),(3,'Stand Up Special','They say if you have to explain a joke, you\'ve ruined it',31,'2015-11-09',18),(4,'How To Write A Story with Dan Harmon','This week Dan Harmon (Community, Rick & Morty, and HarmonQuest) takes us on a journey',35,'2015-11-16',18),(5,'The Office Theme Song','What goes in to choosing a theme song?',19,'2015-11-23',18),(1,'MFM Minisode','This week’s hometowns include a sorority stalker and unhinged team-building questions',30,'2025-09-22',19),(2,'First Live Show in 6 Years','Karen and Georgia are back on tour!',120,'2025-09-24',19),(3,'Rewind with Karen & Georgia','It\'s time to Rewind with Karen & Georgia',80,'2025-09-25',19),(4,'Knot for Naught','On today’s 500th (!!) episode, Karen covers the Lost Women of Highway 20',84,'2025-09-29',19),(5,'MFM Minisode 456','This week’s hometowns include the shadow figures of Davis and an apartment squatter',22,'2025-10-01',19),(1,'The Phreaky World of PBX Hacking','Farhan Arshad and Noor Aziz Uddin were captured 2 years after being placed on the FBI\'s Cyber\'s Most Wanted list for PBX hacking',14,'2017-09-01',20),(2,'The Peculiar Case of the VTech Hacker','VTech makes toy tablets, laptops, and watches for kids. In 2015, they were breached',23,'2017-09-01',20),(3,'DigiNotar, You are the Weakest Link, Good Bye!','The 2011 DigiNotar breach changed the way browsers do security',25,'2017-09-01',20),(4,'Panic! at the TalkTalk Board Room','Mobile provider TalkTalk suffered a major breach in 2015',38,'2017-09-01',20),(5,'#ASUSGATE','Security researcher Kyle Lovett bought a new Asus router in 2013',25,'2017-09-01',20);
/*!40000 ALTER TABLE `episode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `episode_review`
--

DROP TABLE IF EXISTS `episode_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `episode_review` (
  `user_id` int NOT NULL,
  `podcast_id` int NOT NULL,
  `episode_num` int NOT NULL,
  `rating` int NOT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `created_at` date NOT NULL DEFAULT (curdate()),
  PRIMARY KEY (`user_id`,`podcast_id`,`episode_num`),
  KEY `podcast_id` (`podcast_id`,`episode_num`),
  CONSTRAINT `episode_review_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `episode_review_ibfk_2` FOREIGN KEY (`podcast_id`, `episode_num`) REFERENCES `episode` (`podcast_id`, `episode_num`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `episode_review_chk_1` CHECK (((`rating` >= 1) and (`rating` <= 5)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `episode_review`
--

LOCK TABLES `episode_review` WRITE;
/*!40000 ALTER TABLE `episode_review` DISABLE KEYS */;
INSERT INTO `episode_review` VALUES (1,1,1,5,'Great start to an amazing podcast!','2010-01-10'),(1,3,5,5,'Nick and Megan are hilarious','2018-12-20'),(1,11,958,4,'Running and tech - love it','2025-11-26'),(1,11,960,5,'Best Apple gadget ranking ever!','2025-12-03'),(1,20,3,4,'DigiNotar case is important','2017-09-07'),(2,12,1,5,'Hooked from episode one!','2017-12-20'),(2,12,3,5,'Part 2 is even better','2017-12-27'),(2,12,5,5,'Robert Fisher story is crazy','2018-01-10'),(2,19,2,5,'First live show is electric!','2025-09-26'),(3,1,2,4,'Brian and Joe have great chemistry','2010-01-15'),(3,1,5,5,'Love the multi-guest format','2010-02-05'),(3,3,1,5,'Will Ferrell is comedy gold','2018-11-20'),(3,3,3,5,'Bill Burr cracks me up','2018-12-05'),(3,15,1,5,'Kumail is so funny and deep','2011-10-27'),(3,15,3,4,'Demetri Martin philosophy','2011-11-03'),(3,18,2,5,'SNL stories are legendary','2015-11-04'),(3,18,5,4,'The Office theme song story is cool','2015-11-25'),(5,7,1,5,'Love how they explain greatness','2020-11-05'),(5,7,2,5,'Civil war analysis is brilliant','2020-11-06'),(5,7,3,4,'Interesting modern comparison','2020-11-10'),(5,7,4,5,'17th century parallels are spot on','2020-11-12'),(5,13,5,5,'Mike Birbiglia is amazing','2016-11-06'),(6,2,2,5,'Sara Blakely story is so inspiring!','2016-09-15'),(6,2,4,4,'Cathy Hughes is a true pioneer','2016-09-28'),(6,16,1,4,'Great Bitcoin discussion','2018-02-20'),(6,16,3,4,'Opposing views well presented','2018-02-24'),(7,4,2,4,'Fascinating hacker stories','2014-07-15'),(7,9,1,5,'2001 Space Odyssey discussion is amazing','2018-04-08'),(7,9,2,4,'Levee engineering is fascinating','2018-04-09'),(7,9,4,5,'Animals and death - so thought-provoking','2024-10-26'),(8,12,2,5,'Laci Peterson case is heartbreaking','2017-12-21'),(8,12,4,4,'West Mesa case is chilling','2018-01-03'),(8,19,4,5,'500th episode is special','2025-10-01'),(10,13,1,5,'Classic storytelling at its best','2001-01-10'),(10,13,2,5,'Switched at Birth is incredible','2008-07-28'),(10,13,3,4,'Fiasco stories are entertaining','2013-11-05'),(11,5,4,4,'BioShock discussion is awesome','2010-08-16'),(11,11,956,5,'AI agents are coming for us all','2025-11-22'),(11,11,959,5,'Raycast discussion is fascinating','2025-12-01'),(11,14,3,5,'More yapping please!','2024-09-30'),(11,20,1,5,'PBX hacking story is wild','2017-09-03'),(11,20,2,5,'VTech breach is scary','2017-09-05'),(11,20,4,5,'TalkTalk breach well explained','2017-09-09'),(12,6,1,5,'Beautiful and heartfelt','2019-02-16'),(12,6,2,5,'Russell Brand has such depth','2019-02-18'),(12,6,3,5,'Novak is incredibly inspiring','2019-02-20'),(12,6,5,5,'Mike Posner journey is amazing','2019-02-27'),(13,10,1,5,'Best sports podcast out there','2019-05-30'),(13,10,2,4,'Zac Efron was a fun guest','2019-05-31'),(13,10,3,5,'Jeff Ross is hilarious','2019-06-02'),(13,10,4,5,'Blake Griffin interview is gold','2019-06-05'),(13,10,5,5,'Manny Pacquiao stories are incredible','2019-06-06'),(15,8,1,5,'Essential news coverage','2017-02-02'),(15,8,3,4,'Sports meets politics perfectly','2017-02-04'),(17,1,3,5,'Ari is hilarious on this episode','2010-01-20'),(17,3,2,4,'Kristen Bell is so genuine','2018-11-27'),(17,3,4,5,'Dax and Conan together is perfect','2018-12-12'),(17,15,2,5,'TJ Miller gets real weird','2011-10-29'),(17,15,5,5,'Chelsea Peretti is hilarious','2011-11-10'),(17,18,4,5,'Dan Harmon storytelling masterclass','2015-11-18'),(19,4,1,5,'Mind-blowing space content','2014-07-10'),(19,4,3,5,'Leadership insights are valuable','2014-07-28'),(19,9,3,5,'Science committee coverage is important','2019-03-25'),(20,8,2,5,'Important topic well covered','2017-02-03'),(20,8,4,4,'Informative episode','2017-02-07'),(21,2,3,5,'Instagram origin story is fascinating','2016-09-22'),(21,2,5,5,'Love the Clif Bar story','2016-10-05'),(21,16,2,5,'Energy usage debate is important','2018-02-22'),(23,5,1,5,'Best gaming podcast ever!','2010-08-01'),(23,5,3,5,'Great game recommendations','2010-08-10'),(23,5,5,5,'Never disappointed with Game Scoop','2010-08-30'),(23,14,1,5,'Poki and Lily are so funny together!','2024-09-15'),(23,14,2,4,'Unhinged fan stories are wild','2024-09-23'),(23,14,4,5,'Ratatouille discussion is hilarious','2024-10-07'),(23,17,1,5,'Tempest history is fascinating','2012-10-03'),(23,17,2,5,'Zendikar design insights are amazing','2012-10-10'),(23,17,3,5,'Planeswalker origins explained perfectly','2012-10-17'),(27,6,4,4,'Great life lessons','2019-02-24'),(32,1,1,4,'Interesting conversation, good variety of topics','2024-12-04'),(32,18,1,5,'Strong opening episode with clear explanations','2024-12-04'),(32,19,1,5,'Excellent introduction to the series','2024-12-04'),(33,1,1,3,'Engaging but could use more depth','2024-12-04'),(33,18,1,5,'Perfect blend of theory and practice','2024-12-04'),(33,19,1,5,'Captivating first episode, well structured','2024-12-04'),(34,5,1,5,'Conventions are so cool!','2025-12-04'),(35,14,5,5,'I hope she\'s okay :(','2025-12-04');
/*!40000 ALTER TABLE `episode_review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `episode_to_guest`
--

DROP TABLE IF EXISTS `episode_to_guest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `episode_to_guest` (
  `podcast_id` int NOT NULL,
  `episode_num` int NOT NULL,
  `guest_id` int NOT NULL,
  PRIMARY KEY (`podcast_id`,`episode_num`,`guest_id`),
  KEY `guest_id` (`guest_id`),
  CONSTRAINT `episode_to_guest_ibfk_1` FOREIGN KEY (`podcast_id`, `episode_num`) REFERENCES `episode` (`podcast_id`, `episode_num`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `episode_to_guest_ibfk_2` FOREIGN KEY (`guest_id`) REFERENCES `guest` (`guest_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `episode_to_guest`
--

LOCK TABLES `episode_to_guest` WRITE;
/*!40000 ALTER TABLE `episode_to_guest` DISABLE KEYS */;
INSERT INTO `episode_to_guest` VALUES (1,1,1),(1,2,1),(1,4,1),(1,3,2),(1,5,2),(1,5,3),(2,2,4),(2,3,5),(2,3,6),(2,4,7),(2,5,8),(3,1,9),(3,2,10),(3,3,11),(3,4,12),(3,5,13),(3,5,14),(6,1,15),(6,2,16),(6,3,17),(6,5,18),(10,2,19),(10,2,20),(10,3,21),(10,4,22),(10,5,23),(11,960,24),(11,960,25),(11,959,26),(13,5,27),(15,1,28),(15,2,29),(15,3,30),(15,4,31),(15,5,32),(17,3,33),(18,4,34),(18,5,35),(11,958,36);
/*!40000 ALTER TABLE `episode_to_guest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `episode_to_host`
--

DROP TABLE IF EXISTS `episode_to_host`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `episode_to_host` (
  `podcast_id` int NOT NULL,
  `episode_num` int NOT NULL,
  `host_id` int NOT NULL,
  PRIMARY KEY (`podcast_id`,`episode_num`,`host_id`),
  KEY `host_id` (`host_id`),
  CONSTRAINT `episode_to_host_ibfk_1` FOREIGN KEY (`podcast_id`, `episode_num`) REFERENCES `episode` (`podcast_id`, `episode_num`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `episode_to_host_ibfk_2` FOREIGN KEY (`host_id`) REFERENCES `host` (`host_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `episode_to_host`
--

LOCK TABLES `episode_to_host` WRITE;
/*!40000 ALTER TABLE `episode_to_host` DISABLE KEYS */;
INSERT INTO `episode_to_host` VALUES (1,1,1),(1,2,1),(1,3,1),(1,4,1),(1,5,1),(2,1,2),(2,2,2),(2,3,2),(2,4,2),(2,5,2),(3,1,3),(3,2,3),(3,3,3),(3,4,3),(3,5,3),(4,1,4),(4,2,4),(4,3,4),(4,4,4),(4,5,4),(5,1,5),(5,2,5),(5,3,5),(5,4,5),(5,5,5),(6,1,6),(6,2,6),(6,3,6),(6,4,6),(6,5,6),(7,1,7),(7,2,7),(7,3,7),(7,4,7),(7,5,7),(8,1,8),(8,2,8),(8,3,8),(8,4,8),(8,5,8),(9,1,9),(9,2,9),(9,3,9),(9,4,9),(9,5,9),(10,1,10),(10,2,10),(10,3,10),(10,4,10),(10,5,10),(11,956,11),(11,957,11),(11,958,11),(11,959,11),(11,960,11),(11,956,12),(11,957,12),(11,958,12),(11,959,12),(11,960,12),(12,1,13),(12,2,13),(12,3,13),(12,4,13),(12,5,13),(12,1,14),(12,2,14),(12,3,14),(12,4,14),(12,5,14),(13,1,15),(13,2,15),(13,3,15),(13,4,15),(13,5,15),(14,1,16),(14,2,16),(14,3,16),(14,4,16),(14,5,16),(14,1,17),(14,2,17),(14,3,17),(14,4,17),(14,5,17),(15,1,18),(15,2,18),(15,3,18),(15,4,18),(15,5,18),(16,1,19),(16,2,19),(16,3,19),(16,4,19),(16,5,19),(17,1,20),(17,2,20),(17,3,20),(17,4,20),(17,5,20),(18,1,21),(18,2,21),(18,3,21),(18,4,21),(18,5,21),(19,1,22),(19,2,22),(19,3,22),(19,4,22),(19,5,22),(19,1,23),(19,2,23),(19,3,23),(19,4,23),(19,5,23),(20,1,24),(20,2,24),(20,3,24),(20,4,24),(20,5,24);
/*!40000 ALTER TABLE `episode_to_host` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `episode_to_playlist`
--

DROP TABLE IF EXISTS `episode_to_playlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `episode_to_playlist` (
  `user_id` int NOT NULL,
  `podcast_id` int NOT NULL,
  `episode_num` int NOT NULL,
  `playlist_name` varchar(32) NOT NULL,
  PRIMARY KEY (`podcast_id`,`episode_num`,`user_id`,`playlist_name`),
  KEY `user_id` (`user_id`,`playlist_name`),
  CONSTRAINT `episode_to_playlist_ibfk_1` FOREIGN KEY (`user_id`, `playlist_name`) REFERENCES `playlist` (`user_id`, `name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `episode_to_playlist_ibfk_2` FOREIGN KEY (`podcast_id`, `episode_num`) REFERENCES `episode` (`podcast_id`, `episode_num`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `episode_to_playlist`
--

LOCK TABLES `episode_to_playlist` WRITE;
/*!40000 ALTER TABLE `episode_to_playlist` DISABLE KEYS */;
INSERT INTO `episode_to_playlist` VALUES (1,1,1,'Morning Commute'),(1,11,959,'Tech News'),(1,11,960,'Tech News'),(1,20,3,'Tech News'),(2,19,2,'Mystery Hour'),(2,19,4,'Mystery Hour'),(2,12,1,'True Crime Favorites'),(2,12,2,'True Crime Favorites'),(2,12,3,'True Crime Favorites'),(3,3,1,'Comedy Gold'),(3,3,3,'Comedy Gold'),(3,15,1,'Comedy Gold'),(3,15,2,'Comedy Gold'),(5,7,1,'History Lessons'),(5,7,2,'History Lessons'),(5,7,4,'History Lessons'),(5,13,2,'History Lessons'),(6,2,2,'Business Inspiration'),(6,2,3,'Business Inspiration'),(6,2,5,'Business Inspiration'),(6,16,1,'Business Inspiration'),(7,9,1,'Science Deep Dives'),(7,9,2,'Science Deep Dives'),(7,9,4,'Science Deep Dives'),(8,12,2,'Crime Stories'),(8,12,4,'Crime Stories'),(8,12,5,'Crime Stories'),(10,13,1,'Story Time'),(10,13,2,'Story Time'),(10,13,3,'Story Time'),(11,11,956,'Tech Trends'),(11,11,959,'Tech Trends'),(11,20,1,'Tech Trends'),(11,20,2,'Tech Trends'),(12,6,1,'Wellness Journey'),(12,6,2,'Wellness Journey'),(12,6,3,'Wellness Journey'),(12,6,5,'Wellness Journey'),(13,10,1,'Sports Talk'),(13,10,3,'Sports Talk'),(13,10,4,'Sports Talk'),(13,10,5,'Sports Talk'),(15,8,1,'Daily News'),(15,8,2,'Daily News'),(15,8,3,'Daily News'),(17,1,3,'Laugh Out Loud'),(17,3,2,'Laugh Out Loud'),(17,3,4,'Laugh Out Loud'),(17,15,5,'Laugh Out Loud'),(19,4,1,'Learn Something'),(19,4,3,'Learn Something'),(19,9,3,'Learn Something'),(20,8,2,'News Briefs'),(20,8,4,'News Briefs'),(23,5,1,'Gaming World'),(23,5,3,'Gaming World'),(23,5,5,'Gaming World'),(23,17,1,'Gaming World'),(23,17,2,'Gaming World'),(27,6,4,'Deep Thoughts'),(27,7,3,'Deep Thoughts');
/*!40000 ALTER TABLE `episode_to_playlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genre`
--

DROP TABLE IF EXISTS `genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genre` (
  `genre_name` varchar(32) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`genre_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genre`
--

LOCK TABLES `genre` WRITE;
/*!40000 ALTER TABLE `genre` DISABLE KEYS */;
INSERT INTO `genre` VALUES ('Business','Entrepreneurship and business strategies'),('Comedy','Humorous and entertaining content'),('Education','Educational and informative content'),('Gaming','Video game news, reviews, and discussions'),('Health','Health, fitness, and wellness topics'),('History','Historical events and stories'),('Interview','Conversational interviews with guests'),('News','Current events and news analysis'),('Politics','Political commentary and analysis'),('Science','Scientific topics and discoveries'),('Self-Improvement','Personal development and growth'),('Sports','Sports news and commentary'),('Technology','Tech news, reviews, and discussions'),('True Crime','Real-life crime stories and investigations');
/*!40000 ALTER TABLE `genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genre_to_podcast`
--

DROP TABLE IF EXISTS `genre_to_podcast`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genre_to_podcast` (
  `podcast_id` int NOT NULL,
  `genre_name` varchar(32) NOT NULL,
  PRIMARY KEY (`podcast_id`,`genre_name`),
  KEY `genre_name` (`genre_name`),
  CONSTRAINT `genre_to_podcast_ibfk_1` FOREIGN KEY (`podcast_id`) REFERENCES `podcast` (`podcast_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `genre_to_podcast_ibfk_2` FOREIGN KEY (`genre_name`) REFERENCES `genre` (`genre_name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genre_to_podcast`
--

LOCK TABLES `genre_to_podcast` WRITE;
/*!40000 ALTER TABLE `genre_to_podcast` DISABLE KEYS */;
INSERT INTO `genre_to_podcast` VALUES (2,'Business'),(16,'Business'),(1,'Comedy'),(3,'Comedy'),(14,'Comedy'),(15,'Comedy'),(18,'Comedy'),(2,'Education'),(4,'Education'),(7,'Education'),(16,'Education'),(5,'Gaming'),(17,'Gaming'),(6,'Health'),(15,'Health'),(7,'History'),(13,'History'),(18,'History'),(1,'Interview'),(3,'Interview'),(8,'Interview'),(8,'News'),(9,'News'),(11,'News'),(13,'News'),(9,'Science'),(20,'Science'),(6,'Self-Improvement'),(15,'Self-Improvement'),(10,'Sports'),(4,'Technology'),(11,'Technology'),(16,'Technology'),(20,'Technology'),(12,'True Crime'),(19,'True Crime');
/*!40000 ALTER TABLE `genre_to_podcast` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guest`
--

DROP TABLE IF EXISTS `guest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guest` (
  `guest_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(32) NOT NULL,
  `last_name` varchar(32) NOT NULL,
  `bio` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`guest_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guest`
--

LOCK TABLES `guest` WRITE;
/*!40000 ALTER TABLE `guest` DISABLE KEYS */;
INSERT INTO `guest` VALUES (1,'Brian','Redban','Co-founder and early producer of The Joe Rogan Experience'),(2,'Ari','Shaffir','Comedian known for stand-up and podcasting'),(3,'John','Heffron','Comedian and former Last Comic Standing winner'),(4,'Sara','Blakely','Founder of Spanx and self-made entrepreneur'),(5,'Kevin','Systrom','Co-founder of Instagram and tech entrepreneur'),(6,'Mike','Kreiger','Co-founder of Instagram and software engineer'),(7,'Cathy','Hughes','Media entrepreneur and founder of Urban One'),(8,'Gary','Erickson','Entrepreneur, founder of Clif Bar'),(9,'Will','Ferrell','Actor, comedian, and film producer'),(10,'Kristen','Bell','Actress, producer, and advocate'),(11,'Bill','Burr','Actor, comedian, and podcast host'),(12,'Dax','Shepard','Actor, comedian, and podcast host'),(13,'Nick','Offerman','Actor, comedian, and woodworker'),(14,'Megan','Mullally','Actress and comedian, known for Will & Grace'),(15,'Radhi','Devlukia','Entrepreneur and wellness expert'),(16,'Russell','Brand','Comedian, actor, and political commentator'),(17,'Novak','Djokovic','Professional tennis player, Grand Slam champion'),(18,'Mike','Posner','Singer-songwriter and music producer'),(19,'Zach','Efron','Actor and singer in film and television'),(20,'RJ','Hampton','Professional basketball player in NBA'),(21,'Jeff','Ross','Comedian known for celebrity roasts'),(22,'Blake','Griffin','Professional basketball player and sports personality'),(23,'Manny','Pacquiao','Professional boxer, politician, and philanthropist'),(24,'Allison','Johnson','Allison Johnson is a senior reviewer with over a decade of experience writing about consumer tech'),(25,'Victoria','Song','Victoria Song reviews all things wearables and fitness tech for The Verge'),(26,'Thomas','Paul Mann','Thomas Paul Mann is the co-founder and CEO of Raycast'),(27,'Nick','Thompson','Nick Thompson is the CEO of The Atlantic, and Author of \"The Running Ground\"'),(28,'Mike','Birbiglia','Mike Birbiglia is an American stand-up comedian, actor, writer, and director'),(29,'Kumail','Nanjiani','Kumail Nanjiani is a Pakistani-American actor, comedian, and writer known for his sharp wit and diverse talent'),(30,'TJ','Miller','Todd Joseph \"TJ\" Miller is an American actor and comedian'),(31,'Demetri','Martin','Demitri Martin is an American comedian, actor, and writer'),(32,'Dave','Coulier','David Coulier is an American stand-up comedian, actor, voice actor'),(33,'Chelsea','Peretti','Chelsea Peretti is an American comedian, actress, and writer'),(34,'Matt','Cavotta','Matt Cavotta is an American artist and writer'),(35,'Dan','Harmon','Daniel James Harmon is an American television writer, producer, animator, and actor'),(36,'Rainn','Wilson','Rainn Percival Dietrich Wilson is an Emmy-nominated actor, comedian, writer, producer, director, and podcaster');
/*!40000 ALTER TABLE `guest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `host`
--

DROP TABLE IF EXISTS `host`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `host` (
  `host_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(32) NOT NULL,
  `last_name` varchar(32) NOT NULL,
  `bio` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`host_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `host`
--

LOCK TABLES `host` WRITE;
/*!40000 ALTER TABLE `host` DISABLE KEYS */;
INSERT INTO `host` VALUES (1,'Joe','Rogan','Comedian, podcaster, and UFC commentator'),(2,'Guy','Raz','Host of inspiring entrepreneurial and storytelling podcasts'),(3,'Conan','O\'Brien','Comedian and former late-night talk show host'),(4,'Manoush','Zomorodi','Journalist exploring technology and culture topics'),(5,'Daemon','Hatfield','Video game journalist and reviewer'),(6,'Jay','Shetty','Motivational speaker and personal growth coach'),(7,'Dominic','Sandbrook','Historian and bestselling author'),(8,'Michael','Barbaro','Host of The New York Times Daily podcast'),(9,'Ira','Flatow','Science journalist and radio host'),(10,'Dan','Katz','Sports analyst and media personality'),(11,'Nilay','Patel','Nilay Patel is the co-founder and editor-in-chief of The Verge, a Vox Media tech and culture brand'),(12,'David','Pierce','David Pierce is The Verge’s Editor-at-Large'),(13,'Ashley','Flowers','Host & Producer of Crime Junkie & Full Body Chills, Producer & Guest on CounterClock & Host of It\'s a Wonderful Lie & The Deck'),(14,'Brit','Pawat','Host & Producer of Crime Junkie'),(15,'Ira','Glass','Host, Producer & Editor of This American Life & Host of This American Life Archive'),(16,'Imane','Anys','Imane Anys is better known by her online alias Pokimane'),(17,'Lily','Ki','Lily Ki, better known as LilyPichu, is an American online streamer, voice actress, artist and YouTuber'),(18,'Pete','Holmes','Pete Holmes, born,  March 30, 1979, is an American comedian, actor, writer, and podcaster known for his affable personality and sharp wit'),(19,'Brady','Swenson','Brady Swenson is the host of the Citizen Bitcoin podcast'),(20,'Mark','Rosewater','Mark Rosewater is the head designer for Magic: The Gathering and host of Magic: The Gathering Drive to Work Podcast'),(21,'Andrew','Steven','Andrew Steven is an award-winning podcaster, producer, and writer'),(22,'Karen','Kilgariff','Karen Kilgariff is an American writer, comedian, singer, author, actor, television producer'),(23,'Georgia','Hardstark','Georgia Miriam Hardstark is an American television host and podcast personality'),(24,'Jack','Rhysider','Jack Rhysider is a veteran to the security world');
/*!40000 ALTER TABLE `host` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `language`
--

DROP TABLE IF EXISTS `language`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `language` (
  `language_name` varchar(32) NOT NULL,
  PRIMARY KEY (`language_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `language`
--

LOCK TABLES `language` WRITE;
/*!40000 ALTER TABLE `language` DISABLE KEYS */;
INSERT INTO `language` VALUES ('English'),('French'),('German'),('Hindi'),('Italian'),('Japanese'),('Korean'),('Mandarin'),('Portuguese'),('Spanish');
/*!40000 ALTER TABLE `language` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `language_to_podcast`
--

DROP TABLE IF EXISTS `language_to_podcast`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `language_to_podcast` (
  `podcast_id` int NOT NULL,
  `language_name` varchar(32) NOT NULL,
  PRIMARY KEY (`podcast_id`,`language_name`),
  KEY `language_name` (`language_name`),
  CONSTRAINT `language_to_podcast_ibfk_1` FOREIGN KEY (`podcast_id`) REFERENCES `podcast` (`podcast_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `language_to_podcast_ibfk_2` FOREIGN KEY (`language_name`) REFERENCES `language` (`language_name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `language_to_podcast`
--

LOCK TABLES `language_to_podcast` WRITE;
/*!40000 ALTER TABLE `language_to_podcast` DISABLE KEYS */;
INSERT INTO `language_to_podcast` VALUES (1,'English'),(2,'English'),(3,'English'),(4,'English'),(5,'English'),(6,'English'),(7,'English'),(8,'English'),(9,'English'),(10,'English'),(11,'English'),(12,'English'),(13,'English'),(14,'English'),(15,'English'),(16,'English'),(17,'English'),(18,'English'),(19,'English'),(20,'English');
/*!40000 ALTER TABLE `language_to_podcast` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `platform`
--

DROP TABLE IF EXISTS `platform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `platform` (
  `platform_name` varchar(32) NOT NULL,
  `is_subscription_req` tinyint(1) NOT NULL,
  `subscription_monthly_cost` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`platform_name`),
  CONSTRAINT `subscription_check` CHECK ((((`is_subscription_req` = 1) and (`subscription_monthly_cost` is not null)) or ((`is_subscription_req` = 0) and (`subscription_monthly_cost` is null))))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `platform`
--

LOCK TABLES `platform` WRITE;
/*!40000 ALTER TABLE `platform` DISABLE KEYS */;
INSERT INTO `platform` VALUES ('Apple Podcasts',0,NULL),('Audible',1,7.95),('Spotify',1,11.99),('YouTube',0,NULL);
/*!40000 ALTER TABLE `platform` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `platform_to_podcast`
--

DROP TABLE IF EXISTS `platform_to_podcast`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `platform_to_podcast` (
  `podcast_id` int NOT NULL,
  `platform_name` varchar(32) NOT NULL,
  PRIMARY KEY (`podcast_id`,`platform_name`),
  KEY `platform_name` (`platform_name`),
  CONSTRAINT `platform_to_podcast_ibfk_1` FOREIGN KEY (`podcast_id`) REFERENCES `podcast` (`podcast_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `platform_to_podcast_ibfk_2` FOREIGN KEY (`platform_name`) REFERENCES `platform` (`platform_name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `platform_to_podcast`
--

LOCK TABLES `platform_to_podcast` WRITE;
/*!40000 ALTER TABLE `platform_to_podcast` DISABLE KEYS */;
INSERT INTO `platform_to_podcast` VALUES (1,'Apple Podcasts'),(2,'Apple Podcasts'),(3,'Apple Podcasts'),(4,'Apple Podcasts'),(5,'Apple Podcasts'),(6,'Apple Podcasts'),(7,'Apple Podcasts'),(8,'Apple Podcasts'),(9,'Apple Podcasts'),(10,'Apple Podcasts'),(11,'Apple Podcasts'),(12,'Apple Podcasts'),(13,'Apple Podcasts'),(14,'Apple Podcasts'),(15,'Apple Podcasts'),(16,'Apple Podcasts'),(17,'Apple Podcasts'),(18,'Apple Podcasts'),(19,'Apple Podcasts'),(20,'Apple Podcasts'),(1,'Audible'),(2,'Audible'),(3,'Audible'),(4,'Audible'),(5,'Audible'),(6,'Audible'),(7,'Audible'),(8,'Audible'),(9,'Audible'),(10,'Audible'),(11,'Audible'),(12,'Audible'),(13,'Audible'),(15,'Audible'),(17,'Audible'),(18,'Audible'),(19,'Audible'),(20,'Audible'),(1,'Spotify'),(2,'Spotify'),(3,'Spotify'),(4,'Spotify'),(5,'Spotify'),(6,'Spotify'),(7,'Spotify'),(8,'Spotify'),(9,'Spotify'),(10,'Spotify'),(11,'Spotify'),(12,'Spotify'),(13,'Spotify'),(14,'Spotify'),(15,'Spotify'),(16,'Spotify'),(17,'Spotify'),(18,'Spotify'),(19,'Spotify'),(20,'Spotify'),(1,'YouTube'),(2,'YouTube'),(3,'YouTube'),(4,'YouTube'),(5,'YouTube'),(6,'YouTube'),(7,'YouTube'),(8,'YouTube'),(9,'YouTube'),(10,'YouTube'),(11,'YouTube'),(12,'YouTube'),(13,'YouTube'),(14,'YouTube'),(15,'YouTube'),(17,'YouTube'),(18,'YouTube'),(19,'YouTube'),(20,'YouTube');
/*!40000 ALTER TABLE `platform_to_podcast` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playlist`
--

DROP TABLE IF EXISTS `playlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `playlist` (
  `user_id` int NOT NULL,
  `name` varchar(32) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`,`name`),
  UNIQUE KEY `name` (`name`),
  CONSTRAINT `playlist_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playlist`
--

LOCK TABLES `playlist` WRITE;
/*!40000 ALTER TABLE `playlist` DISABLE KEYS */;
INSERT INTO `playlist` VALUES (1,'Morning Commute','Energizing podcasts for my drive'),(1,'Tech News','Latest technology updates'),(2,'Mystery Hour','Unsolved mysteries'),(2,'True Crime Favorites','Best crime investigations'),(3,'Comedy Gold','Funniest episodes ever'),(5,'History Lessons','Educational historical content'),(6,'Business Inspiration','Entrepreneur stories'),(7,'Science Deep Dives','Complex science topics'),(8,'Crime Stories','True crime collections'),(10,'Story Time','Narrative podcasts'),(11,'Tech Trends','Technology and innovation'),(12,'Wellness Journey','Health and mindfulness'),(13,'Sports Talk','All things sports'),(15,'Daily News','Current events'),(17,'Laugh Out Loud','Comedy podcasts'),(19,'Learn Something','Educational shows'),(20,'News Briefs','Quick news updates'),(23,'Gaming World','Video game podcasts'),(27,'Deep Thoughts','Philosophy and reflection');
/*!40000 ALTER TABLE `playlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `podcast`
--

DROP TABLE IF EXISTS `podcast`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `podcast` (
  `podcast_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `release_date` date NOT NULL,
  PRIMARY KEY (`podcast_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `podcast`
--

LOCK TABLES `podcast` WRITE;
/*!40000 ALTER TABLE `podcast` DISABLE KEYS */;
INSERT INTO `podcast` VALUES (1,'The Joe Rogan Experience','Long-form conversations with diverse, thought-provoking guests','2009-12-24'),(2,'How I Built This','Entrepreneurs share stories behind building successful companies','2016-09-12'),(3,'Conan O\'Brien Needs A Friend','Conan seeks genuine friendships through funny celebrity interviews','2018-11-18'),(4,'TED Radio Hour','Ideas and stories inspired by TED talks','2012-04-27'),(5,'Game Scoop!','Weekly video game news, reviews, and discussions','2006-07-20'),(6,'On Purpose with Jay Shetty','Insights on mindfulness, purpose, and personal growth','2019-02-13'),(7,'The Rest is History','Historical events explored with humor and insight','2020-11-02'),(8,'The Daily','Daily news analysis from The New York Times','2017-02-01'),(9,'Science Friday','Science news, discoveries, and expert interviews','1991-10-01'),(10,'Pardon My Take','Humorous sports commentary and interviews with athletes','2016-02-29'),(11,'The Vergecast','The Vergecast is the flagship podcast from The Verge about small gadgets, Big Tech, and everything in between.','2014-01-01'),(12,'Crime Junkie','Dive into your next mystery with Crime Junkie','2017-12-18'),(13,'This American Life','A weekly Society and Culture podcast featuring Ira Glass','2001-01-05'),(14,'Sweet n Sour Podcast','A weekly podcast created and hosted by pokimane and lilypichu','2024-09-13'),(15,'You Made It Weird with Pete Holmes','Everybody has secret weirdness, Pete Holmes gets comedians to share theirs','2011-10-25'),(16,'Citizen Bitcoin','Podcasting the dawn of the Bitcoin Renaissance','2018-02-18'),(17,'Magic: The Gathering Drive to Work Podcast','Join Magic: The Gathering Head Designer Mark Rosewater as he shares stories, insights, and more while driving to work','2012-10-01'),(18,'The History of Standup','Comedian and professor Wayne Federman has spent his life studying the art and history of standup comedy','2015-10-26'),(19,'My Favorite Murder','My Favorite Murder is a true crime comedy podcast hosted by Karen Kilgariff and Georgia Hardstark','2025-09-22'),(20,'Darknet Diaries','Explore true stories of the dark side of the Internet with host Jack Rhysider','2017-09-01');
/*!40000 ALTER TABLE `podcast` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `podcast_review`
--

DROP TABLE IF EXISTS `podcast_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `podcast_review` (
  `user_id` int NOT NULL,
  `podcast_id` int NOT NULL,
  `rating` int NOT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `created_at` date NOT NULL DEFAULT (curdate()),
  PRIMARY KEY (`user_id`,`podcast_id`),
  KEY `podcast_id` (`podcast_id`),
  CONSTRAINT `podcast_review_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `podcast_review_ibfk_2` FOREIGN KEY (`podcast_id`) REFERENCES `podcast` (`podcast_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `podcast_review_chk_1` CHECK (((`rating` >= 1) and (`rating` <= 5)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `podcast_review`
--

LOCK TABLES `podcast_review` WRITE;
/*!40000 ALTER TABLE `podcast_review` DISABLE KEYS */;
INSERT INTO `podcast_review` VALUES (1,1,5,'Best podcast out there, so much variety','2020-01-15'),(1,11,5,'Never miss an episode','2025-11-20'),(2,1,4,'Joe Rogan has incredible guests','2020-02-10'),(2,4,5,'TED talks in podcast form - brilliant','2015-03-20'),(2,12,5,'Crime Junkie is addictive','2021-08-11'),(3,1,5,'Long-form conversations are refreshing','2020-03-05'),(3,3,5,'Conan is naturally funny and curious','2019-06-15'),(4,1,4,'Great variety of topics and guests','2020-04-12'),(5,1,5,'Never a dull moment with Joe','2020-05-18'),(5,7,5,'A masterclass in history storytelling','2021-02-14'),(6,1,5,'Learn something new every episode','2020-06-22'),(6,2,5,'Inspiring entrepreneur stories','2020-05-22'),(6,16,4,'Good Bitcoin education','2020-09-15'),(7,1,4,'Interesting conversations on science','2020-07-14'),(7,9,5,'Science storytelling at its best','2020-11-05'),(8,1,5,'Joe lets guests really open up','2020-08-20'),(8,12,5,'Best true crime podcast','2019-07-20'),(9,1,4,'Always entertaining and informative','2020-09-25'),(10,1,5,'The perfect podcast format','2020-10-30'),(10,13,5,'Radio at its finest','2019-02-28'),(11,11,5,'Essential tech podcast','2025-11-15'),(11,20,5,'Cybersecurity stories are fascinating','2021-04-10'),(12,6,5,'Jay Shetty changed my perspective','2020-08-12'),(13,10,5,'Best sports commentary','2020-08-14'),(15,8,5,'Essential daily listening','2020-11-05'),(17,15,5,'Pete Holmes gets people to open up','2019-12-08'),(19,4,5,'Mind-expanding content','2019-08-27'),(20,8,5,'News done right','2021-12-14'),(21,2,5,'Business inspiration weekly','2020-12-30'),(23,5,5,'Gaming podcast excellence','2020-06-18'),(23,14,5,'Poki and Lily are the best duo','2024-11-01'),(23,17,5,'Must-listen for MTG fans','2021-03-15'),(27,6,4,'Great for personal growth','2021-05-20'),(32,1,4,'Joe should invite me to the podcast','2024-12-04'),(32,2,5,'I should talk about how I built the CAP theorem','2024-12-04'),(32,3,5,'I should have gone into comedy like Conan','2024-12-04'),(32,4,5,'I think I will rename the CAP theorem to the TED theorem','2024-12-04'),(32,5,3,'I might be too old for games','2024-12-04'),(32,18,5,'Consistent, Available, and Partition Tolerable!','2024-12-04'),(32,19,4,'I have heard better','2024-12-04'),(33,1,4,'I remember when Joe was born','2024-12-04'),(33,2,5,'Guy should really invite me on the podcast','2024-12-04'),(33,3,4,'Conan\'s chemistry with guests is wonderful, his curiosity makes every episode enjoyable','2024-12-04'),(33,4,5,'TED Radio Hour expands on the best talks with interviews and context - brilliant concept','2024-12-04'),(33,5,3,'Good for gaming news but the hosts could dive deeper into game design and mechanics','2024-12-04'),(33,18,5,'Podcasts on your computer would not exist without me','2024-12-04'),(33,19,5,'Not bad','2024-12-04'),(34,1,3,'I think it\'s okay...','2025-12-04'),(34,3,5,'I love Conan','2025-12-04'),(34,13,5,'Jackie recommended this to me!','2025-12-04'),(35,1,5,'Great podcast!','2025-12-04'),(35,2,4,'Very cool!','2025-12-04'),(35,14,5,'Superfan!','2025-12-04'),(36,1,3,'I like computers more','2024-12-04'),(36,2,5,'An enigma in the best possible way!','2024-12-04'),(36,3,5,'Conan is great','2024-12-04'),(36,4,5,'I can\'t believe Benedict Cumberbatch played me in a movie','2024-12-04'),(36,5,5,'Pretty cool','2024-12-04');
/*!40000 ALTER TABLE `podcast_review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(32) NOT NULL,
  `username` varchar(32) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `first_name` varchar(32) NOT NULL,
  `last_name` varchar(32) NOT NULL,
  `bio` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'john.doe@email.com','johndoe','hash123abc','John','Doe','Podcast enthusiast and tech lover'),(2,'sarah.smith@email.com','sarahsmith','hash456def','Sarah','Smith','True crime podcast addict'),(3,'mike.johnson@email.com','mikej','hash789ghi','Mike','Johnson','Comedy podcasts are my jam'),(4,'emma.wilson@email.com','emmaw','hashabc123','Emma','Wilson',NULL),(5,'alex.brown@email.com','alexb','hashdef456','Alex','Brown','History buff and podcast collector'),(6,'olivia.davis@email.com','oliviad','hash111aaa','Olivia','Davis','Business podcast junkie'),(7,'james.miller@email.com','jamesm','hash222bbb','James','Miller','Science nerd and podcast lover'),(8,'sophia.garcia@email.com','sophiag','hash333ccc','Sophia','Garcia','True crime and mystery fan'),(9,'william.martinez@email.com','willm','hash444ddd','William','Martinez',NULL),(10,'isabella.rodriguez@email.com','isabellar','hash555eee','Isabella','Rodriguez','Love storytelling podcasts'),(11,'lucas.hernandez@email.com','lucash','hash666fff','Lucas','Hernandez','Tech and startup podcasts'),(12,'mia.lopez@email.com','mial','hash777ggg','Mia','Lopez','Health and wellness enthusiast'),(13,'henry.gonzalez@email.com','henryg','hash888hhh','Henry','Gonzalez','Sports podcast addict'),(14,'amelia.wilson@email.com','ameliaw','hash999iii','Amelia','Wilson',NULL),(15,'benjamin.anderson@email.com','bena','hash000jjj','Benjamin','Anderson','News and politics listener'),(16,'charlotte.thomas@email.com','charlottet','hashaaakkk','Charlotte','Thomas','Music and culture podcasts'),(17,'elijah.taylor@email.com','elijaht','hashbbblll','Elijah','Taylor','Comedy and interview shows'),(18,'harper.moore@email.com','harperm','hashcccmmm','Harper','Moore',NULL),(19,'alexander.jackson@email.com','alexj','hashdddnnn','Alexander','Jackson','Educational content lover'),(20,'evelyn.martin@email.com','evelynm','hasheeeooo','Evelyn','Martin','Daily news podcast listener'),(21,'daniel.lee@email.com','danlee','hashfffppp','Daniel','Lee','Entrepreneurship and business'),(22,'abigail.perez@email.com','abigailp','hashgggqqq','Abigail','Perez',NULL),(23,'matthew.white@email.com','mattw','hashhhhaaa','Matthew','White','Gaming and tech podcasts'),(24,'emily.harris@email.com','emilyh','hashiiisss','Emily','Harris','Book club podcast fan'),(25,'joseph.sanchez@email.com','josephs','hashjjjttt','Joseph','Sanchez','Horror and thriller podcasts'),(26,'elizabeth.clark@email.com','elizc','hashkkkuuu','Elizabeth','Clark',NULL),(27,'david.ramirez@email.com','davidr','hashlllvvv','David','Ramirez','Philosophy and deep talks'),(28,'sofia.lewis@email.com','sofial','hashmmmwww','Sofia','Lewis','Pop culture enthusiast'),(29,'jackson.robinson@email.com','jacksonr','hashnnnxxx','Jackson','Robinson',NULL),(30,'avery.walker@email.com','averyw','hashooozzz','Avery','Walker','Documentary podcast lover'),(31,'edgarcodd@email.com','edgarcodd','$2b$12$ZvNfzWIIDc9AEzHCsm6.Ju.kyr7F.8VU/9GUVvj4cS4k3SShmiwge','Edgar','Codd',NULL),(32,'eric.brewer@email.com','ericbrewer','hashed_password_eric','Eric','Brewer','Computer scientist and podcast lover'),(33,'ada.lovelace@example.com','adalovelace','hashed_password_ada','Ada','Lovelace','Born too early for podcasts :('),(34,'harrisonp@email.com','harrisonp','$2b$12$OPckvpqcoG8vA87ZRg61EemnLXcdeazx9nd2GcB/IF282Eka12RtW','Harrison','Pham',NULL),(35,'jassem@gmail.com','jassem','$2b$12$8LW3heO51ENYjWlOZ7ZSNuTPCHgnRnXjE5qdgGcF5TVH/M2Fc/6yC','Jassem','Alabdulrazaq',NULL),(36,'alanturing@email.com','alanturing','hashed_password_alan','Alan','Turing','I love podcasts more than I love computers');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_to_user`
--

DROP TABLE IF EXISTS `user_to_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_to_user` (
  `id1` int NOT NULL,
  `id2` int NOT NULL,
  `date_added` date NOT NULL DEFAULT (curdate()),
  `status` enum('pending','accepted') NOT NULL,
  PRIMARY KEY (`id1`,`id2`),
  KEY `id2` (`id2`),
  CONSTRAINT `user_to_user_ibfk_1` FOREIGN KEY (`id1`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_to_user_ibfk_2` FOREIGN KEY (`id2`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_to_user`
--

LOCK TABLES `user_to_user` WRITE;
/*!40000 ALTER TABLE `user_to_user` DISABLE KEYS */;
INSERT INTO `user_to_user` VALUES (1,2,'2020-01-15','accepted'),(1,3,'2020-02-20','accepted'),(1,11,'2020-03-10','accepted'),(2,1,'2020-01-15','accepted'),(2,3,'2020-05-12','pending'),(2,8,'2020-04-05','accepted'),(3,1,'2020-02-20','accepted'),(3,2,'2020-05-12','pending'),(3,17,'2020-06-18','accepted'),(5,10,'2020-07-22','accepted'),(5,19,'2020-08-14','accepted'),(6,21,'2020-09-01','accepted'),(7,9,'2020-10-03','accepted'),(7,19,'2020-11-11','accepted'),(8,2,'2020-04-05','accepted'),(9,7,'2020-10-03','accepted'),(10,5,'2020-07-22','accepted'),(10,13,'2020-12-25','accepted'),(11,1,'2020-03-10','accepted'),(11,20,'2021-02-14','accepted'),(11,23,'2021-01-08','accepted'),(12,27,'2021-03-17','pending'),(13,10,'2020-12-25','accepted'),(13,15,'2021-04-20','accepted'),(15,13,'2021-04-20','accepted'),(15,20,'2021-05-05','accepted'),(17,3,'2020-06-18','accepted'),(17,18,'2021-06-12','accepted'),(18,17,'2021-06-12','accepted'),(19,5,'2020-08-14','accepted'),(19,7,'2020-11-11','accepted'),(20,11,'2021-02-14','accepted'),(20,15,'2021-05-05','accepted'),(21,6,'2020-09-01','accepted'),(22,24,'2021-07-19','pending'),(23,11,'2021-01-08','accepted'),(23,24,'2021-08-23','accepted'),(24,22,'2021-07-19','pending'),(24,23,'2021-08-23','accepted'),(25,26,'2021-09-30','accepted'),(26,25,'2021-09-30','accepted'),(27,12,'2021-03-17','pending'),(27,28,'2021-10-15','accepted'),(28,27,'2021-10-15','accepted'),(29,30,'2021-11-01','accepted'),(30,29,'2021-11-01','accepted'),(31,32,'2024-12-04','accepted'),(31,33,'2024-12-04','accepted'),(31,34,'2025-12-04','accepted'),(31,35,'2025-12-04','accepted'),(31,36,'2024-12-04','accepted'),(32,31,'2024-12-04','accepted'),(33,31,'2024-12-04','accepted'),(34,31,'2025-12-04','accepted'),(35,31,'2025-12-04','accepted'),(35,32,'2025-12-04','pending'),(36,31,'2024-12-04','accepted');
/*!40000 ALTER TABLE `user_to_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'hearsay_db'
--
/*!50003 DROP FUNCTION IF EXISTS `get_global_episode_avg_rating` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_global_episode_avg_rating`(podcast_id_p INT, episode_num_p INT) RETURNS decimal(2,1)
    READS SQL DATA
    DETERMINISTIC
BEGIN
	DECLARE episode_rating DECIMAL(2,1);

	SELECT AVG(rating) INTO episode_rating
    FROM episode_review
    WHERE podcast_id = podcast_id_p AND episode_num = episode_num_p;
    
    RETURN episode_rating;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_global_podcast_avg_rating` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_global_podcast_avg_rating`(podcast_id_p INT) RETURNS decimal(2,1)
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE podcast_rating DECIMAL(2,1);
    
	SELECT AVG(rating) INTO podcast_rating
    FROM podcast_review
    WHERE podcast_id = podcast_id_p;
    
    RETURN podcast_rating;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_global_podcast_avg_rating_by_episode` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_global_podcast_avg_rating_by_episode`(podcast_id_p INT) RETURNS decimal(2,1)
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE podcast_rating DECIMAL(2,1);
    
	SELECT AVG(rating) INTO podcast_rating
    FROM episode_review
    WHERE podcast_id = podcast_id_p;
    
    RETURN podcast_rating;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_user_friends_episode_avg_rating` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_user_friends_episode_avg_rating`(user_id_p INT, podcast_id_p INT, episode_num_p INT) RETURNS decimal(2,1)
    READS SQL DATA
    DETERMINISTIC
BEGIN
	DECLARE friends_rating DECIMAL(2,1);
    
	SELECT AVG(rating) INTO friends_rating
    FROM user_to_user
    JOIN episode_review ON id2 = episode_review.user_id
    WHERE id1 = user_id_p AND podcast_id = podcast_id_p AND episode_num = episode_num_p;
    
    RETURN friends_rating;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_user_friends_podcast_avg_rating` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_user_friends_podcast_avg_rating`(user_id_p INT, podcast_id_p INT) RETURNS decimal(2,1)
    READS SQL DATA
    DETERMINISTIC
BEGIN
	DECLARE friends_avg_rating DECIMAL(2,1);
    
    SELECT AVG(rating) INTO friends_avg_rating
    FROM user_to_user
    JOIN podcast_review ON id2 = podcast_review.user_id
    WHERE id1 = user_id_p AND podcast_id = podcast_id_p;
    
    RETURN friends_avg_rating;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_user_friends_podcast_avg_rating_by_episode` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_user_friends_podcast_avg_rating_by_episode`(user_id_p INT, podcast_id_p INT) RETURNS decimal(2,1)
    READS SQL DATA
    DETERMINISTIC
BEGIN
	DECLARE friends_avg_rating_by_episode DECIMAL(2,1);
    
	SELECT AVG(rating) INTO friends_avg_rating_by_episode
    FROM user_to_user
    JOIN episode_review ON id2 = episode_review.user_id
    WHERE id1 = user_id_p AND podcast_id = podcast_id_p;
    
    RETURN friends_avg_rating_by_episode;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `accept_friend_request` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `accept_friend_request`(IN user_id_p INT, IN user_to_accept_id_p INT)
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_episode_to_playlist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_episode_to_playlist`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_playlist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_playlist`(IN user_id_p INT, IN playlist_name_p VARCHAR(32), IN description_p VARCHAR(32))
BEGIN
	IF playlist_name_p NOT IN (SELECT name FROM playlist AS pl WHERE pl.user_id = user_id_p) THEN
		INSERT INTO playlist(user_id, name, description) VALUES (user_id_p, playlist_name_p, description_p);
    ELSE 
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT="Playlist already exists";
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_user`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_episode_review` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_episode_review`(
	IN user_id_p INT,
    IN podcast_id_p INT,
    IN episode_num_p INT
)
BEGIN
    DELETE FROM episode_review 
    WHERE user_id = user_id_p 
    AND podcast_id = podcast_id_p
    AND episode_num = episode_num_p;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_friend` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_friend`(IN user_id_p INT, IN user_to_delete_id_p INT)
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_playlist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_playlist`(IN user_id_p INT, IN playlist_name_p VARCHAR(32))
BEGIN
	IF playlist_name_p IN (SELECT name FROM playlist WHERE user_id = user_id_p) THEN
		DELETE FROM playlist AS pl 
        WHERE pl.user_id = user_id_p
        AND name = playlist_name_p;
    ELSE
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT = "Playlist not found";
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_podcast_review` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_podcast_review`(IN user_id_p INT, IN podcast_id_p INT)
BEGIN
    DELETE FROM podcast_review 
    WHERE user_id = user_id_p 
    AND podcast_id = podcast_id_p;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_genres` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_genres`()
BEGIN
    SELECT genre_name FROM genre;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_guests` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_guests`()
BEGIN
    SELECT first_name, last_name FROM guest;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_hosts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_hosts`()
BEGIN
    SELECT first_name, last_name FROM host;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_languages` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_languages`()
BEGIN
    SELECT language_name FROM language;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_platforms` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_platforms`()
BEGIN
    SELECT platform_name FROM platform;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_episode` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_episode`(IN podcast_id_p INT, IN episode_num_p INT)
BEGIN
    IF NOT EXISTS (SELECT * FROM podcast WHERE podcast_id = podcast_id_p) THEN
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT = "Podcast not found";
    ELSEIF NOT EXISTS (SELECT * FROM episode WHERE podcast_id = podcast_id AND episode_num = episode_num_p) THEN 
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT = "Episode not found";
    END IF;
    
    SELECT * FROM episode WHERE podcast_id = podcast_id_p and episode_num = episode_num_p;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_episodes_in_playlist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_episodes_in_playlist`(IN user_id_p INT, IN playlist_name_p VARCHAR(32))
BEGIN
    SELECT p.podcast_id AS podcast_id, p.name AS podcast_name, e.name AS episode_name, e.episode_num FROM episode_to_playlist AS etp
    JOIN podcast AS p ON p.podcast_id = etp.podcast_id
    JOIN episode AS e ON e.episode_num = etp.episode_num AND e.podcast_id = etp.podcast_id
    WHERE etp.user_id = user_id_p AND playlist_name = playlist_name_p;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_episode_review` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_episode_review`(IN user_id_p INT, IN podcast_id_p INT, IN episode_num_p INT)
BEGIN
	SELECT rating, comment, created_at
    FROM episode_review
    WHERE user_id = user_id_p AND podcast_id = podcast_id_p AND episode_num = episode_num_p;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_friends` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_friends`(user_id_p INT)
BEGIN
	IF NOT EXISTS (SELECT * FROM user WHERE id = user_id_p) THEN
		SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT="User not found";
	END IF;
    SELECT id, date_added, username, first_name, last_name, bio FROM user_to_user
    JOIN user ON id2 = user.id
    WHERE id1 = user_id_p AND status = "accepted";
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_guests` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_guests`()
BEGIN
	SELECT * FROM guest;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_hosts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_hosts`()
BEGIN
	SELECT * FROM host;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_pending_friend_requests` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_pending_friend_requests`(user_id_p INT)
BEGIN
	IF NOT EXISTS (SELECT * FROM user WHERE id = user_id_p) THEN
		SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT="User not found";
	END IF;
    SELECT id, date_added, username, first_name, last_name, bio FROM user_to_user
    JOIN user ON id1 = user.id
    WHERE id2 = user_id_p AND status = "pending";
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_playlists` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_playlists`(IN user_id_p INT)
BEGIN
	SELECT * FROM playlist WHERE user_id = user_id_p;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_podcast` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_podcast`(IN podcast_id_p INT)
BEGIN
    IF NOT EXISTS (SELECT * FROM podcast WHERE podcast_id = podcast_id_p) THEN
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT = "Podcast not found";
    END IF;
    
    SELECT name, description, release_date, GROUP_CONCAT(genre_name) AS genres FROM podcast 
    JOIN genre_to_podcast ON podcast.podcast_id = genre_to_podcast.podcast_id
    WHERE podcast.podcast_id = podcast_id_p
    GROUP BY podcast.podcast_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_podcast_guests` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_podcast_guests`(IN podcast_id_p INT)
BEGIN
    SELECT DISTINCT first_name, last_name FROM episode_to_guest
    JOIN guest USING (guest_id)
    WHERE podcast_id = podcast_id_p;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_podcast_hosts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_podcast_hosts`(IN podcast_id_p INT)
BEGIN
    SELECT DISTINCT first_name, last_name FROM episode_to_host
    JOIN host USING (host_id)
    WHERE podcast_id = podcast_id_p;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_podcast_review` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_podcast_review`(IN user_id_p INT, IN podcast_id_p INT)
BEGIN
    SELECT rating, comment, created_at
    FROM podcast_review
    WHERE user_id = user_id_p AND podcast_id = podcast_id_p;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_sent_friend_requests` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_sent_friend_requests`(user_id_p INT)
BEGIN
	IF NOT EXISTS (SELECT * FROM user WHERE id = user_id_p) THEN
		SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT="User not found";
	END IF;
    SELECT id, date_added, username, first_name, last_name, bio FROM user_to_user JOIN user ON id2 = user.id WHERE id1 = user_id_p;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_user_by_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_user_by_id`(IN user_id_p INT)
BEGIN
    IF NOT EXISTS (SELECT * FROM user WHERE id = user_id_p) THEN
		SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT="User not found";
	END IF;
    
	SELECT id, username, first_name, last_name, bio FROM user WHERE id = user_id_p;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_user_by_username` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_user_by_username`(IN username_p VARCHAR(32))
BEGIN
	SELECT id, username, email, first_name, last_name, bio FROM user WHERE username LIKE CONCAT("%", username_p, "%");
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_user_episode_reviews` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_user_episode_reviews`(IN user_id_p INT)
BEGIN
    IF NOT EXISTS (SELECT * FROM user WHERE id = user_id_p) THEN
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT = "User not found";
    END IF;
    
    SELECT user_id, username, first_name, last_name, podcast_id, podcast.name AS podcast_name, episode_num, rating, comment, created_at FROM user AS u
    JOIN episode_review AS er ON u.id = er.user_id
    JOIN podcast USING (podcast_id)
    WHERE er.user_id = user_id_p
    ORDER BY created_at DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_user_feed` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_user_feed`(IN user_id_p INT)
BEGIN
    IF NOT EXISTS (SELECT * FROM user WHERE id = user_id_p) THEN
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT = "User not found";
    END IF;
    
    SELECT id2 AS id, 
           username, 
           first_name, 
           last_name, 
           episode_review.podcast_id AS podcast_id, 
           episode_review.episode_num AS episode_num, 
           podcast.name AS podcast_name, 
           episode.name AS episode_name, 
           rating, 
           comment, 
           created_at
    FROM user_to_user 
    JOIN episode_review ON id2 = episode_review.user_id
    JOIN user ON id2 = id
    JOIN episode ON episode_review.podcast_id = episode.podcast_id AND episode_review.episode_num = episode.episode_num
    JOIN podcast ON episode_review.podcast_id = podcast.podcast_id
    WHERE id1 = user_id_p AND status = "accepted"
    ORDER BY created_at DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_user_friends_episode_review` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_user_friends_episode_review`(IN user_id_p INT, IN podcast_id_p INT, IN episode_num_p INT)
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
    WHERE id1 = user_id_p AND podcast_id = podcast_id_p AND episode_num = episode_num_p AND status = "accepted"
    ORDER BY created_at DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_user_friends_podcast_reviews` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_user_friends_podcast_reviews`(IN user_id_p INT, IN podcast_id_p INT)
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
    WHERE id1 = user_id_p AND podcast_id = podcast_id_p AND status = "accepted"
    ORDER BY created_at DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_user_log_in_details` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_user_log_in_details`(IN username_p VARCHAR(32))
BEGIN
	IF NOT EXISTS (SELECT * FROM user WHERE username = username_p) THEN
		SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT = "Invalid username and/or password";
	ELSE
		SELECT id, username, password_hash FROM user WHERE username = username_p;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_user_podcast_reviews` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_user_podcast_reviews`(IN user_id_p INT)
BEGIN
    IF NOT EXISTS (SELECT * FROM user WHERE id = user_id_p) THEN
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT = "User not found";
    END IF;
    
    SELECT user_id, username, first_name, last_name, podcast_id, podcast.name AS podcast_name, rating, comment, created_at FROM user AS u
    JOIN podcast_review AS pr ON u.id = pr.user_id
    JOIN podcast USING (podcast_id)
    WHERE pr.user_id = user_id_p
    ORDER BY created_at DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_episode_review` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_episode_review`(IN user_id_p INT, IN podcast_id_p INT, IN episode_num_p INT, IN rating_p INT, IN comment_p VARCHAR(255))
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_podcast_review` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_podcast_review`(IN user_id_p INT, IN podcast_id_p INT, IN rating_p INT, IN comment_p VARCHAR(255))
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `reject_friend_request` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `reject_friend_request`(IN user_id_p INT, IN user_to_reject_id_p INT)
BEGIN
	IF EXISTS (
		SELECT * FROM user_to_user
        WHERE id1 = user_to_reject_id_p AND id2 = user_id_p
	) THEN
		DELETE FROM user_to_user WHERE id1 = user_to_reject_id_p AND id2 = user_id_p;
	ELSE
		SIGNAL SQLSTATE "45000"
		SET MESSAGE_TEXT="Unable to reject friend";
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `remove_episode_from_playlist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `remove_episode_from_playlist`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `search_episodes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `search_episodes`(
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
    SELECT 
        DISTINCT episode.podcast_id AS podcast_id, 
        episode.episode_num AS episode_num, 
        episode.name AS name, 
        description, 
        duration, 
        release_date 
    FROM episode
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `search_podcasts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `search_podcasts`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `send_friend_request` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `send_friend_request`(IN user_id_p INT, IN user_to_request_id_p INT)
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_bio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_bio`(user_id_p INT, bio_p TEXT)
BEGIN
	IF LENGTH(bio_p) > 255 THEN
		SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT="Bio too long";
	END IF;
	IF NOT EXISTS (SELECT * FROM user WHERE id = user_id_p) THEN
		SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT="User not found";
	END IF;
    
	UPDATE user
    SET bio = bio_p WHERE id = user_id_p;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_episode_review` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_episode_review`(IN user_id_p INT, IN podcast_id_p INT, IN episode_num_p INT, IN rating_p INT, IN comment_p VARCHAR(255))
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_podcast_review` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_podcast_review`(IN user_id_p INT, IN podcast_id_p INT, IN rating_p INT, IN comment_p VARCHAR(255))
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-04 23:26:33
