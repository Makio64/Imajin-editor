package ui 
{
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * MenuItem - ImajinEditor
	 * @version 1.0
	 * @author David Ronai
	 */
	public class MenuItem extends Sprite 
	{
		private var callback:Function;
		
		//================== VARIABLES ========================
		
		
		
		//================== CONSTRUCTOR ======================
		
		public function MenuItem(text:String, callback:Function) 
		{
			this.callback = callback;
			var background:Shape = new Shape();
			background.graphics.beginFill(0, .75);
			background.graphics.lineStyle(2, 0x444444);
			background.graphics.drawCircle(0, 0, 20);
			background.graphics.endFill();
			addChild(background);
			
			var title:TextField = new TextField(20, 20, text, "Verdana", 10, 0xCCCCCC, false);
			title.hAlign = HAlign.CENTER;
			title.vAlign = VAlign.CENTER;
			addChild(title);
		}
		
	}

}