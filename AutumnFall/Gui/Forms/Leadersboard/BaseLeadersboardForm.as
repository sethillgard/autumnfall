package AutumnFall.Gui.Forms.Leadersboard 
{
	import AutumnFall.GameData.ScoreData;
	import AutumnFall.Gui.Forms.Form;
	import fl.controls.DataGrid;
	
	/**
	 * ...
	 * @author ...
	 */
	public class BaseLeadersboardForm extends Form
	{
		//Stage
		public var grid:DataGrid;
		
		/**
		 * Constructor.
		 */
		public function BaseLeadersboardForm() 
		{
			grid.addColumn("Index");
			grid.addColumn("Player");
			grid.addColumn("Score");
		}
		
		/**
		 * Fill the grid with the scores provided.
		 * This function can be set as the callback for ScoreManager.getTopScores()
		 * @param	scores An array of ScoreData objects.
		 */
		public function fillGrid(scores:Array):void
		{
			//Fill the grid
			for ( var i:int = 0; i < scores.length ; i++)
			{
				var score:ScoreData = scores[i] as ScoreData;
				grid.addItem( { Index: i + 1, Player: score.alias, Score: score.score } );
			}
		}
	}
	
}