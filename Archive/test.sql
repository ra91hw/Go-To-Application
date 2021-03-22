-- This file should now be used. Though the test data should be removed first probably

create table t_files(id integer, oldFileName varchar(200), newFileName varchar(300), ext varchar(20), path varchar(300), size varchar(200), isImg varchar(8), downloadcounts varchar(6), uploadtime date, userId integer, PRIMARY KEY (id));
create table t_user(id integer, username varchar(80) UNIQUE, password varchar(80), email varchar(80), avatar tinyint(4), PRIMARY KEY (id));
create table t_votes(userId integer, photoId integer, PRIMARY KEY (userId, photoId));


insert into t_files(id, newFileName, ext, userId) values(1, "photo", "png", 12);
insert into t_user(id, username) values(12, "John");
insert into t_user(id, username) values(13, "JOHNN");
insert into t_files(id, newFileName, ext, userId, uploadtime, avatar) values(2, "photo2", "jpg", 12, "2021-03-20", 0);
insert into t_files(id, newFileName, ext, userId, uploadtime, avatar) values(3, "photo3", "jpg", 12, "2021-03-20", 0);
insert into t_files(id, newFileName, ext, userId, uploadtime, avatar) values(4, "photo4", "jpg", 12, "2021-03-20", 0);
insert into t_files(id, newFileName, ext, userId, uploadtime, avatar) values(5, "photo5", "jpg", 12, "2021-03-20", 0);
insert into t_files(id, newFileName, ext, userId, uploadtime, avatar) values(6, "photo6", "jpg", 12, "2021-03-20", 0);
insert into t_files(id, newFileName, ext, userId, uploadtime, avatar) values(7, "photo7", "png", 12, "2021-03-20", 0);
insert into t_files(id, newFileName, ext, userId, uploadtime, avatar) values(8, "photo8", "jpg", 13, "2021-03-20", 0);
insert into t_files(id, newFileName, ext, userId, uploadtime, avatar) values(9, "photo9", "jpg", 12, "2021-03-20", 0);

insert into t_votes(id, userId, photoId) values(1, 12, 2);
insert into t_votes(id, userId, photoId) values(2, 13, 1);
insert into t_votes(id, userId, photoId) values(3, 13, 2);
insert into t_votes(id, userId, photoId) values(4, 12, 3);
-- SELECT CONCAT(newFileName, '.', ext) AS imgname, username FROM t_files JOIN t_user ON t_files.userId=t_user.id LIMIT 20;
-- SELECT username, COUNT(t_votes.id) AS totalVotes FROM t_votes LEFT JOIN t_files ON t_votes.userId = t_files.userId JOIN t_user ON t_user.id = t_files.userId GROUP BY t_files.userId; <-doesn't work yet