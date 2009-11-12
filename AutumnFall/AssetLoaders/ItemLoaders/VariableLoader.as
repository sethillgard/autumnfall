package AutumnFall.AssetLoaders.ItemLoaders 
{
	import AutumnFall.Application;
	import AutumnFall.AssetLoaders.LoadEvent;
	import AutumnFall.Utils.Url;
	import flash.events.Event;
	import flash.net.*;
	import flash.display.*;
	/**
	 * Loads URL variables such as the ones returned by a php script.
	 */
	public class VariableLoader extends ItemLoader
	{	
		/**
		 * The loader obejct.
		 */
		private var loader:URLLoader;		
		
		/**
		 * Constructor.
		 * @param	url	The URL to laod.
		 */
		public function VariableLoader(url:Url)
		{	
			//Initialize objects
			loader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.VARIABLES;
			this.url = url;
			setEventListeners(loader);
		}
		
		/**
		 * Starts the loading.
		 */
		public override function load():void 
		{
			//Add the security variable
			url.addVariable("__security__", Application.ServerScriptsPassword);
			//Add a random variable to the url so that flash cache does't play here
			url.addVariable("__random__", Math.random().toString());
			
			var request:URLRequest = new URLRequest();
			request.url = this.url.getUrl();
			request.method = URLRequestMethod.GET;
			loader.load(request);
		}
		
		/**
		 * Override event handler.
		 * @eventType COMPLETE
		 * @param	event The event.
		 */
		protected override function onComplete(event:Event):void
		{
			//We need to try this because decode may fail (if the URL is not responding for example).
			try
			{
				//Set the assets and parameters
				var toSend:LoadEvent = new LoadEvent(LoadEvent.ON_COMPLETE, {url:url, data:loader.data});
				
				//Fire!
				dispatchEvent(toSend);
			}
			catch(error)
			{
				onError();
			}
		}
		
	}
	
}