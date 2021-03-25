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

//https://www.w3schools.com/php/php_file_upload.asp
$target_dir = "uploads/";
$old_filename = $target_dir . basename($_FILES["fileToUpload"]["name"]);
$uploadOk = 1;
$imageFileType = strtolower(pathinfo($old_filename,PATHINFO_EXTENSION));
// Check if image file is a actual image or fake image
if(isset($_POST)) {
	$check = getimagesize($_FILES["fileToUpload"]["tmp_name"]);
	if($check !== false) {
		//It seems using mime check is exploitable - This should be changed if there is time!
		// echo "File is an image - " . $check["mime"] . ".";
		$uploadOk = 1;
		
		// Check file size
		if ($_FILES["fileToUpload"]["size"] > 50000000) {	//This limit can be changed
			$errorMessage = "File size too large!";
			$uploadOk = 0;
		}
		
		// Check that the user is logged in
		if (!$loggedin){
			$errorMessage = "You need to log in first!";
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
		//By this point, if uploadOk is still 1, the image is confirmed valid
		
		//Create a new name for the file
		if($uploadOk){
			$new_filename = rand(100, 10000000);
			while (file_exists($target_dir . $new_filename . "." . $imageFileType)) {
				//This implementation allows for up to 39999600 file names.
				//That's a maximum of 9999900 for any valid file extension
				//Finding a new valid image will slow down the closer it gets to the maximum capacity
				//But it won't realistically reach the maximum capacity so that shouldn't be a concern at this stage
				$new_filename = rand(100, 10000000);
			}
		}
	} else {
		$errorMessage = "File is not an image.";
		$uploadOk = 0;
	}
}


?>

<!DOCTYPE html>
<html>
	<head>
		<title>Upload Photo</title>
		<!-- basic meta data for webpage -->
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale: 1.0">
		<meta name="Keywords" content="photos, sharing, tags, location">
		<link rel="shortcut icon" href="favicon.ico" type="image/x-icon"/>
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
						<!--THIS IS WHERE PAGE CONTENT GOES!-->
						<?php
							if($uploadOk){
								//If image filters are to be added, this is the area where that process goes
								//Attempt to upload the image
								//echo "<p>" . $_FILES["fileToUpload"]["tmp_name"] . "</p>";
								if (move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_dir . $new_filename . "." . $imageFileType)) {
									$newId = rand(1, 100000000);
									while(mysqli_num_rows(mysqli_query($connection, "SELECT * FROM t_files WHERE id = " . $newId))){
										//Far from efficient, change if possible
										//Though in its defence, it's unlikely that there would be more than one loop on this section anytime soon
										$newId = rand(1, 100000000);
									}
									
									$query = "INSERT INTO t_files (id, oldFileName, newFileName, ext, path, uploadtime, category, userId) VALUES (" . $newId . ", '" . basename($_FILES["fileToUpload"]["name"]) . "', '" . $new_filename . "', '" . $imageFileType . "', '" . $target_dir . "', NOW(), '". $_POST['categories'] . "', " . $userId . ")";
									if ($result = mysqli_query($connection, $query)){
										echo "<p>Image successfully uploaded!</p>";
									}else{
										//echo "<p>" . $query . "</p>";
										echo "<p>Error: " . mysqli_error($connection) . "</p>";
									}
								} else {
									$errorMessage = "Unexpected error in uploading your file. Please try again!";
									$uploadOk = 0;
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
