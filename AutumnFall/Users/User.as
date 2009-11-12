package AutumnFall.Users
{
	import AutumnFall.*;
	import AutumnFall.Session.*;
	import AutumnFall.AssetLoaders.AssetLoader;
	import AutumnFall.AssetLoaders.LoadEvent;
	import AutumnFall.AssetLoaders.LoadType;
	import AutumnFall.Utils.Url;
	import flash.events.*;
	import flash.display.*;
	import flash.net.*;

	/**
	 * Represents a user of the application.
	 */
	public class User
	{
		//The callback used to register new users
		private static var registerCallback:Function = null;
		
		//Data objects
		private var data:UserData = null;
		private var callback:Function = null;
		
		//Save the request object
		private var request:URLRequest = null;
		
		/**
		 * Constructs a new User object and fills it with the information in the database for the username provided.
		 * @param	callback Function called when the user info is ready.
		 * @param	username Name of the user to search for.
		 */
		public function User(callback:Function, username:String)
		{
			this.callback = callback;
			var url:Url = new Url(Application.ServerSideScriptsUrl + "getUserData.php");
			url.addVariable("username", username);
			
			var loader:AssetLoader = new AssetLoader();
			loader.addEventListener(LoadEvent.ON_COMPLETE, onServerAnswer);
			loader.load(url);
		}	
		
		/**
		 * Handles server answer.
		 * @private
		 * @param	event Event
		 * @eventType Event.COMPLETE
		 */
		private function onServerAnswer(event:LoadEvent)
		{	
			data = new UserData();
			
			if(event.Data.data.username == "__invalid_user__")
			{
				data.username = "__invalid_user__";
			}
			else	
			{	
				//Manage server answer filling data object
				data.id = event.Data.data.id;
				data.username = event.Data.data.username;
				data.alias = event.Data.data.alias;
				data.firstName = event.Data.data.firstName;
				data.lastName = event.Data.data.lastName;
				data.email = event.Data.data.email;
				data.url = event.Data.data.url;
				data.avatarUrl = event.Data.data.avatarUrl;
				data.birthday = new Date(String(event.Data.data.birthday).replace("-", "/").replace("-", "/"));	//Replace only changes the first - so we need 2 replaces
				data.joinDate = new Date(String(event.Data.data.joinDate).replace("-", "/").replace("-", "/"));
			}
			
			//Tell the client that the data is ready
			callback(data);
		}
		
		/**
		 * The user data structure.
		 */
		public function get Data() :UserData
		{
			return data;
		}
		
		/**
		 * Registers a new user in the database.
		 * @param	callback The function that will be called on user registration compelte.
		 * @param	userData Almost all the information of the user. The joinDate field is ignored and will be set by php.
		 * @param	password The password of the user.
		 */
		public static function registerUser(callback:Function, userData:UserData, password:String):void
		{
			User.registerCallback = callback;
			var url:Url = new Url(Application.ServerSideScriptsUrl + "registerUser.php");
			url.addVariable("username", userData.username);
			url.addVariable("password", password);
			url.addVariable("alias", userData.alias);
			url.addVariable("email", userData.email);
			url.addVariable("avatarUrl", userData.avatarUrl);
			url.addVariable("url", userData.url);
			url.addVariable("firstName", userData.firstName);
			url.addVariable("lastName", userData.lastName);
			url.addVariable("birthday", userData.birthday.fullYear.toString() + "-" + userData.birthday.month.toString() + "-" +userData.birthday.date.toString());
			
			 trace(userData.birthday.fullYear.toString() + "-" + userData.birthday.month.toString() + "-" +userData.birthday.date.toString());

			
			var loader:AssetLoader = new AssetLoader();
			loader.addEventListener(LoadEvent.ON_COMPLETE, User.onServerRegisterAnswer);
			loader.load(url);
		}
		
		/**
		 * Handles server answer for user registration.
		 * @private
		 * @param	event Event
		 * @eventType Event.COMPLETE
		 */
		private static function onServerRegisterAnswer(event:LoadEvent)
		{	
			if(event.Data.data.exit == "__ok__")
			{
				//New user registered!!!
				new User(User.registerCallback, event.Data.data.username);
			}
			else	
			{	
				//Nope, error ocurred. Client MUST check for the parameter of the callback function to know if the user were added or not.
				User.registerCallback(null);
			}
		}
	}
}