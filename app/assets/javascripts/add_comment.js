const onReadyAddComment = function () {
  if (isShow(['moments', 'strategies', 'meetings'])) {
    $(document).on('click', '#add_comment_button', function (event) {
      event.preventDefault();

      if (!$(this).prop('disabled')) {
        $(this).prop('disabled', true);
        $('#comment_comment').prop('disabled', true);
        $(this).val(I18n.t('comment.posting'));

        let url;
        if (isShow(['moments'])) {
          url = '/moments/comment';
        } else if (isShow(['strategies'])) {
          url = '/strategies/comment';
        } else {
          url = '/meetings/comment';
        }

        let viewers;
        if ($('#comment_viewers').length) {
          viewers = $('#comment_viewers').val();
        }

        const data = {
          commentable_type: $('#comment_commentable_type').val(),
          commentable_id: $('#comment_commentable_id').val(),
          comment_by: $('#comment_comment_by').val(),
          comment: $('#comment_comment').val(),
          visibility: $('#comment_visibility').val(),
          viewers,
        };

        $.ajax({
          dataType: 'json',
          url,
          type: 'POST',
          data,
          success(json) {
            if (json !== undefined) {
              $('#add_comment_button').prop('disabled', false);
              $('#comment_comment').prop('disabled', false);
              $('#comment_comment').val('');
              $('#add_comment_button').val(I18n.t('comment.singular'));

              if (!json.no_save) {
                const commentid = `comment_${json.commentid}`;
                /* eslint-disable camelcase */
                const { comment_info,
                  comment_text,
                  delete_comment,
                  visibility } = json;

                let newComment = `<div class="comment smallMarginTop" id="${commentid}">`;
                newComment += '<div class="gridRowSpaceBetween">';
                newComment += '<div class="comment_info">';
                newComment += comment_info;
                newComment += '</div>';
                if (delete_comment !== null && delete_comment.length > 0) {
                  newComment += delete_comment;
                }
                newComment += '</div>';
                newComment += '<div class="comment_text">';
                newComment += comment_text;
                newComment += '</div>';
                newComment += '<div class="subtle">';
                if (visibility !== null && visibility.length > 0) {
                  newComment += visibility;
                }
                newComment += '</div>';
                newComment += '</div>';

                $('#comments').prepend(newComment);
                /* eslint-enable camelcase */
              }
            }
          },
          error() {
            $('#add_comment_button').prop('disabled', false);
            $('#comment_comment').prop('disabled', false);
            $('#add_comment_button').val(I18n.t('comment.singular'));
          },
        });
      }
    });
  }
};

loadPage(onReadyAddComment);
