package AutumnFall.Display 
{
	import AutumnFall.Components.ScriptComponent;
	import flash.display.MovieClip;
	import AutumnFall.Application;
	import flash.utils.Dictionary;
	import AutumnFall.Components.Component;
	import flash.utils.getDefinitionByName;
	
	/**
	 * Represents a GameObject added to the scene.
	 */
	public class GameObject extends MovieClip
	{
		/**
		 * Holds the number of GameObjects that have been created without an id so we can avoid id collisions.
		 */
		private static var nUnnamedGameObjects:int = 0;
		
		/**
		 * The unique identifier of this GameObject
		 */
		private var id:String = "__unnamedGameObject__";
		public function get Id():String { return id; }
		
		/**
		 * The collection of tags(Strings) that this GameObject has.
		 */
		private var tags:Array = new Array();
		
		/**
		 * The collection of components for this GameObject.
		 */
		protected var components:Dictionary = new Dictionary();
		
		/**
		 * The scene in which this object lives.
		 */
		private var scene:GameScene = null;
		public function get Scene():GameScene
		{
			return scene;
		}
		
		/**
		 * Sets the scene for this object.
		 * This method should only be called by the GameScene class when a GameObject is added or deleted.
		 * @param	scene The scene inwhich this object lives.
		 */
		internal function setScene(scene:GameScene):void
		{
			this.scene = scene;
		}
		
		/**
		 * True when this GameObject is activated (components are working). False otherwise.
		 */
		protected var activated:Boolean = false;
		public function get Activated():Boolean { return activated; }
		
		/**
		 * Constructor. Must always be called by the child classes.
		 * @param	id Optional. The unique id of this GameObject. If not provided one will be generated.
		 */
		public function GameObject(id:String = "")
		{	
			//If no id is provided...
			if (id == "")
			{
				//Can we use the timeline name property?
				if (this.name.substr(0, 8) != "instance") 	//Flash names unnamed objects as "instance1", "instance2, etc 
				{
					id = this.name;
				}
				else	//Create a new id
				{
					id = "__GameObject" + (nUnnamedGameObjects + 1) + "__";
					nUnnamedGameObjects++;
				}
			}
			
			//Save the id as the name too
			this.id = id;
			
			//Activate me
			this.activate();
		}
		
		/**
		 * Adds a new tag to this GameObject.
		 * @param	tag
		 */
		public function addTag(tag:String):void
		{
			if (!hasTag(tag))
			{
				tags.push(tag);
			}
		}
		
		/**
		 * Removes the given tag from this object.
		 * @param	tag
		 */
		public function removeTag(tag:String):void
		{
			//Do I have it?
			for (var i:int = 0; i < tags.length; i++ )
			{
				if (tags[i] == tag)
				{
					tags = tags.splice(i, 1);
				}
			}
		}
		
		/**
		 * Tells if this GameObject was tagged with the given tag.
		 * @param	tag
		 * @return True if this object was tagged, false otherwise.
		 */
		public function hasTag(tag:String):Boolean
		{
			//Do I already have it?
			for (var i:int = 0; i < tags.length; i++ )
			{
				if (tags[i] == tag)
				{
					return true;
				}
			}
			
			return false;
		}
		
		/**
		 * Returns an array containing all the tags that this GameObject has.
		 * @return
		 */
		public function getTags():Array
		{
			//Clone the tags array
			var newTags:Array = new Array();
			
			//Do I already have it?
			for (var i:int = 0; i < tags.length; i++ )
			{
				newTags.push(tags[i]);
			}
			
			return newTags;
		}
		
		/**
		 * Add a component tho this GameObject. If there was already a component of that type the new one will be discarded.
		 * @param	component The component object to be added.
		 * @param activateComponent True if you want the component to start activated, false otherwise.
		 */
		public function addComponent(component:Component, activateComponent:Boolean = true):void
		{
			//If we already have it, return.
			if (getComponent(component.Type))
			{
				return;
			}
			overwriteComponent(component, activateComponent);
		}
		
		/**
		 * Add a component tho this GameObject. If there was already a component of that type the old one will be discarded.
		 * @param	component The component object to be added.
		 * @param activate Optional. True if you want the component to start activated, false otherwise.
		 */
		public function overwriteComponent(component:Component, activate:Boolean = true):void
		{
			var type:String = component.Type;
			if (getComponent(type))
			{
				removeComponent(type);	//If there was a component of that type it will be gone.
			}
			
			//Configure the component.
			components[type] = component;
			component.initialize(this);
			
			//Register the event handlers for the component.
			if (activate)
			{
				component.activate();
			}
		}
		
		/**
		 * Returns the component of the type given (if this GameObject has it).
		 * @param	type The type of the component to be returned.
		 * @return	The Component.
		 */
		public function getComponent(type:String):Component
		{
			return components[type] as Component;
		}
		
		/**
		 * Returns the component of the type given (if this GameObject has it).
		 * @param	type The type of the component to be returned.
		 * @return	The Component.
		 */
		public function hasComponent(type:String):Boolean
		{
			if (components[type])
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		/**
		 * Returns the component of the type given.
		 * If this GameObject has the it, it is returned, if not, a new one is created.
		 * @param	type The type of the component to be returned.
		 * @return	The Component.
		 */
		public function requireComponent(type:String):Component
		{
			var component:Component = components[type] as Component;
			if (!component)
			{
				var c:Class = getDefinitionByName(type) as Class;
				component = new c();
			}
			return component;
		}
		
		/**
		 * Detach the component of the given type of this object and returns it.
		 * @param	type The type of component to be deleted.
		 * @param 	The deatached component.
		 */
		public function removeComponent(type:String):Component
		{
			var component:Component = getComponent(type);
			if (component)
			{
				component.deactivate();
			}
			
			//Delete the records in this GameObject
			components[type] = null;
			delete components[type];
			
			component.setOwner(null);
			return component;
		}
		
		/**
		 * Activate the component of the given type.
		 * @param	type The type of the component to be activated.
		 */
		public function activateComponent(type:String):void
		{
			var component:Component = getComponent(type);
			if (component)
			{
				component.activate();
			}
		}
		
		/**
		 * Deactivate the component of the given type.
		 * @param	type The type of the component to be deactivated.
		 */
		public function deactivateComponent(type:String):void
		{
			var component:Component = getComponent(type);
			if (component)
			{
				component.deactivate();
			}
		}
		
		/**
		 * Enables this GameObject.
		 * Turns on every component attached to it.
		 */
		public function activate():void
		{
			for each (var p:Object in components)
			{
				var component:ScriptComponent = p as ScriptComponent;
				if (component && component.Activated)
				{
					component.registerEvents();
				}
			}
			this.activated = true;
		}
		
		/**
		 * Completly disables this GameObject.
		 * Shuts down every component attached to it.
		 */
		public function deactivate():void
		{
			for each (var p:Object in components)
			{
				var component:ScriptComponent = p as ScriptComponent;
				if (component && component.Activated)
				{
					component.unregisterEvents();
				}
			}
			this.activated = false;
		}
	}
}