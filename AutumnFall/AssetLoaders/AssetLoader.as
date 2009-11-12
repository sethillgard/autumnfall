package AutumnFall.AssetLoaders 
{
	import AutumnFall.AssetLoaders.ItemLoaders.ItemLoader;
	import AutumnFall.Utils.Url;
	import flash.events.*;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.display.LoaderInfo;
	
	/**
	 * Represents a loading system for game assets. Can hold parameters.
	 */
	public class AssetLoader extends AutumnFall.AssetLoaders.Loader
	{	
		/**
		 * Constructor.
		 * @param	parameters The parameters that will be passed to the callback functions.
		 * @param 	throwErrors Set this to false to manually handle the errors ocurred on fail to load.
		 */
		public function AssetLoader(parameters:Object = null, throwErrors:Boolean = true) 
		{
			super(parameters, throwErrors);
		}
		
		/**
		 * Starts the loading process.
		 * @param	url What should we load?
		 * @param	loadType What are we loading? An image? An XML file? A SWF movie?
		 */
		public function load(url:Url, loadType:String = LoadType.GUESS):void
		{
			var loader:ItemLoader = ItemLoader.getItemLoader(url, loadType);
			
			//Set events
			loader.addEventListener(LoadEvent.ON_COMPLETE, onComplete);
			loader.addEventListener(LoadEvent.ON_ERROR, onError);
			loader.addEventListener(LoadEvent.ON_FILE_COMPLETE, onFileComplete);
			loader.addEventListener(LoadEvent.ON_FILE_OPEN, onFileOpen);
			loader.addEventListener(LoadEvent.ON_PROGRESS, onProgress);
			
			//Fire!
			loader.load();

		}
		
		/**
		 * Event handler.
		 * @param	event The event.
		 * @eventType ON_COMPLETE
		 */
		private function onComplete(event:LoadEvent):void
		{
			event.Data.id = this.id;
			dispatchLoadEvent(LoadEvent.ON_COMPLETE, event.Data, event.Parameters);
		}
		
		/**
		 * Event handler.
		 * @param	event The event.
		 * @eventType ON_PROGRESS
		 */
		private function onProgress(event:LoadEvent):void
		{
			event.Data.id = this.id;
			dispatchLoadEvent(LoadEvent.ON_PROGRESS, event.Data, event.Parameters);
		}
		
		/**
		 * Event handler.
		 * @param	event The event.
		 * @eventType ON_FILE_COMPLETE
		 */
		private function onFileComplete(event:LoadEvent):void
		{
			event.Data.id = this.id;
			dispatchLoadEvent(LoadEvent.ON_FILE_COMPLETE, event.Data, event.Parameters);
		}
		/**
		 * Event handler.
		 * @param	event The event.
		 * @eventType ON_FILE_OPEN
		 */
		private function onFileOpen(event:LoadEvent):void
		{
			event.Data.id = this.id;
			dispatchLoadEvent(LoadEvent.ON_FILE_OPEN, event.Data, event.Parameters);
		}
	}
	
}