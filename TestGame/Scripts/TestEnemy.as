package Scripts
{
	import AutumnFall.Display.GameObject;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class TestEnemy extends GameObject
	{
		public function TestEnemy(id:String = "")
		{
			super(id);
			this.addComponent(new CTrace());
			this.addComponent(new CGameDataTest());
		}
		
	}
	
}