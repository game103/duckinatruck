package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.filters.DropShadowFilter;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.display.DisplayObject;
	
	public class Scenery {
		private var grass:MovieClip;
		private var s1:MovieClip;
		private var s2:MovieClip;
		private var s3:MovieClip;
		private var c1:MovieClip;
		private var c2:MovieClip;
		private var c3:MovieClip;
		private var c4:MovieClip;
		private var c5:MovieClip;
		private var c6:MovieClip;
		private var weather:Number;
		
		private var c1Speed:Number;
		private var c2Speed:Number;
		private var c3Speed:Number;
		private var c4Speed:Number;
		private var c5Speed:Number;
		private var c6Speed:Number;
		
		private var i:Number;
		private var drop:Drop;
		private var raindrop:Raindrop;
		
		private var switchingTime:Boolean;
		
		private var timer:Timer;
		
		private var c1DeleteIndex;
		private var c2DeleteIndex;
		private var c3DeleteIndex;
		private var c4DeleteIndex;
		private var c5DeleteIndex;
		private var c6DeleteIndex;
		
		private var rainDelete;
		private var rainDrops:Array;
		
		public function Scenery(grass:MovieClip,s1:MovieClip,s2:MovieClip,s3:MovieClip,c1:MovieClip,c2:MovieClip,c3:MovieClip,c4:MovieClip,c5:MovieClip,c6:MovieClip) {
			this.grass = grass;
			this.s1 = s1;
			this.s2 = s2;
			this.s3 = s3;
			
			this.c1 = c1;
			this.c2 = c2;
			this.c3 = c3;
			this.c4 = c4;
			this.c5 = c5;
			this.c6 = c6;
			
			this.rainDrops = new Array();
			
			this.switchingTime = false;
			
			this.weather = Math.floor(Math.random()*5) + 1;
			changeWeather(this.weather);
			
			this.timer = new Timer(120000,1);
			this.timer.addEventListener(TimerEvent.TIMER,timeUpSwitch);
			timer.start();
			
			this.rainDelete = false;
			
			reset();
		}
		
		public function reset() {
			this.s1.gotoAndStop(Math.floor(Math.random() * 10) + 2);
			this.s2.gotoAndStop(Math.floor(Math.random() * 10) + 2);
			this.s3.gotoAndStop(Math.floor(Math.random() * 10) + 2);
		}
		
		public function timeUpSwitch(event:TimerEvent) {
			this.switchingTime = true;
			this.c1.addEventListener(Event.ENTER_FRAME,switchWeatherType);
		}
		
		public function getRainDelete():Boolean {
			return this.rainDelete;
		}
		
		public function changeWeather(weather:Number) {
			this.rainDelete = false;
			if(weather == 1) {
				this.c1.x = Math.floor(Math.random() * 640)+640;
				this.c2.x = Math.floor(Math.random() * 540)+740;
				this.c3.x = Math.floor(Math.random() * 440)+840;
				this.c4.x = Math.floor(Math.random() * 340)+940;
				this.c5.x = Math.floor(Math.random() * 240)+1040;
				this.c6.x = Math.floor(Math.random() * 140)+1140;
				
				this.c1.y = Math.floor(Math.random() * 50) - 50;
				this.c2.y = Math.floor(Math.random() * 50) - 50;
				this.c3.y = Math.floor(Math.random() * 50) - 50;
				this.c4.y = Math.floor(Math.random() * 50) - 50;
				this.c5.y = Math.floor(Math.random() * 50) - 50;
				this.c6.y = Math.floor(Math.random() * 50) - 50;
				
				this.c1.addEventListener(Event.ENTER_FRAME,moveCloudStorm);
				resetSpeedAll();
				
				var colorTransform:ColorTransform = new ColorTransform();
				colorTransform.color = 0x666666;
				this.c1.incloud.transform.colorTransform = colorTransform;
				this.c2.incloud.transform.colorTransform = colorTransform;
				this.c3.incloud.transform.colorTransform = colorTransform;
				this.c4.incloud.transform.colorTransform = colorTransform;
				this.c5.incloud.transform.colorTransform = colorTransform;
				this.c6.incloud.transform.colorTransform = colorTransform;
				
				for(i = 0;i < 25;i++) {
					drop = new Drop();
					c1.addChildAt(drop,i);
					raindrop = new Raindrop(drop,20+i*16,120,Math.floor(Math.random() * 3000) + 1);
					rainDrops.push(raindrop);
				}
				c1.setChildIndex(this.c1.incloud,this.c1.numChildren-1);
				for(i = 0;i < 25;i++) {
					drop = new Drop();
					c2.addChildAt(drop,i);
					raindrop = new Raindrop(drop,20+i*16,120,Math.floor(Math.random() * 3000) + 1);
					rainDrops.push(raindrop);
				}
				c2.setChildIndex(this.c2.incloud,this.c2.numChildren-1);
				for(i = 0;i < 25;i++) {
					drop = new Drop();
					c3.addChildAt(drop,i);
					raindrop = new Raindrop(drop,20+i*16,120,Math.floor(Math.random() * 3000) + 1);
					rainDrops.push(raindrop);
				}
				c3.setChildIndex(this.c3.incloud,this.c3.numChildren-1);
				for(i = 0;i < 25;i++) {
					drop = new Drop();
					c4.addChildAt(drop,i);
					raindrop = new Raindrop(drop,20+i*16,120,Math.floor(Math.random() * 3000) + 1);
					rainDrops.push(raindrop);
				}
				c4.setChildIndex(this.c4.incloud,this.c4.numChildren-1);
				for(i = 0;i < 25;i++) {
					drop = new Drop();
					c5.addChildAt(drop,i);
					raindrop = new Raindrop(drop,20+i*16,120,Math.floor(Math.random() * 3000) + 1);
					rainDrops.push(raindrop);
				}
				c5.setChildIndex(this.c5.incloud,this.c5.numChildren-1);
				for(i = 0;i < 25;i++) {
					drop = new Drop();
					c6.addChildAt(drop,i);
					raindrop = new Raindrop(drop,20+i*16,120,Math.floor(Math.random() * 3000) + 1);
					rainDrops.push(raindrop);
				}
				c6.setChildIndex(this.c6.incloud,this.c6.numChildren-1);
			}
			else if(weather == 2) {
				this.c1.x = Math.floor(Math.random() * 640)+640;
				this.c2.x = Math.floor(Math.random() * 440)+840;
				this.c3.x = Math.floor(Math.random() * 340)+940;
				this.c4.x = Math.floor(Math.random() * 140)+1140;
				
				this.c1.y = Math.floor(Math.random() * 50) - 50;
				this.c2.y = Math.floor(Math.random() * 50) - 50;
				this.c3.y = Math.floor(Math.random() * 50) - 50;
				this.c4.y = Math.floor(Math.random() * 50) - 50;
				
				this.c1.addEventListener(Event.ENTER_FRAME,moveCloudRain);
				resetSpeedAll();
				
				var colorTransform2:ColorTransform = new ColorTransform();
				colorTransform2.color = 0x999999;
				this.c1.incloud.transform.colorTransform = colorTransform2;
				this.c2.incloud.transform.colorTransform = colorTransform2;
				this.c3.incloud.transform.colorTransform = colorTransform2;
				this.c4.incloud.transform.colorTransform = colorTransform2;
				
				for(i = 0;i < 10;i++) {
					drop = new Drop();
					c1.addChildAt(drop,i);
					raindrop = new Raindrop(drop,20+i*40,120,Math.floor(Math.random() * 3000) + 1);
					rainDrops.push(raindrop);
				}
				c1.setChildIndex(this.c1.incloud,this.c1.numChildren-1);
				for(i = 0;i < 10;i++) {
					drop = new Drop();
					c2.addChildAt(drop,i);
					raindrop = new Raindrop(drop,20+i*40,120,Math.floor(Math.random() * 3000) + 1);
					rainDrops.push(raindrop);
				}
				c2.setChildIndex(this.c2.incloud,this.c2.numChildren-1);
				for(i = 0;i < 10;i++) {
					drop = new Drop();
					c3.addChildAt(drop,i);
					raindrop = new Raindrop(drop,20+i*40,120,Math.floor(Math.random() * 3000) + 1);
					rainDrops.push(raindrop);
				}
				c3.setChildIndex(this.c3.incloud,this.c3.numChildren-1);
				for(i = 0;i < 10;i++) {
					drop = new Drop();
					c4.addChildAt(drop,i);
					raindrop = new Raindrop(drop,20+i*40,120,Math.floor(Math.random() * 3000) + 1);
					rainDrops.push(raindrop);
				}
				c4.setChildIndex(this.c4.incloud,this.c4.numChildren-1);
			}
			else if(weather == 3) {
				
			}
			else {
				var colorTransform3:ColorTransform = new ColorTransform();
				colorTransform3.color = 0xFFFFFF;
				this.c1.incloud.transform.colorTransform = colorTransform3;
				this.c2.incloud.transform.colorTransform = colorTransform3;
				
				this.c1.x = Math.floor(Math.random() * 640)+640;
				this.c2.x = Math.floor(Math.random() * 640)+640;
				
				this.c1.y = Math.floor(Math.random() * 50) - 50;
				this.c2.y = Math.floor(Math.random() * 50) - 50;
				
				this.c1.addEventListener(Event.ENTER_FRAME,moveCloudCloudy);
				resetSpeedAll();
			}
		}
		
		public function switchWeatherType(event:Event) {
			//once cleared reset
			if((c1.x > 640 || c1.x < -445) && (c2.x > 640 || c2.x < -445) && (c3.x > 640 || c3.x < -445) && (c4.x > 640 || c4.x < -445) && (c5.x > 640 || c5.x < -445) && (c6.x > 640 || c6.x < -445)) {
				for each(var r:Raindrop in rainDrops) {
					r.remove();
					r = null;
				}
				rainDrops.length = 0;
				//remove rain
				if(this.weather == 1) {
					for(i = 0;i < 25;i++) {
						var temp:DisplayObject = c1.getChildAt(0);
						temp = null;
						c1.removeChildAt(0);
					}
					for(i = 0;i < 25;i++) {
						var temp2:DisplayObject = c2.getChildAt(0);
						temp2 = null;
						c2.removeChildAt(0);
					}
					for(i = 0;i < 25;i++) {
						var temp3:DisplayObject = c3.getChildAt(0);
						temp3 = null;
						c3.removeChildAt(0);
					}
					for(i = 0;i < 25;i++) {
						var temp4:DisplayObject = c4.getChildAt(0);
						temp4 = null;
						c4.removeChildAt(0);
					}
					for(i = 0;i < 25;i++) {
						var temp5:DisplayObject = c5.getChildAt(0);
						temp5 = null;
						c5.removeChildAt(0);
					}
					for(i = 0;i < 25;i++) {
						var temp6:DisplayObject = c6.getChildAt(0);
						temp6 = null;
						c6.removeChildAt(0);
					}
				}
				else if(this.weather == 2) {
					for(i = 0;i < 10;i++) {
						var temp7:DisplayObject = c1.getChildAt(0);
						temp7 = null;
						c1.removeChildAt(0);
					}
					for(i = 0;i < 10;i++) {
						var temp8:DisplayObject = c2.getChildAt(0);
						temp8 = null;
						c2.removeChildAt(0);
					}
					for(i = 0;i < 10;i++) {
						var temp9:DisplayObject = c3.getChildAt(0);
						temp9 = null;
						c3.removeChildAt(0);
					}
					for(i = 0;i < 10;i++) {
						var temp10:DisplayObject = c4.getChildAt(0);
						temp10 = null;
						c4.removeChildAt(0);
					}
				}
				removeMoveEvents();
				this.weather = Math.floor(Math.random()*5) + 1;
				changeWeather(this.weather);
				trace(this.weather);
				this.switchingTime = false;
				this.timer.removeEventListener(TimerEvent.TIMER,timeUpSwitch);
				this.timer = new Timer(120000,1);
				this.timer.addEventListener(TimerEvent.TIMER,timeUpSwitch);
				timer.start();
				this.c1.removeEventListener(Event.ENTER_FRAME,switchWeatherType);
			}
		}
		
		public function resetSpeedAll() {
			resetSpeed(1);
			resetSpeed(2);
			resetSpeed(3);
			resetSpeed(4);
			resetSpeed(5);
			resetSpeed(6);
		}
		
		public function resetSpeed(cloudNumber:Number) {
			if(cloudNumber == 1) {
				this.c1Speed = Math.floor(Math.random() * 2) + 3;
			}
			else if(cloudNumber == 2) {
				this.c2Speed = Math.floor(Math.random() * 2) + 3;
			}
			else if(cloudNumber == 3) {
				this.c3Speed = Math.floor(Math.random() * 2) + 3;
			}
			else if(cloudNumber == 4) {
				this.c4Speed = Math.floor(Math.random() * 2) + 3;
			}
			else if(cloudNumber == 5) {
				this.c5Speed = Math.floor(Math.random() * 2) + 3;
			}
			else if(cloudNumber == 6) {
				this.c6Speed = Math.floor(Math.random() * 2) + 3;
			}
		}
		
		public function moveCloudStorm(event:Event) {
			c1.x = c1.x - c1Speed;
			c2.x = c2.x - c2Speed;
			c3.x = c3.x - c3Speed;
			c4.x = c4.x - c4Speed;
			c5.x = c5.x - c5Speed;
			c6.x = c6.x - c6Speed;
			if(!switchingTime) {
				if(c1.x < -445) {
					this.c1Speed = Math.floor(Math.random() * 2) + 3;
					this.c1.x = 650;
					this.c1.y = Math.floor(Math.random() * 50) - 50;
				}
				if(c2.x < -445) {
					this.c2Speed = Math.floor(Math.random() * 2) + 3;
					this.c2.x = 650;
					this.c2.y = Math.floor(Math.random() * 50) - 50;
				}
				if(c3.x < -445) {
					this.c3Speed = Math.floor(Math.random() * 2) + 3;
					this.c3.x = 650;
					this.c3.y = Math.floor(Math.random() * 50) - 50;
				}
				if(c4.x < -445) {
					this.c4Speed = Math.floor(Math.random() * 2) + 3;
					this.c4.x = 650;
					this.c4.y = Math.floor(Math.random() * 50) - 50;
				}
				if(c5.x < -445) {
					this.c5Speed = Math.floor(Math.random() * 2) + 3;
					this.c5.x = 650;
					this.c5.y = Math.floor(Math.random() * 50) - 50;
				}
				if(c6.x < -445) {
					this.c6Speed = Math.floor(Math.random() * 2) + 3;
					this.c6.x = 650;
					this.c6.y = Math.floor(Math.random() * 50) - 50;
				}
			}
		}
		
		public function moveCloudRain(event:Event) {
			c1.x = c1.x - c1Speed;
			c2.x = c2.x - c2Speed;
			c3.x = c3.x - c3Speed;
			c4.x = c4.x - c4Speed;
			if(!switchingTime) {
				if(c1.x < -445) {
					this.c1Speed = Math.floor(Math.random() * 2) + 3;
					this.c1.x = 650;
					this.c1.y = Math.floor(Math.random() * 50) - 50;
				}
				if(c2.x < -445) {
					this.c2Speed = Math.floor(Math.random() * 2) + 3;
					this.c2.x = 650;
					this.c2.y = Math.floor(Math.random() * 50) - 50;
				}
				if(c3.x < -445) {
					this.c3Speed = Math.floor(Math.random() * 2) + 3;
					this.c3.x = 650;
					this.c3.y = Math.floor(Math.random() * 50) - 50;
				}
				if(c4.x < -445) {
					this.c4Speed = Math.floor(Math.random() * 2) + 3;
					this.c4.x = 650;
					this.c4.y = Math.floor(Math.random() * 50) - 50;
				}
			}
		}
		
		public function moveCloudCloudy(event:Event) {
			c1.x = c1.x - c1Speed;
			c2.x = c2.x - c2Speed;
			if(!switchingTime) {
				if(c1.x < -445) {
					this.c1Speed = Math.floor(Math.random() * 2) + 2;
					this.c1.x = 650;
					this.c1.y = Math.floor(Math.random() * 50) - 50;
				}
				if(c2.x < -445) {
					this.c2Speed = Math.floor(Math.random() * 2) + 2;
					this.c2.x = 650;
					this.c2.y = Math.floor(Math.random() * 50) - 50;
				}
			}
		}
		
		public function removeMoveEvents() {
			this.c1.removeEventListener(Event.ENTER_FRAME,moveCloudCloudy);
			this.c1.removeEventListener(Event.ENTER_FRAME,moveCloudRain);
			this.c1.removeEventListener(Event.ENTER_FRAME,moveCloudStorm);
		}

	}
	
}
