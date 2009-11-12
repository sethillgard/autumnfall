package AutumnFall.Gui
{
	import AutumnFall.*;
	import AutumnFall.GameData.ScoreManager;
	import AutumnFall.Gui.Forms.Form;
	import AutumnFall.Gui.Forms.Leadersboard.BaseLeadersboardForm;
	import AutumnFall.Tween.TweenManager;
	import AutumnFall.AssetLoaders.Loader;
	import AutumnFall.AssetLoaders.LoadEvent;
	import AutumnFall.Gui.Balloons.Error.BaseErrorBalloon;
	import AutumnFall.Gui.Forms.Login.BaseLoginForm;
	import AutumnFall.Gui.LoadingScreens.BaseLoadingScreen.BaseLoadingScreen;
	import AutumnFall.Gui.LoadingScreens.BaseLoadingScreen.BaseLoadingScreenGraphics;
	import AutumnFall.Gui.LoadingScreens.LoadingScreen;
	import AutumnFall.Gui.Windows.*;
	import AutumnFall.Gui.Windows.BaseWindow.*;
	import AutumnFall.Gui.Windows.MessageBox.*;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	
	/**
	 * Provides static effects to Graphic User Interface items such as login screens.
	 */
	public class GuiManager 
	{	
		/**
		 * Creates a new window. You can use WindowManager to do it but this has support fot default window types, parameters and styles.
		 * @param 	extraParameters Optional. A dynamic object ({ }) that overrides default window parameters.
		 * @param	content Optional. The content inside the window
		 * @param 	type Optional. The class of the window to be created.
		 * @param 	style Optional. All window classes must support styles. This is the style class linked to the library symbol.
		 * @return	The new window.
		 */
		public static function createWindow(extraParameters:Object = null, content:MovieClip = null):Window
		{	
			//Merge the default parameters & the extra parameters
			var parameters:WindowParameters = defaultWindowParameters.clone();
			for (var p:String in extraParameters)
			{
				parameters[p] = extraParameters[p];
			}
			
			//The positon and size of the window
			var rectangle:Rectangle = new Rectangle();
			
			//Position
			if (parameters.position)
			{
				rectangle.x = parameters.position.x;
				rectangle.y = parameters.position.y;
			}
			else
			{
				//Increase position count so not all windows start in the same position
				increaseWindowPosition();
				
				rectangle.x = windowPosition.x;
				rectangle.y = windowPosition.y;
			}
			
			//Size of the window
			if (parameters.size)
			{
				rectangle.width = parameters.size.x;
				rectangle.height = parameters.size.y;
			}
			else //No default size, do we have content to extract the size?
			{
				if (content)
				{
					rectangle.width = content.width + 40;
					rectangle.height = content.height + 60;
				}
				else //Use default one
				{
					rectangle.width = defaultWindowSize.x;
					rectangle.height = defaultWindowSize.y;
				}
			}
			
			//Create the new window. The WindowManager handles internal stuff like visualization.
			return WindowManager.createWindow(windowType, windowStyle, parameters, rectangle, content);			
		}	
		
		/**
		 * Displays a MessageBox using the current window configuration.
		 * @param	message What do you want me to say?
		 * @param	extraParameters Set the title here! All window parameters work.
		 * @return	The window object with the form.
		 */
		public static function createMessageBox(message:String, extraParameters:Object = null):Window
		{
			//Create the messageBox using the information stored in the class.
			var content:MovieClip = new messageBoxContentStyle(message);
			
			//Merge the default parameters & the extra parameters
			var parameters:Object = { title:"MessageBox", modal:false, closeButton:true, draggable:true, resizable:false, destroyOnClose:true, clickBringsToFront:true };
			for (var q:String in extraParameters)
			{
				parameters[q] = extraParameters[q];
			}
			
			//Create the window for the MessageBox
			return GuiManager.createWindow(parameters, content);
		}
		
		/**
		 * Creates a user form using the current window configuration.
		 * @param	form The form object. Specify a child of Form.
		 * @param	extraParameters Set the title here! All window parameters work.
		 * @return 	The window object with the form.
		 */
		public static function createForm(form:Form = null, extraParameters:Object = null):Window
		{	
			//Merge the default parameters & the extra parameters
			var parameters:Object = { title: "Form", modal:false, closeButton:true, draggable:true, resizable:false, destroyOnClose:true, clickBringsToFront:true };
			for (var q:String in extraParameters)
			{
				parameters[q] = extraParameters[q];
			}
			
			//Create the window for the Form
			return GuiManager.createWindow(parameters, form);
		}
		
		/**
		 * Creates a new managed loading screen for the specified loader.
		 * The screen will show and hide automaticly.
		 * @param	loader The loader of this loading screen.
		 * @return The LoadingScreen object
		 */
		public static function showManagedLoadingScreen(loader:Loader, transitionDuration:Number = 1):void
		{
			var screen:LoadingScreen = new loadingScreenType(loader, new loadingScreenStyle());
			
			//Callback function
			var temp = function(event:LoadEvent)
			{
				TweenManager.createTweenTo(screen.Graphics, transitionDuration, { alpha: 0, onComplete:temp2} );
			}
			
			var temp2 = function()
			{
				screen.Graphics.visible = false;
				screen = null;
			}
			
			//Set the laoding screen
			screen.Graphics.x = GameLoader.GameArea.x;
			screen.Graphics.y = GameLoader.GameArea.y;
			screen.Graphics.width = GameLoader.GameArea.width;
			screen.Graphics.height = GameLoader.GameArea.height;
			Application.Root.addChild(screen.Graphics);
			screen.Graphics.alpha = 0;
			TweenManager.createTweenTo(screen.Graphics, transitionDuration, { alpha: 1 } );
			screen.addEventListener(LoadEvent.ON_COMPLETE, temp);
		}
		
		/**
		 * Show a Leadersboard form.
		 * @param	limit Optional. The number of scores to be retrived.
		 * @param 	mode Optional. Set this to the mode from which you want to retrive the scores. Leave empty to use the current mode.
		 * @param 	ignoreMode Optional. Set this to true to get all scores ignoring the mode parameter.
		 * @param 	extraParameters Optional. The extra parameters for the window.
		 */
		public static function showTopScores(limit:int = 10, mode:String = "__currentMode__", ignoreMode:Boolean = false, extraParameters:Object = null):void
		{
			//Save the current mode
			var oldMode:String = ScoreManager.Mode;
			
			//Create the form and show it
			var form:BaseLeadersboardForm = new BaseLeadersboardForm();
			GuiManager.createForm(form, extraParameters).open();
			
			//Different mode?
			if (mode != "__currentMode__")
			{
				ScoreManager.Mode = mode;
			}
			
			//Get the scores
			ScoreManager.getTopScores(form.fillGrid, limit, ignoreMode);
			
			//Restore mode?
			if (mode != "__currentMode__")
			{
				ScoreManager.Mode = oldMode;
			}
	
		}
		
		/**
		 * Overwrites the given parameters in the default ones.
		 * @param	newParameters The new parameters.
		 */
		public static function addDefaultWindowParameters(newParameters:Object)
		{
			//Merge the default parameters & the new parameters
			for (var p:* in newParameters)
			{
				defaultWindowParameters[p] = newParameters[p];
			}
		}
		
		/**
		 * Increases the window position so not all windows start in the same place.
		 * @private
		 */
		private static function increaseWindowPosition():void
		{
			windowPosition.x += 30;
			windowPosition.y += 30;
			
			//Reestart?
			if (windowPosition.y > initialWindowPosition.y + 180)
			{
				windowPosition = initialWindowPosition.clone();
			}
		}
		
		/**
		 * The type of LoadingScreen to be used. Must be a child of LoadingScreen.
		 */
		private static var loadingScreenType:Class = BaseLoadingScreen;
		public static function get LoadingScreenType():Class { return loadingScreenType; }
		public static function set LoadingScreenType(value:Class):void { loadingScreenType = value; }
		
		/**
		 * The style of LoadingScreen to be used. Must be a child of LoadingScreenGraphics.
		 * @example If you are using BaseWindow as type, the window style must be a child of BaseWindowGraphics
		 */
		private static var loadingScreenStyle:Class = BaseLoadingScreen;
		public static function get LoadingScreenStyle():Class { return loadingScreenStyle; }
		public static function set LoadingScreenStyle(value:Class):void { loadingScreenStyle = value; }
		
		/**
		 * The window type of the windows to be created. Must be a child of Window.
		 */
		private static var windowType:Class = BaseWindow;
		public static function get WindowType():Class { return windowType; }
		public static function set WindowType(value:Class):void { windowType = value; }
		
		/**
		 * The window style of the windows to be created. Must be linked to the library and correspond to the window type used.
		* @example If you are using BaseWindow as type, the window style must be a child of BaseWindowGraphics
		 */
		private static var windowStyle:Class = BaseWindowGraphics;
		public static function get WindowStyle():Class { return windowStyle; }
		public static function set WindowStyle(value:Class):void { windowStyle = value; }
		
		/**
		 * The default window parameters of the windows to be created.
		 */
		private static var defaultWindowParameters:WindowParameters = new WindowParameters();
		public static function get DefaultWindowParameters():WindowParameters { return defaultWindowParameters; }
		public static function set DefaultWindowParameters(value:WindowParameters):void { defaultWindowParameters = value; }
		
		/**
		 * The style of the messagebox content to be created. Must be a child of MessageBoxContent.
		 */
		private static var messageBoxContentStyle:Class = BaseMessageBoxContent;
		public static function get MessageBoxContentStyle():Class { return messageBoxContentStyle; }
		public static function set MessageBoxContentStyle(value:Class):void { messageBoxContentStyle = value; }
		
		/**
		 * The default window size of the windows to be created.
		 */
		private static var defaultWindowSize:Point = new Point(400, 300);
		public static function get DefaultWindowSize():Point { return defaultWindowSize; }
		public static function set DefaultWindowSize(value:Point):void { defaultWindowSize = value; }
		
		/**
		 * The position of the windows to be created. 
		 */
		private static var initialWindowPosition:Point = new Point(100, 40);
		public static function get InitialWindowPosition():Point { return initialWindowPosition; }
		public static function set InitialWindowPosition(value:Point):void { initialWindowPosition = value; }
		
		/**
		 * Current window starting position.
		 */
		private static var windowPosition:Point = initialWindowPosition.clone();
	}
	
}