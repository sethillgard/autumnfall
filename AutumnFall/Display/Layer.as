package AutumnFall.Display 
{
	import AutumnFall.Containers.UniqueContainer;
	
	/**
	 * A layer in the display list of the game. Each layer can contain only one GameScene.
	 */
	public class Layer extends UniqueContainer
	{
		/**
		 * The GameScene associated with this layer.
		 */
		private var scene:GameScene = null;
		public function get Scene():GameScene { return scene; }
		
		/**
		 * Sets the scene object for this layer.
		 * @param	scene
		 */
		public function set Scene( scene:GameScene ):void
		{
			this.scene = scene;
			setContent(scene);
		}
		
	}
	
}