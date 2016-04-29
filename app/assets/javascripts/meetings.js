$(document).on("page:load ready", function() {
	if ($('body').hasClass('meetings new') || $('body').hasClass('meetings edit') ||
		$('body').hasClass('meetings create') || $('body').hasClass('meetings update')) {
		$('#meeting_date').datepicker();
		//TODO: not working, need to find working gem
		//$('#meeting_time').timepicker();
	}
});
