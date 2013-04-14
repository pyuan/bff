package com.models
{
	[Bindable]
	public class FriendModel
	{
		
		public var id:int = -1;
		public var name:String = "";
		public var wallCount:int = -1;
		public var picture:String = "";
		public var networks:Array = [];
		public var url:String = "";
		
		//keeps track how many times you ebat up this friend
		public var beatCount:int = 0;
		
		public function FriendModel(id:int, name:String="", wallCount:int=-1, picture:String="", networks:Array=null, url:String="")
		{
			this.id = id;
			this.name = name;
			this.wallCount = wallCount;
			this.picture = picture;
			this.url = url;
			
			if(networks != null){
				this.networks = networks;
			}
		}
		
		public function plusBeatCount():void{
			this.beatCount++;
		}

	}
}