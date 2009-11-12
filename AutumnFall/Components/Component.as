package AutumnFall.Components 
{
	import AutumnFall.Display.GameObject;
	import AutumnFall.Game;
	import flash.display.MovieClip;
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;

	
	/**
	 * Represents a Component for a GameObject (a script attached to the object that has multiple event handlers).
	 * Multiple components can be attached to a single GameObject.
	 */
	public class Component
	{	
		protected var description:XML = describeType(this);
		
		/**
		 * The GameObject that holds this Component.
		 */
		protected var owner:GameObject = null;
		public function get Owner():GameObject { return owner; }
		
		/**
		 * Sets the given owner as the owner of this component.
		 * @private
		 * @param	owner
		 */
		public function setOwner(owner:GameObject):void
		{
			this.owner = owner;
		}
		
		/**
		 * @private
		 * This is used for optimization purposes. Holds the type of this Component.
		 */
		private var type:String = null;
		
		/**
		 * The type of this component.
		 */
		public function get Type():String
		{
			//Optimization
			if (!this.type)
			{
				this.type = getQualifiedClassName(this);
			}
			
			return this.type;
		}
		
		/**
		 * True if this Component is activated (working). false otherwise.
		 * If this is activated but the Owner is disabled this component will be shut down anyway.
		 */
		private var activated:Boolean = false;
		public function get Activated():Boolean { return activated; }
		
		/**
		 * Activates this component
		 */
		public function activate():void 
		{ 
			this.activated = true; 
		}
		
		/**
		 * Deactivates this component
		 */
		public function deactivate():void 
		{
			this.activated = false;
		}
		
		/**
		 * Sets the Owner of this component and calls onInitialize so that the component is ready to operate..
		 * Should be called only by the GameObject class and send this as parameter.
		 * @param	owner The owner of this component.
		 */
		public function initialize(owner:GameObject):void
		{
			setOwner(owner);
			
			//If this is an ScriptComponent fire the first event.
			//This particular event (onInitialize) is not registered to any EventDispatcher and must be fired this way. 
			if (this is ScriptComponent)
			{
				ScriptComponent(this).onInitialize(null);
			}
		}
	}
	
}