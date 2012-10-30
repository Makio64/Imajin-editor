package ui 
{
	import flash.geom.Point;
	import starling.events.Event;
	import starling.display.Shape;
	import starling.display.Sprite;
	
	/**
	 * Link - ImajinEditor
	 * @version 1.0
	 * @author David Ronai
	 */
	public class Link extends Shape 
	{
		private var box1:Box;
		private var box2:Box;
		private var tmpPoint:Point;
		
		public function Link(box1:Box) {
			this.box1 = box1;
			box1.addChildAt(this, 0);
			box1.addEventListener("moved", onMove);
		}
		
		public function connectTo(box:Box):void {
			this.box2 = box;
			box.addEventListener("moved", onMove);
			redraw();
		}
		
		public function focusPoint(x:int, y:int) {
			
		}
		
		private function onMove(e:Event):void 
		{
			redraw();
		}
		
		private function redraw():void 
		{
			graphics.clear();
			graphics.lineStyle(1, 0xFF00FF);
			graphics.moveTo(box1.width/2, box1.height/2);
			if( box2 ){
				graphics.lineTo(box2.x + box2.width/2 - box1.x, box2.y+box2.height/2 - box1.y);
			} else if ( tmpPoint ) {
				graphics.lineTo(box1.x + box1.width/2 - tmpPoint.x, box1.y+box1.height/2 - tmpPoint.y);	
			}
			graphics.endFill();
			
		}
		
		public function update():void {
			
		}
		
	}

}