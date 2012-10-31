package ui 
{
	import flash.geom.Point;
	import starling.display.Shape;
	import starling.events.Event;
	
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
			Core.instance.addChildAt(this, 0);
			box1.addEventListener("drag", onDrag);
		}
		
		public function connectTo(box:Box):void {
			this.box2 = box;
			this.box2.addLink(this);
			this.box2.addEventListener("drag", onDrag);
			redraw();
		}
		
		private function onDrag(e:Event):void {
			redraw();
		}
		
		private function redraw():void {
			graphics.clear();
			graphics.lineStyle(1, 0xFF00FF);
			graphics.moveTo(box1.width/2+box1.x, box1.height/2+box1.y);
			if( box2 ){
				graphics.lineTo(box2.x + box2.width/2, box2.y+box2.height/2);
			} else if ( tmpPoint ) {
				graphics.lineTo(box1.x+tmpPoint.x, box1.y+tmpPoint.y);	
			}
			graphics.endFill();
		}
		
		public function updatePosition(x:int,y:int):void {
			tmpPoint = new Point(x, y);	
			redraw();
		}
		
		public function tryToConnect():Boolean {
			var box:Box = Box.getBoxAtPoint(box1.x + tmpPoint.x, box1.y + tmpPoint.y);
			if ( box != null && box != box1 && !box.connectedTo(box1) ) {
				connectTo(box);
				return true;
			}
			return false;
		}
		
		public function connectedTo(box:Box):Boolean {
			return box == box1 || box == box2;
		}
		
		override public function dispose():void 
		{
			if (parent) {
				parent.removeChild(this, false);
			}
			super.dispose();
		}
	}
}