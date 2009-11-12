package AutumnFall.GameData 
{
	
import AutumnFall.Application;
	import AutumnFall.AssetLoaders.AssetLoader;
	import AutumnFall.AssetLoaders.LoadEvent;
	import AutumnFall.Game;
	import AutumnFall.Session.Session;
	import AutumnFall.Users.User;
	import AutumnFall.Utils.Url;
	import flash.events.Event;
	
	/**
	 * Provides static access to score administration.
	 */
	public class GameDataManager
	{
		/**
		 * The collection of stored scores (GameData objects) that failed to be set.
		 */
		private static var pendingData:Array = new Array();
		
		/**
		 * Tells if there are pending data to be set later.
		 * @return True if we have pending data, false otherwise.
		 */
		public static function hasPendingData():Boolean
		{
			if (pendingData.length > 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		/**
		 * Returns an array of GameData objects containing the data that failed to be set before.
		 * @param	clearPendingData Set this to true to destroy the  pending data in the system.
		 * @return	An array of GameData objects.
		 */
		public static function getPendingData(clearPendingData:Boolean = true):Array
		{
			//Duplicate the array
			var collection:Array = new Array();
			for each(var s:GameData in pendingData)
			{
				collection.push(s);
			}
			
			//Do we have to clear the pending scores?
			if (clearPendingData)
			{
				GameDataManager.clearPendingData();
			}
			
			return collection;
		}
		
		/**
		 * Clears the pending game data.
		 */
		public static function clearPendingData():void
		{
			pendingData = new Array();
		}
		
		 /**
		  * Registers the given game datafor the given user. If no user is set and no session user is set, the data is saved 
		  * for later registration.
		  * @param	name The name of the data to be stored.
		  * @param	value The value of the data (String).
		  * @param 	overwrite Set this to false if you want to avoid overwriting the current value of the game data(if any).
		  * @param	callback Optional. The function to be called when the operation finishes.
		  * @param	user Optional. The user for which we will be registering this.
		  */
		public static function setData(name:String, value:String, overwrite:Boolean = true, callback:Function = null, user:User = null):void
		{
			//If we dont have an user, use the session user.
			if (!user)
			{
				user = Session.Data.user;
				
				//If we dont have a session user, save the score to be set later.
				if (!user)
				{
					var s:GameData = new GameData;
					s.name = name;
					s.value = value;
					s.user = null;
					GameDataManager.pendingData.push(s);
					return;
				}
			}
			
			//Callback function for the existance test
			var temp:Function = function(tempValue:String)
			{
				//If the gamedata already existed and we dont want to overwirte it, there is nothing to do
				if (tempValue && overwrite== false)
				{
					if (callback != null)
					{
						callback();
					}
					return;
				}
				
				var url:Url; 
				
				//Data dont exist, add it!
				if (!tempValue)
				{
					url = new Url(Application.ServerSideScriptsUrl + "setGameData.php");
				}
				else	//We already have that gamedata:
				{
					url = new Url(Application.ServerSideScriptsUrl + "updateGameData.php");
				}
				
				//Add it or update it, go!
				url.addVariable("gameName", Game.CurrentGameName);
				url.addVariable("userId", user.Data.id.toString());
				url.addVariable("name", name);
				url.addVariable("value", value);
				var loader:AssetLoader = new AssetLoader( { callback:callback } );
				loader.addEventListener(LoadEvent.ON_COMPLETE, onSetDataServerAnswer);
				loader.load(url);
			}
			
			//Is this data already exists?
			GameDataManager.getData(temp, name, user);
		}
		
		 /**
		  * Retrives the value of the game data with the specified name.
		  * The value is passed as the parameter of the callback function.
		  * @param	callback The function to be called when the server answers petition. The return value is passed as parameter of this function.
		  * @param	name The name of game data to be retrived.
		  * @param	user Optional. The user for which we will be retriving the data.
		  */
		public static function getData(callback:Function, name:String, user:User = null):void
		{
			//If we dont have an user, use the session user.
			if (!user)
			{
				user = Session.Data.user;
				
				//If we dont have a session user, inform the client
				if (!user)
				{
					callback(null);
					return;
				}
			}
			
			var url:Url = new Url(Application.ServerSideScriptsUrl + "getGameData.php");
			url.addVariable("gameName", Game.CurrentGameName);
			url.addVariable("userId", user.Data.id.toString());
			url.addVariable("name", name);
			var loader:AssetLoader = new AssetLoader( {callback:callback} );
			loader.addEventListener(LoadEvent.ON_COMPLETE, onGetDataServerAnswer);
			loader.load(url);
		}
		
		 /**
		  * Deletes the given game data for the given user.
		  * @param	name The name of the data to be deleted.
		  * @param	callback Optional. The function to be called when the operation finishes.
		  * @param	user Optional. The user for which we will be deleteing this.
		  */
		public static function deleteData(name:String, callback:Function = null, user:User = null):void
		{
			//If we dont have an user, use the session user.
			if (!user)
			{
				user = Session.Data.user;
				
				//If we dont have a session user, there is nothing to do here.
				if (!user)
				{
					if (callback != null)
					{
						callback();
					}
					return;
				}
			}
			
			//Delete the data
			var url:Url = new Url(Application.ServerSideScriptsUrl + "deleteGameData.php");
			url.addVariable("gameName", Game.CurrentGameName);
			url.addVariable("userId", user.Data.id.toString());
			url.addVariable("name", name);
			var loader:AssetLoader = new AssetLoader( { callback:callback } );
			loader.addEventListener(LoadEvent.ON_COMPLETE, onDeleteDataServerAnswer);
			loader.load(url);
		}
			
		
		/**
		 * Event handler for the setData server answer.
		 * @private
		 * @param	event The event.
		 */
		private static function onSetDataServerAnswer(event:LoadEvent):void
		{
			if (event.Parameters.callback != null)
			{
				event.Parameters.callback()
			}
		}
		
		/**
		 * Event handler for the getData server answer.
		 * @private
		 * @param	event The event.
		 */
		private static function onGetDataServerAnswer(event:LoadEvent):void
		{
			var value = event.Data.data.value;
			if (value == "__null__")
			{
				value = null;
			}
			
			//Inform the client
			event.Parameters.callback(value);
		}
		
		/**
		 * Event handler for the deleteData server answer.
		 * @private
		 * @param	event The event.
		 */
		private static function onDeleteDataServerAnswer(event:LoadEvent):void
		{
			if (event.Parameters.callback != null)
			{
				event.Parameters.callback()
			}
		}
	}
	
}