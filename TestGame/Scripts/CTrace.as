package Scripts
{
	import AutumnFall.Components.ScriptComponent;
	import AutumnFall.GameData.ScoreManager;
	import AutumnFall.Session.Session;
	import AutumnFall.Sound.*;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author ...
	 */
	public class CTrace extends ScriptComponent
	{

		public override function onClick(event:MouseEvent = null):void
		{
			trace(Owner.Id);
			var k:SoundHandler = SoundManager.getSound("Beep");
			k.play();
			
			ScoreManager.Mode = "Hard";
			
			if (Owner.hasComponent("Scripts::CAjua"))
			{
				Owner.deactivateComponent("Scripts::CAjua");
				ScoreManager.setScore(7);
			}
			else
			{
				ScoreManager.setScore(1);
			}
		}
	}
	
}