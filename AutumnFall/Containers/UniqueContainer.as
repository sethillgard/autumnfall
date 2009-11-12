package AutumnFall.Containers
{
	import flash.display.*;
	
	/**
	 * Represents a MovieClip that contains a unique children.
	 * Link this class to an empty MovieClip symbol in the library to get its functionality.
	 */
	public class UniqueContainer extends Container
	{		
		/**
		 * Override to only let once child to live.
		 * @param	child The child to add.
		 * @return	The child added.
		 */
		public override function addChild(child:DisplayObject):DisplayObject 
		{
			clearContent();
			return super.addChild(child);
		}
		
		/**
		 * Override to only let once child to live.
		 * @param	child The child to add.
		 * @return	The child added.
		 */
		public override function addChildAt(child:DisplayObject, index:int):DisplayObject 
		{
			clearContent();
			return super.addChild(child);
		}
	}
}