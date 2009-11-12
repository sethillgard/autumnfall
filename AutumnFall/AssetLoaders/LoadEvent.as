package AutumnFall.AssetLoaders 
{
	import AutumnFall.Utils.Url;
	import flash.events.Event;
	
	/**
	 * Represents a event ocurred within a Loader.
	 */
	public class LoadEvent extends Event
	{
		/**
		 * The specific parameters for this event.
		 */
		private var parameters:Object = { };
		
		/**
		 * The data returned by the event such as the asset or the bytes loaded.
		 */
		private var data:LoadEventData = new LoadEventData();
		
		//Event constants
		public static const ON_FILE_OPEN:String = "onFileOpen";
		public static const ON_FILE_COMPLETE:String = "onFileComplete";
        public static const ON_COMPLETE:String = "onComplete";
		public static const ON_PROGRESS:String = "onProgress";
		public static const ON_ERROR:String = "onError";
		
		/**	
		 * LoaderEvent constructor.
		 * @param	type	The name of the event type.
		 * @param 	data	An Object containg the data of the event such as the asset loaded.
		 * @param	parameters	An Object containing the event parameters
		 * @param	bubbles	Does this event bubbles?
		 * @param	cancelable Is this event cancelable?
		 */
		public function LoadEvent(type:String, data:Object = null, parameters:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);  

			//Store data
			this.data = new LoadEventData();
			if (data)
			{
				addData(data);
			}
			
			//Store parameters
			this.parameters = new LoadEventData();
			if (parameters)
			{
				addParameters(parameters);
			}
		}
		/**
		 * The parameters of this event.
		 */
		public function get Parameters():Object
		{
			return parameters;
		}
		
		/**
		 * @private
		 */
		public function set Parameters(value:Object):void
		{
			parameters = value;
		}
		
		/**
		 * The parameters of this event.
		 */
		public function get Data():LoadEventData
		{
			return data;
		}
		
		/**
		 * @private
		 */
		public function set Data(value:LoadEventData):void
		{
			data = value;
		}
		
		/**
		 * Adds the given parameters to the parameters obejct.
		 * @param	extraParameters The new parameters to be added.
		 */
		public function addParameters(extraParameters:Object):void
		{			
			for (var p:* in extraParameters)
			{
				this.parameters[p] = extraParameters[p];
			}
		}
		
		/**
		 * Adds the given data to the data obejct.
		 * @param	extradata The new data to be added.
		 */
		public function addData(extraData:Object):void
		{			
			for (var p:* in extraData)
			{
				this.data[p] = extraData[p];
			}
		}
		
		/**
		 * Provides deep copy.
		 * @return The cloned object.
		 */
		public override function clone():Event
        {
            return new LoadEvent(type, parameters, bubbles, cancelable);
        }
       
		/**
		 * Utility method.
		 * @return The string to be presented to the user.
		 */
        public override function toString():String
        {
            return formatToString("CustomEvent", "parameters", "type", "bubbles", "cancelable");
        }
	}
}