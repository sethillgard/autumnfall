<?php

require("./include/initialize.php"); 
require("./include/utilities.php");

$gameId = getGameId($_GET["gameName"]);

$query = "INSERT INTO scores (rel_game, mode, alias, score) ";
$query .= "VALUES(";
$query .= "'{$gameId}', ";
$query .= "'{$_GET["mode"]}', ";
$query .= "'{$_GET["alias"]}', ";
$query .= "'{$_GET["score"]}' ";
$query .= ");";

//Make the query
mysql_query($query)
or die("&error=" . mysql_error()); 

//Return information
print("&exit=__ok__");

?>