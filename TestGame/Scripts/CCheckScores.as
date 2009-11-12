package Scripts 
{
	import AutumnFall.Components.ScriptComponent;
	import AutumnFall.GameData.*;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import AutumnFall.GameData.ScoreManager;
	
	/**
	 * ...
	 * @author ...
	 */
	public class CCheckScores extends ScriptComponent
	{
		
		public override function onClick(event:MouseEvent = null):void 
		{
			ScoreManager.getTopScores(chale, 15);
		}
		
		public function chale(scores:Array)
		{
			trace("Top results!");
			trace("------------------------------");
			for each(var score:ScoreData in scores)
			{
				trace(score.alias  + ":  " + score.score + "<----" +score.mode);
			}
		}
		
	}
	
}