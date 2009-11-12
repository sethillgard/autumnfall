<?php

require("./include/initialize.php");

//In all cases we need these
print("&startTime=" . time() . "&domain=" . $_SERVER["HTTP_HOST"]);

//If we get a guest session, simply return a guest session
if($_GET["username"] == "__guest__")
{
	//Guest login!
	print("&isGuest=true&isLoginError=false&username=__guest__");
	exit();
}

//Make the query
$result = mysql_query("SELECT username FROM users WHERE username='{$_GET["username"]}' AND password='{$_GET["password"]}';")
or die("&error=" . mysql_error());  

//Do we have a user matching?
if($row = mysql_fetch_array($result)) 
{
	//User login!
	print("&isGuest=false&isLoginError=false&username=" . $row["username"]);
} 
else
{
	//Error login!
	print("&isGuest=true&isLoginError=true&username=" . $row["username"]);
}

print("&exit=__ok__");

?>