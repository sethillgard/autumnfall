package AutumnFall.Sound 
{
	
	/**
	 * This static class provides a useful way to store and retrive sounds.
	 */
	public class SoundPool 
	{
		/**
		 * The collection used to store elements.
		 */
		private var elements:Object = new Object();
		
		/**
		 * Saves a sound handler.
		 * @param	sound The sound handler.
		 * @param	id Its id.
		 */
		public function store(sound:SoundHandler, id:String):void
		{
			elements[id] = sound;
		}
		
		/**
		 * Retrives the sound handler with the given id.
		 * @param	id The id of the sound.
		 * @return	The stored sound.
		 */
		public function retrive(id:String):SoundHandler
		{
			return elements[id];
		}
		
		/**
		 * Deletes an element from this pool.
		 * @param	id The id to be deleted.
		 */
		public function release(id:String):void
		{
			elements[id] = null;
			delete elements[id];
		}
		
	}
	
}