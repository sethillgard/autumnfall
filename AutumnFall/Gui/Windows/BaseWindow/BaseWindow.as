package AutumnFall.Gui.Windows.BaseWindow
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import AutumnFall.Application;
	import AutumnFall.Gui.Windows.*;
	import AutumnFall.Tween.TweenManager;

	
	/**
	 * Represents the default concrete window inside the framework.
	 * Should be linked in the loader library.
	 */
	public class BaseWindow extends Window
	{		
		/**
		 * Timer object used to constantly update the window when its being resized.
		 */
		private var resizeTimer:Timer;
		
		/** 
		 * Constructor.
		 * @param id The unique identifier for the window.
		 * @param rectangle The rectangleangle object that defines the window's boundaries.
		 * @param parameters The window properties that define its behaviour and look.
		 * @param graphics The graphics object associated with this window.
		 */
		public function BaseWindow(id:uint, rectangle:Rectangle, parameters:WindowParameters, graphics:BaseWindowGraphics) 
		{	
			//Construct the window using the given data.
			super(id, rectangle, parameters, graphics);
			
			//Title
			graphics.title.text = parameters.title;
			
			//Close button?
			if (parameters.closeButton == true)
			{
				graphics.closeButton.addEventListener(MouseEvent.CLICK, onCloseButtonPressed);
			}
			else
			{
				graphics.removeChild(graphics.closeButton);
			}
			
			//Draggable?
			if (parameters.draggable == true)
			{
				graphics.titleBar.addEventListener(MouseEvent.MOUSE_DOWN, onTitleBarMouseDown);
				graphics.title.addEventListener(MouseEvent.MOUSE_DOWN, onTitleBarMouseDown);
				graphics.titleBar.addEventListener(MouseEvent.MOUSE_UP, onTitleBarMouseUp);
				graphics.title.addEventListener(MouseEvent.MOUSE_UP, onTitleBarMouseUp);
			}
			
			//Resize?
			if (parameters.resizable == false)
			{
				graphics.removeChild(graphics.resizeHandler);
			}
			else
			{
				resizeTimer = new Timer(10, 0);
				resizeTimer.addEventListener(TimerEvent.TIMER, onResizeTimer);
				
				graphics.resizeHandler.addEventListener(MouseEvent.MOUSE_DOWN, onResizeHandlerMouseDown);
				graphics.resizeHandler.addEventListener(MouseEvent.MOUSE_UP, onResizeHandlerMouseUp);
			}
		}	
		
		/**
		 * This updates the current window's boundaries.
		 * @param	rectangle The rectangleangle object that defines the window's boundaries.
		 * @return This object for chaining.
		 */
		public override function update(rectangle:Rectangle = null):Window
		{	
			//Data assert
			if (!rectangle)
			{
				rectangle = this.rectangle;
			}
			
			//Call daddy
			super.update(rectangle);
			
			var graphics:BaseWindowGraphics = graphics as BaseWindowGraphics;
			
			//Update all properties
			graphics.background.width = rectangle.width;
			graphics.background.height = rectangle.height - 20;
			graphics.titleBar.width = rectangle.width;
			graphics.closeButton.x = (graphics.titleBar.x + graphics.titleBar.width) - graphics.closeButton.width;
			graphics.contentMask.width = rectangle.width - 20;
			graphics.contentMask.height = rectangle.height - 40;
			graphics.resizeHandler.x = rectangle.width - 15;
			graphics.resizeHandler.y = rectangle.height - 15;
			graphics.resizeHandler.width = 15;
			graphics.resizeHandler.height = 15;
			graphics.title.width = rectangle.width - 50;
			
			//Style
			graphics.background.alpha = parameters.alpha;
			graphics.titleBar.alpha = parameters.alpha;
			
			return this;
		}
		
		
		/**
		 * Plays the opening animation of the window.
		 * @return This object for chaining.
		 */
		public override function open():Window
		{
			if (state == WindowState.CLOSED)
			{
				super.open();
				
				graphics.alpha = 0;
				TweenManager.createTweenTo(graphics, parameters.openAnimationDuration, { alpha:1, onComplete:onOpenComplete } );
			}
			
			return this;
		}
		
		/**
		 * Plays the closing animation of the window.
		 * @return This object for chaining.
		 */
		public override function close():Window
		{
			if (state == WindowState.OPENED)
			{
				super.close();
				
				graphics.alpha = 1;
				TweenManager.createTweenTo(graphics, parameters.closeAnimationDuration, {alpha:0, onComplete:onCloseComplete});
			}
			
			return this;
		}
		
		/**
		 * Called when the window finished openning.
		 */
		protected override function onOpenComplete():void
		{	
			super.onOpenComplete();
		}
		
		/**
		 * Called when the window finished closing.
		 */
		protected override function onCloseComplete():void
		{
			super.onCloseComplete();
		}
		
		/**
		 * Event handler for the close button.
		 * @param	event The event
		 * @eventType CLICK
		 */
		private function onCloseButtonPressed(event:Event):void
		{
			close();
		}
		
		/**
		 * Event handler for the mouse down at the title bar.
		 * @param	event The event
		 * @eventType MOUSE_DOWN
		 */
		private function onTitleBarMouseDown(event:Event):void
		{
			if (state == WindowState.OPENED)
			{
				graphics.startDrag();
			}
		}
		
		/**
		 * Event handler for the mouse up at the title bar.
		 * @param	event The event
		 * @eventType MOUSE_DOWN
		 */
		private function onTitleBarMouseUp(event:Event):void
		{
			graphics.stopDrag();
			
			//Update the rectangle object
			this.rectangle.x = graphics.x;
			this.rectangle.y = graphics.y;
		}
		
		/**
		 * Event handler for the mouse down at the resize handler.
		 * @param	event The event
		 * @eventType MOUSE_DOWN
		 */
		private function onResizeHandlerMouseDown(event:Event):void
		{
			if (state == WindowState.OPENED)
			{
				BaseWindowGraphics(graphics).resizeHandler.startDrag(false, new Rectangle(50, 50, Application.Root.stage.width - graphics.x - 15, Application.Root.stage.height - graphics.y - 15));
				resizeTimer.start();
			}
		}
		
		/**
		 * Event handler for the mouse up at the resize handler.
		 * @param	event The event
		 * @eventType MOUSE_DOWN
		 */
		private function onResizeHandlerMouseUp (event:Event):void
		{
			BaseWindowGraphics(graphics).resizeHandler.stopDrag();
			resizeTimer.stop();
		}
		
		/**
		 * Event handler for the timer at the resize handler.
		 * @param	event The event
		 * @eventType TIMER
		 */
		private function onResizeTimer (event:TimerEvent):void
		{
			var graphics:BaseWindowGraphics = graphics as BaseWindowGraphics;
			
			if (state == WindowState.OPENED)
			{
				//Update coordinates
				this.update(new Rectangle(graphics.x, graphics.y, graphics.resizeHandler.x + 15, graphics.resizeHandler.y + 15));
			}
			else
			{
				//Clear the drag
				onResizeHandlerMouseUp(null);
			}
		}
	}
	
}