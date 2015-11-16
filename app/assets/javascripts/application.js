// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require local_time
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require jquery-readyselector
//= require bootstrap-datepicker
//= require_tree .
//= require ckeditor/init
//= require underscore

var subtitle_delay_time = 300;
var subtitle_slideDown_time = 1500;

function toggleElements(elements) {
  	var arrayLength = elements.length;
  	var i = 0;
	while (i < arrayLength) {
	    var el = document.getElementById(elements[i]);
	    if (el.style.display != 'none') {
	    	el.style.display = 'none';
	    } else {
	    	el.style.display = '';
	    }
	    i++;
	}
}