package AutumnFall.Gui.Windows
{
	import AutumnFall.*;
	import AutumnFall.Gui.Windows.BaseWindow.*;
	import fl.managers.StyleManager;
	import flash.display.*;
	import flash.geom.Rectangle;
	import AutumnFall.Effects.Fade.*;
	
	
	/**
	 * Static class used to handle window managment such as the Windows collection.
	 * All windows should be created using this interface (or GuiManager) and not calling Window constructor.
	 */
	public class WindowManager 
	{	

	
		/**
		 * The collection of windows currently opened
		 */
		private static var windows:Array = new Array();
		
		/**
		 * Creates a new window. To display it call open() on the returned window.
		 * @param 	type The class of the window to be created.
		 * @param 	style All window classes must support styles. This is the style class linked to the library symbol.
		 * @param	rect The window's position and size.
		 * @param 	parameters The behaviour of the window.
		 * @param	content Optional. The content inside the window.
		 * @return	The new window.
		 */
		public static function createWindow(type:Class, style:Class, parameters:WindowParameters, rect:Rectangle, content:MovieClip = null):Window
		{	
			var wnd:Window;
			
			//We are not sure about type and style.
			try
			{
				//Create the new window. 
				wnd = new type(windows.length, rect, parameters, new style());
			}
			catch (error)
			{
				throw new Error("Error creating Window. Check Type and Style.");
			}
			
			//Register the new window
			windows.push(wnd);	//Push the new window into the array.
			Application.Root.addChild(wnd.Graphics);	//Diplay it.
			
			//Add some content?
			if (content)
			{
				wnd.Content.addChild(content);
			}
			
			return wnd;
		}
		
		/**
		 * Closes the window with the given id.
		 * @param	id The id of the window to be closed.
		 */
		public static function closeWindow(id:uint):void
		{
			Application.Root.removeChild(windows[id]);
			windows[id] = null;
		}
		
		/**
		 * Destroys the window with the given id.
		 * This doesn't play the close animation and should be called at the end of the close animation (unless you want to reopen the window).
		 * @param	id The id of the window to be destruyed.
		 */
		public static function destoyWindow(id:uint):void
		{
			Application.Root.removeChild(windows[id].Graphics);
			windows[id] = null;
		}
		
		/**
		 * Brings the window with the given Id to the fron of the screen.
		 * @param	id
		 */
		public static function bringWindowToFront(id:uint):void
		{
			Application.Root.setChildIndex(windows[id].Graphics, Application.Root.numChildren - 1);
		}
		
		/**
		 * Returns the Owner Id of the specified content inside a window.
		 * @param	me The window content as MovieClip. Should be a direct child of the WindowContent object. Usually this.
		 * @return	The window associated with this window content.
		 */
		public static function getOwnerWindow(me:MovieClip):Window
		{
			var windowContent:WindowContent = me.parent as WindowContent;
			if (windowContent)
			{
				return windowContent.OwnerWindow;
			}
			else
			{
				return null;
			}
		}
		
		/**
		 * Returns the window stored with the specified window id.
		 * @param	id The id of the window to return.
		 * @return The window if exists or null if not.
		 */
		public static function getWindow(id:uint):Window
		{
			if (windows[id])
			{
				return windows[id];
			}
			else
			{
				return null;
			}
		}
		
		/**
		 * Creates an effect so that the window with the given id appears as a modal window.
		 * @param	id
		 */
		public static function setModalWindow(id:uint):void
		{
			FadeManager.fadeIn( { fullscreen:true, duration:1, alpha:0.5 } );
			Application.Root.setChildIndex(windows[id].Graphics, Application.Root.numChildren - 1);
			Application.Root.setChildIndex(GameLoader(Application.Root).fade, Application.Root.numChildren - 2);
		}
		
		/**
		 * Clears the modal window effect.
		 */
		public static function clearModalWindow():void
		{
			FadeManager.fadeOut( { fullscreen:true, duration:1 } );
			Application.Root.setChildIndex(GameLoader(Application.Root).fade, 0);
		}
	}
	
}