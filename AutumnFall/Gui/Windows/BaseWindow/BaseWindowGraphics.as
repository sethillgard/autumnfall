package AutumnFall.Gui.Windows.BaseWindow
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.text.TextField;
	import AutumnFall.Gui.Windows.*;
	
	/**
	 * Used for linkage within the library of the loader.
	 */
	public class BaseWindowGraphics extends WindowGraphics
	{
		//Stage.
		public var background:MovieClip;
		public var resizeHandler:MovieClip;
		public var titleBar:MovieClip;
		public var contentMask:MovieClip;
		public var closeButton:SimpleButton;
		public var title:TextField;
	}
	
}