package AutumnFall.Gui.Balloons 
{
	import AutumnFall.Utils.Colors;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	/**
	 * Represents a simple Comil Balloon that has a simple tail connected to the skeaker.
	 */
	public class SimpleTailBalloon extends Balloon
	{
		/**
		 * Where do you want the tail to end?
		 */
		protected var tailPoint:Point;
		
		//Colors of the Balloon
		protected var startColor:uint;
		protected var endColor:uint;
		
		//Line properties
		protected var lineThickness:Number;
		protected var lineColor:uint;
		
		/**
		 * Constructor.
		 * @param	content The contents of the ballon.
		 * @param	tailPoint Where do you want the tail to end?
		 * @param	startColor Left color of the balloon.
		 * @param	endColor Right color of the balloon.
		 * @param	lineThickness Line thickness for the border of the balloon.
		 * @param	lineColor The color of the border line.
		 */
		public function SimpleTailBalloon(content:MovieClip, tailPoint:Point, startColor:uint = Colors.WHITE, endColor:uint = Colors.WHITE_SMOKE, lineThickness:Number = 1, lineColor:uint = Colors.BLACK) 
		{
			//Save all data
			this.tailPoint = tailPoint;
			this.startColor = startColor;
			this.endColor = endColor;
			this.lineThickness = lineThickness;
			this.lineColor = lineColor;
			super(content);
			
			//Format the content a little
			content.x = 5;
			content.y = 5;
			
			//Draw everything!
			update();
		}
		
		/**
		 * Draws the borders and the tail of the balloon.Call this function after you move the balloon to update the tail.
		 */
		public override function update():void
		{	
			//Draw the Balloon.
			var g:Graphics = this.graphics;
			g.clear();
			g.lineStyle( lineThickness, lineColor );
			g.beginGradientFill(GradientType.LINEAR, [startColor, endColor], [0.9, 0.9], [0, 255]);
			g.drawRoundRect(0, 0, this.content.width + 5, this.content.height + 5, 15, 15);
			
			//Draw tail
			g.moveTo(this.content.width / 2 - 10, this.content.height + 5);
			g.lineTo(tailPoint.x, tailPoint.y);
			g.lineTo(this.content.width / 2 + 10, this.content.height + 5);
			g.endFill();
		}
		
	}
	
}