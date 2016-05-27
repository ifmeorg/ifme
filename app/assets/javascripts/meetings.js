$(document).on("page:load ready", function() {
	if ($('body').hasClass('meetings new') || $('body').hasClass('meetings edit') ||
		$('body').hasClass('meetings create') || $('body').hasClass('meetings update')) {
		$('#meeting_date').datepicker();
		$('#meeting_time').timepicker({ 'scrollDefault': 'now', 'step': 15 });
	}
});
