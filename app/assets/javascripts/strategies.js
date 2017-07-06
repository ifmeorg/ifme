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
	if (isShow(['strategies'])) {
		$('#showTaggedMoments').click(showTaggedMoments);
		$('#hideTaggedMoments').click(hideTaggedMoments);
	}
};

$(document).on("page:load ready", onReadyStrategies);

