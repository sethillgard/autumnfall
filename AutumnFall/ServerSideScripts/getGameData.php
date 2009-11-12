<?php

require("./include/initialize.php"); 
require("./include/utilities.php");

$gameId = getGameId($_GET["gameName"]);

//Make the query
$query = "SELECT value FROM gamedata WHERE rel_user={$_GET["userId"]} AND rel_game={$gameId} AND name='{$_GET["name"]}';" ;
$result = mysql_query($query)
or die("&error=" . mysql_error()); 


//Do we have a game data matching?
if($row = mysql_fetch_array($result)) 
{
	//Yeah! Return its value
	print("&value=" . $row["value"] );
} 
else
{
	//Nope :(
	print("&value=__null__");
}

//Return information
print("&exit=__ok__");

?>