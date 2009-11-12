<?php
	
//Database configuration
$dbHost = 'localhost';
$dbUser = 'root';
$dbPassword = '';
$dbName = 'autumnfall';

//We always return a dummy field.
print("dummy=dummy");

//Security password for running this script
if($_GET["__security__"] != "silentAutumnFall")
{
	die("&error=Invalid security code. Server Scripts won't run withoun the correct password.");
}

//Connect to the database
$connection = mysql_connect($dbHost, $dbUser, $dbPassword) 
or die("&error=" . mysql_error());
mysql_select_db($dbName) 
or die("&error=" . mysql_error());

//Iterate through the GET parameters escaping them
foreach ($_GET as & $variable) 
{
    if (get_magic_quotes_gpc()) 
	{
		$variable = stripslashes($variable);
	}
	$variable = mysql_real_escape_string($variable);
}
?>