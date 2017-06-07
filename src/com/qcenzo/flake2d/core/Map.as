package com.qcenzo.flake2d.core
{
	import com.qcenzo.flake2d.core.data.MapData;
	import com.qcenzo.flake2d.loaders.ILoader;
	import com.qcenzo.flake2d.loaders.MapTileLoader;
	
	import flash.display3D.Context3D;

	internal class Map extends GameObject
	{
		private var _mapTileLoader:ILoader;
		private var _mapData:MapData;
		private var _col:int;
		private var _row:int;
		private var _sizeDirty:Boolean;

		public function Map()
		{
		}
		
		public function setup(mapData:MapData):void
		{
			_mapData = mapData;
		}
		
		public function get empty():Boolean
		{
			return _mapData == null;
		}
		
		public function resize(stageWidth:int, stageHeight:int):void
		{
			var c:int = Math.ceil(stageWidth / _mapData.tileWidth);
			var r:int = Math.ceil(stageHeight / _mapData.tileHeight);
			if (c == _col && r == _row)
				return;
			
			_col = c;
			_row = r;
			
			_sizeDirty = true;
		}
		
		override internal function set context(c:Context3D):void
		{
			_mapTileLoader = new MapTileLoader(c);
			_mapTileLoader.onLoad = setupTile;
		}
		
		override internal function render():void
		{
			if (_sizeDirty)
			{
				_sizeDirty = false;
				
			}
		}
		
		private function setupTile(tile:*):void
		{
		}
	}
}