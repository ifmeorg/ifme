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
	        	$(editorCount).css('color', '#b5839b');
	        }
	  	});
	});

	if ($('body').hasClass('pages home')) {
		$('#moment_why').bind('keyup', function() {
			noCKEditor($(this));
		});
	}

	if ($('body').hasClass('moments create') ||
		$('body').hasClass('moments new')) {
		$('#strategy_description').bind('keyup', function() {
			noCKEditor($(this));
		});
	}
});

function noCKEditor(editor) {
	var editorName = editor.attr('id');
	var editorData = editor.val();
  	var editorCount = '#' + editorName + '_count';
	var remaining = 2000 - editorData.length;

    $(editorCount).html(remaining);

    if (remaining <= 0) {
    	$(editorCount).css('color', '#990019');
    } else {
    	$(editorCount).css('color', '#b5839b');
    }
}
