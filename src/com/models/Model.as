package com.models
{
	import com.controllers.ApplicationController;
	import com.views.papervision.Character;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class Model
	{
		
		//stores the user's own friend model
		private var friendModel:FriendModel;
		
		//stores all friends
		private var friends:ArrayCollection = new ArrayCollection();
		
		//stores selected character
		public var selectedCharacter:int = 0;
		
		//stores selected environment
		public var selectedEnvironment:int = 0;
		
		//stores your crew
		public var crew:ArrayCollection = new ArrayCollection();
		
		//flags if game is paused
		public var gameIsPaused:Boolean = false;
		
		//keeps track of time passed in game
		public var time:int = 0;
		
		//keeps track of the number of beat downs
		public var beats:int = 0;
		
		//keeps ref to my model
		public var myCharacter:Character;
		
		//stores all enemies in scene
		public var enemies:ArrayCollection = new ArrayCollection();
		
		//stores all loaded 3D dae models
		public var characterTemplates:ArrayCollection = new ArrayCollection();
		
		public var isDefending:Boolean = false;
		
		public function Model(){
			
		}
		
		public function getFriends():ArrayCollection{
			return this.friends;
		}
		
		public function addFriend(friendModel:FriendModel):void{
			this.friends.addItem(friendModel);
		}
		
		public function removeFriend(friendModel:FriendModel):void{
			for(var i:int=0; i<friends.length; i++){
				var friend:FriendModel = friends.getItemAt(i) as FriendModel;
				if(friend.id == friendModel.id){
					friends.removeItemAt(i);
					break;
				}
			}
		}
		
		public function removeAllFriends():void{
			this.friends.removeAll();
		}
		
		public function getFriendModel():FriendModel{
			return this.friendModel;
		}
		
		public function setFriendModel(friendModel:FriendModel):void{
			this.friendModel = friendModel;
		}
		
		public static function getInstance():Model{
			return ApplicationController.getInstance().model;
		}

	}
}