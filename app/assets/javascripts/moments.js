var NO_ALLIES = "Unselect all";
var ALL_ALLIES = "Select all";

function selectAllAlliesWhoCanViewMoment() {
	$(":checkbox[name='moment[viewers][]']").prop("checked", true);
}

function unselectAllAlliesWhoCanViewMoment() {
	$(":checkbox[name='moment[viewers][]']").prop("checked", false);
}

var onReadyMoments = function() {
	if (newOrEdit(['moments'])) {
		$('#viewers_label').text(ALL_ALLIES);

		$('#viewers_all').change(function() {
			if (isAllAlliesInputBoxIsChecked($(this))) {
				selectAllAlliesWhoCanViewMoment();
				setViewersCheckBoxToNotBeSelected();
				$('#viewers_label').text(NO_ALLIES);
			} else {
				unselectAllAlliesWhoCanViewMoment();
				setViewersCheckBoxToNotBeSelected();
				$('#viewers_label').text(ALL_ALLIES);
			}
		});
	}
};

$(document).on("page:load ready", onReadyMoments);
