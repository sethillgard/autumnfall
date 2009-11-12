package AutumnFall.Sound 
{
	import flash.events.Event;
	
	/**
	 * Represents a event ocurred within a window.
	 */
	public class SoundEvent extends Event
	{
		/**
		 * The specific parameters for this event.
		 */
		private var parameters:Object = { };
		
		/**
		 * The data returned by the event such as the widow who fired it.
		 */
		private var data:SoundEventData = new SoundEventData();
		
		//Event constants
        public static const ON_SOUND_COMPLETE:String = "onSoundComplete";
		public static const ON_SOUND_LOOP_COMPLETE:String = "onSoundLoopComplete";
		
		/**	
		 * SoundEvent constructor.
		 * @param	type	The name of the event type.
		 * @param 	data	The data object such as the Window.
		 * @param	parameters	An Object containing the event parameters
		 * @param	bubbles	Does this event bubbles?
		 * @param	cancelable Is this event cancelable?
		 */
		public function SoundEvent(type:String, data:Object = null, parameters:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);  
			
			//Store data
			this.data = new SoundEventData();
			if (data)
			{
				addData(data);
			}
			
			//Store parameters
			this.parameters = new Object();
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
		public function get Data():SoundEventData
		{
			return data;
		}
		
		/**
		 * @private
		 */
		public function set Data(value:SoundEventData):void
		{
			data = value;
		}
		
		/**
		 * Adds the given parameters to the parameters obejct.
		 * @param	extraParameters The new parameters to be added.
		 */
		public function addParameters(extraParameters:Object)
		{
			for (var p:* in extraParameters)
			{
				this.parameters[p] = extraParameters[p];
			}
		}
		
		/**
		 * Adds the given data to the data obejct.
		 * @param	extraParameters The new parameters to be added.
		 */
		public function addData(extraData:Object)
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
            return new SoundEvent(type, parameters, bubbles, cancelable);
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