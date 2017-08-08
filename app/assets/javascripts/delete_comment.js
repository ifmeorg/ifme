var onReadyDeleteComment = function() {
	if (isShow(['moments', 'strategies', 'meetings'])) {
		$(document).on('click', '.delete_comment_button', function(event) {
			event.preventDefault();

			var commentid = $(this).attr('id').replace('delete_comment_', '');
			var comment = '#comment_' + commentid;
			$(comment).remove();

			if ($('.comment').length === 0) {
				$('.actions').addClass('no_margin_bottom');
			} else {
				$('.comment').first().addClass('no_margin_top');
			}

			var url;
			if ($('body').hasClass('moments show')) {
				url = "/moments/delete_comment?commentid=" + commentid;
			} else if ($('body').hasClass('strategies show')) {
				url = "/strategies/delete_comment?commentid=" + commentid;
			} else {
				url = "/meetings/delete_comment?commentid=" + commentid;
			}

			$.ajax(url);
		});
	}
};

$(document).on("turbolinks:load", onReadyDeleteComment);
