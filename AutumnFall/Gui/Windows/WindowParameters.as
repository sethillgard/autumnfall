package AutumnFall.Gui.Windows 
{
	import flash.geom.Point;
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getDefinitionByName;
	import flash.net.registerClassAlias;
	
	/**
	 * Structure for the window parameters such as styel and behaviour.
	 */
	public dynamic class WindowParameters extends Object
	{
		/**
		 * Used by the GuiManager. The position of the widow.
		 */
		public var position:Point = null;
		
		/**
		 * Used by the GuiManager. The size of the window.
		 */
		public var size:Point = null;
		
		/**
		 * Title of the window.
		 */
		public var title:String = "AutumnFall";
		
		/**
		 * Sets if the window is in modal mode (pauses the application) or not.
		 */
		public var modal:Boolean = false; 
		
		/**
		 * Sets if the window will be destroyed (released from memory) when its closed.
		 */
		public var destroyOnClose:Boolean = false;
		
		/**
		 * Set this to false if you want the window not to have a close button.
		 */
		public var closeButton:Boolean = true;
		
		/**
		 * Set this to true if you want the Window to be in front of other display objects when clicked.
		 */
		public var clickBringsToFront:Boolean = true;
		
		/**
		 * Set this to true if you want the window to be draggable by the title bar.
		 */
		public var draggable:Boolean = true;
		
		/**
		 * Set this to true if you want the window to be resizable by the handler.
		 */
		public var resizable:Boolean = true;
		
		/**
		 * The alpha property of the window.
		 */
		public var alpha:Number = 0.93;
		
		/**
		 * How many seconds should the oppening transition should last (in seconds).
		 */
		public var openAnimationDuration = 0.5;
		
		/**
		 * How many seconds should the closing transition should last (in seconds).
		 */
		public var closeAnimationDuration = 0.5;
		
		/**
		 * Provides a deep copy of this object.
		 * @return A clone of the object.
		 */
		public function clone():* 
		{
			if (firstClone == true)
			{
				firstClone = false;
				var name = getQualifiedClassName(this);
				registerClassAlias(name + "__alias__", getDefinitionByName(name) as Class);
			}
			
			var ba:ByteArray = new ByteArray();
			ba.writeObject(this);
			ba.position = 0;
			return ba.readObject();
		}
		private static var firstClone = true;
	}
	
}