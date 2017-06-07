package com.qcenzo.flake2d.loaders
{
	import com.qcenzo.flake2d.ui.ILoadingBar;

	public interface ILoader
	{
		function load(url:String):void;
		/**
		 *  
		 * @param listener 回传null表示加载失败
		 * 
		 */
		function set onLoad(listener:Function):void;
		function set loadingBar(bar:ILoadingBar):void;
	}
}