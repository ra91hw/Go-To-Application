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

$failedlogin = false;	//Right now, there's no reason to believe that there's a failed log in attempt. This may be changed later

if(isset($_POST["usernameS"]) && isset($_POST["passwordS"])) {
	$result = mysqli_query($connection, "SELECT id, password FROM t_user WHERE username = '" . strtolower($_POST["usernameS"]) . "' LIMIT 1");
	echo mysqli_error($connection);
	if (mysqli_num_rows($result) > 0){
		$row = mysqli_fetch_row($result);
		//The username definitely matches a known user.
		//Not necessary to let the user know though. Just say there's a problem if there's a problem.
		 if(password_verify($_POST["passwordS"], $row[1])){
			//Credentials are valid
			
			//Create a cookie storing the currently logged in user
			setcookie("userId", $row[0], time() + (86400 * 30), "/"); // 86400 = 1 day
			mysqli_free_result($result);
			
			header("Location: index.php");	//The cookie now shows that the user is logged in. Return to the main page.
			die();
		 }else{
			//Recognise that there was an attempt to login, but it has not succeeded
			$failedlogin = true;
		 }
	}else{
		//Recognise that there was an attempt to login, but it has not succeeded
		$failedlogin = true;
	}
}

$failedsignup = false;
if(isset($_POST["email"]) && isset($_POST["username"]) && isset($_POST["password"])) {
	$proposedName = strtolower($_POST["username"]);
	$failedsignup = false;
	echo mysqli_error($connection);
	//Verify username and email are valid, and that the username isn't in use
	if(!preg_match("/^[a-z0-9]+$/",$proposedName)){
		//The username contains only letters and numbers
		$failedsignup = true;
		$signuperror = "Username contains invalid characters!";
	}elseif (!filter_var($_POST["email"], FILTER_VALIDATE_EMAIL)){
		//The email address is not an email address (PHP handles email address verification)
		$failedsignup = true;
		$signuperror = "Invalid email address!";
	}elseif (strlen(utf8_decode($_POST["password"])) < 6){
		//The password has at least 6 characters
		//No upper limit. The hashing function will provide a 60 character hashed password regardless
		$failedsignup = true;
		$signuperror = "Password is too short! Please make sure it is at least 6 characters long.";
	}elseif (mysqli_num_rows(mysqli_query($connection, "SELECT id FROM t_user WHERE username = '" . $proposedName . "' LIMIT 1")) == 0 && $proposedName != "index" && $proposedName != "login" && $proposedName != "profile" && $proposedName != "avatar" && $proposedName != "tos" && $proposedName != "upload" ){
		//Username is free
		//$row = mysqli_fetch_row($result);

		//Find an unused userId
		$userId = rand(100, 100000000);
		while(mysqli_num_rows(mysqli_query($connection, "SELECT * FROM t_user WHERE id = " . $userId . " LIMIT 1")) > 0){
			//Try again if id is in use
			$userId = rand(100, 100000000);
		}
		if (mysqli_query($connection, "INSERT INTO t_user (id, username, password, email, avatar) VALUES ('" . $userId . "', '" . $proposedName . "', '" . password_hash($_POST["password"], PASSWORD_DEFAULT) . "', '" . $_POST["email"] . "', 0)")){
			//Create a php file for the new user's profile, and open the template
			$newFile = fopen($proposedName . ".php", "w");
			$templateFile = fopen("part2.txt", "r") or die("Unable to open file!");
			
			//Fill in the blank for the userId in the profile page for the new user
			//Note that the new line characters here vary between OS. These should work for Windows specifically:
			fwrite($newFile, "<?php\r\n\$profileUser = " . $userId . fread($templateFile, filesize("part2.txt")));	//Filesize here means to continue reading for the full size of the file
			fclose($templateFile);
			fclose($newFile);
			
			//Create a cookie storing the currently logged in user
			setcookie("userId", $userId, time() + (86400 * 30), "/"); // 86400 = 1 day
			//mysqli_free_result($result);
			
			header("Location: index.php");	//The cookie now shows that the user is logged in. Return to the main page.
			die();
		}else{
			echo mysqli_error($connection);
			die();
		}
	}else{
		//Recognise that there was an attempt to sign up, but it has not succeeded
		$failedsignup = true;
		$signuperror = "Username in use!";
	}
}
?>


<!DOCTYPE html>
<html>

<head>
	<title>Log In</title>
	<!-- basic meta data for webpage -->
	<meta charset="utf-8">
	<meta name="Keywords" content="photos, sharing, tags, location">
	<link rel="shortcut icon" href="favicon.ico" type="image/x-icon"/>
	<script>	
	function validateSignUp() {
		//var emailAd = document.forms["signUp"]["email"].value;
		
		//if (emailAd "") {
		//	alert("Invalid email");
		//	return false;
		//}
		return true;
	}
	
	function signOut() {
		//Set expiry date to the past so the login cookie disappears
		document.cookie = "userId=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
		window.location.replace("index.php");
	}
	
	</script>

	<!-- import style sheet -->
	<link rel="stylesheet" href="stylesheet.css">

	<!--FontAwesome 5.7.2-->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css"
integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">


</head>

<body>
	<?php
		if(isset($_COOKIE["userId"])){
			header("Location: index.php");	//Redirect back to the main index. You can't log in or register if you're already logged in
			die();
		}else{
			$loggedin = False;
		}
	?>
	<section id="logo">
		<div id="header" class="header">
			<div class="logo">
				<h1><a href="index.php" style="text-decoration: none !important">Go-To</a></h1>
				<h2>Photos on the go</h2>
				<img src="uploads\logo.png" alt="logo">
			</div>
		</div>
	</section>
	
	<section id="Login">
		<div id="login" class="login">
			<ul>
				<li> <a href="login.php">Log in / Register</a> </li>
			</ul>
		</div>
	</section>

	<section id="Upload">
		<div id="uploader" class="uploader">
			<!--I'm pasting this section in here for consistency, but it will never work since you need to be logged in to upload a photo, and logged out to access this page !-->
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
				
				<h1>Welcome. Sign up below!</h1>
				
				<form action = "" method = "POST" name = "signUp">
				Email Address: <input type = "text" placeholder="example@email.com" name = "email" required><br>
				Username: <input type = "text" placeholder="Enter Username" name = "username" required><br>
				Password: <input type = "password" placeholder="**********" name = "password" required><br>
				I have read and agreed to the <a href="tos.php" target="_blank">terms of service:</a> <input type="checkbox" name="tos" required><br>
				<input type = "submit">
				</form>
				<?php
					if ($failedsignup){
						echo "<p>" . $signuperror . "</p>";
					}
				?>
				
				<h1>Or log in!</h1>
				
				<form action = "<?php $_PHP_SELF ?>" method = "POST" name = "signIn">
				Username: <input type = "text" placeholder="Enter Username" name = "usernameS" required><br>
				Password: <input type = "password" placeholder="**********" name = "passwordS" required><br>
				<input type = "submit">
				</form>
				<?php 
					if ($failedlogin){
						//Notify the user that the login attempt has failed.
						echo "<p>Incorrect credentials.</p>";
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