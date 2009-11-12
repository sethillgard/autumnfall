package AutumnFall.Gui.Windows.MessageBox 
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * Represents the contents of a MessageBox
	 */
	public class MessageBoxContent extends MovieClip
	{
		//Stage
		public var message:TextField;
		
		/**
		 * Constructor
		 * @param	message The message of this messagebox.
		 */
		public function MessageBoxContent(message:String)
		{
			this.message.autoSize = TextFieldAutoSize.LEFT;
			this.message.wordWrap = true;
			this.message.text = message;
		}
		
	}
	
}