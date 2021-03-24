<?php
//Test, creates a cookie showing the user as being logged in using the account with id 1234
//$cookie_name = "userId";
//$cookie_value = "1234";
//setcookie($cookie_name, $cookie_value, time() + (86400 / 2), "/"); // 86400 = 1 day

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
	<head>
		<title>Your Profile</title>
		<!-- basic meta data for webpage -->
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale: 1.0">
		<meta name="Keywords" content="photos, sharing, tags, location">
		
		<!-- import style sheet -->
		<link rel="stylesheet" href="stylesheet.css">
		
		<link rel="shortcut icon" href="favicon.ico" type="image/x-icon"/>
		
		<!--FontAwesome 5.7.2-->
		<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css"
		integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">

		<!-- import javascript -->
		<!--<script src="script.js"></script> -->
		<script>
			function signOut() {
				//Set expiry date to the past so the login cookie disappears
				document.cookie = "userId=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
				window.location.replace("index.php");
			}
		</script>
	</head>
	<body>
		<?php
			if(!isset($_COOKIE["userId"])){
				header("Location: index.php");	//Redirect back to the main index. There's nothing to show if the user isn't logged in.
				die();
			} else{
				$userId =$_COOKIE["userId"];
				$loggedin = True;
				$username = mysqli_fetch_array(mysqli_query($connection, "SELECT username FROM t_user WHERE id=" . $userId . ";"))[0];
				$avExt = mysqli_fetch_array(mysqli_query($connection, "SELECT avatar FROM t_user WHERE id=" . $userId . ";"))[0];
			}
		?>
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
			<?php 
				//Check if the current user is even on the table
				//This only happens if they have a nonzero score
				//The following line returns 1 if the user is there, 0 if there are no users (so true and false)
				if(mysqli_fetch_array(mysqli_query($connection, "SELECT COUNT(*) FROM t_scores WHERE scorerId=" . $userId ))[0]){
					$userScore = mysqli_fetch_array(mysqli_query($connection, "SELECT score FROM t_scores WHERE scorerId=" . $userId ))[0];
					echo "<h1>You're number ";
					//Count the number of people who have equal or higher scores than the current user on the leaderboard
					echo mysqli_fetch_array(mysqli_query($connection, "SELECT COUNT(*) FROM t_scores WHERE score >=" . $userScore))[0];
					echo " of ";
					echo mysqli_fetch_array(mysqli_query($connection, "SELECT COUNT(*) FROM t_scores "))[0];
					echo " on <a href='leaderboard.php'>the leaderboards</a>!</h1>";
				}else{
					echo "<h1>You're not on <a href='leaderboard.php'>the leaderboards</a> yet...</h1>";
					echo "<h1>Post images, get votes, and soon you'll be there!</h1>";
				}
				
					//Find the filename of the user's avatar
					switch ($avExt){
						case 0:	//default
							$avFile = "default.png";
							break;
						case 1:	//jpg
							$avFile = $userId . ".jpg";
							break;
						case 2:	//png
							$avFile = $userId . ".png";
							break;
						case 3:	//gif
							$avFile = $userId . ".gif";
							break;
					}
						
					echo "<img src='avatars/" . $avFile . "' width='100' height='100'> </p> <hr> </td> </tr>";
					?>
					<h3>Change Avatar</h3>
					<form action="avatar.php" method="post" enctype="multipart/form-data">
						<input type="file" name="fileToUpload" onchange="form.submit()" id="fileToUpload">
					</form>
					<p><u><a onClick='signOut();' style="cursor: pointer; cursor: hand;">Sign out</a></u></p>
					<hr>
			
			<h1>Images uploaded by <?php echo $username?>.</h1>
			
			<?php 				
				$query = "SELECT CONCAT(newFileName, '.', ext) AS imgname FROM t_files WHERE userId = " . $userId . " ORDER BY t_files.uploadtime DESC LIMIT 20 OFFSET " . ($page * 20); //Gets 20 file names including extension, out of those uploaded by the currently logged in user
				$result = mysqli_query($connection, $query);
				
				//Note that the full number of photos is yet to be counted, as this is capped at 20. But if there's more than 0, there's more than 0
				if(mysqli_num_rows($result) > 0){
					echo "<table>"; // begin table

					while($image = mysqli_fetch_array($result)){   // for each image returned
						echo "<tr> <td> <img src = 'uploads/" . $image['imgname'] . "' style='max-height:600px;height:100%'>";  //$image['index'] the index here is a field name
						echo " </td> </tr>";
					}

					echo "</table>"; // end table
					
					$photoCount = mysqli_num_rows(mysqli_query($connection, "SELECT CONCAT(path, newFileName, '.', ext) AS imgname FROM t_files WHERE userId = " . $userId));
					
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
					echo "<p>No images found</p>";
				}
				mysqli_close($connection);
			?>
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