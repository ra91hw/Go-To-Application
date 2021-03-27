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
		<title>Go-To</title>
		<!-- basic meta data for webpage -->
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale: 1.0">
		<meta name="Keywords" content="photos, sharing, tags, location">
		
		<!-- import style sheet -->
		<link rel="stylesheet" href="stylesheet.css">
		
		<!-- import icon -->
		<link rel="shortcut icon" href="favicon.ico" type="image/x-icon"/>
		
		<!-- https://www.w3schools.com/tags/tag_table.asp !-->
		<!-- In this file only, since it would ruin the look of the index file -->
		<style>
		table, th, td {
		border: 1px solid black;
		border-collapse: collapse;
		text-align: center;
		}
		
		table {
			width: 100%;
		}
		</style>

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
						<input type="file" name="fileToUpload" onchange="" id="fileToUpload">
						<label for="cars">Select category:</label>
						<select id="categories" name="categories">
							<option value="landscape">Landscape</option>
							<option value="water">Water</option>
							<option value="structures">Structures</option>
							<option value="indoors">Indoors</option>
							<option value="animals">Animals</option>
							<option value="wilderness">Wilderness</option>
							<option value="messages">Messages</option>
							<option value="messages" selected>Other</option>
						</select><br>
						<input type="submit" onclick="getElementById('imageUpload').value='Uploading...';" value="Go" id="imageUpload">
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
						<li><a href="messages.php">Messages</a></li>
						<li><a href="messages.php">Other</a></li>
					</ul>
				</div>
			</div>
		</section>
		
		<section id="content">
			<div id="pictures" class="pictures">
				<div class="content">
					<h1>Top 20:</h1>
					<?php
						$query = "SELECT scorer, score, scorerId, t_user.avatar AS avatarExt FROM t_scores JOIN t_user ON t_scores.scorerId = t_user.id ORDER BY score LIMIT 20";
						$topScorers = mysqli_query($connection, $query);
						//Count how many scorers there are, up to 20.
						//This allows for working out if the limit of 20 is reached, and fill it in with blanks if it isn't
						$scorerCount = mysqli_num_rows($topScorers);
							
						$position = 1;	//Use this to count the position each user is in
						echo "<table>"; // begin table
						echo "<tr> <th>#</th> <th>User</th> <th>Score</th> </tr>";	//Output header row
						if($scorerCount > 0){
							//Start adding results from the database - but the table has been started already, as there will always be a table, even without results
							while($highScorer = mysqli_fetch_array($topScorers)){   // for each of the top 20
								
								//Find the filename of the user's avatar
								switch ($highScorer['avatarExt']){
									case 0:	//default
										$avFile = "default.png";
										break;
									case 1:	//jpg
										$avFile = $highScorer["scorerId"] . ".jpg";
										break;
									case 2:	//png
										$avFile = $highScorer["scorerId"] . ".png";
										break;
									case 3:	//gif
										$avFile = $highScorer["scorerId"] . ".gif";
										break;
								}
								
								if($loggedin && $username == $highScorer['scorer']){	//Show the user the profile page if the user on the leaderboard happens to be them
									echo "<tr> <td> <p>" . $position++ . "</p> </td> <td> <p> <a href='profile.php'>" . $highScorer['scorer'] . "</a> <img src='avatars/" . $avFile . "' width='30' height='30'> </p> </td> <td>" . $highScorer['score'] . "</td> </tr>";  
								}else{
									echo "<tr> <td> <p>" . $position++ . "</p> </td> <td> <p> <a href='" . $highScorer['scorer'] . ".php'>" . $highScorer['scorer'] . "</a> <img src='avatars/" . $avFile . "' width='30' height='30'> </p> </td> <td> <p>" . $highScorer['score'] . "</p> </td> </tr>";
								}
								//$position is updated each time it's referenced
							}
						}
						//Fill in the rest of the rows of the table that may have been missed
						if ($scorerCount < 20){
							while ($position <= 20){
								echo "<tr> <td> <p>" . $position++ . "</p> </td> <td> <p> --- <img src='avatars/goto.png' width='30' height='30'> </p> </td> <td> <p> - </p> </td> </tr>"; 
							}
						}
						echo "</table><br>"; // end table (not sure why the <br> is there, but I used it earlier so I guess I'll just leave it. Won't cause any problems at least
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
