package com.views.ui
{
	import com.constants.Constants;
	import com.controllers.AudioController;
	
	import flash.events.MouseEvent;
	
	import mx.controls.Button;
	
	public class GenericButton extends Button
	{
		public function GenericButton()
		{
			super();
			this.styleName = "genericButton";
		}
		
		override protected function commitProperties():void
		{
			var newLabel:String = this.label.toString().toUpperCase();
			textField.text = newLabel;
			
			if(this.enabled){
				this.buttonMode = true;
			}
			else{
				this.buttonMode = false;
			}
		} 
		
		override protected function clickHandler(event:MouseEvent):void
		{
			super.clickHandler(event);
			AudioController.getInstance().playRandomHitSound();
		}

	}
}