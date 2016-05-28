$(document).on("page:load ready", function() {

	if (isShow(['moments', 'strategies', 'meetings'])) {

		$(document).on('click', '#add_comment_button', function(event) {
			event.preventDefault();

			if (!$(this).prop('disabled')) {
				$(this).prop('disabled', true);
				$('#comment_comment').prop('disabled', true);
				$(this).val('Posting comment...');

				if ($('.comment').length > 0) {
					$('.actions').removeClass('no_margin_bottom');
				}

				var url;
				if (isShow(['moments'])) {
					url = '/moments/comment';
				} else if (isShow(['strategies'])) {
					url = '/strategies/comment';
				} else {
					url = '/meetings/comment';
				}

				var viewers;
				if ($('#comment_viewers').length) {
					viewers = $('#comment_viewers').val();
				}

				data = {
					comment_type: $('#comment_comment_type').val(),
					commented_on:$('#comment_commented_on').val(),
					comment_by: $('#comment_comment_by').val(),
					comment: $('#comment_comment').val(),
					visibility: $('#comment_visibility').val(),
					viewers: viewers
				};

				$.ajax({
				    dataType: 'json',
				    url: url,
				    type: 'POST',
				    data: data,
				    success: function(json) {
				    	if (json !== undefined) {
				    		$('#add_comment_button').prop('disabled', false);
				    		$('#comment_comment').prop('disabled', false);
				    		$('#comment_comment').val('');
							$('#add_comment_button').val('Comment');

				    		if (!json.no_save) {
					    		var commentid = 'comment_' + json.commentid;
					    		var profile_picture = json.profile_picture;
					    		var comment_info = json.comment_info;
					    		var comment_text = json.comment_text;
					    		var visibility = json.visibility;
					    		var delete_comment = json.delete_comment;

					    		// Remove no_margin_top on first comment
					    		if ($('.comment').length > 0) {
					    			$('.comment.no_margin_top').removeClass('no_margin_top');
					    		}

					    		var newComment = '<div class="comment no_margin_top" id="' + commentid + '">';
					    		newComment += '<div class="table">';
					    		newComment += '<div class="table_row">';

					    		newComment += '<div class="table_cell small_profile_picture_div vertical_align_middle padding_right">';

					    		newComment += profile_picture;
					    		newComment += '</div>';

					    		newComment += '<div class="table_cell">';
					    		newComment += '<div class="comment_info">'
					    		newComment += comment_info;
					    		newComment += '</div>';
					    		newComment += '<div class="comment_text">';
					    		newComment += comment_text;
					    		newComment += '</div>';
					    		if (visibility != null && visibility.length > 0) {
					    			newComment += visibility;
					    		}
					    		newComment += '</div>';


					    		if (delete_comment != null && delete_comment.length > 0) {
					    			newComment += delete_comment;
					    		}

					    		newComment += '</div>';
					    		newComment += '</div>';
					    		newComment += '</div>';

					    		$('#comments').prepend(newComment);

					    		if ($('.comment').length > 0) {
									$('.actions').removeClass('no_margin_bottom');
								}
					    	}
				    	}
				    },
				    error: function() {
				    	$('#add_comment_button').prop('disabled', false);
				    	$('#comment_comment').prop('disabled', false);
						$('#add_comment_button').val('Comment');
				    }
				});
			}
		});
	}
});