## Qcenzo *flake2d* RPG Game  Library ##
2017/4/7 10:16:58  

### Runtime Version ###
Flash Player 16.0, AIR 16.0


### Class Diagram ###
![](http://www.qcenzo.com/2017/flake2d/images/flake2d_classdiag.jpg) 

### Example ###

>  Main.as

	package
	{
		import com.qcenzo.flake2d.Game;
		
		import flash.display.Sprite;
		import flash.display.StageAlign;
		import flash.display.StageScaleMode;
		import flash.utils.setInterval;
		import com.qcenzo.flake2d.test.client.proxy.MyHeroProxy;
		
		[SWF(width="1280", height="720", frameRate="60")] 
		public class Main extends Sprite
		{
			private var game:Game;
	
			public function Main()
			{
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
				
				game = new Game();
				game.heroProxy = new MyHeroProxy();
				game.clock.setInterval(heartBeat, 3);
				addChild(game);
			}
			
			private function heartBeat():void
			{
				trace("beat", game.clock.fps);
			}
		}
	}


> MyHeroProxy.as

	package com.qcenzo.flake2d.test.client.proxy
	{
		import com.qcenzo.flake2d.core.HeroProxy;
		import com.qcenzo.flake2d.test.client.vo.MyUserData;
		
		import flash.geom.Point;
		
		public class MyHeroProxy extends HeroProxy
		{
			public function MyHeroProxy()
			{
				super();
			}
			
			override protected function init():void
			{
				_hero.data = new MyUserData("com.qcenzo.flake2d.demo.server.vo");
				_loader.load("assets/levels/0/0.qla");
			}
			
			override public function moveTo(position:Point):void
			{
				trace(position);
				_hero.moveTo(position);
			}
		}
	}

> MyUserData.as

	package com.qcenzo.flake2d.test.client.vo
	{
		import com.qcenzo.flake2d.net.Serializable;
		
		import flash.geom.Point;
		
		public class MyUserData extends Serializable
		{
			public var id:int;
			public var name:String;
			public var pos:Point;
			public var mapID:int;
			
			public function MyUserData(aliasName:String)
			{
				super(aliasName);
			}
		}
	}
	  
> MyLevelLoadingBar.as

	package com.qcenzo.flake2d.test.client.ui
	{
		import com.qcenzo.flake2d.ui.ILoadingBar;
		
		import flash.display.Sprite;
		import flash.text.TextField;
		
		public class MyLevelLoadingBar extends TextField implements ILoadingBar
		{
			private var _root:Sprite;
	
			public function MyLevelLoadingBar(root:Sprite)
			{
				_root = root;
			}
			
			public function show():void
			{
				_root.addChild(this);
			}
			
			public function echo(assetName:String, percent:Number):void
			{
				text = (percent == -1) ? assetName + "丢失"
					: assetName + int(percent * 100) + "%";
			}
			
			public function hide():void
			{
				_root.removeChild(this);
			}
		}
	}	
### Test ###
- <http://qcenzo.com/2017/flake2d/test.html>