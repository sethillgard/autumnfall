package AutumnFall
{
	import AutumnFall.Application;
	import AutumnFall.Containers.UniqueContainer;
	import AutumnFall.Game;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.system.ApplicationDomain;
	
	/**
	 * Represnts an application capable of loading games
	 */
	public class GameLoader extends Application
	{
		/**
		 * Stage. Contains the game being loaded.
		 */
		public var gameContainer:UniqueContainer;
		
		/**
		 * The game area where the game wil be loaded.
		 */
		protected var gameArea:Rectangle = null;
		
		/**
		 * Loader object which will load the game
		 */
		protected var gameLoader:Loader = null;
		
		/**
		 * Static. Where should I look for the game?
		 */
		protected static var gameLoadUrl:String = "./";
		
		/**
		 * Static. The game object that is currently loaded.
		 */
		protected static var game:AutumnFall.Game = null;
		
		/**
		 * Static. Name of the game currently loaded.
		 */
		protected static var gameName:String = "";
		
		/**
		 * Static. The name of the game that you are trying to load. Will be set as gameName on successful load.
		 */
		private static var gameNameToLoad:String = "";
		
		/**
		 * Loads the specified game
		 * @param	gameName
		 */
		public function loadGame(gameName:String):void
		{
			//We want to load this.
			GameLoader.gameNameToLoad = gameName;
			
			//Try to load it!
			gameLoader = new Loader();
			gameLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onGameLoad);
			
			//The Game adds its unique definitions to
			//parent SWF; both SWFs share the same domain
			//child SWFs definitions do not overwrite parents
			var context:LoaderContext = new LoaderContext();
			context.applicationDomain = ApplicationDomain.currentDomain;
			
			gameLoader.load(new URLRequest(gameLoadUrl + "/" + gameName + "/" + gameName + ".swf"), context);		
			
			// child SWF adds its unique definitions to
			// parent SWF; both SWFs share the same domain
			// child SWFs definitions do not overwrite parents
			var addedDefinitions:LoaderContext = new LoaderContext();
			addedDefinitions.applicationDomain = ApplicationDomain.currentDomain;
		}
		
		/**
		 * Event handler for the load game operation.
		 * Override this method to get control over the game position & style.
		 * @param	event Event
		 * @eventType Event.COMPLETE
		 */
		protected function onGameLoad(event:Event)
		{	
			//Set the current game & gameName
			GameLoader.gameName = GameLoader.gameNameToLoad;
			GameLoader.game = gameLoader.content as AutumnFall.Game;
			
			//Set properties of the game
			gameLoader.x = gameArea.x;
			gameLoader.y = gameArea.y;
			
			//Add the game to the display list.
			addChild(gameLoader);
			setChildIndex(gameLoader, 0);
		}
		
		/**
		 * Gets the name of the game currently loaded.
		 */
		public static function get GameName():String
		{
			return gameName;
		}
		
		/**
		 * Returns the currently loaded game.
		 */
		public static function get Game():AutumnFall.Game
		{
			return game;
		}
		
		/**
		 * Returns the GameLoader object (The Application object as GameLoader).
		 */
		public static function get Root():GameLoader
		{
			return Application.Root as GameLoader;
		}
	
		/**
		 * Return the game area of the current game loader
		 */
		public static function get GameArea():Rectangle
		{
			return GameLoader.Root.gameArea;
		}
		
		/**
		 * The URL where we are loading games.
		 */
		public static function get GameLoadUrl():String
		{
			return gameLoadUrl;
		}
		
		/**
		 * @private
		 */
		public static function set GameLoadUrl(value:String):void
		{
			gameLoadUrl = value;
		}
	}
}


