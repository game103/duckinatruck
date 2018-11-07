package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Powerup {
		private var slow:MovieClip;
		private var s:MovieClip;
		private var x2:MovieClip;
		private var doubleCoins:MovieClip;
		private var stopTruck:MovieClip;
		private var invincible:MovieClip;
		
		private var hay:Hay;
		private var player:Player;
		private var scoreKeeper:ScoreKeeper;
		private var coin:Coin;
		
		private var isInvicible:Boolean;
		
		private var doubleScoreTimer:Number;
		private var doubleCoinsTimer:Number;
		private var stoppedTruckTimer:Number;
		private var invincibleTimer:Number;
		
		private var paused:Boolean;
		
		private var x2Bar:MovieClip;
		private var doubleCoinsBar:MovieClip;
		private var stoppedTruckBar:MovieClip;
		private var invincibleBar:MovieClip;
		
		private var x2Icon:MovieClip;
		private var doubleCoinsIcon:MovieClip;
		private var stoppedTruckIcon:MovieClip;
		private var invincibleIcon:MovieClip;
		
		private var permy:Permy;

		public function Powerup(slow,s,x2,doubleCoins,stopTruck,invincible,hay,player,scoreKeeper,coin,x2Bar,doubleCoinsBar,stoppedTruckBar,invincibleBar,x2Icon,doubleCoinsIcon,stoppedTruckIcon,invincibleIcon,permy) {
			this.slow = slow;
			this.s = s;
			this.x2 = x2;
			this.doubleCoins = doubleCoins;
			this.stopTruck = stopTruck;
			this.invincible = invincible;
			this.hay = hay;
			this.player = player;
			this.scoreKeeper = scoreKeeper;
			this.coin = coin;
			this.isInvicible = false;
			this.doubleScoreTimer = 0;
			
			this.x2Icon = x2Icon;
			this.doubleCoinsIcon = doubleCoinsIcon;
			this.stoppedTruckIcon = stoppedTruckIcon;
			this.invincibleIcon = invincibleIcon;
			
			this.x2Bar = x2Bar;
			this.x2Bar.width = 0;
			this.x2Bar.visible = false;
			this.doubleCoinsTimer = 0;
			this.doubleCoinsBar = doubleCoinsBar;
			this.doubleCoinsBar.width = 0;
			this.doubleCoinsBar.visible = false;
			this.stoppedTruckTimer = 0;
			this.stoppedTruckBar = stoppedTruckBar;
			this.stoppedTruckBar.width = 0;
			this.stoppedTruckBar.visible = false;
			this.invincibleTimer = 0;
			this.invincibleBar = invincibleBar;
			this.invincibleBar.width = 0;
			this.invincibleBar.visible = false;
			
			this.paused = false;
			
			this.slow.addEventListener(Event.ENTER_FRAME,slowHit);
			this.s.addEventListener(Event.ENTER_FRAME,sHit);
			this.x2.addEventListener(Event.ENTER_FRAME,x2Hit);
			this.doubleCoins.addEventListener(Event.ENTER_FRAME,doubleCoinsHit);
			this.stopTruck.addEventListener(Event.ENTER_FRAME,stoppedTruckHit);
			this.invincible.addEventListener(Event.ENTER_FRAME,invincibleHit);
			
			this.permy = permy;
			
			allSpawn();
		}
		
		public function allSpawn() {
			spawn(slow);
			spawn(s);
			spawn(x2);
			spawn(doubleCoins);
			spawn(stopTruck);
			spawn(invincible);
		}
		
		public function setPaused() {
			if(this.paused == false) {
				this.paused = true;
			}
			else {
				this.paused = false;
			}
		}
		
		public function fadeOut() {
			this.slow.addEventListener(Event.ENTER_FRAME,fadeOutEvent);
		}
		
		public function fadeOutEvent(event:Event) {
			if(this.slow.alpha > 0) {
				this.slow.alpha -= 0.05;
				this.s.alpha -= 0.05;
				this.x2.alpha -= 0.05;
				this.doubleCoins.alpha -= 0.05;
				this.stopTruck.alpha -= 0.05;
				this.invincible.alpha -= 0.05;
			}
			else {
				this.slow.removeEventListener(Event.ENTER_FRAME,fadeOutEvent);
			}
		}
		
		public function spawn(whichPowerUp:MovieClip) {
			this.slow.removeEventListener(Event.ENTER_FRAME,fadeOutEvent);
			whichPowerUp.alpha = 1;
			whichPowerUp.x = Math.floor(Math.random() * 3550) + 20;
			whichPowerUp.y = Math.floor(Math.random() * 200) + 550;
			if(whichPowerUp.x > 530 && whichPowerUp.x < 640) {
				whichPowerUp.x = 530;
			}
		}
		
		public function slowHit(event:Event) {
			if(this.slow.hitTestObject(this.hay.getTarget())) {
				if(this.slow.perfectHitTest(this.hay.getTarget(),1)) {
					if(this.player.getSpeed() - 2 >= 5) {
						this.player.setSpeed(this.player.getSpeed() - 2);
					}
					else {
						this.player.setSpeed(5);
					}
					this.slow.x = -1000;
				}
			}
		}
		
		public function sHit(event:Event) {
			if(this.s.hitTestObject(this.hay.getTarget())) {
				if(this.s.perfectHitTest(this.hay.getTarget(),1)) {
					this.hay.setTimerTime(this.hay.getTimerTime() + 3000);
					this.s.x = -1000;
				}
			}
		}
		
		public function x2Hit(event:Event) {
			if(this.x2.hitTestObject(this.hay.getTarget())) {
				if(this.x2.perfectHitTest(this.hay.getTarget(),1)) {
					this.x2.x = -1000;
					this.hay.setMultiplier(2);
					this.doubleScoreTimer = 300 * this.permy.getPowerUpMulti();
					if(!x2Bar.visible) {
						if(!doubleCoinsBar.visible && !stoppedTruckBar.visible && !invincibleBar.visible) {
							this.x2Bar.y = 550;
							this.x2Icon.y = 550;
						}
						else if((!doubleCoinsBar.visible && !stoppedTruckBar.visible) || (!doubleCoinsBar.visible && !invincibleBar.visible) || (!stoppedTruckBar.visible && !invincibleBar.visible)) {
							this.x2Bar.y = 590;
							this.x2Icon.y = 590;
						}
						else if(!doubleCoinsBar.visible || !stoppedTruckBar.visible || !invincibleBar.visible) {
							this.x2Bar.y = 630;
							this.x2Icon.y = 630;
						}
						else {
							this.x2Bar.y = 670;
							this.x2Icon.y = 670;
						}
					}
					this.x2Bar.visible = true;
					this.x2Icon.visible = true;
					this.x2.addEventListener(Event.ENTER_FRAME,x2Timer);
				}
			}
		}
		
		public function x2Timer(event:Event) {
			if(!this.paused) {
				this.x2Bar.width = this.doubleScoreTimer / this.permy.getPowerUpMulti();
				this.doubleScoreTimer = this.doubleScoreTimer - 1;
				if(this.doubleScoreTimer <= 0) {
					this.doubleScoreTimer = 0;
					this.x2Bar.visible = false;
					this.x2Icon.visible = false;
					if(this.doubleCoinsBar.visible && doubleCoinsBar.y > x2Bar.y) {
						this.doubleCoinsIcon.y = this.doubleCoinsIcon.y - 40;
						this.doubleCoinsBar.y = this.doubleCoinsBar.y - 40;
					}
					if(this.stoppedTruckBar.visible && stoppedTruckBar.y > x2Bar.y) {
						this.stoppedTruckIcon.y = this.stoppedTruckIcon.y - 40;
						this.stoppedTruckBar.y = this.stoppedTruckBar.y - 40;
					}
					if(this.invincibleBar.visible && invincibleBar.y > x2Bar.y) {
						this.invincibleIcon.y = this.invincibleIcon.y - 40;
						this.invincibleBar.y = this.invincibleBar.y - 40;
					}
					this.hay.setMultiplier(1);
					this.x2.removeEventListener(Event.ENTER_FRAME,x2Timer);
				}
			}
		}
		
		public function doubleCoinsHit(event:Event) {
			if(this.doubleCoins.hitTestObject(this.hay.getTarget())) {
				if(this.doubleCoins.perfectHitTest(this.hay.getTarget(),1)) {
					this.doubleCoins.x = -1000;
					this.coin.setMultiplier(2);
					this.doubleCoinsTimer = 300 * this.permy.getPowerUpMulti();
					if(!doubleCoinsBar.visible) {
						if(!x2Bar.visible && !stoppedTruckBar.visible && !invincibleBar.visible) {
							this.doubleCoinsBar.y = 550;
							this.doubleCoinsIcon.y = 550;
						}
						else if((!x2Bar.visible && !stoppedTruckBar.visible) || (!x2Bar.visible && !invincibleBar.visible) || (!stoppedTruckBar.visible && !invincibleBar.visible)) {
							this.doubleCoinsBar.y = 590;
							this.doubleCoinsIcon.y = 590;
						}
						else if(!x2Bar.visible || !stoppedTruckBar.visible || !invincibleBar.visible) {
							this.doubleCoinsBar.y = 630;
							this.doubleCoinsIcon.y = 630;
						}
						else {
							this.doubleCoinsBar.y = 670;
							this.doubleCoinsIcon.y = 670;
						}
					}
					this.doubleCoinsBar.visible = true;
					this.doubleCoinsIcon.visible = true;
					this.doubleCoins.addEventListener(Event.ENTER_FRAME,doubleCoinsTimerFunction);
				}
			}
		}
		
		public function doubleCoinsTimerFunction(event:Event) {
			if(!this.paused) {
				this.doubleCoinsBar.width = this.doubleCoinsTimer / this.permy.getPowerUpMulti();
				this.doubleCoinsTimer = this.doubleCoinsTimer - 1;
				if(this.doubleCoinsTimer <= 0) {
					this.doubleCoinsTimer = 0;
					this.doubleCoinsBar.visible = false;
					this.doubleCoinsIcon.visible = false;
					if(this.x2Bar.visible && this.x2Bar.y > doubleCoinsBar.y) {
						this.x2Icon.y = this.x2Icon.y - 40;
						this.x2Bar.y = this.x2Bar.y - 40;
					}
					if(this.stoppedTruckBar.visible && this.stoppedTruckBar.y > doubleCoinsBar.y) {
						this.stoppedTruckIcon.y = this.stoppedTruckIcon.y - 40;
						this.stoppedTruckBar.y = this.stoppedTruckBar.y - 40;
					}
					if(this.invincibleBar.visible && this.invincibleBar.y > doubleCoinsBar.y) {
						this.invincibleIcon.y = this.invincibleIcon.y - 40;
						this.invincibleBar.y = this.invincibleBar.y - 40;
					}
					this.coin.setMultiplier(1);
					this.doubleCoins.removeEventListener(Event.ENTER_FRAME,doubleCoinsTimerFunction);
				}
			}
		}
		
		public function stoppedTruckHit(event:Event) {
			if(this.stopTruck.hitTestObject(this.hay.getTarget())) {
				if(this.stopTruck.perfectHitTest(this.hay.getTarget(),1)) {
					this.stopTruck.x = -1000;
					this.player.stopMoving();
					this.stoppedTruckTimer = 300 * this.permy.getPowerUpMulti();
					if(!stoppedTruckBar.visible) {
						if(!x2Bar.visible && !doubleCoinsBar.visible && !invincibleBar.visible) {
							this.stoppedTruckBar.y = 550;
							this.stoppedTruckIcon.y = 550;
						}
						else if((!x2Bar.visible && !doubleCoinsBar.visible) || (!x2Bar.visible && !invincibleBar.visible) || (!doubleCoinsBar.visible && !invincibleBar.visible)) {
							this.stoppedTruckBar.y = 590;
							this.stoppedTruckIcon.y = 590;
						}
						else if(!x2Bar.visible || !doubleCoinsBar.visible || !invincibleBar.visible) {
							this.stoppedTruckBar.y = 630;
							this.stoppedTruckIcon.y = 630;
						}
						else {
							this.stoppedTruckBar.y = 670;
							this.stoppedTruckIcon.y = 670;
						}
					}
					this.stoppedTruckBar.visible = true;
					this.stoppedTruckIcon.visible = true;
					this.stopTruck.addEventListener(Event.ENTER_FRAME,stoppedTruckTimerFunction);
				}
			}
		}
		
		public function stoppedTruckTimerFunction(event:Event) {
			if(!this.paused) {
				this.stoppedTruckBar.width = this.stoppedTruckTimer / this.permy.getPowerUpMulti();
				this.stoppedTruckTimer = this.stoppedTruckTimer - 1;
				if(this.stoppedTruckTimer <= 0) {
					this.stoppedTruckTimer = 0;
					this.stoppedTruckBar.visible = false;
					this.stoppedTruckIcon.visible = false;
					if(this.x2Bar.visible && this.x2Bar.y > stoppedTruckBar.y) {
						this.x2Icon.y = this.x2Icon.y - 40;
						this.x2Bar.y = this.x2Bar.y - 40;
					}
					if(this.doubleCoinsBar.visible && this.doubleCoinsBar.y > stoppedTruckBar.y) {
						this.doubleCoinsIcon.y = this.doubleCoinsIcon.y - 40;
						this.doubleCoinsBar.y = this.doubleCoinsBar.y - 40;
					}
					if(this.invincibleBar.visible && this.invincibleBar.y > stoppedTruckBar.y) {
						this.invincibleIcon.y = this.invincibleIcon.y - 40;
						this.invincibleBar.y = this.invincibleBar.y - 40;
					}
					this.stopTruck.removeEventListener(Event.ENTER_FRAME,stoppedTruckTimerFunction);
				}
			}
		}
		
		public function getStoppedTruckTimer():Number {
			return this.stoppedTruckTimer;
		}
		
		public function invincibleHit(event:Event) {
			if(this.invincible.hitTestObject(this.hay.getTarget())) {
				if(this.invincible.perfectHitTest(this.hay.getTarget(),1)) {
					this.invincible.x = -1000;
					this.invincibleTimer = 300 * this.permy.getPowerUpMulti();
					if(!this.invincibleBar.visible) {
						if(!x2Bar.visible && !doubleCoinsBar.visible && !stoppedTruckBar.visible) {
							this.invincibleBar.y = 550;
							this.invincibleIcon.y = 550;
						}
						else if((!x2Bar.visible && !doubleCoinsBar.visible) || (!x2Bar.visible && !stoppedTruckBar.visible) || (!doubleCoinsBar.visible && !stoppedTruckBar.visible)) {
							this.invincibleBar.y = 590;
							this.invincibleIcon.y = 590;
						}
						else if(!x2Bar.visible || !doubleCoinsBar.visible || !stoppedTruckBar.visible) {
							this.invincibleBar.y = 630;
							this.invincibleIcon.y = 630;
						}
						else {
							this.invincibleBar.y = 670;
							this.invincibleIcon.y = 670;
						}
					}
					this.invincibleBar.visible = true;
					this.invincibleIcon.visible = true;
					this.invincible.addEventListener(Event.ENTER_FRAME,invincibleTimerFunction);
				}
			}
		}
		
		public function invincibleTimerFunction(event:Event) {
			if(!this.paused) {	
				this.invincibleBar.width = this.invincibleTimer/ this.permy.getPowerUpMulti();
				this.invincibleTimer = this.invincibleTimer - 1;
				if(this.invincibleTimer <= 0) {
					this.invincibleTimer = 0;
					this.invincibleBar.visible = false;
					this.invincibleIcon.visible = false;
					if(this.x2Bar.visible && this.x2Bar.y > invincibleBar.y) {
						this.x2Icon.y = this.x2Icon.y - 40;
						this.x2Bar.y = this.x2Bar.y - 40;
					}
					if(this.doubleCoinsBar.visible && this.doubleCoinsBar.y > invincibleBar.y) {
						this.doubleCoinsIcon.y = this.doubleCoinsIcon.y - 40;
						this.doubleCoinsBar.y = this.doubleCoinsBar.y - 40;
					}
					if(this.stoppedTruckBar.visible && this.stoppedTruckBar.y > invincibleBar.y) {
						this.stoppedTruckIcon.y = this.stoppedTruckIcon.y - 40;
						this.stoppedTruckBar.y = this.stoppedTruckBar.y - 40;
					}
					this.invincible.removeEventListener(Event.ENTER_FRAME,invincibleTimerFunction);
				}
			}
		}
		
		public function getInvincibleTimer():Number {
			return this.invincibleTimer;
		}
		
		public function removeTimers() {
			this.invincibleIcon.visible = false;
			this.x2Icon.visible = false;
			this.doubleCoinsIcon.visible = false;
			this.stoppedTruckIcon.visible = false;
			this.invincibleTimer = 0;
			this.doubleScoreTimer = 0;
			this.doubleCoinsTimer = 0;
			this.stoppedTruckTimer = 0;
			this.x2Bar.visible = false;
			this.hay.setMultiplier(1);
			this.x2.removeEventListener(Event.ENTER_FRAME,x2Timer);
			this.doubleCoinsBar.visible = false;
			this.coin.setMultiplier(1);
			this.doubleCoins.removeEventListener(Event.ENTER_FRAME,doubleCoinsTimerFunction);
			this.stoppedTruckBar.visible = false;
			this.stopTruck.removeEventListener(Event.ENTER_FRAME,stoppedTruckTimerFunction);
			this.invincibleBar.visible = false;
			this.invincible.removeEventListener(Event.ENTER_FRAME,invincibleTimerFunction);
		}

	}
	
}
