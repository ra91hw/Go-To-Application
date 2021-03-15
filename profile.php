<?php
//Test, creates a cookie showing the user as being logged in using the account with id 1234
//$cookie_name = "userid";
//$cookie_value = "1234";
//setcookie($cookie_name, $cookie_value, time() + (86400 / 2), "/"); // 86400 = 1 day

//Set up SQL connection
$connection = mysql_connect('localhost', 'root', '');
mysql_select_db('userfiles');
if(!isset($_COOKIE["userid"])){
	header("Location: index.php");	//Redirect back to the main index. There's nothing to show if the user isn't logged in.
	die();
}else{
	$userid =$_COOKIE["userid"];
	$loggedin = True;
	$username = mysql_query("SELECT username FROM t_user WHERE id=" . $userid . ";");
}

?>

<!DOCTYPE html>
<html>
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
				<script>
					function logout() {
						//Delete the cookie storing who is logged in
						//WARNING: IF THIS IS POSSIBLE, THEN IT IS PROBABLY POSSIBLE TO EDIT THE COOKIES TO "LOG IN" AS SOMEONE ELSE WITHOUT USING THE PASSWORD
						//AJAX MIGHT NEED TO BE USED TO GET AROUND THIS
						document.cookie = "userid=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
					} 
				</script>
				<ul> <li> <p> <a onClick='logout();' >Logged in as <?php echo $username ?>. Log out?</a> </p> </li> </ul>
				
				echo "<ul> <li> <p>Welcome, " . $username . "</p> </li> </ul>"; //NEEDS A LOG OUT OPTION
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
				
						<h1>Images uploaded by <?php echo $username?>.</h1>
						<?php 
							

							$query = "SELECT CONCAT(newFileName, '.', ext) AS imgname FROM t_files WHERE userid=" . $userid . " LIMIT 20"; //Gets 20 file names including extension, out of those uploaded by the currently logged in user
							$result = mysql_query($query);

							echo "<table>"; // begin table

							while($image = mysql_fetch_array($result)){   // for each image returned
							echo "<tr> <td> <img src = '" . $image['imgname'] . "'>";  //$image['index'] the index here is a field name
							echo " </td> </tr>"
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