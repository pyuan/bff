package com.views.ui
{
	import com.controllers.ApplicationController;
	import com.models.FriendModel;
	
	import flash.events.MouseEvent;
	import flash.system.LoaderContext;
	
	import mx.controls.Image;
	import mx.binding.utils.BindingUtils;
	
	public class ProfilePic extends Image
	{
		
		[Bindable]
		public var friend:FriendModel;
		
		public function ProfilePic()
		{
			super();
			BindingUtils.bindSetter(onChange, this, "friend");
		}
		
		private function onChange(friendModel:FriendModel):void
		{
			if(friendModel != null){
				var loaderContext:LoaderContext = new LoaderContext(true);
				this.loaderContext = loaderContext;
				this.source = friend.picture;
				this.width = this.height = 50;
				this.maintainAspectRatio = false;
				this.smoothBitmapContent = true;
				this.addEventListener(MouseEvent.CLICK, function():void{
					ApplicationController.getInstance().showWebPage(friend.url);
				});
				this.buttonMode = true;
				this.toolTip = friend.name;
			}
		}

	}
}