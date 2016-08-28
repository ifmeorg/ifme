var NO_ALLIES = "Unselect all";
var ALL_ALLIES = "Select all";

function selectAllAlliesWhoCanViewStrategy() {
	$(":checkbox[name='strategy[viewers][]']").prop("checked", true);
}

function unselectAllAlliesWhoCanViewStrategy() {
	$(":checkbox[name='strategy[viewers][]']").prop("checked", false);
}

var showTaggedMoments = function() {
	$('#moment_tag_usage').addClass('display_block').removeClass('display_none');
	$('#showTaggedMoments').addClass('display_none').removeClass('display_inline_block');
	$('#hideTaggedMoments').addClass('display_inline_block').removeClass('display_none');
};

var hideTaggedMoments = function() {
	$('#moment_tag_usage').removeClass('display_block').addClass('display_none');
	$('#showTaggedMoments').removeClass('display_none').addClass('display_inline_block');
	$('#hideTaggedMoments').removeClass('display_inline_block').addClass('display_none');
};

var onReadyStrategies = function() {
	if ($('body').hasClass('strategies new') || $('body').hasClass('strategies edit') || $('body').hasClass('strategies create') || $('body').hasClass('strategies update')) {
		$('#viewers_label').text(ALL_ALLIES);

		$('#viewers_all').change(function() {
			if (isAllAlliesInputBoxIsChecked($(this))) {
				selectAllAlliesWhoCanViewStrategy();
				setViewersCheckBoxToNotBeSelected();
				$('#viewers_label').text(NO_ALLIES);
			} else {
				unselectAllAlliesWhoCanViewStrategy();
				setViewersCheckBoxToNotBeSelected();
				$('#viewers_label').text(ALL_ALLIES);
			}
		});
	}
	if (isShow(['strategies'])) {
		$('#showTaggedMoments').click(showTaggedMoments);
		$('#hideTaggedMoments').click(hideTaggedMoments);
	}
};

$(document).on("page:load ready", onReadyStrategies);
