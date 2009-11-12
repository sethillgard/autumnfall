package AutumnFall
{
	import AutumnFall.Containers.Container;
	import AutumnFall.Containers.UniqueContainer;
	import AutumnFall.Components.Component;
	import AutumnFall.Display.*;
	import AutumnFall.Session.Session;
	import flash.display.*;
	import flash.events.Event;	
	import flash.geom.Rectangle;
	import flash.system.System;
	/**
	 * Represents a game using the AutumnFall framework
	 */
	public class Game extends Container
	{
		/**
		 * The collection of layers of this game.
		 */
		private var layers:Array = new Array();
		
		/**
		 * Constructor.
		 * Register the current constents of the game as the init scene.
		 */
		public function Game()
		{
			//No normal execution please
			stop();
			
			//Is this game being loaded correctly?
			if (!Application.getInstance())
			{
				clearContent();
				trace("Game compiled correctly. Run your GameLoader to view it.");
				return;
			}
			
			//Create a Scene object that represents the current state of the game.
			//Move all my childs to the scene
			var sceneContents:Container = new Container();
			for each(var t:DisplayObject in this.getContents())
			{
				sceneContents.addChild(t);
			}
			
			//Register and display it!
			getLayer(0).Scene = new GameScene("init");
			getLayer(0).Scene.addChild(sceneContents);
			
			//Start user session
			Session.startSession();
			
			//Call the initializer when the game is on the stage.
			if (stage)
			{
				initialize();
			}
			else 
			{
				addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			}
		}
		
		/**
		 * Utility event handler.
		 * Called when the object is added to stage.
		 * @param	event The event.
		 */
		protected function onAddedToStage(event:Event)
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			initialize();
		}
		
		/**
		 * Use this function as the game constructor. Put any initalization code here.
		 * Should be overriden.
		 */
		protected function initialize()
		{
		}

		/**
		 * Returns the given layer id of this game. 
		 * @param	layer The id of the layer to be returned.
		 * @return Tha Layer object.
		 */
		public function getLayer(layer:int):Layer
		{
			//If we don't have this layer, add it
			if (!layers[layer])
			{
				layers[layer] = new Layer();
				addChildAt(layers[layer], layer);
			}
			
			return layers[layer];
		}
		
		/**
		 * Gets the id of the game currently loaded.
		 */
		public static function get CurrentGameName():String
		{
			return GameLoader.GameName;
		}
		
		/**
		 * Returns the currently loaded game.
		 */
		public static function get CurrentGame():Game
		{
			return GameLoader.Game;
		}
		
		/**
		 * Returns the currently loaded game.
		 */
		public static function get GameArea():Rectangle
		{
			return GameLoader.GameArea;
		}
		
		/**
		 * Override.
		 * @param	child The child to add.
		 * @return	The child added.
		 */
		public override function addChild(child:DisplayObject):DisplayObject 
		{
			if (child is Layer)
			{
				return super.addChild(child);
			}
			
			throw new Error("You cannot add contents to the game directly. Use a GameScene instead.");
			return null;
		}
		
		/**
		 * Override.
		 * @param	child The child to add.
		 * @return	The child added.
		 */
		public override function addChildAt(child:DisplayObject, index:int):DisplayObject 
		{
			if (child is Layer)
			{
				return super.addChild(child);
			}
			
			throw new Error("You cannot add contents to the game directly. Use a GameScene instead.");
			return null;
		}
		
		/**
		 * Override.
		 * @param	child The child to modify.
		 * @param	index The new chld index.
		 */
		public override function setChildIndex(child:DisplayObject, index:int):void
		{
			throw new Error("You cannot edit the child index of the game directly. modify the GameScene instead.");
		}
	}
}
