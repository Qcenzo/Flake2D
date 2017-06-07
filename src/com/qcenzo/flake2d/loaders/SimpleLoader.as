package com.qcenzo.flake2d.loaders
{
	import com.qcenzo.flake2d.ui.ILoadingBar;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class SimpleLoader implements ILoader
	{
		private static const IMG_SUFFIX:RegExp = /.\.(jpg|jpeg|jpe|jfif|png|bmp)$/i;
		
		private var _bar:ILoadingBar;
		private var _request:URLRequest;
		private var _loader:Loader;
		private var _urlLoader:URLLoader;
		private var _onLoad:Function;

		public function SimpleLoader() 
		{
			_request = new URLRequest();
			
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			
			_urlLoader = new URLLoader();
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_urlLoader.addEventListener(ProgressEvent.PROGRESS, onProgress);
			_urlLoader.addEventListener(Event.COMPLETE, onComplete);
		}
		
		public function load(url:String):void
		{
			if (_bar != null)
				_bar.show();
			
			_request.url = url;
			IMG_SUFFIX.test(url) ? _loader.load(_request) : _urlLoader.load(_request);
		}
		
		public function set onLoad(listener:Function):void
		{
			_onLoad = listener; 
		}
		
		public function set loadingBar(bar:ILoadingBar):void
		{
			_bar = bar;
		}
		
		private function onComplete(event:Event):void
		{
			_onLoad(event.target == _urlLoader ? _urlLoader.data : _loader.content);
			
			if (_bar != null)
				_bar.hide();
		}
		
		private function onProgress(event:ProgressEvent):void
		{
			echo(_request.url, event.bytesLoaded / event.bytesTotal);
		}
		
		private function onIOError(event:IOErrorEvent):void
		{
			echo(_request.url, -1);
			_onLoad(null);
		}
		
		private function echo(assetName:String, percent:Number):void
		{
			if (_bar != null)
				_bar.echo(assetName, percent);
			else
				trace(assetName, percent);
		}
	}
}