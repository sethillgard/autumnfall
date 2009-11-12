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
	public class ScoreManager
	{
		/**
		 * The collection of stored scores (ScoreData objects) that failed to be set.
		 */
		private static var pendingScores:Array = new Array();
		
		/**
		 * The mode of the score system. You can use modes to separate different score lists for the same game like "Normal" and "Hard".
		 */
		private static var mode:String = "";
		public static function get Mode():String { return mode; }
		public static function set Mode(value:String):void { mode = value;  }
		
		/**
		 * Tells if there are pending scores to be set later.
		 * @return True if we have pending scores, false otherwise.
		 */
		public static function hasPendingScores():Boolean
		{
			if (pendingScores.length > 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		/**
		 * Returns an array of ScoreData objects containing the scores that failed to be set before.
		 * @param	clearPendingScores Set this to true to destroy the  pending socres in the system.
		 * @return	An array of ScoreData objects.
		 */
		public static function getPendingScores(clearPendingScores:Boolean = true):Array
		{
			//Duplicate the array
			var collection:Array = new Array();
			for each(var s:ScoreData in pendingScores)
			{
				collection.push(s);
			}
			
			//Do we have to clear the pending scores?
			if (clearPendingScores)
			{
				ScoreManager.clearPendingScores();
			}
			
			return collection;
		}
		
		/**
		 * Clears the pending scores.
		 */
		public static function clearPendingScores():void
		{
			pendingScores = new Array();
		}
		
		/**
		 * Registers the given score with the given alias. If no alias is set and no session alias is set, the score is saved 
		 * for later registration.
		 * @param	score The score to set.
		 * @param	alias An explicit alias for this score. Left blank to use the Session Alias.
		 * @param 	callback Optional. The function to be called when the operation finishes.
		 */
		public static function setScore(score:Number, alias:String = "", callback:Function = null):void
		{
			//If we dont have an explicit alias, use the session alias.
			if (alias == "")
			{
				alias = Session.Alias;
				
				//If we dont have a session alias, save the score to be set later.
				if ( alias == "__noAliasSet__")
				{
					var s:ScoreData = new ScoreData;
					s.alias = "__noAliasSet__";
					s.mode = Mode;
					s.score = score;
					ScoreManager.pendingScores.push(s);
					return;
				}
			}
			
			var url:Url = new Url(Application.ServerSideScriptsUrl + "setScore.php");
			url.addVariable("gameName", Game.CurrentGameName);
			url.addVariable("mode", mode);
			url.addVariable("alias", alias);
			url.addVariable("score", score.toString());
			var loader:AssetLoader = new AssetLoader( { callback:callback } );
			loader.addEventListener(LoadEvent.ON_COMPLETE, onSetScoreServerAnswer);
			loader.load(url);
		}
		
		/**
		 * Retrives an array of ScoreData objects containing the top [number] of scores for this game.
		 * The array is passed as parameter of the callback function.
		 * @param	callback The function to be called when the server answers petition. The return value is passed as parameter of this function.
		 * @param	limit Optional. The number of scores to be retrived.
		 * @param 	ignoreMode Optional. Set this to true to get all scores ignoring the mode parameter.
		 */
		public static function getTopScores(callback:Function, limit:int = 10, ignoreMode:Boolean = false):void
		{
			var url:Url = new Url(Application.ServerSideScriptsUrl + "getTopScores.php");
			url.addVariable("gameName", Game.CurrentGameName);
			url.addVariable("mode", mode);
			url.addVariable("limit", limit.toString());
			url.addVariable("ignoreMode", ignoreMode.toString());
			var loader:AssetLoader = new AssetLoader( {callback:callback} );
			loader.addEventListener(LoadEvent.ON_COMPLETE, onGetTopScoresServerAnswer);
			loader.load(url);
		}
		
		/**
		 * Event handler for the setScore sever answer.
		 * @private
		 * @param	event The event.
		 */
		private static function onSetScoreServerAnswer(event:LoadEvent):void
		{
			if (event.Parameters.callback != null)
			{
				event.Parameters.callback()
			}
		}
		
		/**
		 * Event handler for the getTopScores sever answer.
		 * @private
		 * @param	event The event.
		 */
		private static function onGetTopScoresServerAnswer(event:LoadEvent):void
		{
			var scores:Array = new Array();
			
			//Parse the data returned
			for (var p:* in event.Data.data)
			{				
				//We will only get the alias properties
				if (p.substr(0, 5) != "alias")
				{
					continue;
				}
				
				//The index of the alias
				var index:int = int(p.substring(5, p.length));
				
				//Create the ScoreData object
				var score:ScoreData = new ScoreData();
				score.mode = event.Data.data["mode" + index];
				score.alias = event.Data.data["alias" + index];
				score.score = Number(event.Data.data["score" + index]);
				
				//Store it
				scores.push(score);
			}
			
			//Sort the scores array
			scores.sortOn("score", Array.DESCENDING | Array.NUMERIC);
			
			//Inform the client
			event.Parameters.callback(scores)
		}
	}
}