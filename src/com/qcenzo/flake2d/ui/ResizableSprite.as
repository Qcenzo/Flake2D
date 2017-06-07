package com.qcenzo.flake2d.ui
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class ResizableSprite extends Sprite
	{
		protected var _resizable:Vector.<IResizable>;
		
		public function ResizableSprite()
		{
			_resizable = new Vector.<IResizable>();
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			return push(super.addChild(child));
		}
		
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			return push(super.addChildAt(child, index));
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			return splice(super.removeChild(child));
		}
		
		override public function removeChildAt(index:int):DisplayObject
		{
			return splice(super.removeChildAt(index));
		}
		
		[Deprecated]
		override public function removeChildren(beginIndex:int=0, endIndex:int=int.MAX_VALUE):void
		{
		}
		
		[Deprecated]
		override public function set x(value:Number):void
		{
		}
		
		[Deprecated]
		override public function set y(value:Number):void
		{
		}
		
		protected function init():void
		{
		}
		
		private function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			stage.addEventListener(Event.RESIZE, onResize); 
			onResize(null);
			
			init();
		}
		
		private function push(displayObject:DisplayObject):DisplayObject
		{
			if (displayObject is IResizable)
			{
				var r:IResizable = displayObject as IResizable;

				if (stage != null)
					r.resize(stage.stageWidth, stage.stageHeight);
				
				_resizable.push(r);
			}
			return displayObject;
		}
		
		private function splice(displayObject:DisplayObject):DisplayObject
		{
			if (displayObject is IResizable)
			{
				var i:int = _resizable.indexOf(displayObject);
				if (i != -1)
					_resizable.splice(i, 1);
			}
			return displayObject;
		}
		
		private function onResize(event:Event):void
		{
			for each (var r:IResizable in _resizable)
				r.resize(stage.stageWidth, stage.stageHeight);
		}
	}
}