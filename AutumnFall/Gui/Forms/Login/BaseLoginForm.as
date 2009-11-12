package AutumnFall.Gui.Forms.Login
{
	import AutumnFall.Gui.Balloons.Error.BaseErrorBalloon;
	import AutumnFall.Gui.Windows.MessageBox.BaseMessageBoxContent;
	import AutumnFall.Users.*;
	import AutumnFall.Session.*;
	import AutumnFall.Gui.Forms.*;
	import fl.controls.Button;
	import fl.controls.TextInput;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * Represents the graphics of the base login form
	 */
	public class BaseLoginForm extends Form
	{
		//Stage
		public var username:TextInput;
		public var password:TextInput;
		public var submitButton:Button;
		
		/**
		 * Constructor.
		 */
		public function BaseLoginForm()
		{			
			submitButton.addEventListener(MouseEvent.CLICK, onSubmit);
		}
		
		/**
		 * Event handler for the submit button.
		 * @param	event The event.
		 */
		public function onSubmit(event:Event):void
		{
			if (validate())
			{
				Session.startSession(onServerAnswer, username.text, password.text);
			}
		}
		
		/**
		 * Handle user login.
		 * @param	data The session data passed in by the Session module.
		 */
		public function onServerAnswer(data:SessionData):void
		{
			if (!data.isLoginError)
			{
				trace(data.user.Data.email);
			}
		}
		
		/**
		 * Validate the data
		 * @return true if all data is correct, false otherwise.
		 */
		public override function validate():Boolean
		{
			clearErrors();
			
			if (username.text.substr(0,1) == "a")
			{
				addErrorMessage( username, "The username cannot start with an a.");
			}
			if (password.text.substr(0,1) == "b")
			{
				addErrorMessage( password, "The password cannot start with a b.");
				
			}
			return super.validate();
		}
		
	}
	
}