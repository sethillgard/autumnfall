package AutumnFall.AssetLoaders 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * Abstract asset loader.
	 */
	public class Loader extends EventDispatcher
	{
		/**
		 * This Assetloadr may have an Id (set by BulkLoader)
		 */
		protected var id:String = "";
		
		/**
		 * The parameters that will be sent to the callback functions.
		 */
		protected var parameters:Object;
		
		/**
		 * How should we manage errors while loading? 
		 */
		protected var throwErrors:Boolean = true;
		
		/**
		 * Constructor.
		 * @param	parameters The parameters that will be passed to the callback functions.
		 * @param 	throwErrors Set this to false to manually handle the errors ocurred on fail to load.
		 */
		public function Loader(parameters:Object = null, throwErrors:Boolean = true) 
		{
			if (parameters == null)
			{
				parameters = { };
			}
			
			this.parameters = parameters ? parameters : new Object();
			this.throwErrors = throwErrors;
		}
		
		/**
		 * The id of this Loader
		 */
		public function get Id():String
		{
			return id;
		}
		
		/**
		 * @private
		 */
		public function set Id(value:String):void
		{
			id = value;
		}
		
		/**
		 * Default event handler.
		 * @eventType ERROR
		 * @param	event The event.
		 */
		protected function onError(event:LoadEvent):void
		{	
			if (this.throwErrors)
			{
				throw new Error("Error loading aseset: " + event.Data.url.getBaseUrl());
			}
			
			//Fire!
			dispatchLoadEvent(LoadEvent.ON_ERROR, event.Data);
		}
		
		/**
		 * Utility method used to dispatch events.
		 * @param	type The type of the event to be dispatched. Use LoadEvent constants.
		 * @param	data The data object associated with the new event.
		 * @param 	extraParameters Extra parameters used for this event. Place here properties corresponding to LoadEventData such as bytesLoaded. 
		 */
		protected function dispatchLoadEvent(type:String, data:LoadEventData = null, parameters:Object = null):void
		{	
			//Create the event 
			var toSend:LoadEvent = new LoadEvent(type);
			toSend.Data = data ? data : new LoadEventData();
			toSend.Parameters = parameters ? parameters : new Object();
			
			//Add the parameters given to this loader
			toSend.addParameters(this.parameters);
			
			//Fire!
			dispatchEvent(toSend);
		}
	}
	
}