package AutumnFall.AssetLoaders.ItemLoaders 
{
	
	import AutumnFall.Sound.SoundHandler;
	import AutumnFall.AssetLoaders.*;
	import AutumnFall.Utils.Url;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.ErrorEvent;
	import flash.media.Sound;
	import flash.net.URLRequest;
	
	/**
	 * Loads SWF files.
	 */
	public class SoundLoader extends ItemLoader
	{
		/**
		 * The loader obejct.
		 */
		private var loader:Sound = null;	
		private var sound:SoundHandler = null;
		
		/**
		 * Constructor.
		 * @param	url	The URL to laod.
		 */
		public function SoundLoader(url:Url)
		{
			//Initialize objects
			loader = new Sound();
			this.url = url;
			setEventListeners(loader);
		}
		
		/**
		 * Starts the loading.
		 */
		public override function load():void 
		{
			loader.load(url.getUrlRequest());
		}
		
		/**
		 * Event handler.
		 * @eventType OPEN
		 * @param	event The event.
		 */
		protected override function onOpen(event:Event):void
		{	
			//Create the sound handler
			sound = new SoundHandler(Sound(event.target));
			
			//Fire!
			dispatchEvent(new LoadEvent(LoadEvent.ON_FILE_OPEN, {url:url, asset:sound}));
		}
		
		/**
		 * Event handler.
		 * @eventType COMPLETE
		 * @param	event The event.
		 */
		protected override function onComplete(event:Event):void
		{
			//Set the assets and parameters
			var event1:LoadEvent = new LoadEvent(LoadEvent.ON_COMPLETE, {url:url, asset:sound});
			var event2:LoadEvent = new LoadEvent(LoadEvent.ON_FILE_COMPLETE, {url:url, asset:sound});
			
			//Fire!
			dispatchEvent(event1);
			dispatchEvent(event2);
		}
		
		/**
		 * Event handler.
		 * @eventType PROGRESS
		 * @param	event The event.
		 */
		protected override function onProgress(event:ProgressEvent):void
		{			
			//Fire!
			dispatchEvent(new LoadEvent(LoadEvent.ON_PROGRESS, {url: url, bytesLoaded: event.bytesLoaded, bytesTotal: event.bytesTotal, asset: sound}));
		}
		
	}
	
}