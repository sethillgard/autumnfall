package AutumnFall.Gui.LoadingScreens.BaseLoadingScreen 
{
	import AutumnFall.AssetLoaders.Loader;
	import AutumnFall.AssetLoaders.LoadEvent;
	import AutumnFall.AssetLoaders.LoadEventData;
	import AutumnFall.Gui.LoadingScreens.LoadingScreen;
	
	/**
	 * Represents a standard loading screen.
	 */
	public class BaseLoadingScreen extends LoadingScreen
	{
		/**
		 * Constructor.
		 * @param	loader The loader associated with the loading screen.
		 * @param	graphics The style of the loading screen.
		 */
		public function BaseLoadingScreen(loader:Loader, graphics:BaseLoadingScreenGraphics) 
		{
			//Call daddy!
			super(loader, graphics);
		}
		
		/**
		 * Event handler.
		 * @param	event The event.
		 */
		protected override function onProgress(event:LoadEvent):void
		{
			var graphics:BaseLoadingScreenGraphics = this.graphics as BaseLoadingScreenGraphics;
			var data:LoadEventData = event.Data as LoadEventData;
			var percentage:int = calculatePercentage(data.bytesLoaded, data.bytesTotal);
			graphics.progressLabel.text = percentage.toString();
			graphics.progressIndicator.width = percentage * 3;
		}
		
		/**
		 * Event handler.
		 * @param	event The event.
		 */
		protected override function onComplete(event:LoadEvent):void
		{
			super.onComplete(event);
		}
		
		
		/**
		 * Event handler.
		 * @param	event The event.
		 */
		protected override function onError(event:LoadEvent):void
		{
			super.onError(event);
		}
		
	}
	
}