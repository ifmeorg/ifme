var onReadyMoments = function() {
	if (newOrEdit(['moments'])) {
		var NO_ALLIES = "Unselect all";
		var ALL_ALLIES = "Select all";
		$('#viewers_label').text(ALL_ALLIES);
		$('#viewers').change(function() {
			if (isChecked($(this), ALL_ALLIES)) {
         selectAuthorizedViewers(true);
				$('#viewers_label').text(NO_ALLIES);
			} else if (isChecked($(this), NO_ALLIES)) {
         selectAuthorizedViewers(false);
				$('#viewers_label').text(ALL_ALLIES);
				$(":checkbox[name='moment[comment]']").prop("checked", false);
			}
		});
	}
}

function isChecked(input, allyStatus) {
		return input.is(":checked") && $('#viewers_label').text() === allyStatus;
	}

function selectAuthorizedViewers(checkedFlag) {
		$(":checkbox[name='moment[viewers][]']").prop("checked", checkedFlag);
		$(":checkbox[id='viewers']").prop("checked", false);
}

$(document).on("page:load ready", onReadyMoments);
