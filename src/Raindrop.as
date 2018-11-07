package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class Raindrop {
		private var drop:MovieClip;
		private var startX:Number;
		private var startY:Number;
		private var speed:Number;
		private var delayedStartTime:Number;
		private var timer:Timer;

		public function Raindrop(drop:MovieClip,startX:Number,startY:Number,delayedStartTime:Number) {
			this.drop = drop;
			this.startX = startX;
			this.startY = startY;
			this.drop.x = startX;
			this.drop.y = startY;
			this.delayedStartTime = delayedStartTime;
			this.speed = 0;
			this.timer = new Timer(delayedStartTime,1);
			this.timer.addEventListener(TimerEvent.TIMER,startFall);
			this.timer.start();
			this.drop.visible = false;
		}
		
		public function startFall(event:TimerEvent) {
			this.drop.visible = true;
			this.drop.addEventListener(Event.ENTER_FRAME,fall);
		}
		
		public function fall(event:Event) {
			this.drop.y = this.drop.y + this.speed;
			this.speed = this.speed + 0.5;
			if(this.drop.y >= 1000) {
				this.drop.y = this.startY;
				this.speed = 0;
			}
		}
		
		public function remove() {
			this.drop.removeEventListener(Event.ENTER_FRAME,fall);
		}

	}
	
}
