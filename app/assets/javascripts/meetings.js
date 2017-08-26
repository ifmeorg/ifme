var onReadyMeetings = function() {
	if (newOrEdit(['meetings'])) {
		$('#meeting_date').datepicker();
		$('#meeting_time').timepicker({ 'scrollDefault': 'now', 'step': 15 });
	}
};

document.addEventListener("turbolinks:load", onReadyMeetings);
