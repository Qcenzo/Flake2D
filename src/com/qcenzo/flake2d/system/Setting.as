package com.qcenzo.flake2d.system
{
	import com.qcenzo.flake2d.media.BGMPlayer;

	public class Setting
	{
		private var _antiAlias:int;
		private var _bgmPlayer:BGMPlayer;

		public function Setting()
		{
			_bgmPlayer = new BGMPlayer();
		}
		
		public function get antiAlias():int
		{
			return _antiAlias;
		}

		public function set antiAlias(value:int):void
		{
			if (value < 0 || _antiAlias == value)
				return;
			_antiAlias = value;
		}
		
		public function get volume():Number
		{
			return _bgmPlayer.volume;
		}
		
		public function set volume(value:Number):void
		{
			if (value == value)
				_bgmPlayer.volume = value;
		}
		
		flake2d function set bgm(url:String):void
		{
			_bgmPlayer.url = url;
		}
	}
}