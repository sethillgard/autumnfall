<?php

require("./include/initialize.php");

//Make the query
$result = mysql_query("SELECT * FROM users WHERE username='{$_GET["username"]}';")
or die("&error=" . mysql_error());  

//Do we have a user matching?
if($row = mysql_fetch_array($result)) 
{
	//User exists!
	print("&id=" . $row['user_id']);
	print("&username=" . $row['username']);
	print("&alias=" . $row['alias']);
	print("&firstName=" . $row['first_name']);
	print("&lastName=" . $row['last_name']);
	print("&email=" . $row['email']);
	print("&avatarUrl=" . $row['avatar_url']);
	print("&url=" . $row['url']);
	print("&birthday=" . $row['birthday']);
	print("&joinDate=" . $row['join_date']);
	
} 
else
{
	//Error login!
	print("&username=__invalid_user__");
}

print("&exit=__ok__");

?>