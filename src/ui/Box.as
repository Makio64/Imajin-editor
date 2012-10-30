package ui 
{
	import flash.geom.Point;
	import starling.display.DisplayObjectContainer;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * Box - ImajinEditor
	 * @version 1.0
	 * @author David Ronai
	 */
	public class Box extends Sprite 
	{
		private var _selected:Boolean;
		private var _background:Shape;
		private var _dragClic:Point;
		private var _startPosition:Point;
		private var _action:String;
		
		public function Box(container:DisplayObjectContainer, x:int, y:int) 
		{
			this.x = x;
			this.y = y;
			this._action = none;
			this._background = new Shape();
			addChild(_background);
			
			drawBackground();
			
			var title:TextField = new TextField(80, 30, "text", "Verdana", 12, 0xCCCCCC, false);
			title.hAlign = HAlign.CENTER;
			title.vAlign = VAlign.CENTER;
			addChild(title);
			
			addEventListener(TouchEvent.TOUCH, onTouch);
			
			container.addChild(this);
		}
		
		public function linkTo(box2:Box):void 
		{
			new Link(this, box2);
		}
		
		private function drawBackground():void 
		{
			_background.graphics.clear();
			if( !selected ){
				_background.graphics.beginFill(0x333333, 1);
				_background.graphics.lineStyle(1, 0, 1);
			} else {
				_background.graphics.beginFill(0x333333, 1);
				_background.graphics.lineStyle(3, 0x0000FF, 1);
			}
			_background.graphics.drawRect(0, 0, 80, 30);
			_background.graphics.endFill();
			_background.graphics.beginFill(0x555555, 1);
			_background.graphics.drawRect( 0, 0, 10, 10);
			_background.graphics.endFill();
		}
		
		private function onTouch(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(this);
			if (touch)
			{
				var position:Point = touch.getLocation(this);
				switch(touch.phase) {
					case TouchPhase.BEGAN:
						selected = true;
						if ( position.x < 10) {
							_action = "link";
							_tmpLink = new Link(this);
						} else {
							_action = "drag";
						}
						_dragClic = position.clone();
						//_startPosition = localToGlobal(position);
						break;
					case TouchPhase.MOVED:
						x = localToGlobal(position).x - _dragClic.x;
						y = localToGlobal(position).y - _dragClic.y;
						dispatchEventWith("moved");
						break;
					case TouchPhase.ENDED:
							selected = false;
						break;
					default:
						break;
				}
			}
		}
		
		public function get selected():Boolean 
		{
			return _selected;
		}
		
		public function set selected(value:Boolean):void 
		{
			_selected = value;
			drawBackground();
		}
	}
}