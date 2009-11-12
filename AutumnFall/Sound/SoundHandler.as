package AutumnFall.Sound 
{
	import AutumnFall.Application;
	import AutumnFall.Tween.TweenManager;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.ID3Info;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	/**
	 * ...
	 * @author ...
	 */
	public class SoundHandler extends EventDispatcher
	{
		/**
		 * The sound that this handlers wraps.
		 */
		private var sound:Sound = null;
		
		/**
		 * The sound transform that defines the behaviour of the sound.
		 */
		private var transform:SoundTransform = null;
		
		/**
		 * The sound channel used to play the sound.
		 */
		private var channel:SoundChannel = null;
		
		/**
		 * The number of loops the sound is gonna be playing.
		 */
		private var loops:int = 1;
		
		/**
		 * Is this sound paused?
		 */
		private var paused:Boolean = false;
		public function get Paused():Boolean { return paused; }
		
		/**
		 * Is this sound stopped?
		 */
		private var stopped:Boolean = true;
		public function get Stopped():Boolean { return stopped; }
		
		/**
		 * Constructor. Creates a new SoundHandler.
		 * @param	sound The sound object you want to play.
		 * @param	transform Optional. The SoundTransform object associated.
		 */
		public function SoundHandler(sound:Sound, transform:SoundTransform = null) 
		{	
			this.sound = sound;
			
			if (!transform)
			{
				transform = new SoundTransform();
			}
			
			this.transform = transform;
		}
		
		/**
		 * Activates the event handling system for this sound so it will alert you when it finished playing and the like.
		 * Adds an expensive event listener.
		 */
		public function activateEventHandling():void
		{		
			//Register an onEnterFrame event handler so that we can know if the sound finished playing.
			Application.Stage.addEventListener(Event.ENTER_FRAME, onUpdate);
		}
		
		/**
		 * Deactivates the event handling system for this sound so it wont alert you when it finished playing and the like.
		 */
		public function deactivateEventHandling():void
		{		
			//Register an onEnterFrame event handler so that we can know if the sound finished playing.
			Application.Stage.removeEventListener(Event.ENTER_FRAME, onUpdate);
		}
		
		/**
		 * If you make a change to the SoundTransform, please call this method to update the changes in the Sound.
		 * @param Optional. The new transform object for this sound.
		 */
		public function updateTransform(newTransform:SoundTransform = null):void
		{	
			//If we have a new transform, apply it.
			if (newTransform)
			{
				transform = newTransform;
			}
			
			//Update!
			if (channel)
			{
				channel.soundTransform = transform;
			}
		}
		
		/**
		 * Plays the sound.
		 * @param	loops The number of times you want the sound to be played.
		 * @param	position The position (in miliseconds) of the sound where you want to start playing it.
		 */
		public function play(loops:int = 1, position:Number = 0):void
		{
			//Save data
			this.loops = loops;
			this.paused = false;
			this.stopped = false;
			
			//Play the sound and save the channel.
			channel = sound.play(position, loops, transform);
			channel.soundTransform = transform;
		}
		
		/**
		 * Resumes the sound after being paused.
		 */
		public function resume():void
		{
			//Resume only if we are paused
			if (channel != null && paused == true)
			{
				play(loops, channel.position);
			}
			else	//We have no sound channel yet, start playing the sound!
			{
				play(loops, 0);
			}
		}
		
		/**
		 * Stops the sound from playing.
		 */
		public function stop():void
		{
			//Save data
			this.stopped = true;
			
			//Stop
			if (channel != null)
			{
				channel.stop();
			}
		}
		
		/**
		 * Pauses the sound. You can resume it later calling resume().
		 */
		public function pause():void
		{
			//Save data
			this.paused = true;
			
			//Pause
			if (channel != null)
			{
				channel.stop();
			}
		}
		
		/**
		 * Sets the volume of the sound affecting its sound transform.
		 * @param	volume The volume. Must be between 0 and 1.
		 */
		public function setVolume(volume:Number):void
		{
			transform.volume = volume;
			updateTransform();
		}
		
		/**
		 * Gently fades to the given volume
		 * @param	volume The target volume
		 * @param	duration The duration of the fade
		 * @param	callback The function that will be called when the fade completes
		 */
		public function fadeVolume(volume:Number, duration:Number = 1, callback:Function = null):void
		{
			//When the fade is done, call the callback (if any)
			var temp:Function = function()
			{
				if (callback != null)
				{
					callback();
				}
			}
			
			//This is only works if the sound is already playing.
			if (channel)
			{	
				//Tween!
				TweenManager.createTweenTo( channel, duration, { volume: volume, onComplete: temp } );
			}
		}

		/**
		 * Starts playing the sound increasing its volume until it reaches the given volume.
		 * @param	duration The duration of the fade.
		 * @param	volume The final volume of the sound.
		 * @param	callback The function that will be called when the fade is complete.
		 * @param	loops The number of loops of the sound.
		 * @param	position The starting position of the sound.
		 */
		public function fadePlay(duration:Number = 1,  volume:Number = 1, callback:Function = null, loops:int = 1, position:Number = 0):void
		{
			setVolume(0);
			play(loops, position);
			fadeVolume(volume, duration, callback);
		}
		
		/**
		 * Resumes playing the sound increasing its volume until it reaches the given volume.
		 * @param	duration The duration of the fade.
		 * @param	volume The final volume of the sound.
		 * @param	callback The function that will be called when the fade is complete.
		 */
		public function fadeResume(duration:Number = 1, volume:Number = 1, callback:Function = null):void
		{
			setVolume(0);
			resume();
			fadeVolume(volume, duration, callback);
		}
		
		/**
		 * Fades out the sound and the stops it.
		 * @param	duration The duration of the fade.
		 * @param	callback The function that will be called when the fade is complete.
		 */
		public function fadeStop(duration:Number = 1, callback:Function = null):void
		{
			var temp:Function = function()
			{
				stop();
				if (callback != null)
				{
					callback();
				}
			}
			
			fadeVolume(0, duration, temp);
		}
		
		/**
		 * Fades out the sound and the pauses it.
		 * @param	duration The duration of the fade.
		 * @param	callback The function that will be called when the fade is complete.
		 */
		public function fadePause(duration:Number = 1, callback:Function = null):void
		{
			var temp:Function = function()
			{
				pause();
				if (callback != null)
				{
					callback();
				}
			}
			
			fadeVolume(0, duration, temp);
		}

		/**
		 * The current volume of the sound.
		 */
		public function get Volume():Number 
		{
			return transform.volume;
		}
		
		/**
		 * The current position of the sound.
		 */
		public function get Position():Number
		{
			if (channel)
			{
				return channel.position;
			}
			return 0;
		}
		
		/**
		 * The length of the sound.
		 */
		public function get Length():Number
		{
			return sound.length;
		}
		
		/**
		 * The SoundTransform object associated with this sound.
		 * If tou modify this, please call updateTransform().
		 */
		public function get Transform():SoundTransform
		{
			return transform;
		}
		
		/**
		 * The ID3 infor on the mp3 sound.
		 */
		public function get Id3():ID3Info
		{
			return sound.id3;
		}
		
		/**
		 * Event handler for ENTER_FRAME 
		 * @param	event The event
		 */
		private function onUpdate(event:Event):void
		{
			//TODO:Make Sound events work
			if (channel.position >= (sound.length - 1 / Application.Stage.frameRate))
			{
				dispatchEvent(new SoundEvent(SoundEvent.ON_SOUND_LOOP_COMPLETE, { sound:this } ));
			}
			
			if (channel.position >= (sound.length * loops))
			{
				dispatchEvent(new SoundEvent(SoundEvent.ON_SOUND_COMPLETE, { sound:this } ));
			}
		}
	}
	
}