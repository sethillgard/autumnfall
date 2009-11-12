package AutumnFall.Gui.LoadingScreens 
{
	import AutumnFall.AssetLoaders.Loader;
	import AutumnFall.AssetLoaders.LoadEvent;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	
	/**
	 * Represents a loading screen. Abstract class.
	 */
	public class LoadingScreen extends EventDispatcher
	{
		/**
		 * The graphics object for this loading screen.
		 */
		protected var graphics:LoadingScreenGraphics;
		
		/**
		 * Constructor.
		 * @param	loader The loader associated with this loading screen.
		 * @param	graphics The graphics object.
		 */
		public function LoadingScreen(loader:Loader, graphics:LoadingScreenGraphics) 
		{
			//Save the graphics object
			this.graphics = graphics;
			
			//Suscribe to the loader's events.
			loader.addEventListener(LoadEvent.ON_COMPLETE, onComplete);
			loader.addEventListener(LoadEvent.ON_PROGRESS, onProgress);
			loader.addEventListener(LoadEvent.ON_ERROR, onError);
		}
		
		/**
		 * Event handler. Should be overriden.
		 * @param	event The event.
		 */
		protected function onComplete(event:LoadEvent):void
		{
			dispatchEvent(new LoadEvent(LoadEvent.ON_COMPLETE));
		}
		
		/**
		 * Event handler. Should be overriden.
		 * @param	event The event.
		 */
		protected function onError(event:LoadEvent):void
		{
			dispatchEvent(new LoadEvent(LoadEvent.ON_ERROR));
		}
		
		/**
		 * Event handler. Should be overriden.
		 * @param	event The event.
		 */
		protected function onProgress(event:LoadEvent):void
		{
		}
		
		/**
		 * Calculates the simple math to obtain the porcentage loaded.
		 * @param	bytesLoaded
		 * @param	bytesTotal
		 * @return The porcentage (0% - 100%)
		 */
		protected function calculatePercentage(bytesLoaded:int, bytesTotal:int):int
		{
			return int(Number(bytesLoaded) / Number(bytesTotal) * 100);
		}
		
		/**
		 * The graphics associated with this object.
		 */
		public function get Graphics():MovieClip
		{
			return graphics as MovieClip;
		}
	}
	
}