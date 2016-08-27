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
//= require ckeditor/init
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require jquery-readyselector
//= require bootstrap-datepicker
//= require underscore
//= require_tree .

function newOrEdit(forms) {
	var result = false;
	_.each(forms, function(form) {
		if ($('body').hasClass(form + ' new') || $('body').hasClass(form + ' create') || $('body').hasClass(form + ' edit') || $('body').hasClass(form + ' update')) {
			result = true;
			return;
	    }
	});

	return result;
}

function isShow(forms) {
	var result = false;
	_.each(forms, function(form) {
		if ($('body').hasClass(form + ' show')) {
			result = true;
			return;
	    }
	});

	return result;
}

var onReadyApplication = function() {
	$.ajaxSetup({
  		headers: {
    		'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
  		}
	});

	// Timezone detection
	var tz = jstz.determine();
  	$.cookie('timezone', tz.name(), { path: '/' });

	$('.yes_title').find(':not(.no_title)').tooltip();

	if (newOrEdit(['moments', 'strategies'])) {

		$('#showCategories').click(function(event) {
			event.preventDefault();
			$('#categories').css({"display": "block"});
			$('#showCategories').css({"display": "none"});
			$('#hideCategories').css({"display": "block"});
		});

		$('#hideCategories').click(function(event) {
			event.preventDefault();
			$('#categories').css({"display": "none"});
			$('#showCategories').css({"display": "block"});
			$('#hideCategories').css({"display": "none"});
		});

		$('#showMoods').click(function(event) {
			event.preventDefault();
			$('#moods').css({"display": "block"});
			$('#showMoods').css({"display": "none"});
			$('#hideMoods').css({"display": "block"});
		});

		$('#hideMoods').click(function(event) {
			event.preventDefault();
			$('#moods').css({"display": "none"});
			$('#showMoods').css({"display": "block"});
			$('#hideMoods').css({"display": "none"});
		});

		$('#showStrategies').click(function(event) {
			event.preventDefault();
			$('#strategies').css({"display": "block"});
			$('#showStrategies').css({"display": "none"});
			$('#hideStrategies').css({"display": "block"});
		});

		$('#hideStrategies').click(function(event) {
			event.preventDefault();
			$('#strategies').css({"display": "none"});
			$('#showStrategies').css({"display": "block"});
			$('#hideStrategies').css({"display": "none"});
		});

		$('#showViewers').click(function(event) {
			event.preventDefault();
			$('#viewers').css({"display": "block"});
			$('#showViewers').css({"display": "none"});
			$('#hideViewers').css({"display": "block"});
		});

		$('#hideViewers').click(function(event) {
			event.preventDefault();
			$('#viewers').css({"display": "none"});
			$('#showViewers').css({"display": "block"});
			$('#hideViewers').css({"display": "none"});
		});
	}
};

$(document).on("page:load ready", onReadyApplication);
