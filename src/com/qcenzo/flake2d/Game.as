package com.qcenzo.flake2d
{
	import com.qcenzo.flake2d.core.HeroProxy;
	import com.qcenzo.flake2d.core.Scene;
	import com.qcenzo.flake2d.system.Clock;
	import com.qcenzo.flake2d.system.Setting;
	import com.qcenzo.flake2d.system.flake2d;
	import com.qcenzo.flake2d.ui.ILoadingBar;
	import com.qcenzo.flake2d.ui.ResizableSprite;
	
	import flash.events.Event;
	
	public class Game extends ResizableSprite
	{
		private var _clock:Clock;
		private var _scene:Scene;

		public function Game()
		{
			_clock = new Clock();
			
			_scene = new Scene();
			_resizable.push(_scene);
		}

		public function set levelLoadingBar(bar:ILoadingBar):void
		{
			_scene.levelLoadingBar = bar;
		}
		
		public function set heroProxy(proxy:HeroProxy):void
		{
			_scene.heroProxy = proxy;
		}
		
		public function get setting():Setting
		{
			return _scene.setting;
		}
		
		public function get clock():Clock
		{
			return _clock;
		}
		
		override protected function init():void
		{
			_scene.init(stage);
			addEventListener(Event.ENTER_FRAME, onFrame);
		}
		
		private function onFrame(event:Event):void
		{
			if (_clock.flake2d::tick()){
				_scene.render();
			}
		}
	}
}
