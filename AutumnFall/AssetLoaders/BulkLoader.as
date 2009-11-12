package AutumnFall.AssetLoaders 
{
	import AutumnFall.AssetLoaders.ItemLoaders.*;
	import AutumnFall.Utils.Url;
	import flash.utils.Dictionary;
	
	/**
	 * Represents an Asset Loader capable of loading multiple items at once.
	 */
	public class BulkLoader extends AutumnFall.AssetLoaders.Loader
	{
		//Each asset to be loaded need this inforation.
		private var ids:Array = new Array();
		private var urls:Dictionary = new Dictionary();
		private var loadTypes:Dictionary = new Dictionary();
		private var loaders:Dictionary = new Dictionary();
		private var bytesLoaded:Dictionary = new Dictionary();
		private var bytesTotal:Dictionary = new Dictionary();
		private var assets:Dictionary = new Dictionary();
		private var completed:Dictionary = new Dictionary();
		
		//Progress event data for all files.
		private var totalBytesLoaded:int = 0;
		private var totalBytesToLoad:int = 0;
		
		/**
		 * Constructor.
		 * @param	parameters The parameters that will be passed to the callback functions.
		 * @param 	throwErrors Set this to false to manually handle the errors ocurred on fail to load.
		 */
		public function BulkLoader(parameters:Object = null, throwErrors:Boolean = true) 
		{
			super(parameters, throwErrors);
		}
		
		/**
		 * Adds an item to be loaded.
		 * @param	id The id used to retrive the item after load.
		 * @param	url	The URL of the item.
		 * @param	loadType The LoadType of the loaded object. Use the LoadType structure.
		 */
		public function addItem(id:String, url:Url, loadType:String = LoadType.GUESS)
		{
			//Save the id and the loader
			ids.push(id);
			var loader:AssetLoader = new AssetLoader( null, false); 
			loader.Id = id;	//Set the loader id so it can set the event's id.
			loaders[id] = loader;
			urls[id] = url;
			loadTypes[id] = loadType;
			
			//Set events
			loader.addEventListener(LoadEvent.ON_COMPLETE, onFileComplete);
			loader.addEventListener(LoadEvent.ON_ERROR, onError);
			loader.addEventListener(LoadEvent.ON_FILE_OPEN, onFileOpen);
			loader.addEventListener(LoadEvent.ON_PROGRESS, onProgress);
		}
		
		/**
		 * Starts the loading process.
		 */
		public function load():void
		{
			for (var i:int ; i < ids.length ; i++)
			{
				//Start the load process for this asset using the stored data in the dictionaries.	
				AssetLoader(loaders[ids[i]]).load(urls[ids[i]], loadTypes[ids[i]]);
				completed[ids[i]] = false;	//This file is not completed yet.
			}
		}
		
		/**
		 * Retrives the loaded asset with the given id.
		 * If the asset haven't finished loaded or isn't in the load list this method returns null
		 * @param	id The String with the id given to the asset.
		 * @return	The loaded asset if available.
		 */
		public function getAsset(id:String):Object
		{
			return assets[id];
		}
		
		
		/**
		 * Event handler.
		 * @param	event The event.
		 * @eventType ON_FILE_OPEN
		 */
		private function onFileOpen(event:LoadEvent):void
		{
			dispatchLoadEvent(LoadEvent.ON_FILE_OPEN, event.Data, event.Parameters);
		}
		
		/**
		 * Event handler.
		 * @param	event The event.
		 * @eventType ON_PROGRESS
		 */
		private function onProgress(event:LoadEvent):void
		{
			//Update progress data for this file
			bytesLoaded[event.Data.id] = event.Data.bytesLoaded;
			bytesTotal[event.Data.id] = event.Data.bytesTotal;
			
			//Update global progress data
			totalBytesLoaded = 0;
			totalBytesToLoad = 0;
			for (var i:int ; i < ids.length ; i++)
			{
				totalBytesLoaded += bytesLoaded[ids[i]];
				totalBytesToLoad += bytesTotal[ids[i]];
			}
			
			//Set global loadig data to the event.
			var data:LoadEventData = event.Data;
			data.bytesLoaded = totalBytesLoaded;	
			data.bytesTotal = totalBytesToLoad;
			dispatchLoadEvent(LoadEvent.ON_PROGRESS, data);
		}
		
		/**
		 * Event handler.
		 * @param	event The event.
		 * @eventType ON_FILE_COMPLETE
		 */
		private function onFileComplete(event:LoadEvent):void
		{			
			//Save the asset
			assets[event.Data.id] = event.Data.asset;
			
			//Send file complete event.
			dispatchLoadEvent(LoadEvent.ON_FILE_COMPLETE, event.Data, event.Parameters);
			
			//Is this the last file to load?
			bytesLoaded[event.Data.id] = bytesTotal[event.Data.id];
			completed[event.Data.id] = true;
			for (var i:int = 0 ; i < ids.length ; i++)
			{
				if (completed[ids[i]] == false)
				{
					//We have found a file that havent finished loading, we don't need to send the ON_COMPLETE event.
					return;
				}
			}
			
			//Send the all complete event.
			dispatchLoadEvent(LoadEvent.ON_COMPLETE, event.Data, event.Parameters);
		}
	}
	
}