package com.qcenzo.flake2d.media
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;

	public class BGMPlayer
	{
		private const MP3_SUFFIX:RegExp = /.\.(mp3)$/i;

		private var _sound:Sound;
		private var _request:URLRequest;
		private var _channel:SoundChannel;
		private var _transform:SoundTransform;
		
		public function BGMPlayer()
		{
			_request = new URLRequest();
			_transform = new SoundTransform();
		}
		
		public function set url(value:String):void
		{
			if (value == null || !MP3_SUFFIX.test(value))
				return;
			
			if (_sound != null)
			{
				_sound.removeEventListener(Event.COMPLETE, onCompelete);
				_sound.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
				
				if (_channel != null)
				{
					_channel.stop();
					_transform.volume = 1; 
				}
			}
			
			_request.url = value; 
			
			_sound = new Sound(_request);
			_sound.addEventListener(Event.COMPLETE, onCompelete);
			_sound.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
		}
		
		public function get volume():Number
		{
			return _transform.volume;
		}
		
		public function set volume(value:Number):void
		{
			_transform.volume = value;
			if (_channel != null)
				_channel.soundTransform = _transform;
		}
		
		private function onCompelete(event:Event):void
		{
			_channel = _sound.play(0, int.MAX_VALUE, _transform);
		}
		
		private function onIOError(event:IOErrorEvent):void
		{
			trace(event.text);
		}
	}
}