-- WARNING! THIS DELETES ALL DATA IN THE DATABASE
-- DO NOT USE THIS UNLESS YOU WANT TO DELETE ALL DATA FROM THE DATABASE
-- PHOTOS (IN uploads/) AND AVATARS (IN avatars/) MUST BE DELETED SEPERATELY
-- (NOTE: This doesn't actually remove the tables, but just the content, so the Go-To website is still usable)

--BEST NOT TO USE THIS THOUGH - USE reset.php INSTEAD

TRUNCATE TABLE t_files;
TRUNCATE TABLE t_user;
TRUNCATE TABLE t_votes;
TRUNCATE TABLE t_follows;