package Scripts
{
	import AutumnFall.GameData.GameDataManager;
	import AutumnFall.Components.ScriptComponent;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author ...
	 */
	public class CGameDataTest extends ScriptComponent
	{
		
		public override function onClick(event:MouseEvent = null):void 
		{
			GameDataManager.setData(Owner.Id + "Clicked", "true"); 
			//GameDataManager.deleteData(Owner.Id + "Clicked");
		}
		
		public override function onMouseWheel(event:MouseEvent = null):void
		{
			GameDataManager.getData(chale, Owner.Id + "Clicked");
		}
		
		public function chale(value:String)
		{
			if (!value)
			{
				trace("No data set for " + Owner.Id);
				return;
			}
			trace("GameData for " + Owner.Id + ":   " + value);
		}
	}
	
}