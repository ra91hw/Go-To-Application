<?php
//Open database_login.csv, storing the login details to the mysql database
//database_login.csv should contain 4 values:
//	1. host
//	2. username
//	3. password
//	4. database name
$file = fopen("database_login.csv","r");
$logindetails = fgetcsv($file);
fclose($file);

//Set up SQL connection
$connection = mysqli_connect($logindetails[0], $logindetails[1], $logindetails[2], $logindetails[3]);

if (mysqli_connect_errno()) {
	echo "Failed to connect to MySQL: " . mysqli_connect_error();
	exit();
}

//Find the page number of results to display
if(isset($_GET["page"])){
	//There's a certain page number of photos to use
	$page = $_GET["page"];
} else{
	//Default to 0 to show first results
	$page = 0;
}
?>

<!DOCTYPE html>
<html>
	<?php
	//Check if the cookies currently record the user as being logged in
	if(isset($_COOKIE["userId"])){
		$loggedin = True; //Logged in as user with the userId value
		$userId =$_COOKIE["userId"];
		$result = mysqli_query($connection, "SELECT username FROM t_user WHERE id = " . $userId);
		$username = mysqli_fetch_array($result)[0];
	} else{
		$loggedin = False;
	}
	
	//Vote or unvote images.
	//If the relevant button was available to be clicked, then the record exists / is absent as required.
	if(isset($_POST["vote"])){
		//Need to add a vote for user = $userId, image = $_POST["vote"]
		mysqli_query($connection, "INSERT INTO t_votes (userId, photoId) VALUES (" . $userId . ", " . $_POST["vote"] . ")");
	}
	if(isset($_POST["unvote"])){
		//Need to remove the vote for user = $userId, image = $_POST["unvote"]
		mysqli_query($connection, "DELETE FROM t_votes WHERE userId = " . $userId . " AND photoId = " . $_POST["unvote"]);
	}
	
	?>
	<head>
		<title>Landscapes</title>
		<!-- basic meta data for webpage -->
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale: 1.0">
		<meta name="Keywords" content="photos, sharing, tags, location">
		
		<!-- import style sheet -->
		<link rel="stylesheet" href="stylesheet.css">
		
		<!-- import icon -->
		<link rel="shortcut icon" href="favicon.ico" type="image/x-icon"/>
		
		<!--FontAwesome 5.7.2-->
		<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css"
		integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">

		<!-- import javascript -->
		<script src="script.js"></script>
		<script>
			function signOut() {
				//Set expiry date to the past so the login cookie disappears
				document.cookie = "userId=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
				window.location.replace("index.php");
			}
		</script>
	</head>
	<body>
	
		<section id="logo">
			<div id="header" class="header">
				<div class="logo">
					<h1><a href="index.php" style="text-decoration: none !important">Go-To</a></h1>
					<h2>Photos on the go</h2>
				</div>
			</div>
		</section>
		
		<section id="Login">
			<div id="login" class="login">
				<?php
				if ($loggedin){
					echo "<ul> <li> <a href='profile.php'>Welcome, " . $username . "</a> </li> </ul>";
				} else{
					echo "<ul> <li> <a href='login.php'>Log in / Register</a> </li> </ul>";
				}
				?>
			</div>
		</section>
		
		<section id="Upload">
			<div id="uploader" class="uploader">
				<div class="upload">
					<h3 style="line-height: 0.7em;">Upload a Photo</h3>
					<form action="upload.php" method="post" enctype="multipart/form-data">
						<input type="file" name="fileToUpload" onchange="form.submit()" id="fileToUpload">
						<label for="cars">Select category:</label>
						<select id="categories" name="categories">
							<option value="landscape">Landscape</option>
							<option value="water">Water</option>
							<option value="structures">Structures</option>
							<option value="indoors">Indoors</option>
							<option value="animals">Animals</option>
							<option value="wilderness">Wilderness</option>
							<option value="other" selected>Other</option>
						</select><br>
						<input type="submit" value="Go">
					</form>
				</div>
			</div>
		</section>
		
		<section id="Popular">
			<div id="menu" class="menu">
				<div class="popular">
					<h3>Categories</h3>
					<ul>
						<li><a href="landscape.php">Landscapes</a></li>
						<li><a href="water.php">Water</a></li>
						<li><a href="structures.php">Structures</a></li>
						<li><a href="indoors.php">Indoors</a></li>
						<li><a href="animals.php">Animals</a></li>
						<li><a href="wilderness.php">Wilderness</a></li>
						<li><a href="other.php">Other</a></li>
					</ul>
				</div>
			</div>
		</section>
		
		<section id="content">
			<div id="pictures" class="pictures">
				<div class="content">
						<h1>Sometimes it's good to get the bigger picture of the world.</h1>
						<h2>Recently uploaded landscape photos:</h2>
						<?php 
							$query = "SELECT CONCAT(path, newFileName, '.', ext) AS imgname, t_files.id AS imgId, t_user.id AS userId, t_user.username AS username, t_user.avatar AS avatarExt FROM t_files JOIN t_user ON t_files.userId=t_user.id WHERE category='landscape' ORDER BY t_files.uploadtime DESC LIMIT 20 OFFSET " . ($page*20); //Gets 20 file names including extension
							
							//Count the results of a different query (since the previous one is limited)
							$photoCount = mysqli_num_rows(mysqli_query($connection, "SELECT CONCAT(newFileName, '.', ext) AS imgname, t_user.id AS userId, t_user.username AS username FROM t_files JOIN t_user ON t_files.userId=t_user.id WHERE category='landscape'"));
							
							//NOTE: Tags have NOT yet been implemented on uploading. Once the database supports it, using "SELECT CONCAT(newFileName, '.', ext) AS imgname FROM t_files WHERE [tag field name] = [desired tag name] LIMIT 20" should work. This can be copied across each of the pages on the menu at the side (i.e. for what is currently listed as Ocean, Forest, Skyline and Animals
								
								
							if($photoCount > 0){
								$result = mysqli_query($connection, $query);

								echo "<table>"; // begin table

								while($image = mysqli_fetch_array($result)){   // for each image returned
									echo "<tr> <td> <img src = '" . $image['imgname'] . "' style='max-height:600px;height:100%'>";  //$image['index'] the index here is a field name
									
									//Display vote option
									if($loggedin && $userId != $image['userId']){
										$imageId = $image['imgId'];
										//1 if user has voted on the current image, 0 if not
										$voted = mysqli_num_rows(mysqli_query($connection, "SELECT * FROM t_votes WHERE userId = " . $userId . " AND photoId = " . $imageId . " LIMIT 1"));
										
										//Create a link to either vote or unvote an image
										echo "<form action = '' method = 'POST'>";
										if ($voted){
											//User has voted on this image
											echo "<button name='unvote' type='submit' value=" . $imageId . ">Unvote</button>";
										}else{
											//User has not voted on this image
											echo "<button name='vote' type='submit' value=" . $imageId . ">Vote</button>";
										}
										echo "</form>";
									}
									if(!$loggedin || $userId != $image['userId']){
										echo "<p> Uploaded by <a href='" . $image['username'] . ".php'>" . $image['username'] . "</a>  ";
									}else{
										echo "<p> Uploaded by <a href='profile.php'>" . $image['username'] . "</a>  ";
									}
									
									//Find the filename of the user's avatar
									switch ($image['avatarExt']){
										case 0:	//default
											$avFile = "default.png";
											break;
										case 1:	//jpg
											$avFile = $image["userId"] . ".jpg";
											break;
										case 2:	//png
											$avFile = $image["userId"] . ".png";
											break;
										case 3:	//gif
											$avFile = $image["userId"] . ".gif";
											break;
									}
									
									echo "<img src='avatars/" . $avFile . "' width='40' height='40'> </p> <hr> </td> </tr>";
								}

								echo "</table> <br>"; // end table
								
								//Have options to cycle through pages of results
								echo "<form action = '' method = 'GET'>";
								if($page > 0){
									//Not the first page - can go back any earlier!
									//Display a previous page button, setting page to the current value of page - 1
									echo "<button name='page' type='submit' value=" . ($page - 1) . ">Previous</button>";
								}
								if(($page + 1) * 20 < $photoCount){
									//There are photos remaining
									//Display a previous page button, setting page to the current value of page - 1
									echo "<button name='page' type='submit' value=" . ($page + 1) . ">Next</button>";
								}
								echo "</form>";
							}else{
								echo "<p>No photos found...</p>";
							}
							//Finished with the database
							mysqli_close($connection); ?>
						<!--<h1> Content from Database above </h1>!-->
				</div>
			</div>
		</section>	
			
		<section class="footer">
			<div id="footer" class="footer">
				<i class="far fa-copyright" style="font-size:1.2em">2021 - Enterprise Development, Inc. All rights reserved</i>
				<div style="font-size:1.5em">
					<a href="https://github.com/ra91hw/Go-To-Application" title="GitHub" target="_blank" id="gh"><i class="fab fa-github"></i> Github</a> &nbsp;| &nbsp;
					<a href="http://facebook.com" title="Facebook" target="_blank" id="fb"><i class="fab fa-facebook"></i> Facebook</a>  &nbsp;| &nbsp;
					<a href="http://twitter.com" title="Twitter" target="_blank" id="tw"><i class="fab fa-twitter"></i> Twitter</a> &nbsp;| &nbsp;
					<a href="http://instagram.com" title="Instagram" target="_blank" id="insta"><i class="fab fa-instagram"></i>Instagram</a>
				</div>
			</div>
		</section>
		
	</body>
</html>	
