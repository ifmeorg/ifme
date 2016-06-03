var NO_ALLIES = "Unselect all";
var ALL_ALLIES = "Select all";

var onChangeViewers = function() {
	if ($(this).is(":checked") && $('#viewers_label').text() === ALL_ALLIES) {
		$(":checkbox[name='strategy[viewers][]']").prop("checked", true);
		$(":checkbox[id='viewers']").prop("checked", false);
		$('#viewers_label').text(NO_ALLIES);
	} else if ($(this).is(":checked") && $('#viewers_label').text() === NO_ALLIES) {
		$(":checkbox[name='strategy[viewers][]']").prop("checked", false);
		$(":checkbox[id='viewers']").prop("checked", false);
		$('#viewers_label').text(ALL_ALLIES);
		$(":checkbox[name='strategy[comment]']").prop("checked", false);
	};
};

var showTaggedMoments = function() {
	$('#moment_tag_usage').removeClass('display_none').addClass('display_block');
	$('#showTaggedMoments').addClass('display_none').removeClass('display_inline_block');
	$('#hideTaggedMoments').removeClass('display_none').addClass('display_inline_block');
};
var hideTaggedMoments = function() {
	$('#moment_tag_usage').removeClass('display_block').addClass('display_none');
	$('#showTaggedMoments').removeClass('display_none').addClass('display_inline_block');
	$('#hideTaggedMoments').addClass('display_none').removeClass('display_inline_block');
};

var onReadyStrategies = function() {
	if ($('body').hasClass('strategies new') || $('body').hasClass('strategies edit') || $('body').hasClass('strategies create') || $('body').hasClass('strategies update')) {
		$('#viewers_label').text(ALL_ALLIES);
		$('#viewers').change(onChangeViewers);
	}
	if (isShow(['strategies'])) {
		$('#showTaggedMoments').click(showTaggedMoments);
		$('#hideTaggedMoments').click(hideTaggedMoments);
	}
}

$(document).on("page:load ready", onReadyStrategies);
