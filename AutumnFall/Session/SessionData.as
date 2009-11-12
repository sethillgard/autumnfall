package AutumnFall.Session
{
	import AutumnFall.Users.User;
	
	/**
	 *	Session data container struct
	 */
	public class SessionData
	{
		/**
		 * <code>true</code> if the current session is in login mode, <code>false</code> otherwise.
		 */
		public var isGuest:Boolean;
		
		/**
		 * <code>true</code> if the current session is in guest mode and the last login attempt failed, <code>false</code> otherwise.
		 */
		public var isLoginError:Boolean;
		
		/**
		 * Session startup timestamp.
		 */
		public var startTime:int;
		
		/**
		 * Current domain in which the Application object is located (GameLoader).
		 */
		public var domain:String;
		
		/**
		 * The exact username that was used to start a session even if the login failed.
		 */
		public var username:String;
		
		/**
		 * This field is suppossed to be filled by the Session class on successful login.
		 * Use SessionData::user.UserData to get the UserData structure of the user.
		 */
		public var user:User = null;
	}
}