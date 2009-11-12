package AutumnFall.Gui.Windows
{
	import AutumnFall.Containers.Container;
	import fl.transitions.Tween;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	/**
	 * Represents an abstract flash window inside the framework
	 */
	public class Window extends EventDispatcher
	{	
		/**
		 * The graphics object associated with the window
		 */
		protected var graphics:WindowGraphics;
		
		/**
		 * A reference to the contents of the window.
		 * This MUST be a child of the graphics object in order to be correctly added.
		 */
		protected var content:WindowContent;
		
		/**
		 * The rectangleangle object that defines the window's boundaries.
		 */
		protected var rectangle:Rectangle;
		
		/**
		 * The WindowParameters object that defines the window's properties.
		 */
		protected var parameters:WindowParameters;
		
		/**
		 * Unique identifier for the window. It is assigned by the WindowManager.
		 */
		protected var id:int;	
		
		/**
		 * Represents the state of the window at thi time.
		 */
		protected var state:String = WindowState.CLOSED;
		
		/** 
		 * Constructor.
		 * @param id The unique identifier for the window.
		 * @param rectangle The rectangleangle object that defines the window's boundaries.
		 * @param parameters The window properties that define its behaviour and look.
		 * @param graphics The MovieClip of the graphics object associated with this Window.
		 * 
		 */
		public function Window(id:uint, rectangle:Rectangle, parameters:WindowParameters, graphics:WindowGraphics) 
		{	
			//Save data
			this.id = id;
			this.rectangle = rectangle.clone();
			this.parameters = parameters.clone();
			this.graphics = graphics;
			this.content = graphics.content;
		
			//Set the content's owner
			content.setOwnerWindow(this);
			
			//Hide the window
			graphics.visible = false;
			
			//Utility event listener
			graphics.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
		}
		
		/**
		 * This updates the current window's boundaries.
		 * Override this method to get custom functionality but call it via super.
		 * @param	rectangle The rectangleangle object that defines the window's boundaries.
		 * @return This object for chaining.
		 */
		public function update(rectangle:Rectangle = null):Window
		{
			if (rectangle)
			{
				this.rectangle = rectangle;
				graphics.x = rectangle.x;
				graphics.y = rectangle.y;
			}
			return this;
		}
		
		/**
		 * Plays the oppening animation of the window.
		 * Should be overriden.
		 * @return This object for chaining.
		 */
		public function open():Window
		{
			//Update state
			state = WindowState.OPENING;
			
			//Create a modal window?
			if (parameters.modal == true)
			{
				WindowManager.setModalWindow(this.id);
			}
			
			//Update the window with all the information given
			update();
			
			//Show the window
			graphics.visible = true;
			
			return this;
		}
		
		/**
		 * Plays the closing animation of the window.
		 * Should be overriden.
		 * @return This object for chaining.
		 */
		public function close():Window
		{
			//Update state
			state = WindowState.CLOSING;
				
			//Am I modal?
			if (parameters.modal == true)
			{
					WindowManager.clearModalWindow();
			}
			
			return this;
		}
		
		/**
		 * Gets the contents of the window.
		 * @return A container MovieClip with all the contents of the window.
		 */
		public function get Content():Container
		{
			return content;
		}
		
		/**
		 * Gets the unique id of this window.
		 * @return The id.
		 */
		public function get Id():int
		{
			return id;
		}
		
		/**
		 * Gets the graphics  MovieClip of the window
		 * @return A MovieClip with all the graphics of the window.
		 */
		public function get Graphics():MovieClip
		{
			return graphics;
		}
		
		/**
		 * Registers a new event listener for this window.
		 * This override is made to set useWeakReference as true by default as weak references are needed for correct window managment.
		 * @param type The type of event.
		 * @param listener The listener function that processes the event.
		 * @param useCapture Determines whether the listener works in the capture phase or the target and bubbling phases.
		 * @param priority The priority level of the event listener.
		 * @param useWeakReference Determines whether the reference to the listener is strong or weak. Weak references should be used so that windows can be garbage collected.
		 */
		public override function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = true):void
		{
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		/**
		 * Called when the window finished openning.
		 * Should be overriden.
		 */
		protected function onOpenComplete():void
		{
			//Update state
			state = WindowState.OPENED;
			
			//Tell the world we are open.
			dispatchWindowEvent(WindowEvent.ON_OPEN_COMPLETE);
		}
		
		/**
		 * Called when the window finished closing.
		 * Should be overriden.
		 */
		protected function onCloseComplete():void
		{
			//Update state
			state = WindowState.CLOSED;
			
			graphics.visible = false;
			
			//Tell the world we are closed.
			dispatchWindowEvent(WindowEvent.ON_CLOSE_COMPLETE);
			
			if (parameters.destroyOnClose == true)
			{
				dispatchWindowEvent(WindowEvent.ON_DESTROY);
				WindowManager.destoyWindow(id);
			}
		}
		
		/**
		 * Called when the window is clicked.
		 * @param event The event.
		 * @eventType MOUSE_DOWN
		 */
		protected function onMouseDown(event:Event):void
		{
			//If we want the window to be in front when it is clicked, add the event listener.
			if (parameters.clickBringsToFront == true)
			{
				WindowManager.bringWindowToFront(id);
			}
		}
		
		/**
		 * Utility function to dispatch events.
		 * @param	type The type of event to dispatch.
		 */
		protected function dispatchWindowEvent(type:String):void
		{
			dispatchEvent(new WindowEvent(type, {window:this}));
		}
	}
	
}