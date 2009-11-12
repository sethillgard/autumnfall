package AutumnFall.Containers 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	
	/**
	 * Represents a MovieClip that contains children.
	 * Link this class to an empty MovieClip symbol in the library to get its functionality.
	 */
	public class Container extends MovieClip
	{	
		/**
		 * Gets all the contents of this container.
		 * @return contents An Array of <code>DisplayObject</code>.
		 */
		public function getContents():Array
		{
			var a:Array = new Array();
			for(var i=0; i < numChildren; i++)
			{
				a[a.length] = getChildAt(i);	//Push into the array
			}
			
			return a;
		}
		
		/**
		 * Gets all the contents of this container that matches an specified type.
		 * @param type The <code>Class</code> object representing the type.
		 * @return contents An Array of objects of the specified type.
		 */
		public function getContentsOfType(type:Class):Array
		{
			var a:Array = new Array();
			for(var i=0; i < numChildren; i++)
			{
				var o = getChildAt(i);
				if(o is type)
				{
					a[a.length] = o;	//Push into the array
				}
			}
			
			return a;
		}
		
		/**
		 * Clears all the children of this container
		 */
		public function clearContent()
		{
			for(var i=0; i < numChildren; i++)
			{
				removeChildAt(i);
			}
		}
		
		/**
		 * Drop content and add the new child 
		 * @param o The DisplayObject that will be the content of the container
		 * @return	The content set.
		 */
		public function setContent(o:DisplayObject):DisplayObject
		{
			clearContent();
			return addChild(o);
		}
		
	}
	
}