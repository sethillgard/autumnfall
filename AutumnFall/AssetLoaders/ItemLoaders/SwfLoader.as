package AutumnFall.AssetLoaders.ItemLoaders 
{
	import AutumnFall.Utils.Url;
	import flash.display.Loader;
	import flash.net.URLRequest;
	
	/**
	 * Loads SWF files.
	 */
	public class SwfLoader extends ItemLoader
	{
		/**
		 * The loader obejct.
		 */
		private var loader:flash.display.Loader;		
		
		/**
		 * Constructor.
		 * @param	url	The URL to laod.
		 */
		public function SwfLoader(url:Url)
		{
			//Initialize objects
			loader = new flash.display.Loader();
			this.url = url;
			setEventListeners(loader.contentLoaderInfo);
		}
		
		/**
		 * Starts the loading.
		 */
		public override function load():void 
		{
			loader.load(url.getUrlRequest());
		}
		
	}
	
}