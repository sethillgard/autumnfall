<?php

require("./include/initialize.php"); 
require("./include/utilities.php");

$gameId = getGameId($_GET["gameName"]);

$query = "INSERT INTO gamedata (rel_user, rel_game, name, value) ";
$query .= "VALUES(";
$query .= "'{$_GET["userId"]}', ";
$query .= "'{$gameId}', ";
$query .= "'{$_GET["name"]}', ";
$query .= "'{$_GET["value"]}' ";
$query .= ");";

//Make the query
mysql_query($query)
or die("&error=" . mysql_error()); 

//Return information
print("&exit=__ok__");

?>