package com.qcenzo.flake2d.core.data
{
	import flash.display.BitmapData;

	public class MapData
	{
		public var name:String;
		public var width:int;
		public var height:int;
		public var row:int;
		public var col:int;
		public var thumbnail:BitmapData;
		public var thumbnailScaleFactor:Number;
		public var waypoint:BitmapData;
		public var waypointScaleFactor:Number;
		public var tiles:String;
		public var tileWidth:Number;
		public var tileHeight:Number;
		
		public function MapData()
		{
		}
	}
}