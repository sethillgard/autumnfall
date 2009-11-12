package AutumnFall.Session
{
	import AutumnFall.*;
	import AutumnFall.Users.*;
	import AutumnFall.AssetLoaders.AssetLoader;
	import AutumnFall.AssetLoaders.LoadEvent;
	import AutumnFall.Utils.Url;
	import flash.events.*;
	import flash.display.*;
	import flash.net.*;
	
	
	/**
	 * Provides static accessto session related actions and information.
	 * Contains the user alias that will be user for scoreboard registers.
	 * Static class.
	 */
	public class Session
	{
		/**
		 * The data of the session
		 */
		private static var data:SessionData = null;
		
		/**
		 * Which function are we going to call on server answer.
		 */
		private static var callback:Function = null;
		
		//Current session alias for the player
		private static var alias:String = "__noAliasSet__";
		
		/**
		 * Try to log in using specified username & password
		 * @param	callback Function to be called when the server answers the request to log in
		 * @param	username The username string.
		 * @param	password The password string.
		 */
		public static function startSession(callback:Function = null, username:String = "__guest__", password:String = "__guest__")
		{
			Session.callback = callback;
			var url:Url = new Url(Application.ServerSideScriptsUrl + "startSession.php");
			url.addVariable("username", username);
			url.addVariable("password", password);
			var loader:AssetLoader = new AssetLoader();
			loader.addEventListener(LoadEvent.ON_COMPLETE, onServerSessionAnswer);
			loader.load(url);
		}
		
		/**
		 * Terminate current session.
		 * Only works if we have user session running (no guest).
		 * Used to destroy the session alias.
		 * @param	callback Function to be called when the server answers the request to log out
		 */
		public static function endSession(callback:Function = null)
		{
			if(data.isGuest == false)
			{
				//Set default alias for this session && terminate it
				alias = "__noAliasSet__";
				Session.startSession(callback);	//Default paramets starts a guest session.
			}
		}
		
		/**
		 * Handles server answer for session startup.
		 * If we have a successful user login, gets the user info.
		 * @private
		 * @param	event Event
		 */
		private static function onServerSessionAnswer(event:LoadEvent)
		{
			//Shortcut
			var vars:Object =  event.Data.data;		
			
			//Manage server answer filling data object
			data = new SessionData();
			data.isGuest = vars.isGuest == "false" ? false : true;
			data.isLoginError = vars.isLoginError == "false" ? false : true;
			data.startTime = vars.startTime;
			data.username = vars.username;
			data.domain = vars.domain;
			
			//Set the default alias for this session
			Session.alias = "__noAliasSet__";
			
			//If we have a login, get user data
			if(data.isGuest == false)
			{
				data.user = new User(onServerUserAnswer, data.username);
			}
			else //No successful login?, tell the client that the data is ready
			{
				if (callback != null)
				{
					callback(data);
				}
			}
		}
		
		/**
		 * Handles server answer for user info.
		 * Only used if we have a successful login.
		 * @private
		 * @param	event Event
		 */
		private static function onServerUserAnswer(userData:UserData)
		{
			//Set the session alias with the user alias
			alias = userData.alias;
			
			//Ok...NOW data is ready. Inform the client.
			if (callback != null)
			{
				callback(data);
			}
		}
		
		/**
		 * The session data structure.
		 */
		public static function get Data() :SessionData
		{
			return data;
		}
		
		/**
		 * Session alias for scoreboard registers.
		 */
		public static function get Alias() :String
		{
			return alias;
		}
		
		/**
		 * @private
		 */
		public static function set Alias(value:String) :void
		{
			alias = value;
		}
	}
}