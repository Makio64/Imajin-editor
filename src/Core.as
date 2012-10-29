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
			addChild(new Box(30,30));
		}
		
	}

}