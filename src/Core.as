package  
{
	import starling.display.Sprite;
	import starling.text.TextField;
	import ui.Box;
	
	/**
	 * Core - ImajinEditor
	 * @version 1.0
	 * @author David Ronai
	 */
	public class Core extends Sprite 
	{
		static public var instance:Core;
		
		public function Core() 
		{
			instance = this;
			var box3:Box = new Box(this, 230, 100);
			var box1:Box = new Box(this, 30, 30);
			var box2:Box = new Box(this, 130, 130);
		}
		
		
	}

}