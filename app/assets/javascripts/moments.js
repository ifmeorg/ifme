$(document).on("page:load ready", function() {
	if (newOrEdit(['moments'])) {
		var NO_ALLIES = "Unselect all";
		var ALL_ALLIES = "Select all";
		$('#viewers_label').text(ALL_ALLIES);
		$('#viewers').change(function() {
			if ($(this).is(":checked") && $('#viewers_label').text() == ALL_ALLIES) {
				$(":checkbox[name='moment[viewers][]']").prop("checked", true);
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
});