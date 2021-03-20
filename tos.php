<?php
//This barely needs to be a PHP file, an HTML file would almost work
//But the cookie only stores the userId, so to display a welcome message, database access is required

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

//Check if the cookies currently record the user as being logged in
if(isset($_COOKIE["userid"])){
	$loggedin = True; //Logged in as user with the userid value
	$userid =$_COOKIE["userid"];
	$username = mysqli_query($connection, "SELECT username FROM t_user WHERE id=" . $userid . ";");
} else{
	$loggedin = False;
}

//Close connection now that username (if applicable) is known
mysqli_close($connection);

?>


<!DOCTYPE html>
<html>

<head>
	<title>Log In</title>
	<!-- basic meta data for webpage -->
	<meta charset="utf-8">
	<meta name="Keywords" content="photos, sharing, tags, location">

	<!-- import style sheet -->
	<link rel="stylesheet" href="stylesheet.css">

	<!--FontAwesome 5.7.2-->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css"
integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">


</head>

<body>

	<section id="logo">
		<div id="header" class="header">
			<div class="logo">
				<h1>Go-To</h1>
				<h2>Photos on the go</h2>
				<img src="images-slideshow\Go-to logo.png" alt="logo">
			</div>
		</div>
	</section>
	
	<section id="Login">
		<div id="login" class="login">
				<?php
					if ($loggedin){
						echo "<ul> <li> <a href="profile.php">Welcome, " . $username . "</a> </li> </ul>";
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
				
				<h1>Welcome. Before signing up, please read the following terms and conditions.</h1>
				
				<p>1. Any photograph you upload to the service must have no people in it. This includes all photographs, and all people.</p>
				<p>2. All images you upload must be a photograph that you have taken, and its copyright must not belong to any other individual.</p>
				<p>3. Do not upload anything illegal.</p>
				<p>4. Respect other users of the platform.</p>
				<p>5. Do not attempt to hack or otherwise abuse our website or we may terminate your account immediately.</p>
				<p>6. Try to keep things varied. Don't upload very similar pictures to ones that you have already posted, it is much more interesting to see something new. We hope you will see many things you haven't seen before here on Go-To!</p>

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