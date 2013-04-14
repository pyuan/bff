<?php

ob_start();
require_once 'services/getFriends_multi.php';

?>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
        <title>BFF (Beat Friends Forever)</title>
		<link rel="stylesheet" title="default" type="text/css" href="assets/css/web.css"/>
		<link rel="shortcut icon" href="assets/images/favicon.ico" />
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
		<script type="text/javascript" src="js/main.js"></script>
    </head>
    <body>
		
		<div id="swfContainer">
			<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
				id="game" width="100%" height="100%"
				codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab">
				<param name="movie" value="BFF.swf" />
				<param name="quality" value="high" />
				<param name="bgcolor" value="#000000" />
				<param name="wmode" value="transparent" />
				<param name="allowScriptAccess" value="sameDomain" />
				<embed src="BFF.swf" quality="high" bgcolor="#000000"
					width="100%" height="100%" name="game" align="middle"
					play="true"
					loop="false"
					quality="high"
					allowScriptAccess="sameDomain"
					wmode="transparent"
					type="application/x-shockwave-flash"
					pluginspage="http://www.adobe.com/go/getflashplayer">
				</embed>
			</object>
		</div>
		
    </body>
</html>

<?php ob_flush(); ?>