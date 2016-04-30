$(document).bind('page:change', function() {
  $('.ckeditor').each(function() {
    CKEDITOR.replace($(this).attr('id'));
  });
});