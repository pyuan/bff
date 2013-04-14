package com.views.papervision
{
	import caurina.transitions.Tweener;
	
	import com.constants.Constants;
	import com.controllers.ApplicationController;
	import com.models.FriendModel;
	
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.primitives.Cube;
	
	public class CubeCharacter extends Cube
	{
		
		private var friendModel:FriendModel;
		
		private var direction:int = Constants.MOVE_UP;
		
		public function CubeCharacter(materials:MaterialsList, width:int, depth:int, height:int)
		{
			super(materials, width, depth, height);
		}
		
		public function move(dir:int):void
		{
			this.direction = dir;
			var x:int = this.x;
			var y:int = this.y;
			var z:int = this.z;
			
			switch(dir){
				case Constants.MOVE_UP:
					z -= Constants.MOVE_AMOUNT;
					break;
				case Constants.MOVE_DOWN:
					z += Constants.MOVE_AMOUNT;
					break;
				case Constants.MOVE_LEFT:
					x += Constants.MOVE_AMOUNT;
					break;
				case Constants.MOVE_RIGHT:
					x -= Constants.MOVE_AMOUNT;
					break;
			}
			Tweener.addTween(this, {x: x, y: y, z: z, time: 0.25, transition: 'linear', 
				onUpdate: function():void{
					ApplicationController.getInstance().collisionDetection(this);
				}
			});
		}
		
		public function receiveHit():void
		{
			Tweener.removeTweens(this);
			var x:int = this.x;
			var z:int = this.z;
			
			switch(direction){
				case Constants.MOVE_UP:
					z += Constants.MOVE_AMOUNT;
					break;
				case Constants.MOVE_DOWN:
					z -= Constants.MOVE_AMOUNT;
					break;
				case Constants.MOVE_LEFT:
					x -= Constants.MOVE_AMOUNT;
					break;
				case Constants.MOVE_RIGHT:
					x += Constants.MOVE_AMOUNT;
					break;
			}
			
			Tweener.addTween(this, {x: x, z: z, time: 1, transition: "easeOutBounce"});
		}

	}
}