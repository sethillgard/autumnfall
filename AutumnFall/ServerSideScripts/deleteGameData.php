<?php

require("./include/initialize.php"); 
require("./include/utilities.php");

$gameId = getGameId($_GET["gameName"]);

//Update the current state of the gamedata
$query = "DELETE FROM gamedata WHERE rel_user={$_GET["userId"]} AND rel_game={$gameId} AND name='{$_GET["name"]}';" ;

//Make the query
mysql_query($query)
or die("&error=" . mysql_error()); 

//Return information
print("&exit=__ok__");

?>