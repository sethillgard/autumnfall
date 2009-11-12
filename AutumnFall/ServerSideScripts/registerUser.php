<?php

require("./include/initialize.php"); 

$query = "INSERT INTO users (username, password, alias, email, avatar_url, url, first_name, last_name, birthday, join_date) ";
$query .= "VALUES(";
$query .= "'{$_GET["username"]}', ";
$query .= "'{$_GET["password"]}', ";
$query .= "'{$_GET["alias"]}', ";
$query .= "'{$_GET["email"]}', ";
$query .= "'{$_GET["avatarUrl"]}', ";
$query .= "'{$_GET["url"]}', ";
$query .= "'{$_GET["firstName"]}', ";
$query .= "'{$_GET["lastName"]}', ";
$query .= "'{$_GET["birthday"]}', "; 
$query .= "'" . date("Y-m-d") . "'"; 
$query .= ");";

//Make the query
mysql_query($query)
or die("&error=" . mysql_error()); 

//Return information(both critical!)
print("&username=" . $_GET["username"]);
print("&exit=__ok__");

?>