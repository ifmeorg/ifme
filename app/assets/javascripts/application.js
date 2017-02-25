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
//= require i18n
//= require i18n.js
//= require i18n/translations

/* Viewers */
function isAllAlliesInputBoxIsChecked(inputTag) {
	return inputTag.is(":checked") && $('#viewers_label').text() === ALL_ALLIES;
}

function setViewersCheckBoxToNotBeSelected() {
	$(":checkbox[id='viewers_all']").prop("checked", false);
}

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

function toggleLocale(locale) {
	$.ajax({
		url: '/toggle_locale',
		data: { locale: locale }
	}).done(function() {
		if (window.localStorage !== 'undefined') {
			window.localStorage.setItem('locale', locale);
		}
		var href = window.document.URL;
		if (href.indexOf(locale) === -1) {
			window.location.href = `${href.split('?')[0]}?locale=${locale}`;
		}
	});
}

var onReadyLocale = function() {
	var locale;
	if (window.localStorage !== 'undefined' && window.localStorage.getItem('locale')) {
		locale = window.localStorage.getItem('locale');
		if ($('#locale').val() !== locale) {
			toggleLocale(locale);
		}
	}
	$('#locale').change(function() {
		if ($(this).val() !== locale) {
			toggleLocale($(this).val());
		}
	});
}

var onReadyMomentsAndStrategies = function() {
	$('.expand_toggle').click(function(event) {
		var toggleID = $(this).data('toggle');
		$(toggleID).toggle();
		$(this).find('.toggle_button i').toggleClass('fa-caret-down');
		$(this).find('.toggle_button i').toggleClass('fa-caret-up');
		event.preventDefault();
	});

	$('#viewers_all').click(function(){
		$("#viewers_list :checkbox").prop("checked", $(this).prop("checked"));
	});
}

var onReadyApplication = function() {
	$.ajaxSetup({
		headers: {
			'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
		}
	});

	onReadyLocale();

	// Timezone detection
	var tz = jstz.determine();
	$.cookie('timezone', tz.name(), { path: '/' });

	$('.yes_title').find(':not(.no_title)').tooltip();

	if (newOrEdit(['moments', 'strategies'])) {
		onReadyMomentsAndStrategies();
	}
};

$(document).on("page:load ready", onReadyApplication);
