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
		static private var _boxs:Vector.<Box> = new Vector.<Box>();
		
		private var _selected:Boolean;
		private var _background:Shape;
		private var _dragClic:Point;
		private var _startPosition:Point;
		private var _action:String;
		private var _tmpLink:Link;
		private var _links:Vector.<Link>;
		private var _dragged:Boolean;
		
		public function Box(container:DisplayObjectContainer, x:int, y:int) 
		{
			this.x = x;
			this.y = y;
			this._action = "none";
			this._links = new Vector.<Link>();
			this._background = new Shape();
			addChild(_background);
			
			drawBackground();
			
			var title:TextField = new TextField(60, 30, "text", "Verdana", 11, 0xCCCCCC, false);
			title.x = 20;
			title.hAlign = HAlign.CENTER;
			title.vAlign = VAlign.CENTER;
			addChild(title);
			
			addEventListener(TouchEvent.TOUCH, onTouch);
			
			_boxs.push( this );
			container.addChild(this);
		}
		
		private function drawBackground():void 
		{
			_background.graphics.clear();
			if( !_selected ){
				_background.graphics.beginFill(0x333333, 1);
				_background.graphics.lineStyle(1, 0, 1);
			} else if(_dragged) {
				_background.graphics.beginFill(0x333333, 1);
				_background.graphics.lineStyle(3, 0x0000FF, 1);
			} else {
				_background.graphics.beginFill(0x333333, 1);
				_background.graphics.lineStyle(2, 0x0000FF, 1);
			}
			_background.graphics.drawRect(0, 0, 80, 30);
			_background.graphics.endFill();
			_background.graphics.beginFill(0x555555, 1);
			_background.graphics.drawRect( 0, 0, 20, 30);
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
						unselectAllBox();
						selected = true;
						if ( position.x < 20) {
							_action = "link";
							_tmpLink = new Link(this);
						} else {
							dragged = true;
							_action = "drag";
						}
						_dragClic = position.clone();
						break;
					case TouchPhase.MOVED:
						if( _action == "drag"){
							x = localToGlobal(position).x - _dragClic.x;
							y = localToGlobal(position).y - _dragClic.y;
							dispatchEventWith("drag");
						}else {
							_tmpLink.updatePosition(position.x, position.y);
						}
						break;
					case TouchPhase.ENDED:
							//selected = false;
							if (_action == "link") {
								if(!_tmpLink.tryToConnect()){
									_tmpLink.dispose();
								}else {
									_links.push(_tmpLink);
								}	
								_tmpLink = null;
							} else {
								dragged = false;
							}
						break;
					default:
						break;
				}
			}
		}
		
		private function unselectAllBox():void 
		{
			for each (var box:Box in _boxs) {
				box.selected = false;
			}
		}
		
		static public function getBoxAtPoint(x:Number, y:Number):Box 
		{
			for each (var box:Box in _boxs) {
				if (box.x <= x && box.y <= y && box.x + box.width >= x && box.y + box.height >= y ) {
					return box;
				}
			}
			return null;
		}
		
		override public function get height():Number 
		{
			return _background.height;
		}
		
		override public function set height(value:Number):void 
		{
			super.height = value;
		}
		
		override public function get width():Number 
		{
			return _background.width;
		}
		
		override public function set width(value:Number):void 
		{
			super.width = value;
		}
		
		public function set selected(value:Boolean):void 
		{
			if( value != _selected){
				_selected = value;
				drawBackground();
			}
		}
		
		public function set dragged(value:Boolean):void 
		{
			_dragged = value;
			drawBackground();
		}
		
		override public function dispose():void 
		{
			_boxs.splice(_boxs.indexOf(this), 1);
			super.dispose();
		}
		
		public function connectedTo(box:Box):Boolean 
		{
			for each(var link:Link in _links) {
				if (link.connectedTo(box)) {
					return true;
				}
			}
			return false;
		}
		
		public function addLink(link:Link):void 
		{
			_links.push(link);
		}
	}
}