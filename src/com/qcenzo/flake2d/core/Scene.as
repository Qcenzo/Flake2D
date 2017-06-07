package com.qcenzo.flake2d.core
{
	import com.qcenzo.flake2d.core.data.LevelData;
	import com.qcenzo.flake2d.loaders.ILoader;
	import com.qcenzo.flake2d.loaders.LevelLoader;
	import com.qcenzo.flake2d.system.Setting;
	import com.qcenzo.flake2d.system.flake2d;
	import com.qcenzo.flake2d.ui.ILoadingBar;
	import com.qcenzo.flake2d.ui.IResizable;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.Stage3D;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProfile;
	import flash.display3D.Context3DRenderMode;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;

	public class Scene implements IResizable
	{
		private var _context:Context3D;
		private var _heroProxy:HeroProxy;
		private var _hotArea:Sprite; 
		private var _setting:Setting;
		private var _map:Map;
		private var _levelLoader:ILoader;
		
		public function Scene()
		{
			_map = new Map();
			_setting = new Setting();
			
			_hotArea = new Sprite();
			_hotArea.graphics.beginFill(0xFF0000, 0);
			_hotArea.graphics.drawRect(0, 0, 1, 1);
			_hotArea.graphics.endFill();
			
			_levelLoader = new LevelLoader();
			_levelLoader.onLoad = setupLevel;
		}
		
		public function set levelLoadingBar(bar:ILoadingBar):void
		{
			_levelLoader.loadingBar = bar;
		}

		public function set heroProxy(value:HeroProxy):void
		{
			_heroProxy = value;
			_heroProxy.loader = _levelLoader;
			_heroProxy.hero = new Hero();
		}
		
		public function get setting():Setting
		{
			return _setting;
		}
		
		public function init(stage:Stage):void
		{
			stage.addChild(_hotArea);
			
			if (stage.stage3Ds.length > 0)
			{
				var s:Stage3D = stage.stage3Ds[0];
				s.addEventListener(ErrorEvent.ERROR, onError);
				s.addEventListener(Event.CONTEXT3D_CREATE, onCreate);
				s.requestContext3D(Context3DRenderMode.AUTO, Context3DProfile.STANDARD);
			}
		}
		
		public function render():void
		{
			if (running())
			{
				_map.render();
				_heroProxy.render();
			}
		}
		
		public function resize(stageWidth:int, stageHeight:int):void
		{
			_hotArea.width = stageWidth;
			_hotArea.height = stageHeight;
			
			if (running())
				setScissorRectangle(stageWidth, stageHeight);
			
			if (!_map.empty)
				_map.resize(stageWidth, stageHeight);
		}
		
		private function onCreate(event:Event):void
		{
			var c:Context3D = event.target.context3D;
			c.configureBackBuffer(Capabilities.screenResolutionX, 
				Capabilities.screenResolutionY, _setting.antiAlias);
			
			_map.context = c;
			_heroProxy.context = c;
			_context = c;
			
			setScissorRectangle(_hotArea.width, _hotArea.height);
			
			if (!_hotArea.hasEventListener(MouseEvent.CLICK))
				_hotArea.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function running():Boolean
		{
			return _context != null && _context.driverInfo != "Disposed";
		}
		
		private function setScissorRectangle(width:int, height:int):void
		{
			_context.setScissorRectangle(new Rectangle(0, 0, width, height));
		}
		
		private function setupLevel(data:LevelData):void
		{
			_map.setup(data.mapData);
			_map.resize(_hotArea.width, _hotArea.height);
			
			_setting.flake2d::bgm = data.bgm; 
		}
		
		private function onClick(event:MouseEvent):void
		{
			if (_heroProxy == null)
				return;
			_heroProxy.moveTo(null);
		}
		
		private function onError(event:ErrorEvent):void
		{
			throw new Error(event.text + "\r解决方案：" +
				"\r1.针对Air运行时，确保{你的应用}-app.xml中节点'renderMode'值为'direct'、节点'depthAndStencil'值为'true';" +
				"\r2.针对FlashPlayer运行时，尝试使用AX、NPAPI版本的播放器");
		}
	}
}