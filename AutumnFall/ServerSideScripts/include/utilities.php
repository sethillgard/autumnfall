<?php

//Gets the Id of the game given its name.
function getGameId($gameName)
{
	//Get the id of the current game
	$query = "SELECT game_id FROM games WHERE name='{$gameName}';";
	$result = mysql_query($query)
	or die("&error=" . mysql_error()); 
	
	//Do we have a game matching?
	$gameId = 0;
	if($row = mysql_fetch_array($result)) 
	{
		$gameId = $row['game_id'];
	}
	
	//Assert
	if($gameId == 0)
	{
		die("&error=No game with that name was found.");
	}
	
	return $gameId;
}

?>