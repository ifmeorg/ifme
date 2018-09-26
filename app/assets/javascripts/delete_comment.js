var onReadyDeleteComment = function() {
  if (isShow(['moments', 'strategies', 'meetings'])) {
    $(document).on('click', '.delete_comment_button', function(event) {
      event.preventDefault();

      var commentid = $(this).attr('id').replace('delete_comment_', '');
      var comment = '#comment_' + commentid;
      $(comment).remove();

      if ($('.comment').length === 0) {
        $('.actions').addClass('noMarginBottom');
      } else {
        $('.comment').first().addClass('noMarginTop');
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

loadPage(onReadyDeleteComment);
