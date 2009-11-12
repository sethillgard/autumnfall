package AutumnFall.Gui.Windows 
{
	import AutumnFall.Containers.Container;
	
	/**
	 * Represents the contents of a window.
	 */
	public class WindowContent extends Container
	{
		/**
		 * The window in which this content is inside.
		 */
		private var ownerWindow:Window = null;
		
		/**
		 * Sets the window in which this content is inside.
		 */
		internal function setOwnerWindow(value:Window):void
		{
			this.ownerWindow = value;
		}
		
		/**
		 * Returns the in which this content is inside.
		 */
		public function get OwnerWindow():Window
		{
			return ownerWindow;
		}
		
	}
	
}