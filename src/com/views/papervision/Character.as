package com.views.papervision
{
	import caurina.transitions.Tweener;
	
	import com.constants.Constants;
	import com.constants.Embeds;
	import com.controllers.ApplicationController;
	import com.controllers.AudioController;
	import com.models.FriendModel;
	import com.models.Model;
	
	import flash.display.Bitmap;
	import flash.utils.ByteArray;
	
	import org.papervision3d.materials.BitmapFileMaterial;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.materials.special.Letter3DMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.parsers.DAE;
	import org.papervision3d.typography.Text3D;
	import org.papervision3d.typography.fonts.HelveticaMedium;
	import mx.binding.utils.BindingUtils;
	
	public class Character extends DAE
	{
		
		[Bindable]
		public var friendModel:FriendModel;
		
		private var direction:int = Constants.MOVE_UP;
		
		private var materialList:MaterialsList;
		
		private var text:Text3D
		
		public function Character(modelTypeId:int, friendModel:FriendModel=null)
		{
			super();
			
			this.friendModel = friendModel;
			var modelClass:Class = Embeds.MODEL_CHAR_1;
			var byteArray:ByteArray = new modelClass() as ByteArray;
			this.load(byteArray);
			
			var model:Model = Model.getInstance();
			
			materialList = new MaterialsList();
			BindingUtils.bindSetter(updateMask, this, "friendModel");
	            
            var textureClass:Class = Embeds.getModelTexture(modelTypeId, Constants.MODEL_TEXTURE_BODY);
            var bitmap:Bitmap = new textureClass();
            var material:BitmapMaterial = new BitmapMaterial(bitmap.bitmapData);
            materialList.addMaterial(material, "body_texture");
            
            textureClass = Embeds.getModelTexture(modelTypeId, Constants.MODEL_TEXTURE_EAR);
            bitmap = new textureClass();
            material = new BitmapMaterial(bitmap.bitmapData);
            materialList.addMaterial(material, "ear_texture");
            
            textureClass = Embeds.getModelTexture(modelTypeId, Constants.MODEL_TEXTURE_HEAD);
            bitmap = new textureClass();
            material = new BitmapMaterial(bitmap.bitmapData);
            materialList.addMaterial(material, "head_texture");
            
            textureClass = Embeds.getModelTexture(modelTypeId, Constants.MODEL_TEXTURE_HAIR);;
            bitmap = new textureClass();
            material = new BitmapMaterial(bitmap.bitmapData);
            materialList.addMaterial(material, "hair_texture");
            
            textureClass = Embeds.getModelTexture(modelTypeId, Constants.MODEL_TEXTURE_GLOVE);;
            bitmap = new textureClass();
            material = new BitmapMaterial(bitmap.bitmapData);
            materialList.addMaterial(material, "glove_texture");
            
            textureClass = Embeds.getModelTexture(modelTypeId, Constants.MODEL_TEXTURE_FEET);;
            bitmap = new textureClass();
            material = new BitmapMaterial(bitmap.bitmapData);
            materialList.addMaterial(material, "feet_texture");
            
            var letterMat:Letter3DMaterial = new Letter3DMaterial(0x888888, 1);
     		letterMat.doubleSided = true;
      		letterMat.interactive = true;
     		text = new Text3D(friendModel.name, new HelveticaMedium(), letterMat);
     		text.scale = 0.01;
     		text.rotationY = 180;
     		text.y = 10;
            this.addChild(text);
            
            this.materials = materialList;
            this.pitch(35); 
            this.scale = 35;
            this.rotationX = 0;
            this.y = -50;
            this.x = Math.random() * 2000 - 1000;
            this.z = Math.random() * 2000 - 1000;
            this.stop();
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
					this.rotationY = 180;
					text.rotationY = 0;
					break;
				case Constants.MOVE_DOWN:
					z += Constants.MOVE_AMOUNT;
					this.rotationY = 0;
					text.rotationY = 180;
					break;
				case Constants.MOVE_LEFT:
					x += Constants.MOVE_AMOUNT;
					this.rotationY = 90;
					text.rotationY = 90;
					break;
				case Constants.MOVE_RIGHT:
					x -= Constants.MOVE_AMOUNT;
					this.rotationY = -90;
					text.rotationY = -90;
					break;
			}
			Tweener.removeTweens(this);
			Tweener.addTween(this, {x: x, y: y, z: z, time: 0.25, transition: 'linear', 
				onUpdate: function():void{
					ApplicationController.getInstance().collisionDetection(this);
				}
			}); 
			
			if(this.animation){
				this.animation.startTime = 0;
			}
			this.play();
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
			AudioController.getInstance().playRandomScreamSound();
		}
		
		public function randomMove():void
		{
			var random:int = Math.random() * 4;
			move(random);
			Tweener.addTween(this, {alpha: 1, time: 0.25, transition: "linear", onComplete: randomMove});
		}
		
		public function kick():void
		{
			AudioController.getInstance().playRandomHitSound();
			ApplicationController.getInstance().killEnemy();
			this.animation.startTime = 2;
			this.play();
		}
		
		public function punch():void
		{
			AudioController.getInstance().playRandomHitSound();
			ApplicationController.getInstance().killEnemy();
			this.animation.startTime = 1;
			this.play();
		}
		
		private function updateMask(friendModel:FriendModel):void
		{
			if(friendModel != null){
				var bitmapFileMaterial:BitmapFileMaterial = new BitmapFileMaterial(friendModel.picture);
				bitmapFileMaterial.doubleSided = false;
				bitmapFileMaterial.smooth = true;
		        materialList.addMaterial(bitmapFileMaterial, "mask_texture");
			}
		}

	}
}