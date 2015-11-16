$(document).on("page:load ready", function() {
	if ($('body').hasClass('triggers new') || $('body').hasClass('triggers edit')) {
		var NO_ALLIES = "No allies";
		var ALL_ALLIES = "All allies";
		$('#viewers_label').text(ALL_ALLIES);
		$('#viewers').change(function() {
			if ($(this).is(":checked") && $('#viewers_label').text() == ALL_ALLIES) {
				$(":checkbox[name='trigger[viewers][]']").prop("checked", true);
				$(":checkbox[id='viewers']").prop("checked", false);
				$('#viewers_label').text(NO_ALLIES);
			} else if ($(this).is(":checked") && $('#viewers_label').text() == NO_ALLIES) {
				$(":checkbox[name='trigger[viewers][]']").prop("checked", false);
				$(":checkbox[id='viewers']").prop("checked", false);
				$('#viewers_label').text(ALL_ALLIES);
			}
		});
	}
});