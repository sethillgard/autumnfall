package AutumnFall.Sound 
{
	import AutumnFall.Utils.Url;
	import flash.media.SoundTransform;
	import flash.utils.getDefinitionByName;
	import flash.media.Sound;
	
	/**
	 * Provides static access to sound managment tasks.
	 */
	public class SoundManager 
	{
		/**
		 * The collection of sound definions (sound classes) used in the game.
		 * This is used to chache the used sounds and avoid getDefinitionByName.
		 */
		private static var soundDefinitions:Object = new Object;
		
		/**
		 * Creates a new SoundHandler for the given sound id.
		 * @param	id The id of the sound you want to get.
		 * @param transform Optional. The SoundTransform object associated with this sound.
		 * @return The handler object for the sound.
		 */
		public static function getSound(id:String, transform:SoundTransform = null):SoundHandler
		{
			//If we donthave the definition, try to find it.
			if (!soundDefinitions[id])
			{
				var c:Class = getDefinitionByName(id) as Class;
				if (c)
				{
					SoundManager.soundDefinitions[id] = c;
				}
				else //No sound found.
				{
					return null;
				}
			}
			
			//Create and return the new SoundHandler
			var sound:Sound = new SoundManager.soundDefinitions[id]() as Sound;
			return new SoundHandler(sound, transform);
		}
		
		/**
		 * Returns a new SoundHandler object given an URL containing a sound that will be streamed.
		 * @param	url The url of the sound.
		 * @param transform Optional. The SoundTransform object associated with this sound.
		 * @return The soundHandler.
		 */
		public static function getStreamedSound(url:Url, transform:SoundTransform = null):SoundHandler
		{
			var sound:Sound = new Sound(url.getUrlRequest());
			return new SoundHandler(sound, transform);
		}
	}
	
}