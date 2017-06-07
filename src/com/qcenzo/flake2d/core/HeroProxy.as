package com.qcenzo.flake2d.core
{
	import com.qcenzo.flake2d.loaders.ILoader;
	import com.qcenzo.flake2d.net.Serializable;
	import com.qcenzo.flake2d.system.flake2d;
	
	import flash.display3D.Context3D;
	import flash.geom.Point;

	public class HeroProxy extends SerializableGameObject
	{
		protected var _hero:SerializableGameObject;
		protected var _loader:ILoader;

		public function HeroProxy()
		{
		}
		
		internal function set loader(loader:ILoader):void
		{
			_loader = loader;
		}
		
		internal function set hero(h:SerializableGameObject):void
		{
			_hero = h;
			init();
		}
		
		override internal function set context(c:Context3D):void
		{
			_hero.context = c;
		}
		
		override internal function render():void
		{
			_hero.render();
		}
		
		protected function init():void
		{
		}
		
		override public function get data():Serializable
		{
			return _hero.data; 
		}
		
		override public function set data(value:Serializable):void
		{
			_hero.data = value;
		}
		
		override public function moveTo(position:Point):void
		{
			_hero.moveTo(position);
		}
	}
}