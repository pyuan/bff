package com.utils
{
	public class StringUtil
	{
		
		/**
		 * extract networks array from a string
		 */
		public static function getNetworks(data:String):Array{
			var split:Array = data.split(",");
			var networks:Array = [];
			for(var i:int=0; i<split.length; i++){
				var n:String = split[i];
				if(n.length != 0){
					networks.push(n);
				}
			}
			return networks;
		}
		
		/**
		 * extract the first name from a full name string
		 */
		public static function getFirstName(name:String):String{
			var split:Array = name.split(" ");
			var firstname:String = "";
			if(split.length > 0){
				firstname = split[0];
			}
			return firstname;
		}
		
		/**
		 * extract the last name from a full name string
		 */
		public static function getLastName(name:String):String{
			var split:Array = name.split(" ");
			var lastName:String = "";
			if(split.length > 1){
				lastName = split[1];
			}
			return lastName;
		}
		
		/**
		 * convert seconds to time
		 */
		public static function getTime(seconds:int):String{
			var min:int = seconds>60 ? Math.floor(seconds/60) : 0;
			var sec:int = seconds>60 ? seconds-min*60 : seconds;
			var secStr:String = sec.toString();
			if(sec == 0){
				secStr = "00";
			}
			else if(sec < 10){
				secStr = "0" + sec;
			}
			return min + ":" + secStr;
		}

	}
}