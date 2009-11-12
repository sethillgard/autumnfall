package AutumnFall
{
	import AutumnFall.Utils.Url;
	import flash.display.*;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import AutumnFall.Users.*;
	import AutumnFall.Gui.Windows.*;
	import AutumnFall.Input.KeyboardManager;
	
	/**
	* Provides access to application level resources such as the stage.
	* Singleton class.
	**/
	public class Application extends MovieClip
	{
		/**
		 * Stage. Black MovieClip used to create effects.
		 */
		public var fade:MovieClip;
		
		/**
		 * The instance object.
		 */
		private static var instance:Application = null;
		
		/**
		 * Global configuration URLs
		 */
		protected static var serverSideScriptsUrl:String = "http://localhost/AutumnFall/AutumnFall/ServerSideScripts/";
		
		/**
		 * Password for accessing PHP scripts.
		 */
		protected static var serverScriptsPassword:String = "silentAutumnFall";
		
		/**
		 * Private constructor hack
		 * @private
		 */
		public function Application()
		{		
			if(instance != null)
			{
				throw new Error("Application class should not be instantiated.");
			}
			
			instance = this;
			
			//Contructor code here.
			this.fade.visible = false;
		}
		
		/**
		 * Use this function to obtain a reference to the Application object.
		 * @return The instance object.
		 */
		public static function getInstance():Application
		{
			return instance;
		}
		
		/**
		 * Retrives the stage of the application.
		 * @return The Stage object.
		 */
		public static function get Stage():flash.display.Stage
		{
			return getInstance().stage;
		}		
		
		/**
		 * Use this to simulate the AS2 _root object. 
		 * Actually this method is an alias for getInstance() since Application IS THE root object
		 * @return The root MovieClip
		 */
		public static function get Root():MovieClip
		{
			return getInstance();
		}	
		
		/**
		 * The Url as a string of the folder where all server scripts are stored.
		 */
		public static function get ServerSideScriptsUrl():String
		{
			return serverSideScriptsUrl;
		}
		
		/**
		 * @private
		 */
		public static function set ServerSideScriptsUrl(value:String):void
		{
			serverSideScriptsUrl = value;
		}
		
		/**
		 * The password for accessing server scripts.
		 */
		public static function get ServerScriptsPassword():String
		{
			return serverScriptsPassword;
		}
		
		/**
		 * @private
		 */
		public static function set ServerScriptsPassword(value:String):void
		{
			serverScriptsPassword = value;
		}
	}
}