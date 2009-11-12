package AutumnFall.Gui.Forms 
{
	import AutumnFall.Application;
	import AutumnFall.Gui.Balloons.Error.BaseErrorBalloon;
	import AutumnFall.Gui.Forms.ErrorIndicators.BaseErrorIndicator;
	import AutumnFall.Gui.Forms.ErrorIndicators.ErrorIndicator;
	import AutumnFall.Gui.GuiManager;
	import AutumnFall.Gui.Windows.MessageBox.MessageBoxContent;
	import AutumnFall.Gui.Windows.WindowManager;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import AutumnFall.Gui.Balloons.Balloon;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	/**
	 * Abstract class. Represents a user form.
	 */
	public class Form extends MovieClip
	{
		/**
		 * Collection of error messages in this form. 
		 */
		protected var errors:Dictionary = new Dictionary();
		
		/**
		 * Collection of all ErrorIndicators in this form.
		 */
		protected var errorIndicators:Array = new Array();
		
		/**
		 * Default implementation for validate.
		 * Should be overriden.
		 * This function implementation should use return super.validate();
		 * @return true if all data validated correctly, false otherwise.
		 */
		public function validate():Boolean
		{
			//Do we have errors?
			for each (var value:Object in errors) 
			{
				if (value)
				{
					//We have errors, show them!
					displayErrorMessageBox();
					return false;
				}
			}
			
			//We have no errors
			return true;
		}
		
		/**
		 * Should be overriden.
		 * Sets every field in the form to its original state.
		 */
		public function clearData():void
		{
			return;
		}
		
		/**
		 * Clear al error messages.
		 */
		public function clearErrors():void
		{
			//Iterate through each indicator and remove it.
			for (var i = 0; i < errorIndicators.length; i++ ) 
			{
				if (contains(errorIndicators[i]))
				{
					removeChild(errorIndicators[i]);
				}
			}
			
			//Clear data!
			errorIndicators = new Array();
			errors = new Dictionary();
		}
		
		/**
		 * Clears the whole form to its original state.
		 */
		public function clear():void
		{
			clearErrors();
			clearData();
		}
		
		/**
		 * Registers a new error in the form.
		 * @param	control The control that generated the error.
		 * @param	errorMessage The error message you wish to display to the user.
		 */
		public function addErrorMessage(control:DisplayObject, errorMessage:String)
		{	
			//Register and add the new error.
			errors[control] = errorMessage;
			
			//Add the graphic indicator.
			var indicator:ErrorIndicator = new BaseErrorIndicator();
			indicator.x = control.x + control.width + indicator.width / 2;
			indicator.y = control.y;
			errorIndicators.push(indicator);
			addChild(indicator);
		}
		
		/**
		 * Displays a MessageBox with the errors in the form.
		 */
		private function displayErrorMessageBox()
		{
			var text:String = "";
			for each (var value:String in errors) 
			{
				if (value)
				{
					text += "* " + value + "\n";
				}
			}
			
			//Create it!
			GuiManager.createMessageBox(text, { title:"Errors in the Form", modal:true } ).open();
		}	
	}
	
}