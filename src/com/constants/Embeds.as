package com.constants
{
	public class Embeds
	{
		/**** Images ***/
		[Embed(source="assets/images/countmarks/1.png")]
        [Bindable]
        public static var COUNT1:Class;  
        
        [Embed(source="assets/images/countmarks/2.png")]
        [Bindable]
        public static var COUNT2:Class;
        
        [Embed(source="assets/images/countmarks/3.png")]
        [Bindable]
        public static var COUNT3:Class;
        
        [Embed(source="assets/images/countmarks/4.png")]
        [Bindable]
        public static var COUNT4:Class;
        
        [Embed(source="assets/images/countmarks/5.png")]
        [Bindable]
        public static var COUNT5:Class;
        
        [Embed(source="assets/images/screen_credits.png")]
        [Bindable]
        public static var SCREEN_CREDITS:Class;
        
        [Embed(source="assets/images/screen_instructions.png")]
        [Bindable]
        public static var SCREEN_INSTRUCTIONS:Class;
        
        [Embed(source="assets/images/bg_selection.png")]
        [Bindable]
        public static var BG_SELECTION:Class;
        
        [Embed(source="assets/images/logo.png")]
        [Bindable]
        public static var LOGO:Class;
        
        [Embed(source="assets/images/logo_reflect.png")]
        [Bindable]
        public static var LOGO_REFLECT:Class;
        
        [Embed(source="assets/images/icon_music_off.png")]
        [Bindable]
        public static var ICON_MUSIC_OFF:Class;
        
        [Embed(source="assets/images/icon_music_on.png")]
        [Bindable]
        public static var ICON_MUSIC_ON:Class;
        
        [Embed(source="assets/images/environment/env1_floor.jpg")]
        [Bindable]
        public static var ENVIRONMENT1_FLOOR:Class;
        
        [Embed(source="assets/images/environment/env1_wall.jpg")]
        [Bindable]
        public static var ENVIRONMENT1_WALL:Class;
        
        [Embed(source="assets/images/environment/env2_floor.jpg")]
        [Bindable]
        public static var ENVIRONMENT2_FLOOR:Class;
        
        [Embed(source="assets/images/environment/env2_wall.jpg")]
        [Bindable]
        public static var ENVIRONMENT2_WALL:Class;
        
        [Embed(source="assets/images/environment/env3_floor.jpg")]
        [Bindable]
        public static var ENVIRONMENT3_FLOOR:Class;
        
        [Embed(source="assets/images/environment/env3_wall.jpg")]
        [Bindable]
        public static var ENVIRONMENT3_WALL:Class;
        
        [Embed(source="assets/3dmodels/textures/ear_1.jpg")]
        [Bindable]
        public static var TEXTURE_EAR_1:Class;
        
        [Embed(source="assets/3dmodels/textures/head_1.jpg")]
        [Bindable]
        public static var TEXTURE_HEAD_1:Class;
        
        [Embed(source="assets/3dmodels/textures/head_2.jpg")]
        [Bindable]
        public static var TEXTURE_HEAD_2:Class;
        
        [Embed(source="assets/3dmodels/textures/shirt_1.jpg")]
        [Bindable]
        public static var TEXTURE_SHIRT_1:Class;
        
        [Embed(source="assets/3dmodels/textures/shirt_2.jpg")]
        [Bindable]
        public static var TEXTURE_SHIRT_2:Class;
        
        [Embed(source="assets/3dmodels/textures/shirt_3.jpg")]
        [Bindable]
        public static var TEXTURE_SHIRT_3:Class;
        
        [Embed(source="assets/3dmodels/textures/feet_1.gif")]
        [Bindable]
        public static var TEXTURE_FEET_1:Class;
        
        [Embed(source="assets/3dmodels/textures/glove_1.jpg")]
        [Bindable]
        public static var TEXTURE_GLOVE_1:Class;
        
        [Embed(source="assets/3dmodels/textures/glove_3.gif")]
        [Bindable]
        public static var TEXTURE_GLOVE_3:Class;
        
        [Embed(source="assets/3dmodels/textures/hair_1.gif")]
        [Bindable]
        public static var TEXTURE_HAIR_1:Class;
        
        [Embed(source="assets/3dmodels/textures/hair_2.gif")]
        [Bindable]
        public static var TEXTURE_HAIR_2:Class;
        
        [Embed(source="assets/3dmodels/textures/hair_3.gif")]
        [Bindable]
        public static var TEXTURE_HAIR_3:Class;
        
        [Embed(source="assets/3dmodels/char_1.dae", mimeType = "application/octet-stream")]
		public static var MODEL_CHAR_1:Class;
		
		[Embed('assets/audio/sfx/hit_1.mp3', mimeType="audio/mpeg")]
        public static var SFX_HIT_1:Class;
        
        [Embed('assets/audio/sfx/hit_2.mp3', mimeType="audio/mpeg")]
        public static var SFX_HIT_2:Class;
        
        [Embed('assets/audio/sfx/scream_1.mp3', mimeType="audio/mpeg")]
        public static var SFX_SCREAM_1:Class;
        
        [Embed('assets/audio/sfx/scream_2.mp3', mimeType="audio/mpeg")]
        public static var SFX_SCREAM_2:Class;
        
        [Embed('assets/audio/sfx/scream_3.mp3', mimeType="audio/mpeg")]
        public static var SFX_SCREAM_3:Class;
        
        [Embed('assets/audio/sfx/scream_4.mp3', mimeType="audio/mpeg")]
        public static var SFX_SCREAM_4:Class;
        
        /**
        * retrieve a embedded environment texture
        */
        public static function getEnvironmentTexture(environmentId:int, type:String):Class
        {
        	var texture:Class = null;
        	switch(environmentId){
        		case 0:
        			if(type == Constants.ENVIRONMENT_TEXTURE_TYPE_FLOOR){
        				texture = ENVIRONMENT1_FLOOR;
        			}
        			else{
        				texture = ENVIRONMENT1_WALL;
        			}
        			break;
        		case 1:
        			if(type == Constants.ENVIRONMENT_TEXTURE_TYPE_FLOOR){
        				texture = ENVIRONMENT2_FLOOR;
        			}
        			else{
        				texture = ENVIRONMENT2_WALL;
        			}
        			break;
        		case 2:
        			if(type == Constants.ENVIRONMENT_TEXTURE_TYPE_FLOOR){
        				texture = ENVIRONMENT3_FLOOR;
        			}
        			else{
        				texture = ENVIRONMENT3_WALL;
        			}
        			break;
        	}
        	return texture;
        }
        
        /**
        * retrieve a shirt texture for a model
        */
        public static function getModelTexture(modelId:int, type:int):Class
        {
        	var texture:Class = null;
        	switch(type){
        		case Constants.MODEL_TEXTURE_BODY:
        			if(modelId == 0){
        				texture = TEXTURE_SHIRT_1;
        			}
        			else if(modelId == 1){
        				texture = TEXTURE_SHIRT_2;
        			}
        			else if(modelId == 2){
        				texture = TEXTURE_SHIRT_3;
        			}
        			break;
        		case Constants.MODEL_TEXTURE_EAR:
        			texture = TEXTURE_EAR_1;
        			break;
        		case Constants.MODEL_TEXTURE_FEET:
        			texture = TEXTURE_FEET_1;
        			break;
        		case Constants.MODEL_TEXTURE_GLOVE:
        			if(modelId == 0){
        				texture = TEXTURE_GLOVE_1;
        			}
        			else if(modelId == 1){
        				texture = TEXTURE_GLOVE_1;
        			}
        			else if(modelId == 2){
        				texture = TEXTURE_GLOVE_3;
        			}
        			break;
        		case Constants.MODEL_TEXTURE_HAIR:
        			if(modelId == 0){
        				texture = TEXTURE_HAIR_1;
        			}
        			else if(modelId == 1){
        				texture = TEXTURE_HAIR_2;
        			}
        			else if(modelId == 2){
        				texture = TEXTURE_HAIR_3;
        			}
        			break;
        		case Constants.MODEL_TEXTURE_HEAD:
        			if(modelId == 0){
        				texture = TEXTURE_HEAD_1;
        			}
        			else if(modelId == 1){
        				texture = TEXTURE_HEAD_2;
        			}
        			else if(modelId == 2){
        				texture = TEXTURE_HEAD_1;
        			}
        			break;
        	}
        	return texture;
        }
        
	}
}