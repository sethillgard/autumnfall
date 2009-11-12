<?php

require("./include/initialize.php"); 
require("./include/utilities.php");

$gameId = getGameId($_GET["gameName"]);

//Make the query
$query = "";
if($_GET["ignoreMode"] == "true")
{
	$query = "SELECT mode, alias, score FROM scores ORDER BY score DESC;" ;
}
else
{
	$query = "SELECT mode, alias, score FROM scores WHERE mode='{$_GET["mode"]}' ORDER BY score DESC;" ;
}
$result = mysql_query($query)
or die("&error=" . mysql_error()); 

//Iterate through the results and limit its count.
$index = 1;
while(($row = mysql_fetch_array($result)) && $index <= $_GET["limit"]) 
{
	//User exists!
	print("&mode{$index}=" . $row['mode']);
	print("&alias{$index}=" . $row['alias']);
	print("&score{$index}=" . $row['score']);
	$index++;
} 


//Return information
print("&exit=__ok__");

?>