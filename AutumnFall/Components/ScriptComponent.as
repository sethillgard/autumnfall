package AutumnFall.Components 
{
	import AutumnFall.Application;
	import AutumnFall.Display.GameObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.utils.describeType;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;
	
	/**
	 * Represents a compont that is capable of handling user scripts.
	 */
	public class ScriptComponent extends Component
	{	
		/**
		 * Collection of event handlers.
		 * Event handlers (functions) are stored in this object in the form:
		 * eventHandlers[eventType] = method;
		 * @example
		 * eventHandlers[MouseEvent.CLICK] = onClick;
		 */
		protected var eventHandlers:Object = new Object();
		
		/**
		 * Activates this component.
		 */
		public override function activate():void 
		{ 
			//This assert is only for optimization since this check will be made inside registerEvent anyway.
			if (owner && owner.Activated)
			{
				registerEvents();
			}
			super.activate();
		}
		
		/**
		 * Deactivates this component.
		 */
		public override function deactivate():void 
		{
			unregisterEvents();
			super.deactivate();
		}
		
		/**
		 * Sets the event handlers for this component.
		 * If a component implements new event handlers this method should be overriden and called back useng super.
		 */
		public function registerEvents():void
		{		
			registerEvent(Event.ENTER_FRAME, "onUpdate");
			registerEvent(MouseEvent.CLICK, "onClick");
			registerEvent(MouseEvent.DOUBLE_CLICK, "onDoubleClick");
			registerEvent(MouseEvent.MOUSE_DOWN, "onMouseDown");
			registerEvent(MouseEvent.MOUSE_UP, "onMouseUp");
			registerEvent(MouseEvent.ROLL_OVER, "onMouseOver");
			registerEvent(MouseEvent.ROLL_OUT, "onMouseOut");
			registerEvent(MouseEvent.MOUSE_WHEEL, "onMouseWheel");
			registerEvent(KeyboardEvent.KEY_DOWN, "onKeyDown", Application.Stage);
			registerEvent(KeyboardEvent.KEY_UP, "onKeyUp", Application.Stage);
		}
		
		/**
		 * Removes all event handlers for the given component.
		 * If a component implements new event handlers this method should be overriden and called back useng super.
		 */
		public function unregisterEvents():void
		{	
			unregisterEvent(Event.ENTER_FRAME);
			unregisterEvent(MouseEvent.CLICK);
			unregisterEvent(MouseEvent.DOUBLE_CLICK);
			unregisterEvent(MouseEvent.MOUSE_DOWN);
			unregisterEvent(MouseEvent.MOUSE_UP);
			unregisterEvent(MouseEvent.ROLL_OVER);
			unregisterEvent(MouseEvent.ROLL_OUT);
			unregisterEvent(MouseEvent.MOUSE_WHEEL);
			unregisterEvent(KeyboardEvent.KEY_DOWN, Application.Stage);
			unregisterEvent(KeyboardEvent.KEY_UP, Application.Stage);
		}
		
		/**
		 * Registers the given event handler.
		 * @private
		 * @param	eventType The type of event. For example MouseEvent.CLICK
		 * @param	handlerName The name of the handler function such as onClick.
		 * @param 	dispatcher Optional. The event dispatcher that will be sending this events. Set to null to use the component's owner.
		 */
		protected function registerEvent(eventType:String, handlerName:String, dispatcher:EventDispatcher = null):void
		{	
			//We can't activate an event if this component has no owner or the owner is deactivated.
			if (!owner || !owner.Activated)
			{
				return;
			}
			
			//Only add it if the event handler was declared by a class other that Component.
			//This is for optimization but to keep a reference of the event handlers in the Component base class.
			if (isMethodOverriden(handlerName))
			{
				if (dispatcher)
				{
					dispatcher.addEventListener(eventType, this[handlerName]);
				}
				else
				{
					owner.addEventListener(eventType, this[handlerName]);
				}
				eventHandlers[eventType] = this[handlerName];
			}
			
		}
		
		/**
		 * Unregisters the given event for the given component.
		 * @private
		 * @param	eventType The type of event. For example MouseEvent.CLICK
		 * @param 	dispatcher Optional. The event dispatcher that will be sending this events. Set to null to use the component's owner.
		 */
		protected function unregisterEvent(eventType:String, dispatcher:EventDispatcher = null):void
		{	
			if (eventHandlers[eventType])
			{
				if (dispatcher)
				{
					dispatcher.removeEventListener(eventType, eventHandlers[eventType]);
				}
				else
				{
					//If this component has no owner then there is nothing to do here
					if(owner)
					{
						owner.removeEventListener(eventType, eventHandlers[eventType]);
					}
				}
			}
		}
		
		/**
		 * Tells if a given method was overriden in a child of Component.
		 * @private
		 * @param	methodName The name method to test.
		 * @return true if the method is overiden, false otherwise.
		 */
		protected function isMethodOverriden(methodName:String):Boolean
		{	
			/*if (owner.Id == "jose" && this.Type == "Scripts::CTrace")
			{				
				var myClassName:String = getQualifiedClassName(this);
				var declarerName:String = description.method.(@name == methodName).@declaredBy.toXMLString();
				var declarer:Class = getDefinitionByName(declarerName) as Class;
				var declarerParentName:String = getQualifiedSuperclassName(declarer);
				var declarerParent:Class = getDefinitionByName(declarerParentName) as Class;
				

				trace();
				trace(methodName, declarerName, declarerParentName);
				
				
				if (k[methodName])
				{
					trace("method is overriden!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
				}
				else
				{
					trace("method is not overriden");
				}
			}*/
			
			//TODO:Make this isMethodOverriden work
			
			return true;
		}
		
		
		
		
		
		/**
		 * Event handler for the initialize function
		 * @param	event
		 */
		public function onInitialize(event:Event = null):void
		{
		}
		
		/**
		 * Event handler for the update function
		 * @param	event
		 */
		public function onUpdate(event:Event = null):void
		{
		}
		
		/**
		 * Event handler for the click event
		 * @param	event
		 */
		public function onClick(event:MouseEvent = null):void
		{
		}
		
		/**
		 * Event handler for the double click event
		 * @param	event
		 */
		public function onDoubleClick(event:MouseEvent = null):void
		{
		}
		
		/**
		 * Event handler for the mouse down event
		 * @param	event
		 */
		public function onMouseDown(event:MouseEvent = null):void
		{
		}
		
		/**
		 * Event handler for the mouse up event
		 * @param	event
		 */
		public function onMouseUp(event:MouseEvent = null):void
		{
		}
		
		/**
		 * Event handler for the mouse over event
		 * @param	event
		 */
		public function onMouseOver(event:MouseEvent = null):void
		{
		}
		
		/**
		 * Event handler for the mouse out event
		 * @param	event
		 */
		public function onMouseOut(event:MouseEvent = null):void
		{
		}
		
		/**
		 * Event handler for the mouse wheel event
		 * @param	event
		 */
		public function onMouseWheel(event:MouseEvent = null):void
		{
		}
		
		/**
		 * Event handler for the key down event
		 * @param	event
		 */
		public function onKeyDown(event:KeyboardEvent = null):void
		{
		}
		
		/**
		 * Event handler for the key up event
		 * @param	event
		 */
		public function onKeyUp(event:KeyboardEvent = null):void
		{
		}
	}
	
}