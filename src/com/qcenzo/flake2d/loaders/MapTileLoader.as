package com.qcenzo.flake2d.loaders
{
	import com.qcenzo.flake2d.ui.ILoadingBar;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.textures.Texture;
	import flash.geom.Matrix;
	import flash.utils.Dictionary;

	public class MapTileLoader implements ILoader
	{
		private static const CACHE:Dictionary = new Dictionary();
		
		private var _context:Context3D;
		private var _canvas:BitmapData;
		private var _simpleLoader:ILoader;
		private var _wait:Array;
		private var _onLoad:Function;
		private var _loading:Boolean;
		private var _url:String;
		
		public function MapTileLoader(context:Context3D, textureSize:int = 512)
		{
			_context = context;
			_canvas = new BitmapData(textureSize, textureSize, true, 0);
			_wait = [];
			_simpleLoader = new SimpleLoader();
			_simpleLoader.onLoad = onComplete;
		}
		
		public function load(url:String):void
		{
			if (url == null)
				return;
			
			if (CACHE.hasOwnProperty(url))
			{
				_onLoad(CACHE[url]);
				return;
			}
			
			if (_loading)
			{
				_wait.push(url);
				return;
			}
			
			_loading ||= true;
			_simpleLoader.load(_url = url);
		}
		
		public function set onLoad(listener:Function):void
		{
			_onLoad = listener;
		}
		
		public function set loadingBar(bar:ILoadingBar):void
		{
		}
		
		private function onComplete(data:*):void
		{
			_onLoad(CACHE[_url] = getTexture(data));
			
			if (_wait.length > 0)
				load(_wait.shift());
			else
				_loading = false;
		}
		
		private function getTexture(data:Bitmap):Texture
		{
			var s:int = _canvas.width;
			
			_canvas.fillRect(_canvas.rect, 0);
			_canvas.draw(data, new Matrix(s / data.width, 0, 0, s / data.height), null, null, null, true);
			
			var t:Texture = _context.createTexture(s, s, Context3DTextureFormat.BGRA, false);
			t.uploadFromBitmapData(_canvas);
			
			return t;
		}
	}
}