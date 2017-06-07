package com.qcenzo.flake2d.loaders
{
	import com.qcenzo.flake2d.core.data.LevelData;
	import com.qcenzo.flake2d.core.data.MapData;
	import com.qcenzo.flake2d.ui.ILoadingBar;
	
	import flash.display.Bitmap;
	
	public class LevelLoader implements ILoader
	{
		private const QLA_SUFFIX:RegExp = /.\.qla$/i;
		private const QLA:int = 0;  
		private const THNM:int = 1;
		private const WAYP:int = 2;
		
		private var _simpleLoader:ILoader;
		private var _target:int;
		private var _raw:Object;
		private var _thum:Bitmap;
		private var _onLoad:Function;

		public function LevelLoader()
		{
			_simpleLoader = new SimpleLoader();
			_simpleLoader.onLoad = onComplete;
		}
		
		public function load(level:String):void
		{
			if (level == null || !QLA_SUFFIX.test(level))
				return;
			_target = QLA;
			_simpleLoader.load(level);
		}
		
		public function set onLoad(listener:Function):void
		{
			_onLoad = listener;
		}
		
		public function set loadingBar(bar:ILoadingBar):void
		{
			_simpleLoader.loadingBar = bar;
		}
		
		private function onComplete(data:*):void
		{
			switch (_target)
			{
				case QLA:
					_target = THNM;
					_raw = JSON.parse(data);
					_simpleLoader.load(_raw.root + 
						_raw.map.root + _raw.map.thumbnail);
					break;
				case THNM: 
					_target = WAYP;
					_thum = data;
					_simpleLoader.load(_raw.root + 
						_raw.map.root + _raw.map.waypoint);
					break;
				case WAYP:
					_onLoad(getData(data));
					break;
			}
		}
		
		private function getData(waypoint:Bitmap):LevelData
		{
			var mapDat:MapData = new MapData();
			mapDat.name = _raw.map.name;
			mapDat.width = _raw.map.width;
			mapDat.height = _raw.map.height;
			mapDat.row = _raw.map.row;
			mapDat.col = _raw.map.col;
			mapDat.thumbnail = _thum.bitmapData;
			mapDat.thumbnailScaleFactor = _thum.width / mapDat.width;
			mapDat.waypoint = waypoint.bitmapData;
			mapDat.waypointScaleFactor = waypoint.width / mapDat.width; 
			mapDat.tiles = _raw.root + 
				_raw.map.root + _raw.map.tiles;
			mapDat.tileWidth = mapDat.width / mapDat.col;
			mapDat.tileHeight = mapDat.height / mapDat.row;
			
			var levelDat:LevelData = new LevelData();
			levelDat.bgm = _raw.root + _raw.bgm;
			levelDat.mapData = mapDat;
			levelDat.npcs = _raw.npcs;
			levelDat.gates = _raw.gates;
			levelDat.effects = _raw.effects;
			
			return levelDat; 
		}		
	}
}