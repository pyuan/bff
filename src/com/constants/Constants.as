package com.constants
{
	public class Constants
	{
		
		/**** Application Constants ****/
		public static const DIR_SOUND_SFX : String = "assets/audio/sfx/";
		public static const DIR_SOUND_BACKGROUNDS : String = "assets/audio/backgrounds/";
		private static const SERVICE_GETDIR : String = "services/getDirectory.php?dir=";
		public static const SERVICE_GETDIR_SOUND_BACKGROUNDS : String = SERVICE_GETDIR + "/audio/backgrounds";
		public static const NUM_LEADERBOARD_FRIENDS : int = 25;
		public static const NUM_LEADERBOARD_MAX_MARK_COUNT : int = 15;
		public static const NUM_CREW : int = 2;
		public static const NUM_ENEMIES : int = 3;
		public static const NUM_MODEL_TYPES : int = 3;
		
		/**** Game Constants ****/
		public static const GAME_NUM_SECONDS : int = 60 * 1.5; //in seconds
		public static const GAME_TIME_KILL_GAIN : int = 5; //in seconds
		
		/**** 3D Constants ****/
		public static const ENVIRONMENT_TEXTURE_TYPE_WALL : String = "wall";
		public static const ENVIRONMENT_TEXTURE_TYPE_FLOOR : String = "floor";
		public static const ENVIRONMENT_POS_MAX : int = 1000;
		public static const ENVIRONMENT_POS_MIN : int = -1000;
		public static const MOVE_UP : int = 0;
		public static const MOVE_RIGHT : int = 1;
		public static const MOVE_DOWN : int = 2;
		public static const MOVE_LEFT : int = 3;
		public static const MOVE_AMOUNT : int = 100;
		
		public static const MODEL_TEXTURE_BODY : int = 0;
		public static const MODEL_TEXTURE_HEAD : int = 1;
		public static const MODEL_TEXTURE_HAIR : int = 2;
		public static const MODEL_TEXTURE_GLOVE : int = 3;
		public static const MODEL_TEXTURE_FEET : int = 4;
		public static const MODEL_TEXTURE_EAR : int = 5;
		
		public static const COLLISION_TOLERANCE : int = 100;
		
		/**** Javascript Constants ****/
		public static const JAVASCRIPT_FUNCTION_GETFRIENDS : String = "getFriendsXML";
		public static const JAVASCRIPT_FUNCTION_SETFRIENDS : String = "setFriends";
		
		/**** Screen Constants ****/
		public static const SCREEN_NAME_HOME : String = "home";
		public static const SCREEN_NAME_INSTRUCTIONS : String = "instructions";
		public static const SCREEN_NAME_CREDITS : String = "credits";
		public static const SCREEN_NAME_LEADERBOARD : String = "leaderboard";
		public static const SCREEN_NAME_PLAY : String = "play";
		public static const SCREEN_NAME_GAME : String = "game";
		public static const SCREEN_NAME_CHARACTER : String = "character";
		public static const SCREEN_NAME_ARENA: String = "arena";
		public static const SCREEN_NAME_CREW : String = "crew";
		
		/**** Sound Constants ****/
		public static const AUDIO_BACKGROUND_INTRO : String = DIR_SOUND_SFX + "selection_theme.mp3";
		public static const AUDIO_SFX_BUTTON : String = DIR_SOUND_SFX + "hit_2.mp3";
		public static const AUDIO_SFX_LOSE : String = DIR_SOUND_SFX + "game_over.mp3";
		public static const AUDIO_BACKGROUND_ID_INTRO : int = 0;
		public static const AUDIO_HIT_SOUNDS : Array = ["hit_1.mp3", "hit_2.mp3", "hit_3.mp3", "hit_4.mp3"];
		public static const AUDIO_SCREAM_SOUNDS : Array = ["scream_1.mp3", "scream_2.mp3", "scream_3.mp3", "scream_4.mp3"];
		
		/**** Footer Constants ****/
		public static const STATUS_LINK : String = "http://www.bff.maxvisualstudios.com";
		public static const STATUS_MSG : String = "Hey beat up your friends at http://www.bgg.maxvisualstudios.com!";
		public static const FOOTER_TWITTER : int = 0;
		public static const FOOTER_FACEBOOK : int = 1;
		public static const FOOTER_MYSPACE : int = 2;
		public static const FOOTER_LINKEDIN : int = 3;
		public static const FOOTER_DELICIOUS : int = 4;
		public static const FOOTER_DIGG : int = 5;
		
		/**** Color Constants ****/
		public static const COLOR_GREEN : uint = 0xa5e070;
		public static const COLOR_BLUE : uint = 0x1b314c;
		public static const COLOR_RED : uint = 0x912828;
		public static const COLOR_LIGHT_BLUE : uint = 0x2f588a;
		
	}
}