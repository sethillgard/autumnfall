package AutumnFall.Input
{
    
    import flash.display.Stage;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
	import AutumnFall.Application;
    
    /**
     * Represents the state of the keyboard.
     */
    public class KeyboardManager 
	{
		
        private static var initialized:Boolean = false;  // Marks whether or not the class has been initialized
        private static var keysDown:Object = new Object();  // Stores key codes of all keys pressed
        
		/**
		 * Static initializer
		 */
		{
			Application.Stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPressed);
            Application.Stage.addEventListener(KeyboardEvent.KEY_UP, onKeyReleased);
            Application.Stage.addEventListener(Event.DEACTIVATE, onFocusLost);
		}
        
        /**
         * Returns true or false if the key represented by the
         * keyCode passed is being pressed
		 * @param keyCode The Keycode corresponding to the key that should be tested.
		 * @return A Boolean determining if the specified key is down.
         */
        public static function isKeyDown(keyCode:uint):Boolean 
		{
            return Boolean(keyCode in keysDown);
        }
        
        /**
         * Event handler for capturing keys being pressed.
         */
        private static function onKeyPressed(event:KeyboardEvent):void 
		{
            // create a property in keysDown with the name of the keyCode
            keysDown[event.keyCode] = true;
        }
        
        /**
         * Event handler for capturing keys being released.
         */
        private static function onKeyReleased(event:KeyboardEvent):void 
		{
            if (event.keyCode in keysDown) 
			{
                //Delete the property in keysDown if it exists
                delete keysDown[event.keyCode];
            }
        }
        
        /**
         * Event handler for Flash Player deactivation.
         */
        private static function onFocusLost(event:Event):void 
		{
            //Clear all keys in keysDown since the player cannot detect keys being pressed or released when not focused
            keysDown = new Object();
        }
    }
}