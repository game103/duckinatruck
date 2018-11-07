package  {
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.events.Event;
	import flash.display.DisplayObject;
	
	public class Coin {
		private var coin:MovieClip;
		private var coin2:MovieClip;
		private var hay:MovieClip;
		private var coins:Number;
		private var coinField:TextField;
		private var permy:Permy;
		private var totalCoinsField:TextField;
		private var paused:Boolean;
		private var missionHandler:MissionHandler;
		private var multiplier:Number;

		public function Coin(coin:MovieClip,coin2:MovieClip,hay:MovieClip,coinField:TextField,permy:Permy,totalCoinsField:TextField,missionHandler:MissionHandler) {
			this.coin = coin;
			this.coin2 = coin2;
			this.hay = hay;
			this.coinField = coinField;
			this.permy = permy;
			this.coins = 0;
			this.totalCoinsField = totalCoinsField;
			this.coinField.text = this.coins.toString();
			this.totalCoinsField.text = this.permy.getTotalCoins().toString();
			this.missionHandler = missionHandler;
			this.paused = false;
			this.multiplier = 1;
			spawn(coin);
			spawn(coin2);
		}
		
		public function reset() {
			this.coins = 0;
			this.coinField.text = this.coins.toString();
			this.totalCoinsField.text = this.permy.getTotalCoins().toString();
			spawn(coin);
			spawn(coin2);
		}
		
		public function getTotalCoinsField():TextField {
			return this.totalCoinsField;
		}
		
		public function setCoinField(number:Number) {
			this.coinField.text = number.toString();
		}
		
		public function getCoinField():TextField {
			return this.coinField;
		}
		
		public function fadeOut() {
			this.coin.addEventListener(Event.ENTER_FRAME,fadeOutEvent);
		}
		
		public function fadeOutEvent(event:Event) {
			if(this.coin.alpha > 0) {
				this.coin.alpha -= 0.05;
				this.coin2.alpha -= 0.05;
			}
			else {
				this.coin.removeEventListener(Event.ENTER_FRAME,fadeOutEvent);
			}
		}
		
		public function setPaused() {
			if(this.paused == false) {
				this.paused = true;
			}
			else {
				this.paused = false;
			}
		}
		
		public function setTotalCoinsField(number:Number) {
			this.totalCoinsField.text = number.toString();
		}
		
		public function addCoins(coins:Number) {
			this.coins = this.coins + coins * this.permy.getCoinMulti();
			this.permy.setTotalCoins(this.permy.getTotalCoins() + coins * this.permy.getCoinMulti());
			this.coinField.text = this.coins.toString();
			this.totalCoinsField.text = this.permy.getTotalCoins().toString();
		}
		
		public function setMultiplier(multiplier:Number) {
			this.multiplier = multiplier;
		}
		
		public function spawn(whichCoin:MovieClip) {
			this.coin.removeEventListener(Event.ENTER_FRAME,fadeOutEvent);
			whichCoin.alpha = 1;
			whichCoin.x = Math.floor(Math.random() * 550) + 20;
			whichCoin.y = Math.floor(Math.random() * 200) + 550;
			whichCoin.value.text = (Math.floor(Math.random() * 10) + 1).toString();
			if(whichCoin == this.coin) {
				whichCoin.removeEventListener(Event.ENTER_FRAME,listenForHit);
				whichCoin.addEventListener(Event.ENTER_FRAME,listenForHit);
			}
			else {
				whichCoin.removeEventListener(Event.ENTER_FRAME,listenForHit2);
				whichCoin.addEventListener(Event.ENTER_FRAME,listenForHit2);
			}
		}
		
		public function listenForHit(event:Event) {
			if(!this.paused) {
				if(this.coin.hitTestObject(this.hay)) {
					if(this.coin.perfectHitTest(this.hay,1)) {
						this.coins = this.coins + Number(this.coin.value.text) * this.multiplier * this.permy.getCoinMulti();   
						this.coinField.text = this.coins.toString();
						this.permy.setTotalCoins(this.permy.getTotalCoins() + Number(this.coin.value.text) * this.multiplier * this.permy.getCoinMulti());
						this.missionHandler.setCoinsRound(this.missionHandler.getCoinsRound() + Number(this.coin.value.text) * this.multiplier * this.permy.getCoinMulti());
						this.missionHandler.setCoinsSinceMission(this.missionHandler.getCoinsSinceMission() + Number(this.coin.value.text) * this.multiplier * this.permy.getCoinMulti());
						this.totalCoinsField.text = this.permy.getTotalCoins().toString();
						this.coin.removeEventListener(Event.ENTER_FRAME,listenForHit);
						this.spawn(coin);
					}
				}
			}
		}
		
		public function listenForHit2(event:Event) {
			if(!this.paused) {
				if(this.coin2.hitTestObject(this.hay)) {
					if(this.coin2.perfectHitTest(this.hay,1)) {
						this.coins = this.coins + Number(this.coin2.value.text) * this.multiplier * this.permy.getCoinMulti();   
						this.coinField.text = this.coins.toString();
						this.permy.setTotalCoins(this.permy.getTotalCoins() + Number(this.coin2.value.text) * this.multiplier * this.permy.getCoinMulti());
						this.missionHandler.setCoinsRound(this.missionHandler.getCoinsRound() + Number(this.coin2.value.text) * this.multiplier * this.permy.getCoinMulti());
						this.missionHandler.setCoinsSinceMission(this.missionHandler.getCoinsSinceMission() + Number(this.coin2.value.text) * this.multiplier * this.permy.getCoinMulti());
						this.totalCoinsField.text = this.permy.getTotalCoins().toString();
						this.coin.removeEventListener(Event.ENTER_FRAME,listenForHit2);
						this.spawn(coin2);
					}
				}
			}
		}

	}
	
}
