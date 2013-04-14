package com.views.papervision
{
    import caurina.transitions.Tweener;
    
    import com.constants.Constants;
    import com.constants.Embeds;
    import com.models.Model;
    import com.controllers.ApplicationController;
    
    import flash.display.Bitmap;
    
    import org.papervision3d.lights.PointLight3D;
    import org.papervision3d.materials.BitmapMaterial;
    import org.papervision3d.materials.WireframeMaterial;
    import org.papervision3d.materials.shadematerials.FlatShadeMaterial;
    import org.papervision3d.materials.utils.MaterialsList;
    import org.papervision3d.objects.primitives.Plane;
    import org.papervision3d.view.BasicView;
    
    import mx.binding.utils.BindingUtils;
   
    public class Environment extends BasicView
    {
        private var me:Character;
        
        private var floor:Plane;
        private var wallFront:Plane;
        private var wallBack:Plane;
        private var wallRight:Plane;
        private var wallLeft:Plane;
       
        public function Environment():void
        {
            super();
            init();
        }
        
        protected function init():void
        {
            createChildren();
            startRendering();
            ApplicationController.getInstance().setEnvironment(this);
        }
        
        protected function createChildren():void
        {
        	var model:Model = Model.getInstance();
        	var floorBitmap:Class = Embeds.getEnvironmentTexture(model.selectedEnvironment, 
        		Constants.ENVIRONMENT_TEXTURE_TYPE_FLOOR);
        	var wallBitmap:Class = Embeds.getEnvironmentTexture(model.selectedEnvironment, 
        		Constants.ENVIRONMENT_TEXTURE_TYPE_WALL);
            
            //create floor
            var bitmap:Bitmap = new floorBitmap() as Bitmap;
			var material:BitmapMaterial = new BitmapMaterial(bitmap.bitmapData);
			material.tiled = true;
			material.maxU = 2000/bitmap.width;
			material.maxV = 2000/bitmap.height;
			material.smooth;
			
			floor = new Plane(material, 2000, 2000, 10, 10);
			floor.material.doubleSided = true;
            floor.pitch(90); 
            floor.y = -50;
            scene.addChild(floor);
            
            //create front wall
            bitmap = new wallBitmap() as Bitmap;
			material = new BitmapMaterial(bitmap.bitmapData);
			material.tiled = true;
			material.maxU = 2000/bitmap.height;
			/* material.maxV = 2000/bitmap.width/4; */
			material.smooth;
			
			wallFront = new Plane(material, bitmap.width, 2000, 10, 10);
			wallFront.material.doubleSided = true;
            wallFront.pitch(90); 
            wallFront.z = -1000;
            wallFront.rotationZ = 90;
            scene.addChild(wallFront);
            
            //create back wall
			wallBack = new Plane(material, bitmap.width, 2000, 10, 10);
			wallBack.material.doubleSided = true;
            wallBack.pitch(90); 
            wallBack.z = 1000;
            wallBack.rotationZ = 90;
            scene.addChild(wallBack);
            
            //create left wall
            wallLeft = new Plane(material, bitmap.width, 2000, 10, 10);
			wallLeft.material.doubleSided = true;
            wallLeft.pitch(90); 
            wallLeft.x = 1000;
            wallLeft.rotationZ = 90;
            wallLeft.rotationX = 90;
            scene.addChild(wallLeft);
            
            //create right wall
            wallRight = new Plane(material, bitmap.width, 2000, 10, 10);
			wallRight.material.doubleSided = true;
            wallRight.pitch(90); 
            wallRight.x = -1000;
            wallRight.rotationZ = 90;
            wallRight.rotationX = 90;
            scene.addChild(wallRight);
           
            //Create 3D Objects
            me = new Character(model.selectedCharacter, model.getFriendModel());
            
            //set intial camera
            var zoomOut:int = 2500;
            var zoomIn:int = 750;
            camera.x = zoomOut;
            camera.z = zoomOut*2;
            camera.y = zoomOut*3;
            Tweener.addTween(camera, {x: 0, z: zoomIn, y: zoomIn, time: 2, transition: 'easeOutQuad'});
            camera.lookAt(me);
            
            moveCamera();
        }
        
        /**
        * move the camera to follow the user
        */
        public function moveCamera():void
        {
        	var x:Number = me.x + 500;
        	var y:Number = me.y + 500;
        	var z:Number = me.z + 500;
        	if(z < 500){
        		z = 500;
        	}
        	else if(z > 1250){
        		z = 1250;
        	}
        	
            Tweener.addTween(camera, {x: 0, z: z, y: y, time: 2, transition: 'easeOutQuad'});
            camera.lookAt(me);
        }
        
    }
}