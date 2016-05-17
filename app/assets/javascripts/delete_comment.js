$(document).on("page:load ready", function() {

	if ($('body').hasClass('moments show') ||
		$('body').hasClass('strategies show') ||
		$('body').hasClass('meetings show')) {
		$('.delete_comment_button').on('click', function(event) {
			event.preventDefault();
			
			var commentid = $(this).attr('id').replace('delete_comment_', '');
			var comment = '#comment_' + commentid;
			$(comment).remove();

			if ($('.comment').length == 0) {
				$('.actions').addClass('no_margin_bottom');
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

});