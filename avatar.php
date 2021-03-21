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


//https://www.w3schools.com/php/php_file_upload.asp
$target_dir = "avatars/";
$old_filename = $target_dir . basename($_FILES["fileToUpload"]["name"]);
$uploadOk = 1;
$imageFileType = strtolower(pathinfo($old_filename,PATHINFO_EXTENSION));
// Check if image file is a actual image or fake image
if(isset($_POST)) {
	$check = getimagesize($_FILES["fileToUpload"]["tmp_name"]);
	if($check != false) {
		//It seems using mime check is exploitable - This should be changed if there is time!
		// echo "File is an image - " . $check["mime"] . ".";
		
		// Check file size
		if ($_FILES["fileToUpload"]["size"] > 500000) {	//This limit can be changed
			$errorMessage = "File size too large!";
			$uploadOk = 0;
		}
		
		//jpeg and jpg reference the same file format
		if($imageFileType == "jpeg"){
			$imageFileType = "jpg";
		}
		
		// Allow certain file formats
		if($imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "gif") {
			$errorMessage = "Invalid file format. Please submit a png, jpg or gif!";
			$uploadOk = 0;
		}
		//By this point, the image is confirmed valid
		}
	} else {
		$errorMessage = "File is not an image.";
		$uploadOk = 0;
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
		mysqli_free_result($result);
	} else{
		$loggedin = False;
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
					echo "<ul> <li> <a href='profile.php'>Welcome, " . $username . "</a> </li> </ul>"; //PROFILE PAGE NEEDS A LOG OUT OPTION
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
					<form action="upload.php" method="post" enctype="multipart/form-data">
						<input type="file" name="fileToUpload" onchange="form.submit()" id="fileToUpload">
					</form>
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
						<!--THIS IS WHERE PAGE CONTENT GOES!-->
						<?php
							if($uploadOk){
								//If image filters are to be added, this is the area where that process goes
								
								//Create a new name for the file
		
								//Both username and id are unique
								//By using the ID rather than the username, it would be easier to allow accounts to change their username, should that feature ever be implemented (it almost definitely won't)
								//It will come at the security cost of making it trivially easy to find out someone else's ID (by just checking the URL of their avatar, if they have one set).
								//If it's possible for a user to create a cookie storing an arbritary userId, then it would be very easy to gain access to anyone's account through this
								//That being said, the security flaw here is mainly being able to create cookies like that, so the priority should be to fix that instead
								$new_filename = $target_dir . $userId . "." . $imageFileType;
								
								//Delete any pre-existing avatar
								//Could use unlink($target_dir . $userId . ".*") but this should cover everything
								//Maybe this is more efficient? (only checks 3 possibilities) 
								//Either way, it's nicer only deleting files after explicitly naming them, there's absolutely no room for accidentally deleting *.* or anything
								foreach (array(".jpg", ".png", ".gif") as &$extension) {
									if(file_exists($target_dir . $userId . "." . $extension)){
										echo "<p>" . $target_dir . $userId . $extension . "</p>";
										unlink($target_dir . $userId . $extension);
									}else{
										echo "<p>There is no " . $target_dir . $userId . $extension . "</p>";
									}
								}
								unset($extension);
															
								//Attempt to upload the image
								//echo "<p>" . $_FILES["fileToUpload"]["tmp_name"] . "</p>";
								echo "<p>Moving ". $_FILES["fileToUpload"]["tmp_name"] . " to " .$new_filename  . "</p>";
								if (move_uploaded_file($_FILES["fileToUpload"]["tmp_name"],  $new_filename)) {
									//NO DATABASE INVOLVEMENT REQUIRED
									echo "<h1>Successfully changed profile picture!</h1>";
									echo "<a href='index.php'>Return to main page...</a>";
								} else {
									echo "<p>Unexpected error in uploading your file. Please try again!</p>";
								}
								//echo "<p>Success! " . $new_filename . "</p>";
							}else{
								echo "<h1>UPLOAD FAILED: ". $errorMessage . "</h1>";
								echo "<a href='index.php'>Return to main page...</a>";
							}	
						?>
						
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
