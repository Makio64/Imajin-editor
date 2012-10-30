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
		public function Core() 
		{
			
			var textField:TextField = new TextField(400, 300, "Welcome to Starling!");
			addChild(textField);
			var box1:Box = new Box(this, 30, 30);
			var box2:Box = new Box(this, 130, 130);
			box1.linkTo(box2);
		}
		
		
	}

}