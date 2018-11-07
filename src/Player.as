package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Player {
		private var truck:MovieClip;
		private var hitTruck:MovieClip;
		private var speed:Number;
		private var randomExtra:Number;
		private var direction:String;
		private var hitFront:MovieClip;
		private var hitTop:MovieClip;
		private var speedometer:MovieClip;
		private var paused:Boolean;

		public function Player(truck:MovieClip,speed:Number,hitTruck:MovieClip,hitFront:MovieClip,hitTop:MovieClip,speedometer:MovieClip) {
			this.truck = truck;
			truck.inside.w1Out.w1.play();
			truck.inside.w2Out.w1.play();
			this.speed = speed;
			this.hitTruck = hitTruck;
			this.direction = "Right";
			this.hitFront = hitFront;
			this.hitTop = hitTop;
			this.speedometer = speedometer;
			this.paused = false;
			this.randomExtra = Math.floor(Math.random() * 3) - 1;
			this.truck.addEventListener(Event.ENTER_FRAME,moveTruck);
			this.speedometer.addEventListener(Event.ENTER_FRAME,speedometerRotation);
		}
		
		public function setPaused() {
			if(this.paused == false) {
				this.paused = true;
				truck.inside.w1Out.w1.stop();
				truck.inside.w2Out.w1.stop();
			}
			else {
				this.paused = false;
				truck.inside.w1Out.w1.play();
				truck.inside.w2Out.w1.play();
			}
		}
		
		public function speedometerRotation(event:Event) {
			if(!this.paused) {
				if(this.speed != 0) {
				//if(this.speedometer.needle.rotation < (this.speed+this.randomExtra)*22.5) {
					this.speedometer.needle.rotation = (this.speed+this.randomExtra-3)*22.5;//4 is minimun speed
				//}
				}
				else {
					this.speedometer.needle.rotation = 0;
				}
				//else if(this.speedometer.needle.rotation > (this.speed+this.randomExtra)*22.5) {
					//this.speedometer.needle.rotation = this.speedometer.needle.rotation - 0.5;
				//}
			}
		}
		
		public function moveTruck(event:Event):void {
			if(!this.paused) {
				if(this.direction == "Right") {
					this.truck.x = this.truck.x + this.speed + this.randomExtra;
					this.hitTruck.x = this.hitTruck.x + this.speed + this.randomExtra;
					this.hitTop.x = this.hitTop.x + this.speed + this.randomExtra;
					this.hitFront.x = this.hitFront.x + this.speed + this.randomExtra;
					if(this.truck.x > 640 + 30) {
						this.direction = "Left";
						this.randomExtra = Math.floor(Math.random() * 3) - 1; //max = 4 min = -4
						this.truck.scaleX = -this.truck.scaleX;
						this.truck.x = this.truck.x + this.truck.width;
						this.hitTruck.x = this.truck.x - 5 - this.hitTruck.width;
						this.hitTop.x = this.truck.x - 132 - this.hitTop.width;
						this.hitFront.x = this.truck.x -  212 - this.hitFront.width;
					}
				}
				if(this.direction == "Left") {
					this.truck.x = this.truck.x - this.speed + this.randomExtra;
					this.hitTruck.x = this.hitTruck.x - this.speed + this.randomExtra;
					this.hitTop.x = this.hitTop.x - this.speed + this.randomExtra;
					this.hitFront.x = this.hitFront.x - this.speed + this.randomExtra;
					if(this.truck.x < 0 - 30) {
						this.direction = "Right";
						this.randomExtra = Math.floor(Math.random() * 3) - 1;
						this.truck.scaleX = -this.truck.scaleX;
						this.truck.x = this.truck.x - this.truck.width;
						this.hitTruck.x = this.truck.x + 5;
						this.hitTop.x = this.truck.x + 132;
						this.hitFront.x = this.truck.x + 212;
					}
				}
			}
		}
		
		public function setRandomExtra() {
			this.randomExtra = Math.floor(Math.random() * 3) - 1;
		}
		
		public function getSpeed():Number {
			return this.speed;
		}
		
		public function setSpeed(speed:Number) {
			this.speed = speed;
		}
		
		public function getTruck():MovieClip {
			return this.truck;
		}
		
		public function quack() {
			this.truck.duck.play();
		}
		
		public function reset() {
			if (this.direction == "Left") {
				this.truck.scaleX = -this.truck.scaleX;
				this.truck.x = this.truck.x - this.truck.width;
				this.hitTruck.x = this.truck.x + 5;
				this.hitTop.x = this.truck.x + 132;
				this.hitFront.x = this.truck.x + 212;
				this.direction = "Right";
			}
			this.truck.x = 0;
				this.hitTruck.x = 5;
				this.hitTop.x = 132;
				this.hitFront.x = 212;
			this.truck.removeEventListener(Event.ENTER_FRAME,reverse);
			this.truck.removeEventListener(Event.ENTER_FRAME,listenForStart);
		}
		
		public function moveTruckToStart() {
			this.truck.addEventListener(Event.ENTER_FRAME,listenForStart);
			if(this.direction == "Left" || this.truck.x < 0) {
				this.startMoving();
			}
			else if(this.truck.x > 0) {
				this.truck.addEventListener(Event.ENTER_FRAME,reverse);
			}
		}
		
		public function reverse(event:Event) {
			//always to the right
			this.truck.x = this.truck.x - this.speed - this.randomExtra;
			this.hitTruck.x = this.hitTruck.x - this.speed - this.randomExtra;
			this.hitTop.x = this.hitTop.x - this.speed - this.randomExtra;
			this.hitFront.x = this.hitFront.x - this.speed - this.randomExtra;
			this.truck.inside.w1Out.w1.prevFrame();
			this.truck.inside.w2Out.w1.prevFrame();
			if(this.truck.inside.w2Out.w1.currentFrame == 1) {
				this.truck.inside.w1Out.w1.gotoAndStop(6);
				this.truck.inside.w2Out.w1.gotoAndStop(6);
			}
		}
		
		public function resetSpeedometer() {
			this.speedometer.needle.rotation = 0;
		}
		
		public function listenForStart(event:Event) {
			if(this.truck.x >= 0 && this.truck.x <= this.speed+this.randomExtra && this.direction == "Right") {
				this.stopMoving();
				this.truck.x = 0;
				this.hitTruck.x = 5;
				this.hitTop.x = 132;
				this.hitFront.x = 212;
				this.speed = 0;
				this.randomExtra = 0;
				this.truck.removeEventListener(Event.ENTER_FRAME,reverse);
				this.truck.removeEventListener(Event.ENTER_FRAME,listenForStart);
			}
		}
		
		public function stopMoving():void {
			this.truck.removeEventListener(Event.ENTER_FRAME,moveTruck);
			truck.inside.w1Out.w1.stop();
			truck.inside.w2Out.w1.stop();
		}
		
		public function startMoving():void {
			this.truck.addEventListener(Event.ENTER_FRAME,moveTruck);
			truck.inside.w1Out.w1.play();
			truck.inside.w2Out.w1.play();
		}
		
		public function getDirection():String {
			return this.direction;
		}

	}
	
}
