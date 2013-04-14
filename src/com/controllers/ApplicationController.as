package com.controllers
{
	import caurina.transitions.Tweener;
	
	import com.constants.Constants;
	import com.models.FriendModel;
	import com.models.Model;
	import com.utils.StringUtil;
	import com.views.papervision.Character;
	import com.views.papervision.Environment;
	import com.views.screens.Play;
	
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	import mx.collections.Sort;
	import mx.collections.SortField;
	import mx.core.Container;
	
	public class ApplicationController
	{
		
		private static var instance:ApplicationController = null;
		
		public function ApplicationController(){}
		
		public static function getInstance():ApplicationController {
			if(instance == null) {
				instance = new ApplicationController();
			}
			return instance;
		}
		
		[Bindable]
		public var model:Model;
		
		private var app:BFF;
		
		//public so pause button can use it to change label
		public var gameTimer:Timer;
		
		private var environment:Environment;
		
		public function init(app:BFF):void
		{
			this.app = app;
			model = new Model();
			AudioController.getInstance().init();
			ExternalInterface.addCallback(Constants.JAVASCRIPT_FUNCTION_SETFRIENDS, setFriends);
			callJavascriptFunction(Constants.JAVASCRIPT_FUNCTION_GETFRIENDS);
		}
		
		/**
		 * load the facebook data from DOM
		 */
		private function setFriends(data:String):void
		{
			var xml:XML = new XML(data);
			
			//set user's friend model
			var id:int = xml.me.id;
			var name:String = xml.me.name;
			var wallCount:int = xml.me.count;
			var picture:String = xml.me.pic;
			var networks:Array = StringUtil.getNetworks(xml.me.networks);
			var url:String = xml.me.url;
			var friendModel:FriendModel = new FriendModel(id, name, wallCount, picture, networks);
			model.setFriendModel(friendModel);
			
			//set up user's friends			
			for(var i:int=0; i<xml.friend.length(); i++){
				id = xml.friend[i].id;
				name = xml.friend[i].name;
				wallCount = xml.friend[i].count;
				picture = xml.friend[i].pic;
				networks = StringUtil.getNetworks(xml.friend[i].networks);
				url = xml.friend[i].url;
				friendModel = new FriendModel(id, name, wallCount, picture, networks, url);
				model.addFriend(friendModel);
			}
			
			trace("Facebook data loaded into user model, # of friends: " + model.getFriends().length);
		}
		
		/**
		 * call external javascript function
		 */
		public function callJavascriptFunction(functionName:String):void
		{
			ExternalInterface.call(functionName);
			trace("Calling javascript: " + functionName);
		}
		
		/**
		 * change screen
		 */
		public function changeView(viewId:String):void
		{
			var view:Container = app.layers.views.getChildByName(viewId) as Container;
			if(view != null){
				app.layers.views.selectedChild = view;
			}
			trace("Change view to: " + viewId);
		}
		
		/**
		 * change screen in play view
		 */
		public function changePlayView(viewId:String):void
		{
			var play:Container = app.layers.views.getChildByName(Constants.SCREEN_NAME_PLAY) as Container;
			if(play != null){
				app.layers.views.selectedChild = play;
				var view:Container = Play(play).views.getChildByName(viewId) as Container;
				if(view != null){
					Play(play).views.selectedChild = view;
				}
			}
			trace("Change lay view to: " + viewId);
		}
		
		/**
		 * sort the user's firends list in the order of beat count
		 */
		public function sortFriendsByBeatCount():void
		{
			var beatCountSortField:SortField = new SortField();
            beatCountSortField.name = "beatCount";
            beatCountSortField.numeric = true;
            beatCountSortField.descending = true;
            
            var nameSortField:SortField = new SortField();
            nameSortField.name = "name";
            nameSortField.numeric = false;
            nameSortField.descending = false;
 
            var sort:Sort = new Sort();
            sort.fields = [beatCountSortField, nameSortField];
 
            model.getFriends().sort = sort;
            model.getFriends().refresh();
            trace("Friends list sorted by beat count");
		}
		
		/**
		 * sort the user's firends list in the order of name
		 */
		public function sortFriendsByName():void
		{
            var nameSortField:SortField = new SortField();
            nameSortField.name = "name";
            nameSortField.numeric = false;
            nameSortField.descending = false;
 
            var sort:Sort = new Sort();
            sort.fields = [nameSortField];
 
            model.getFriends().sort = sort;
            model.getFriends().refresh();
            trace("Friends list sorted by name");
		}
		
		/**
		 * open a new web page
		 */
		public function showWebPage(url:String):void
		{
			var urlRequest:URLRequest = new URLRequest(url);
			navigateToURL(urlRequest, "_blank");
		}
		
		/**
		 * start game
		 */
		public function startGame():void
		{
			AudioController.getInstance().playNewBackgroundMusic();
			//reset model
			model.time = 0;
			model.beats = 0;
			
			//start timer
			gameTimer = new Timer(1000, Constants.GAME_NUM_SECONDS);
			gameTimer.addEventListener(TimerEvent.TIMER, updateTime);
			gameTimer.start();
			
			generateEnermy();
		}
		
		/**
		 * make sure there are always enermies on the screen
		 */
		private function generateEnermy():void
		{
			if(model.enemies.length < Constants.NUM_ENEMIES){
				for(var i:int = 0; i <= (Constants.NUM_ENEMIES - model.enemies.length); i++){
					var friendModel:FriendModel = getRandomFriend();
					var modelType:int = getRandomModelTypeId();
					//var enemy:Character = new Character(friendModel, modelType);
					
					var enemy:Character = model.myCharacter.clone() as Character;
					enemy.friendModel = friendModel;
					
					if(environment != null){
						model.enemies.addItem(enemy);
						environment.scene.addChild(enemy);
						enemy.randomMove();
					}
				}
			}
		}
		
		public function endGame():void
		{
			gameTimer.stop();
			environment = null;
			model.time = 0;
			model.myCharacter = null;
			model.enemies.removeAll();
			Tweener.removeAllTweens();
		}
		
		public function quitGame():void
		{
			endGame();
			changeView(Constants.SCREEN_NAME_LEADERBOARD);
			AudioController.getInstance().stopBackgroundMusic();
			AudioController.getInstance().playSfx(Constants.AUDIO_SFX_LOSE);
		}
		
		private function updateTime(e:TimerEvent):void
		{
			model.time++;
			if(model.time >= Constants.GAME_NUM_SECONDS){
				quitGame();
			}
		}
		
		public function setEnvironment(environment:Environment):void
		{
			this.environment = environment;
		}
		
		/**
		 * toggle pause
		 */
		public function togglePauseGame():void
		{
			if(gameTimer.running){
				gameTimer.stop();
				model.gameIsPaused = true;
			}
			else{
				gameTimer.start();
				model.gameIsPaused = false;
			}
		}
		
		public function attachKeyListeners():void
		{
			app.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			app.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			if(model.myCharacter != null){
				switch(e.keyCode){
					case Keyboard.UP:
						model.myCharacter.move(Constants.MOVE_UP);
						break;
					case Keyboard.DOWN:
						model.myCharacter.move(Constants.MOVE_DOWN);
						break;
					case Keyboard.LEFT:
						model.myCharacter.move(Constants.MOVE_LEFT);
						break;
					case Keyboard.RIGHT:
						model.myCharacter.move(Constants.MOVE_RIGHT);
						break;
					case 65:
						model.myCharacter.punch();
						break;
					case 83:
						model.myCharacter.kick();
						break;
					case 68:
						model.isDefending = true;
						break;
				}
				
				if(environment != null){
					environment.moveCamera();
				}
			}
		}
		
		private function onKeyUp(e:KeyboardEvent):void
		{
			model.isDefending = false;
		}
		
		public function collisionDetection(character:Character):void
		{
			//trace(character.x + "|" + character.y +"|"+ character.z);
			if(character.x >= Constants.ENVIRONMENT_POS_MAX){
				character.x = Constants.ENVIRONMENT_POS_MAX;
			}
			else if(character.x <= Constants.ENVIRONMENT_POS_MIN){
				character.x = Constants.ENVIRONMENT_POS_MIN;
			}
			
			if(character.z >= Constants.ENVIRONMENT_POS_MAX){
				character.z = Constants.ENVIRONMENT_POS_MAX;
			}
			else if(character.z <= Constants.ENVIRONMENT_POS_MIN){
				character.z = Constants.ENVIRONMENT_POS_MIN;
			}
			
			/* var allChars:ArrayCollection = new ArrayCollection();
			allChars.addAll(model.enemies);
			allChars.addItem(model.myCharacter);
			for(var i:int=0; i<allChars.length; i++){
				var char:Character = allChars.getItemAt(i) as Character;
				if(char.friendModel.id != character.friendModel.id){
					var isHit:Boolean = false;
					
					if(character.x > char.x - Constants.COLLISION_TOLERANCE &&
						character.x < char.x + Constants.COLLISION_TOLERANCE &&
						character.z > char.z - Constants.COLLISION_TOLERANCE &&
						character.z < char.z + Constants.COLLISION_TOLERANCE)
					{
						isHit = true;
					} 
					
					if(isHit){
						character.receiveHit();
						break;
					}
				}
			}  */
		}
		
		/**
		 * get a random friend from stack
		 */
		public function getRandomFriend():FriendModel
		{
			var random:int = Math.random() * model.getFriends().length;
			var friendModel:FriendModel = model.getFriends().getItemAt(random) as FriendModel;
			return friendModel;
		}
		
		/**
		 * get a random model type id
		 */
		public function getRandomModelTypeId():int
		{
			var random:int = Math.random() * Constants.NUM_MODEL_TYPES;
			return random;
		}
		
		/**
		 * kill enemy and generate a new one
		 */
		public function killEnemy():void
		{
			for(var i:int=0; i<model.enemies.length; i++){
				var enemy:Character = model.enemies.getItemAt(i) as Character;
				if(model.myCharacter.x >= enemy.x - Constants.COLLISION_TOLERANCE &&
					model.myCharacter.x <= enemy.x + Constants.COLLISION_TOLERANCE &&
					model.myCharacter.z >= enemy.z - Constants.COLLISION_TOLERANCE &&
					model.myCharacter.z <= enemy.z + Constants.COLLISION_TOLERANCE)
				{
					AudioController.getInstance().playRandomScreamSound();
					var f:FriendModel = getFriendModelByName(enemy.friendModel.name);
					f.plusBeatCount();
					model.beats++;
					model.time -= Constants.GAME_TIME_KILL_GAIN;
					model.enemies.removeItemAt(i);
					environment.scene.removeChild(enemy);
					generateEnermy();
					break;
				}
			}
		}
		
		/**
		 * retrieve a friend model
		 */
		public function getFriendModelByName(name:String):FriendModel
		{
			var friendModel:FriendModel = null;
			for(var i:int=0; i<model.getFriends().length; i++){
				var f:FriendModel = model.getFriends().getItemAt(i) as FriendModel;
				if(f.name == name){
					friendModel = f;
					break;
				}
			}
			return friendModel;
		}
		
		/**
		 * update facebook status with game status
		 */
		public function postFacebookStatus():void
		{
			var url:String = "http://www.facebook.com/sharer.php?u=" + Constants.STATUS_LINK + "&t=I just beat up " + model.beats + " of my friends.";
			navigateToURL(new URLRequest(url), '_blank');
		}

	}
}