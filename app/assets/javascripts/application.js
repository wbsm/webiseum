/*
 //= require turbolinks
 //= require jquery
 //= require jquery_ujs
 //= require twitter/bootstrap
 //= require jquery/jquery.tagcloud
 //= require jstz-timezone/jstz-1.0.4.min
 //= require_tree .
*/

var timeZone = jstz.determine();
document.cookie = 'jstz_time_zone='+timeZone.name()+';';