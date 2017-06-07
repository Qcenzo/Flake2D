package com.qcenzo.flake2d.ui
{
	public interface ILoadingBar
	{
		function show():void;
		/**
		 * 
		 * @param assetName
		 * @param percent 加载进度，-1 表示资源丢失
		 * 
		 */
		function echo(assetName:String, percent:Number):void;
		function hide():void;
	}
}