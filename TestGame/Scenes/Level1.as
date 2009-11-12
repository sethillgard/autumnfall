package Scenes
{
	import AutumnFall.Display.GameScene;
	import AutumnFall.Display.GameObject;
	import flash.display.MovieClip;
	import Scripts.*;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Level1 extends GameScene
	{
		
		public function Level1(id:String = "") 
		{
			super(id);
			
			juan.addTag("mov");
			juan.addTag("special");
			jose.addTag("mov");

			var objs = getGameObjectsWithTag("mov");
			
			for each(var p:GameObject in objs)
			{
				p.addComponent(new CAjua());
			}
			
		}
		
	}
	
}