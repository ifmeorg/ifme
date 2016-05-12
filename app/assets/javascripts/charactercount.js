$(document).on("page:load ready", function() {
	CKEDITOR.on("instanceReady", function(event) {
		var editor;
	  	editor = event.editor;
	  	return editor.on('change', function(event) {
	  		var editorCount = '#' + editor.name + '_count';
		    var remaining = 2000 - editor.getData().length;

	        $(editorCount).html(remaining);

	        if (remaining <= 0) {
	        	$(editorCount).css('color', '#990019');
	        } else {
	        	$(editorCount).css('color', '#E1CDD7');
	        }
	  	});
	});
});
