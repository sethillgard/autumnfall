package
{
	import AutumnFall.Display.*;
	import AutumnFall.Gui.Forms.Form;
	import AutumnFall.Gui.Forms.Leadersboard.BaseLeadersboardForm;
	import AutumnFall.Gui.Forms.Login.BaseLoginForm;
	import AutumnFall.Gui.GuiManager;;
	import flash.display.*;
	import AutumnFall.*;
	import AutumnFall.Session.Session;
	import Scenes.*;
	
	public class TestGame extends Game
	{	
		protected override function initialize()
		{
			GuiManager.createMessageBox("Hey! I'm a messagebox!!!!! Arghhhh!").open();
		
			GuiManager.createForm(new BaseLoginForm()).open();
			
			var level:GameScene = new Level1("level");
			getLayer(0).Scene = level;
			
			GuiManager.showTopScores(10, "", true, { modal:true, title: "Hey you!" });
		}
	}
}