package AutumnFall.Gui.Balloons 
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	/**
	 * Abstract Balloon object used to create comic-like speaking balloons.
	 */
	public class Balloon extends MovieClip
	{
		/**
		 * The contents of this balloon.
		 */
		protected var content:MovieClip
		
		/**
		 * Contructor.
		 * @param	content The contents of the new Balloon.
		 */
		public function Balloon(content:MovieClip) 
		{	
			this.content = content;
			this.addChild(content);
		}
		
		/**
		 * Updates the drawing of the Balloon.
		 * Should be overriden.
		 */
		public function update():void
		{
		}
	}
	
}