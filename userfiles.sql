-- Create the required tables

CREATE TABLE t_files(
	id INTEGER,
	oldFileName VARCHAR(200),
	newFileName VARCHAR(300),
	ext VARCHAR(20),
	path VARCHAR(300),
	size VARCHAR(200),
	isImg VARCHAR(8),
	downloadcounts VARCHAR(6),
	uploadtime DATETIME,
	category VARCHAR(20),
	userId INTEGER,
		PRIMARY KEY (id));


-- -------------------------------------------------------------------------------------------------------

CREATE TABLE t_user(
	id INTEGER,
	username VARCHAR(80) UNIQUE,
	password CHAR(60),
	email VARCHAR(80),
	avatar TINYINT(4),
		PRIMARY KEY (id));


-- -------------------------------------------------------------------------------------------------------

CREATE TABLE t_votes(
	userId INTEGER,
	photoId INTEGER,
		PRIMARY KEY (userId, photoId));

-- -------------------------------------------------------------------------------------------------------

-- Calculate the scores.
-- Score per user is calculated as:
-- Σ(For all photos uploaded by that user, {(2*|{Votes on an image}|)/([number of days since upload]+1)})
-- This means each vote is worth 2 points when on a photo the day it is uploaded, 1 point the next day, ~0.7 the next, and so on, gradually decreasing.
CREATE VIEW t_scores AS
SELECT	scorer,
		scorerId,
		SUM(photoScores.photoScore) AS score
FROM	(SELECT ((COUNT(t_votes.userId)*2) / (DATEDIFF(CURDATE(), DATE(t_files.uploadtime))+1)) AS photoScore,
         	t_user.username AS scorer,
         	t_user.id AS scorerId
		FROM t_votes
		JOIN t_files ON t_votes.photoId=t_files.id
		JOIN t_user ON t_files.userId=t_user.id
		GROUP BY t_votes.photoId) AS photoScores;
		
-- -------------------------------------------------------------------------------------------------------	

-- Below is some test data, giving an example of what kind of content may go in the database
-- However, it is best avoided, since it references photos that don't exist, so they will display as errors
-- Using the website itself to upload images properly is the best way

-- insert into t_files(id, newFileName, ext, userId) values(1, "photo", "png", 12);
-- insert into t_user(id, username) values(12, "john");
-- insert into t_user(id, username) values(13, "johnn");
-- insert into t_files(id, newFileName, ext, userId, uploadtime, avatar) values(2, "photo2", "jpg", 12, "2021-03-20", 0);
-- insert into t_files(id, newFileName, ext, userId, uploadtime, avatar) values(3, "photo3", "jpg", 12, "2021-03-20", 0);
-- insert into t_files(id, newFileName, ext, userId, uploadtime, avatar) values(4, "photo4", "jpg", 12, "2021-03-20", 0);
-- insert into t_files(id, newFileName, ext, userId, uploadtime, avatar) values(5, "photo5", "jpg", 12, "2021-03-20", 0);
-- insert into t_files(id, newFileName, ext, userId, uploadtime, avatar) values(6, "photo6", "jpg", 12, "2021-03-20", 0);
-- insert into t_files(id, newFileName, ext, userId, uploadtime, avatar) values(7, "photo7", "png", 12, "2021-03-20", 0);
-- insert into t_files(id, newFileName, ext, userId, uploadtime, avatar) values(8, "photo8", "jpg", 13, "2021-03-20", 0);
-- insert into t_files(id, newFileName, ext, userId, uploadtime, avatar) values(9, "photo9", "jpg", 12, "2021-03-20", 0);

-- insert into t_votes(id, userId, photoId) values(1, 12, 2);
-- insert into t_votes(id, userId, photoId) values(2, 13, 1);
-- insert into t_votes(id, userId, photoId) values(3, 13, 2);
-- insert into t_votes(id, userId, photoId) values(4, 12, 3);
-- SELECT CONCAT(newFileName, '.', ext) AS imgname, username FROM t_files JOIN t_user ON t_files.userId=t_user.id LIMIT 20;
-- SELECT username, COUNT(t_votes.id) AS totalVotes FROM t_votes LEFT JOIN t_files ON t_votes.userId = t_files.userId JOIN t_user ON t_user.id = t_files.userId GROUP BY t_files.userId; <-doesn't work yet