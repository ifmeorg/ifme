var onReadyStrategies = function() {
	if ($('body').hasClass('strategies new') || $('body').hasClass('strategies edit') || $('body').hasClass('strategies create') || $('body').hasClass('strategies update')) {
		var NO_ALLIES = "Unselect all";
		var ALL_ALLIES = "Select all";
		$('#viewers_label').text(ALL_ALLIES);
		$('#viewers').change(function() {
			if ($(this).is(":checked") && $('#viewers_label').text() == ALL_ALLIES) {
				$(":checkbox[name='strategy[viewers][]']").prop("checked", true);
				$(":checkbox[id='viewers']").prop("checked", false);
				$('#viewers_label').text(NO_ALLIES);
			} else if ($(this).is(":checked") && $('#viewers_label').text() == NO_ALLIES) {
				$(":checkbox[name='strategy[viewers][]']").prop("checked", false);
				$(":checkbox[id='viewers']").prop("checked", false);
				$('#viewers_label').text(ALL_ALLIES);
				$(":checkbox[name='strategy[comment]']").prop("checked", false);
			}
		});
	}

	if (isShow(['strategies'])) {
		$('#showTaggedMoments').click(function() {
			$('#moment_tag_usage').removeClass('display_none');
			$('#moment_tag_usage').addClass('display_block');
			$('#showTaggedMoments').addClass('display_none');
			$('#showTaggedMoments').removeClass('display_inline_block');
			$('#hideTaggedMoments').removeClass('display_none');
			$('#hideTaggedMoments').addClass('display_inline_block');
		});

		$('#hideTaggedMoments').click(function() {
			$('#moment_tag_usage').removeClass('display_block');
			$('#moment_tag_usage').addClass('display_none');
			$('#showTaggedMoments').removeClass('display_none');
			$('#showTaggedMoments').addClass('display_inline_block');
			$('#hideTaggedMoments').addClass('display_none');
			$('#hideTaggedMoments').removeClass('display_inline_block');
		});
	}
}

$(document).on("page:load ready", onReadyStrategies);
