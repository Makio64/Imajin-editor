package ui 
{
	import com.greensock.easing.Back;
	import com.greensock.TweenLite;
	import starling.display.Shape;
	import starling.display.Sprite;
	
	/**
	 * Menu - ImajinEditor
	 * @version 1.0
	 * @author David Ronai
	 */
	public class Menu extends Sprite 
	{
		private var _isOpen:Boolean;
		private var _items:Vector.<MenuItem>;
		
		public function Menu() 
		{
			_isOpen = false;
			_items = new Vector.<MenuItem>()
			
			var background:Shape = new Shape();
			background.graphics.beginFill(0, .75);
			background.graphics.lineStyle(2, 0x444444);
			background.graphics.drawCircle(0, 0, 25);
			background.graphics.endFill();
			addChild(background);
			
			addItem("new box", addBox);
			//addItem("undo", addBox);
			
			scaleX = scaleY = .7;
			alpha = 0;
		}
		
		private function addBox():void 
		{
			
		}
		
		public function addItem(text:String, callback:Function):void
		{
			var item = new MenuItem(text, callback);
			_items.push(item);
			addChild(item);
		}
		
		public function open():void
		{
			_isOpen = true;
			TweenLite.to(this, .6, { ease:Back.easeOut, scaleX:1, scaleY:1, alpha:1 } );
		}
		
		public function close():void
		{
			_isOpen = false;
			TweenLite.to(this, .4, { ease:Back.easeIn, scaleX:.7, scaleY:.7, alpha:0 } );
		}
		
		public function moveTo(x:int, y:int):void 
		{
			this.x = x;
			this.y = y;
		}
		
		public function get isOpen():Boolean 
		{
			return _isOpen;
		}
	}
}