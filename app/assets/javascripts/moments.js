
var onReadyMoments = function() {
	if (newOrEdit(['moments'])) {
		var NO_ALLIES = "Unselect all";
		var ALL_ALLIES = "Select all";
		$('#viewers_label').text(ALL_ALLIES);

		$('#viewers').change(function() {
			if (isAllAlliesInputBoxChecked($(this))) {
				selectAllAlliesWhoCanViewMomement();
				viewersCheckBoxIsNotSelected();
				$('#viewers_label').text(NO_ALLIES);
			} else if ($(this).is(":checked") && $('#viewers_label').text() == NO_ALLIES) {
				$(":checkbox[name='moment[viewers][]']").prop("checked", false);
				$(":checkbox[id='viewers']").prop("checked", false);
				$('#viewers_label').text(ALL_ALLIES);
				$(":checkbox[name='moment[comment]']").prop("checked", false);
			}
		});
	}
}

function isAllAlliesInputBoxChecked(inputTag) {
			return inputTag.is(":checked") && $('#viewers_label').text() == ALL_ALLIES
}

function selectAllAlliesWhoCanViewMomement() {
	$(":checkbox[name='moment[viewers][]']").prop("checked", true);
}

function viewersCheckBoxIsNotSelected() {
	$(":checkbox[id='viewers']").prop("checked", false);
}

$(document).on("page:load ready", onReadyMoments);


