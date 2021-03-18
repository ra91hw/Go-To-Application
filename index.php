<?php
//Test, creates a cookie showing the user as being logged in using the account with id 1234
//$cookie_name = "userid";
//$cookie_value = "1234";
//setcookie($cookie_name, $cookie_value, time() + (86400 / 2), "/"); // 86400 = 1 day
?>

<!DOCTYPE html>
<html>
	<?php
	//Check if the cookies currently record the user as being logged in
	if(isset($_COOKIE["userid"])){
		$loggedin = True; //Logged in as user with the userid value
		$userid =$_COOKIE["userid"];
	} else{
		$loggedin = False;
	}
	//Set up SQL connection
	$connection = mysql_connect('localhost', 'root', '');
	mysql_select_db('database');
	if($loggedin){
		$username = mysql_query("SELECT username FROM t_user WHERE id=" . $userid . ";");
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
		
<!--FontAwesome 5.7.2-->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css"
integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">

		<!-- import javascript -->
		<script src="script.js"></script>
	</head>
	<body>
	
		<section id="logo">
			<div id="header" class="header">
				<div class="logo">
					<h1>Go-To</h1>
					<h2>Photos on the go</h2>
				</div>
			</div>
		</section>
		
		<section id="Login">
			<div id="login" class="login">
				<?php
				if ($loggedin){
					echo "<ul> <li> <a href="profile.php">Welcome, " . $username . "</a> </li> </ul>"; //PROFILE PAGE NEEDS A LOG OUT OPTION
				} else{
					echo "<ul> <li> <a href='login.php'>Log in / Register</a> </li> </ul>";
				}
				?>
			</div>
		</section>
		
		<section id="Upload">
			<div id="uploader" class="uploader">
				<div class="upload">
					<h3>Upload a Photo</h3>
					<button type="button" onclick="document.getElementById('file-input').click();">Select File</button>
					<input id="file-input" type="file" name="test" style="display: none;" />
				</div>
			</div>
		</section>
		
		<section id="Popular">
			<div id="menu" class="menu">
				<div class="popular">
					<h3>Popular Channels For You</h3>
					<ul>
						<li><a href="placeholder">Ocean</a></li>
						<li><a href="placeholder">Forest</a></li>
						<li><a href="placeholder">Skyline</a></li>
						<li><a href="placeholder">Animals</a></li>
					</ul>
				</div>
			</div>
		</section>
		
		<section id="content">
			<div id="pictures" class="pictures">
				<div class="content">
					<div id="slideshow">
						<a><img src="images-slideshow\ocean.jpg" alt="ocean"></a>
						<a><img src="images-slideshow\forest.jpg" alt="forest"></a>
						<a><img src="images-slideshow\skyline.jpg" alt="skyline"></a>
					</div>
				
						<h1>Content from Database will go here.</h1>
						<?php 
							//Check if the currently logged in user is a moderator
							//if (!$loggedin){
							//$usermod = False; 
							//} else{
							//	mysql_query("SELECT moderator FROM t_users WHERE ");
							//}//This will need to work out if the user is a moderator, using the database.
							

							$query = "SELECT CONCAT(newFileName, '.', ext) AS imgname, t_user.username FROM t_files JOIN t_user ON t_files.userId=t_user.id LIMIT 20"; //Gets 20 file names including extension
							//NOTE: Tags have NOT yet been implemented on uploading. Once the database supports it, using "SELECT CONCAT(newFileName, '.', ext) AS imgname FROM t_files WHERE [tag field name] = [desired tag name] LIMIT 20" should work. This can be copied across each of the pages on the menu at the side (i.e. for what is currently listed as Ocean, Forest, Skyline and Animals
							//Another thing to add is the ability to cycle through the rest of the images beyond the first 20. To do this, it might be best to filter them out with PHP rather than in the SQL tag?
							$result = mysql_query($query);

							echo "<table>"; // begin table

							while($image = mysql_fetch_array($result)){   // for each image returned
								echo "<tr> <td> <img src = '" . $image['imgname'] . "'>";  //$image['index'] the index here is a field name
								echo "<p> Uploaded by " . $image['username'] . "</p></td> </tr>";
							}

							echo "</table>"; // end table

							mysql_close(); ?>
						<h1> Content from Database above </h1>
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
