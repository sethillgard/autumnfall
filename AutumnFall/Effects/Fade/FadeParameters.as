package AutumnFall.Effects.Fade 
{
	import fl.motion.Color;
	
	/**
	 * FadeEffect parameters. Used with FadeManager.
	 */
	public dynamic class FadeParameters extends Object
	{
		/**
		 * Is the fade fullscreen?
		 */
		public var fullscreen:Boolean = false;
		
		/**
		 * The duration of the fade object.
		 */
		public var duration:Number = 1;
		
		/**
		 * The maximum alpha of the fade.
		 */
		public var alpha:Number = 1;
		
		/**
		 * The stating alpha of the fade.
		 */
		public var startAlpha:Number = -1;
		
		/**
		 * Tint applied to the fade.
		 */
		public var tint:Color = new Color(0, 0, 0);
	}
	
}