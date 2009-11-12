package AutumnFall.Effects.Fade
{
	import AutumnFall.*;
	import fl.motion.Color;
	import AutumnFall.Tween.*;
	import AutumnFall.Tween.Easing.*;
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	
	/**
	 * Provides static access to the fade object in the main timeline used to create fade effects.
	 */
	public class FadeManager 
	{
		//Last values of the parameters (parameter caching)
		private static var lastDuration:Number = -1;
		private static var lastAlpha:Number = -1;
		private static var lastTint:Color = null;
		
		/**
		 * Creates a Tween for the fade object to enter the scene.
		 * @param	parameters The parameters of the fade.
		 * @param 	onCompleteCallback The function that will be called when the fade is complete.
		 */
		public static function fadeIn(parameters:Object = null, onCompleteCallback:Function = null) 
		{
			//Null prevention
			parameters = parameters ? parameters : {};
			
			//Set the callback
			var temp:Function = function()
			{
				//Call and clear callbacks
				if (onCompleteCallback != null)
				{
					onCompleteCallback();
				}
			}
			
			//Start the fade
			GameLoader.Root.fade.alpha = 0;
			GameLoader.Root.fade.visible = true;
			var gameLoader:GameLoader = GameLoader.Root;
			gameLoader.setChildIndex(gameLoader.fade, gameLoader.numChildren - 1);
			FadeManager.createFade(parameters, temp);
		}
		
		/**
		 * Creates a Tween for the fade object to exit the scene.
		 * @param	parameters The parameters of the fade.
		 * @param 	onCompleteCallback The function that will be called when the fade is complete.
		 */
		public static function fadeOut(parameters:Object = null, onCompleteCallback:Function = null) 
		{
			//Null prevention
			parameters = parameters ? parameters : {};
			
			//Set the callback
			var temp:Function = function()
			{
				//Call and clear callbacks
				if (onCompleteCallback != null)
				{
					onCompleteCallback();
				}
				
				GameLoader.Root.fade.alpha = 0;
				GameLoader.Root.fade.visible = false;
			}
			
			//End the fade
			parameters.alpha = 0;
			FadeManager.createFade(parameters, temp);
		}
		
		
		/**
		 * Creates a Tween for the fade object to enter and exits the scene.
		 * @param	parameters The parameters of the fade.
		 * @param 	onMiddleFade The function that will be called when the fade is at half (when the screen is covered by it).
		 * @param 	onCompleteCalllback The function that will be called when the fade is complete.
		 */
		public static function fadeInOut(parameters:Object = null, onMiddleFade = null, onCompleteCalllback:Function = null) 
		{	
			//Null prevention
			parameters = parameters ? parameters : {};
			
			//Correct duration parameter
			if (parameters.duration)
			{
				parameters.duration /= 2;
			}
			else
			{
				parameters.duration = (new FadeParameters()).duration / 2;
			}
			
			var temp:Function = function()
			{
				if (onMiddleFade != null)
				{
					onMiddleFade();
				}
				FadeManager.fadeOut(parameters, temp2);
			}
			
			var temp2:Function = function()
			{
				onCompleteCalllback();
			}
			
			//Start the fade
			FadeManager.fadeIn(parameters, temp);
		}
		
		/**
		 * Creates a Tween for the fade object.
		 * @param	parameters The parameters for this fade
		 * @param 	onCompleteCallback The function you want to be called when the effect finishes.
		 */
		private static function createFade(parameters:Object = null, onCompleteCallback:Function = null) 
		{
			//Shortcut
			var fade:MovieClip = GameLoader(Application.Root).fade;
			
			//Null prevention
			parameters = parameters ? parameters : {};
			
			//Make the parameters of the correct type.
			var params:FadeParameters = new FadeParameters();
			for (var p:* in parameters)
			{
				params[p] = parameters[p];
			}
			
			//Make it visible
			GameLoader(Application.Root).fade.visible = true;
			
			//Apply tint
			GameLoader(Application.Root).fade.transform.colorTransform.color = params.tint.color;
			
			//Set the size
			if (params.fullscreen == true)
			{
				fade.x = 0;
				fade.y = 0;
				fade.width = fade.stage.width;
				fade.height = fade.stage.height;
			}
			else
			{
				fade.x = GameLoader.GameArea.x;
				fade.y = GameLoader.GameArea.y;
				fade.width = GameLoader.GameArea.width;
				fade.height = GameLoader.GameArea.height;
			}
			
			//Start alpha
			if (params.startAlpha != -1)
			{
				fade.fade.alpha = params.startAlpha;
			}
			
			//The parameters of the tween.
			var tweenParameters:Object = { };
			tweenParameters.alpha = params.alpha;
			if (onCompleteCallback != null)
			{
				tweenParameters.onComplete = onCompleteCallback;	
			}
			
			//Tween it!
			TweenManager.createTweenTo(fade, params.duration, tweenParameters);
		}
	}
}