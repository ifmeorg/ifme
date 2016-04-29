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
//= require ckeditor/init
//= require underscore
//= require_tree .

$(document).on("page:load ready", function() {
	$('.yes_title').find(':not(.no_title)').tooltip();


	if ($('body').hasClass('categories index') ||
		$('body').hasClass('groups index') ||
		$('body').hasClass('medications index') ||
		$('body').hasClass('moods index') ||
		$('body').hasClass('strategies index') ||
		$('body').hasClass('triggers index')) {
		var subtitle_delay_time = 300;
		var subtitle_slideDown_time = 1500;
		$(".subtitle").delay(subtitle_delay_time).slideDown(subtitle_slideDown_time);
	}

	if ($('body').hasClass('triggers edit') ||
		$('body').hasClass('triggers create') ||
		$('body').hasClass('strategies edit') ||
		$('body').hasClass('strategies create')) {

		$('#showCategories').click(function() {
			$('#categories').css({"display": "block"});
			$('#showCategories').css({"display": "none"});
			$('#hideCategories').css({"display": "block"});
		});

		$('#hideCategories').click(function() {
			$('#categories').css({"display": "none"});
			$('#showCategories').css({"display": "block"});
			$('#hideCategories').css({"display": "none"});
		});

		$('#showMoods').click(function() {
			$('#moods').css({"display": "block"});
			$('#showMoods').css({"display": "none"});
			$('#hideMoods').css({"display": "block"});
		});

		$('#hideMoods').click(function() {
			$('#moods').css({"display": "none"});
			$('#showMoods').css({"display": "block"});
			$('#hideMoods').css({"display": "none"});
		});

		$('#showStrategies').click(function() {
			$('#strategies').css({"display": "block"});
			$('#showStrategies').css({"display": "none"});
			$('#hideStrategies').css({"display": "block"});
		});

		$('#hideStrategies').click(function() {
			$('#strategies').css({"display": "none"});
			$('#showStrategies').css({"display": "block"});
			$('#hideStrategies').css({"display": "none"});
		});
	}
});