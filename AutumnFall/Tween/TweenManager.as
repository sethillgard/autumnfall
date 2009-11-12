package AutumnFall.Tween 
{
	import AutumnFall.Tween.TweenLite.*;
	
	/**
	 * Abstraction layer between the framework and the tween engine so that we can change the tween engine at pleasure.
	 */
	public class TweenManager 
	{
		private static var tweenEngine:Class = TweenLite;
		
		/**
		 * Creates a tween from the current state of the property  to the specified one in parameters
		 * @param	object	The target of the tween.
		 * @param	duration The duration of the tween.
		 * @param	parameters An object containing all the target values  and callback functions.
		 */
		public static function createTweenTo(object:Object, duration:Number, parameters:Object)
		{
			if(tweenEngine == TweenLite)
			{
				TweenLite.to(object, duration, parameters);
			}
		}
		
		/**
		 * Creates a tween from the specified state in parameters to the current one.
		 * @param	object	The target of the tween.
		 * @param	duration The duration of the tween.
		 * @param	parameters An object containing all the target values  and callback functions.
		 */
		public static function createTweenFrom(object:Object, duration:Number, parameters:Object)
		{
			if(tweenEngine == TweenLite)
			{
				TweenLite.from(object, duration, parameters);
			}
		}
		
	}
	
}