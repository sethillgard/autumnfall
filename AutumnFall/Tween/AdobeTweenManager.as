package AutumnFall.Tween
{
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import fl.transitions.TweenEvent;
	
	/**
	 * Static class used to create Adobe's Tweens inside the framework.
	 * This manager uses Adobe's Tween.
	 */
	public class AdobeTweenManager 
	{		

		private static var tweens:Array = new Array();
		
		/**
		 * Creates a single-run tween for the specified object.
		 * @param	object The target of the tween
		 * @param	propertyName The name of the property that will be changed
		 * @param	begin The start value of the property
		 * @param	finish The end value of the property
		 * @param	duration The duration of the tween
		 * @param	easing Optional. The easing function
		 * @param	useSeconds If set to true the duration parameter is expressed in seconds, else,in miliseconds.
		 * @return The tween object
		 */
		public static function createManagedTween(object:Object, propertyName:String, begin:Number, finish:Number, duration:Number, easing:Function = null, useSeconds:Boolean = true):Tween
		{
			//Parameter correction
			if (easing == null)
			{
				easing = None.easeNone;
			}
			
			//Create the tween
			var tween:Tween = new Tween(object, propertyName, easing, begin, finish, duration, useSeconds);
			
			//Add the tween to the collection
			tweens.push(tween);
			
			//Automaticly reove the tween from the collection on finish.
			tween.addEventListener("motionFinish", TweenManager.onMotionFinish, false, 0, false);
			
			//Return the tween inc ase someone needs it
			return tween;
		}
		
		
		/**
		 * Creates a generic tween for the specified object.
		 * @param	object The target of the tween
		 * @param	propertyName The name of the property that will be changed
		 * @param	begin The start value of the property
		 * @param	finish The end value of the property
		 * @param	duration The duration of the tween
		 * @param	easing Optional.The easing function
		 * @param	useSeconds If set to true the duration parameter is expressed in seconds, else,in miliseconds.
		 * @return The tween object
		 */
		public static function createUnmanagedTween(object:Object, propertyName:String, begin:Number, finish:Number, duration:Number, easing:Function = null, useSeconds:Boolean = true):Tween
		{
			//Parameter correction
			if (easing == null)
			{
				easing = None.easeNone;
			}
			
			//Create the tween
			var tween:Tween = new Tween(object, propertyName, easing, begin, finish, duration, useSeconds);
			
			//Return it
			return tween;
		}
		
		/**
		 * Removes the given tween from the managment system so it can be garbage collected
		 * Should not be called for tweens that are still running animation (unexpected bahaviour)
		 * @param	tween The tween that is no longer needed.
		 */
		public static function removeTween(tween:Tween):void
		{
			var i:uint = tweens.indexOf(tween);
			if (i >= 0)
			{
				tweens.splice(i, 1);
			}
		}
		
		/**
		 * Event handler for the disposal of managed tweens.
		 * @param	event The event.
		 */
		private static function onMotionFinish(event:TweenEvent):void
		{
			//Remove the event listener
			Tween(event.target).removeEventListener("motionFinish", TweenManager.onMotionFinish, false);
			
			//Remove it from the collection
			removeTween(Tween(event.target));
			
			//The tween object is now ready to be garbage collected.
		}
	}
	
}