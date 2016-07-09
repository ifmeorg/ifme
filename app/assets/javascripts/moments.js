
var onReadyMoments = function() {
	if (newOrEdit(['moments'])) {
		var NO_ALLIES = "Unselect all";
		var ALL_ALLIES = "Select all";
		$('#viewers_label').text(ALL_ALLIES);

		$('#viewers').change(function() {
			if (labelTextIsAllAllies()) {
				selectAllAllies();
				$(":checkbox[id='viewers']").prop("checked", false);
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


function labelTextIsAllAllies() {
			return $(this).is(":checked") && $('#viewers_label').text() == ALL_ALLIES
}

function selectAllAllies() {
	$(":checkbox[name='moment[viewers][]']").prop("checked", true);
}

$(document).on("page:load ready", onReadyMoments);


