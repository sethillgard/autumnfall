package AutumnFall.AssetLoaders 
{
	import AutumnFall.Utils.Url;
	
	/**
	 * Static structure.
	 */
	public dynamic class LoadEventData extends Object
	{
		/**
		 * The unique identifier of the asset when loaded using a bulk loader.
		 */
		public var id:String = "";
		
		/**
		 * The Url object that we are loading.
		 */
		public var url:Url = null;
		
		/**
		 * What is going to be loaded.
		 */
		public var asset:Object = null;
		
		/**
		 *If we are loading variables this holds all the variables loaded.
		 */
		public var data:Object = { };
		
		/**
		 * The number of bytes loaded.
		 */
		public var bytesLoaded:int = -1;
		
		/**
		 * The total umber of bytes to be loaded.
		 */
		public var bytesTotal:int = -1;
	}
	
}