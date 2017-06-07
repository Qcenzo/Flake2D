package com.qcenzo.flake2d.core
{
	import com.qcenzo.flake2d.net.Serializable;

	public class SerializableGameObject extends GameObject
	{
		private var _data:Serializable;
		
		public function SerializableGameObject()
		{
			super();
		}
		
		public function get data():Serializable
		{
			return _data; 
		}
		
		public function set data(value:Serializable):void
		{
			_data = value;
		}
	}
}