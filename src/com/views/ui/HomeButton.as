package com.views.ui
{
	import flash.events.MouseEvent;
	import flash.filters.BevelFilter;
	import flash.filters.BitmapFilterType;
	import com.controllers.AudioController;
	import com.constants.Constants;
	
	import mx.controls.Button;
	
	public class HomeButton extends Button
	{
		
		private var isMousedOver:Boolean = false;
		
		public function HomeButton()
		{
			super();
			this.styleName = "homeButton";
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			var shadowColor:uint = 0xd44d4d;
			var hiliteColor:uint = 0xffffff;
		    if(this.enabled){
				this.buttonMode = true;
			}
			else{
				this.buttonMode = false;
				shadowColor = 0x1a1a1a;
				hiliteColor = 0xeaeaea;
			}
			
			var bevel:BevelFilter = new BevelFilter();
			bevel.type = BitmapFilterType.INNER;
			bevel.angle = 135;
			bevel.blurX = bevel.blurY = 5;
			bevel.distance = 5;
			bevel.highlightAlpha = .75;
			bevel.highlightColor = hiliteColor;
			bevel.shadowAlpha = 0.6;
			bevel.strength = 1;
			bevel.shadowColor = shadowColor;
			textField.filters = [bevel];
		}
		
		override protected function rollOverHandler(event:MouseEvent):void
		{
			super.rollOverHandler(event);
			isMousedOver = true;
		}
		
		override protected function rollOutHandler(event:MouseEvent):void
		{
			super.rollOutHandler(event);
			isMousedOver = false;
		}
		
		override protected function clickHandler(event:MouseEvent):void
		{
			super.clickHandler(event);
			isMousedOver = false;
			AudioController.getInstance().playRandomHitSound();
		}
		
	}
}