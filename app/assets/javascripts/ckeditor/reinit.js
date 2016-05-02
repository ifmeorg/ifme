$(document).bind('page:change', function() {
  $('.ckeditor').each(function() {
  	if (!this) {
    	CKEDITOR.replace($(this).attr('id'));
	}
  });
});