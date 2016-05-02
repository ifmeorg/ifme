$(document).bind('page:load ready', function() {
  $('.ckeditor').each(function() {
  	if (!this) {
    	CKEDITOR.replace($(this).attr('id'));
	}
  });
});