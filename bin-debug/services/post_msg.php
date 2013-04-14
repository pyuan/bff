<?php

$message = 'Watch this video!';
$attachment =  array(
      'name' => 'ninja cat',
      'href' => 'http://www.youtube.com/watch?v=muLIPWjks_M',
      'caption' => '{*actor*} uploaded a video to www.youtube.com',
      'description' => 'a sneaky cat',
      'properties' => array('category' => array(
                            'text' => 'pets',
                            'href' => 'http://www.youtube.com/browse?s=mp&t=t&c=15'),
                            'ratings' => '5 stars'),
      'media' => array(array('type' => 'flash',
                             'swfsrc' => 'http://www.youtube.com/v/fzzjgBAaWZw&hl=en&fs=1',
                             'imgsrc' => 'http://img.youtube.com/vi/muLIPWjks_M/default.jpg?h=100&w=200&sigh=__wsYqEz4uZUOvBIb8g-wljxpfc3Q=',
                             'width' => '100', 
                             'height' => '80', 
                             'expanded_width' => '160', 
                             'expanded_height' => '120')));
$action_links = array(
                      array('text' => 'Upload a video',
                            'href' => 'http://www.youtube.com/my_videos_upload'));
$target_id = 2342314;
$facebook->api_client->stream_publish($message, $attachment, $action_links, $target_id);

?>