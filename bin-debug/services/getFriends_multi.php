<?php

require_once 'xd_receiver.htm';
require_once 'facebook/facebook.php';

$appapikey = '0e3860b4b3ada16eeea3b35e9ca75c15';
$appsecret = '30458bc7911ce686e8f935ff63c03190';
$facebook = new Facebook($appapikey, $appsecret);
$user_id = $facebook->require_login();

$xml = "<?xml version='1.0' encoding='utf-8'?>";
$xml .= "<friends>";
$friends = $facebook->api_client->friends_get();
$friends[] = $user_id; //add my own data

//construct fql query
$queries = array();
foreach ($friends as $friend) 
{
	$queries["$friend"] = "SELECT affiliations, name, wall_count, pic_big, profile_url FROM user where uid = $friend";
}
$responses = $facebook->api_client->fql_multiquery($queries);

//parse response into xml
foreach ($responses as $response)
{
	$result = $response["fql_result_set"];
	$id = (string) $response["name"];
	if(isset($result[0])){
		$affiliations = $result[0]['affiliations'];
		$name = $result[0]['name'];
		$count = $result[0]['wall_count'];
		$pic = $result[0]['pic_big'];
		$profile = $result[0]['profile_url'];
		
		$networks = "";
		if(count($affiliations) > 1){
			foreach ($affiliations as $key => $value) {
				$networks .= $value['name'] . ",";
			}
		}
				
		$node = $id === (string)$user_id ? "<me>" : "<friend>";
		$node .= "<id>$friend</id>";
		$node .= "<name>$name</name>";
		$node .= "<count>$count</count>";
		$node .= "<pic>$pic</pic>";
		$node .= "<networks>$networks</networks>";
		$node .= "<url>$profile</url>";
		$node .= $id === (string)$user_id ? "</me>" : "</friend>";
		
		//filter out bad data
		if($count > 0 && $pic != ""){
			$xml .= $node;
		}
	}
}

$xml .= "</friends>";
echo "<div id='xml' style='display: none;'>$xml</div>"; //store xml into an invisible div

?>






