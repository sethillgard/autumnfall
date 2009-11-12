package AutumnFall.AssetLoaders.ItemLoaders 
{
	import AutumnFall.AssetLoaders.LoadEvent;
	import AutumnFall.AssetLoaders.LoadType;
	import AutumnFall.Utils.Url;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.events.ErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;

	/**
	 * Abstract class. Represents an ActionScripot native loader such as Loader and URLLoader.
	 */
	public class ItemLoader extends EventDispatcher
	{
		/**
		 * The url that we are loading.
		 */
		protected var url:Url;	

		/**
		 * Static. Returns the correct ItemLoader obejct for the given URL and Type
		 * @param	url	The URL to laod.
		 * @param	loadType The String containing the file type.
		 * @return The ItemLoader object capable of loading that item.
		 */
		public static function getItemLoader(url:Url, loadType:String):ItemLoader
		{
			//Guess by extension?
			if (loadType == LoadType.GUESS)
			{
				var extension:String = url.getExtension();
				switch(extension)
				{
					case "swf":
						loadType = LoadType.SWF;
						break;
					case "php":
					case "py":
						loadType = LoadType.VARIABLES;
						break;
					case "jpg":
					case "jpeg":
					case "gif":
					case "png":
						loadType = LoadType.IMAGE;
					case "wav":
					case "mp3":
						loadType = LoadType.SOUND;
						
				}
			}
			
			//Select the correct type
			switch(loadType)
			{
				case LoadType.SWF:
					return new SwfLoader(url);
					
				case LoadType.VARIABLES:
					return new VariableLoader(url);
					
				case LoadType.SOUND:
					return new SoundLoader(url);
					
				case LoadType.IMAGE:
					return new ImageLoader(url);
					
				default: 
					return null; 
				
			}
			
		}
		
		/**
		 * Interface. This method should be overriden.
		 */
		public function load():void
		{
			throw new Error("ItemLoader::load called. ItemLoader is an abstract clas and this method exists only to provide interface to concrete ItemLoaders");
		}
		
		/**
		 * Adds the event listeners to the given EventDispatcher (native loader).
		 * @param	dispatcher
		 */
		protected function setEventListeners(dispatcher:EventDispatcher):void
		{
			//Add the event listeners
			dispatcher.addEventListener(Event.COMPLETE, onComplete);
			dispatcher.addEventListener(Event.OPEN, onOpen);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, onProgress);
			dispatcher.addEventListener(ErrorEvent.ERROR, onError);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, onError);
			dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
		}
		
		
		/**
		 * Event handler.
		 * @eventType ERROR
		 * @param	event The event.
		 */
		protected function onError(event:Event = null):void
		{
			//Fire!
			dispatchEvent(new LoadEvent(LoadEvent.ON_ERROR, { url:url} ));
		}
		
		/**
		 * Event handler.
		 * @eventType COMPLETE
		 * @param	event The event.
		 */
		protected function onComplete(event:Event):void
		{
			//Set the assets and parameters
			var event1:LoadEvent = new LoadEvent(LoadEvent.ON_COMPLETE, {url:url, asset:event.target.content});
			var event2:LoadEvent = new LoadEvent(LoadEvent.ON_FILE_COMPLETE, {url:url, asset:event.target.content});
			
			//Fire!
			dispatchEvent(event1);
			dispatchEvent(event2);
		}
		
		/**
		 * Event handler.
		 * @eventType OPEN
		 * @param	event The event.
		 */
		protected function onOpen(event:Event):void
		{	
			//Fire!
			dispatchEvent(new LoadEvent(LoadEvent.ON_FILE_OPEN, {url:url}));
		}
		
		/**
		 * Event handler.
		 * @eventType PROGRESS
		 * @param	event The event.
		 */
		protected function onProgress(event:ProgressEvent):void
		{			
			//Fire!
			dispatchEvent(new LoadEvent(LoadEvent.ON_PROGRESS, {url: url, bytesLoaded: event.bytesLoaded, bytesTotal: event.bytesTotal}));
		}
	}
	
}