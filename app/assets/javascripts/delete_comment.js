var onReadyDeleteComment = function() {
	if (isShow(['moments', 'strategies', 'meetings'])) {
		$(document).on('click', '.delete_comment_button', function(event) {
			event.preventDefault();

			var comment_id = $(this).attr('id').replace('delete_comment_', '');
			var comment = '#comment_' + comment_id;
			$(comment).remove();

			if ($('.comment').length === 0) {
				$('.actions').addClass('no_margin_bottom');
			} else {
				$('.comment').first().addClass('no_margin_top');
			}


			var kind;
			if ($('body').hasClass('moments show')) {
				kind = "moment";
			} else if ($('body').hasClass('strategies show')) {
				kind = "strategy";
			} else {
				kind = "meeting";
			}

			$.ajax({
                url: '/comments/' + comment_id,
                type: 'DELETE',
                data: { comment: { comment_type: kind } }
            });
		});
	}
};

$(document).on("page:load ready", onReadyDeleteComment);
