package AutumnFall.Display 
{
	import AutumnFall.Containers.Container;
	import AutumnFall.Game;
	import AutumnFall.Display.GameObject;
	import AutumnFall.Utils.AssetManager;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.utils.Dictionary;
	
	/**
	 *	Represents a game scene like the game menu, a level or the instructions page.
	 */
	public class GameScene extends Container
	{	
		/**
		 * The dynamic object that holds all reference to the loaded scenes.
		 */
		private static var scenes:Object = new Object();
		
		/**
		 * Retrives the scene object associated with the specified key.
		 * @param	id The key of the scene.
		 * @return The scene object if found, null otherwise.
		 */
		public static function getScene(id:String):GameScene
		{
			return scenes[id] as GameScene;
		}
		
		/**
		 * The id of this Scene.
		 */
		private var id:String = "__unnamedScene__";
		public function get Id():String { return id; }
		
		/**
		 * The collection of all GameObjects this scene has.
		 */
		private var gameObjects:Object = new Object();
		
		/**
		 * Is this scene paused?. 
		 */
		private var paused:Boolean = false;
		public function get Paused():Boolean { return paused; }
		
		/**
		 * Pauses the scene deactivating all GameObjects.
		 */
		public function pause():void 
		{
			this.paused = true;
			for each(var go:GameObject in gameObjects)
			{
				go.deactivate();
			}
		}
		
		/**
		 * Resumes the scene activating all previusly activated GameObjects (before the scene was paused);
		 */
		public function resume():void 
		{
			this.paused = false;
			for each(var go:GameObject in gameObjects)
			{
				if (go.Activated)
				{
					go.activate();
				}
			}
		}
		
		
		/**
		 * Scene constructor. Must be called by every child of this class.
		 * @param 	id	Optional. The id of this scene. If not provided the scene wont have an id.
		 */
		public function GameScene(id:String = "") 
		{
			//Do we have an id?
			if (id != "")
			{
				//Register me in the Scene Manager
				register(id);
			}
			
			//Get all the GameObjects in this DisplayObject.
			readSource(this);
		}
		
		/**
		 * Reads the given MovieClip in the search of DisplayObjects and GameObjects to add them to the scene.
		 * The source parameter is modified in the sense that all DisplayObjects will be transfered to this scene.
		 * @param	source The MovieClip to be read.
		 */
		public function readSource(source:MovieClip):void
		{
			//Find GameObjects and add them to the list
			for (var i:int = 0; i < source.numChildren; i++)
			{
				var child:DisplayObject = source.getChildAt(i);
				
				//Is this child a GameObject?
				if (child is GameObject)
				{
					var gameObject:GameObject = child as GameObject;
					
					//Set the child's owner scene and store it in the collection
					gameObject.setScene(this);
					gameObjects[gameObject.Id] = gameObject;
				}
				
				//If the source is this object, add its childs to the display list
				if (source != this)
				{
					addChildAt(child, i);
				}
			}
		}
		
		/**
		 * Clears (empty) this scene. All GameObjects and DisplayObjects are deatached.
		 */
		public function clear():void
		{
			//Iterate and find all GameObjects
			for each(var p:GameObject in gameObjects)
			{
				removeGameObject(p.Id);
			}
			
			//No childs please
			clearContent();
		}
		
		/**
		 * Registers a new GameObject to this scene.
		 * @param	gameObject The GameObject to be added.
		 * @param 	insertAt Optional. The index of the GameObject in the display list of the scene.  If not specified the object will be added on top.
		 */
		public function addGameObject(gameObject:GameObject, insertAt:int = undefined)
		{
			//Tell the GameObject who is its new daddy.
			gameObject.setScene(this);
			
			//Add it to the collection
			gameObjects[gameObject.Id] = gameObject;
			
			//Add it to the display list of the scene.
			if (insertAt)
			{
				addChildAt(gameObject, insertAt);
			}
			else
			{
				addChild(gameObject);
			}
		}
		
		/**
		 * Removes the GameObject with the given id from this scene and returns it.
		 * @param	id The id of the object to be removed.
		 * @return The deatached GameObject
		 */
		public function removeGameObject(id:String):GameObject
		{
			var gameObject:GameObject = getGameObject(id);
			if (gameObject)
			{
				//Tell it it no longer lives here
				gameObject.setScene(null);
				
				//Delete scene records
				gameObjects[id] = null;
				
				//Deatach it
				removeChild(gameObject);
			}
			
			return gameObject;
		}
		
		/**
		 * Returns the GameObject with the given id.
		 * @param	id The id to search.
		 * @return	The GameObject, null if it doesn't exist.
		 */
		public function getGameObject(id:String):GameObject
		{
			return gameObjects[id] as GameObject;
		}
		
		/**
		 * Find all the GameObjects in the scene and return an Array containing them.
		 * @return	An Array of GameObjects.
		 */
		public function getGameObjects():Array
		{
			var collection:Array = new Array();
			
			//Iterate and find all objects
			for each(var p:GameObject in gameObjects)
			{
				collection.push(p);
			}
			
			//Return it
			return collection;
		}
		
		/**
		 * Find all the GameObjects in the scene with the given tag and return an Array containing them.
		 * @param	tag The tag to search within all GameObjects in the scene.
		 * @return	An Array of GameObjects.
		 */
		public function getGameObjectsWithTag(tag:String):Array
		{
			var collection:Array = new Array();
			
			//Iterate and find all objects that have that tag
			for each(var p:GameObject in gameObjects)
			{
				if (GameObject(p).hasTag(tag))
				{
					collection.push(p);
				}
			}
			
			//Return it
			return collection;
		}
		
		/**
		 * Registers this scene within the scene manager.
		 * @param	id The key associated with this scene.
		 */
		public function register(id:String):void
		{
			//If an scene with this id already exists, indicate the Error.
			if (scenes[id])
			{
				throw new Error("Scene id collision. Two scenes have the same id: " + id);
			}
			
			this.id = id; 
			GameScene.scenes[id] = this;
		}
		
		/**
		 * Unregisters this scene within the scene manager.
		 * @param	id The key associated with this scene.
		 */
		public function unregister():void
		{
			//If an scene with this id already exists, indicate the Error.
			if (scenes[id])
			{
				scenes[id] = null;
				delete scenes[id];
				this.id = "";
			}
		}
	}
	
}