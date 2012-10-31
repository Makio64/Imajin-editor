package  
{
	import flash.geom.Point;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import ui.Box;
	import ui.Menu;
	
	/**
	 * Core - ImajinEditor
	 * @version 1.0
	 * @author David Ronai
	 */
	public class Core extends Sprite 
	{
		private var _menu:Menu;
		static public var instance:Core;
		
		public function Core() 
		{
			instance = this;
			addEventListener(Event.ADDED_TO_STAGE, onStage);
		}
		
		private function onStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onStage);
			
			var box3:Box = new Box(this, 230, 100);
			var box1:Box = new Box(this, 30, 30);
			var box2:Box = new Box(this, 130, 130);
			
			_menu = new Menu();
			addChild( _menu );
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(stage, TouchPhase.BEGAN);
			if (touch)
			{
				var position:Point = touch.getLocation(this);
				
				if ( _menu.isOpen ) {
					_menu.close();
					
				} else {
					_menu.moveTo(position.x, position.y);
					_menu.open();
				}
			}
		}		
	}
}