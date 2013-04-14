package com.views.ui
{
	import com.constants.Embeds;
	import com.controllers.AudioController;
	
	import flash.events.MouseEvent;
	
	import mx.binding.utils.BindingUtils;
	
	public class AudioButton extends GenericButton
	{
		public function AudioButton()
		{
			super();
			this.setStyle('paddingTop', 5);
			this.setStyle('paddingBottom', 5);
			this.setStyle('paddingLeft', 5);
			this.setStyle('paddingRight', 5);
			BindingUtils.bindSetter(setIcon, AudioController.getInstance(), "isMute");
		}
		
		private function setIcon(isMute:Boolean):void
		{
			if(isMute){
				this.setStyle('icon', Embeds.ICON_MUSIC_OFF);
			}
			else{
				this.setStyle('icon', Embeds.ICON_MUSIC_ON);
			}
		}
		
		override protected function clickHandler(event:MouseEvent):void
		{
			AudioController.getInstance().toggleMute(2);
		}
		
	}
}