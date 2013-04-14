$(function(){

});

function getFriendsXML()
{
	var xml = $('#xml').html();
	setFriends(xml);
}

function setFriends(data)
{
	try{
		getAppReferenceById("game").setFriends(data);
	} catch(e){}
}

//returns the DOM reference of swf object on the page
function getAppReferenceById(id) 
{
	if(navigator.appName.indexOf("Microsoft") != -1){
		return window[id];
	} 
	else{
		return document[id];
	}
}