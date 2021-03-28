<?php
//Receive database login from file
$file = fopen("database_login.csv","r");
$logindetails = fgetcsv($file);
fclose($file);

//Set up SQL connection
$connection = mysqli_connect($logindetails[0], $logindetails[1], $logindetails[2], $logindetails[3]);
if (mysqli_connect_errno()) {
	echo "Failed to connect to MySQL: " . mysqli_connect_error();
	exit();
}

//Only proceed when the button is clicked
if(isset($_POST['reset'])){
	
	//Delete the cookie (log the current user out)
	setcookie("userId", "", time() - 3600);
	
	//Delete user avatars
	foreach(glob("avatars/*") as $file ) {
		if(basename($file) != "default.png"){
			unlink($file);
		}
	}

	//Delete uploaded photographs (keep the logo, and the test image)
	foreach(glob("uploads/*") as $file ) {
		if(basename($file) != "logo.png" && basename($file) != "test.png"){
			unlink($file);
		}
	}

	//Define the permanent PHP pages to keep
	$permanentPhp = array('avatar.php', 'index.php', 'leaderboard.php', 'login.php', 'profile.php', 'reset.php', 'tos.php', 'upload.php', 'water.php', 'landscape.php', 'structures.php', 'indoors.php', 'animals.php', 'wilderness.php', 'other.php', );

	//Get rid of user pages
	foreach(glob("*.php") as $file) {
		if(!in_array(basename($file), $permanentPhp)){
			unlink($file);
		}
	}

	//Reset the database.
	//Note that TRUNCATE in MySQL removes all data without clearing the database.
	//This would be a more efficient way to write this, were it not for it requiring that the table already exists.
	//This way, reset.php can also start up the database for the first time
	
	//Drop t_files
	mysqli_query($connection,
		"DROP TABLE IF EXISTS t_files CASCADE"
	);
	
	//Initialise t_files
	mysqli_query($connection,
		"CREATE TABLE t_files(
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
			PRIMARY KEY (id))"
	);
	
	// ------------------------
	
	//Drop t_user
	mysqli_query($connection,
		"DROP TABLE IF EXISTS t_user CASCADE"
	);
	
	//Initialise t_user
	mysqli_query($connection,
		"CREATE TABLE t_user(
		id INTEGER, 
		username VARCHAR(80) UNIQUE, 
		password CHAR(60), 
		email VARCHAR(80), 
		avatar TINYINT(4), 
		moderator BOOLEAN, 
			PRIMARY KEY (id))"
	);
	
	// ------------------------
	
	//Drop t_votes
	mysqli_query($connection,
		"DROP TABLE IF EXISTS t_votes CASCADE"
	);
	
	//Initialise t_votes
	mysqli_query($connection,
		"CREATE TABLE t_votes(
		userId INTEGER, 
		photoId INTEGER, 
			PRIMARY KEY (userId, photoId))"
	);
	
	// ------------------------
	
	//Drop t_follows
	mysqli_query($connection,
		"DROP TABLE IF EXISTS t_follows CASCADE"
	);
	
	//Initialise t_follows
	mysqli_query($connection,
	"CREATE TABLE t_follows(
	followerId INTEGER, 
	followingId INTEGER, 
	PRIMARY KEY (followerId, followingId))"
	);
	
	// ------------------------
	
	//Create the score view (which will have been lost due to cascade)
	mysqli_query($connection,
		"CREATE VIEW t_scores AS 
		SELECT	scorer, 
				scorerId, 
				SUM(photoScores.photoScore) AS score 
		FROM	(SELECT ((COUNT(t_votes.userId)*2) / (DATEDIFF(CURDATE(), DATE(t_files.uploadtime))+1)) AS photoScore, 
					t_user.username AS scorer, 
					t_user.id AS scorerId 
				FROM t_votes 
				JOIN t_files ON t_votes.photoId=t_files.id 
				JOIN t_user ON t_files.userId=t_user.id 
				GROUP BY t_votes.photoId) AS photoScores;"
	);
	
	
	//The database has now been reset.
	
	// ------------------------
	
	//Add in test data
	//A normal user
	mysqli_query($connection, 
	"INSERT INTO t_user 
	(id, username, password, email, avatar, moderator) 
	VALUES ('777', 'avery', '" . password_hash("Christian Lion Hearted Man Will Show You", PASSWORD_DEFAULT) . "', 'example@website.com', 0, 0)");
	//An admin user
	mysqli_query($connection, 
	"INSERT INTO t_user 
	(id, username, password, email, avatar, moderator) 
	VALUES ('13', 'admin', '" . password_hash("password123123", PASSWORD_DEFAULT) . "', 'example@email.com', 0, 1)"
	);
	//A photo
	mysqli_query($connection, 
	"INSERT INTO t_files 
	(id, oldFileName, newFileName, ext, path, uploadtime, category, userId) 
	VALUES (15, 'test.png', 'test', 'png', 'uploads/', NOW(), 'water', 777)"
	);
	//A vote
	mysqli_query($connection, 
	"INSERT INTO t_votes (userId, photoId) VALUES (13, 15)"
	);
	//A follow (probably not necessary)
	mysqli_query($connection, 
	"INSERT INTO t_follows (followerId, followingId) VALUES (777, 13)"
	);
	//Create a php file for the new users' profiles, the same way as in login.php
		$newFile = fopen("avery.php", "w");
		$templateFile = fopen("part2.txt", "r") or die("Unable to open file!");
		fwrite($newFile, "<?php\r\n\$profileUser = 777" . fread($templateFile, filesize("part2.txt")));
		fclose($templateFile);
		fclose($newFile);
		$newFile = fopen("admin.php", "w");
		$templateFile = fopen("part2.txt", "r") or die("Unable to open file!");
		fwrite($newFile, "<?php\r\n\$profileUser = 13" . fread($templateFile, filesize("part2.txt")));
		fclose($templateFile);
		fclose($newFile);
	//Remember that the deletion has been successful
	$deleted = true;

}else{
	$deleted = false;
}


?>
<!DOCTYPE html>
<html>
<body>
<!--Don't use any CSS here. It's supposed to look scary and intimidating to match its danger !-->
<h2>RESET DATA</h2>
<p>WARNING! If you click the below button, all existing data will be lost / reset. Only click this if you are fine with losing all data.</p>
<p>(This feature should <b>never</b> be accessible to anyone outside of testing purposes.)</p>
<form action="" method="post">
   <input id="reset" type="submit" onclick="getElementById('reset').value='Resetting...';" name="reset" value="Reset">
</form> 
<?php
	if($deleted){
		echo "<p>All data has been reset!</p>";
	}
?>
<p><a href='index.php'>Return to main page</a></p>

</body>
</html>