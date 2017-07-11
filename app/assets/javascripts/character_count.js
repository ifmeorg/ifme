function changeEditorCount(editorCount, remaining) {
	$(editorCount).html(remaining);
    if (remaining <= 0) {
    	$(editorCount).css('color', '#990019');

    	if (remaining === 0) {
    		$('input[type="submit"]').prop('disabled', false);
    	} else {
    		$('input[type="submit"]').prop('disabled', true);
    	}
    } else {
    	$(editorCount).css('color', '#b5839b');
    	$('input[type="submit"]').prop('disabled', false);
    }
}

function noCKEditor(editor) {
	var editorName = editor.attr('id');
	var editorData = editor.val();
  	var editorCount = '#' + editorName + '_count';
	var remaining = 2000 - editorData.length;

	 changeEditorCount(editorCount, remaining);
}

function yesCKEditor(editor) {
	var editorCount = '#' + editor.name + '_count';
    var remaining = 2000 - editor.getData().length;

	changeEditorCount(editorCount, remaining);
}

var onReadyCharacterCount = function() {
	CKEDITOR.on("instanceReady", function(event) {
		var editor;
	  	editor = event.editor;

	  	yesCKEditor(editor);

	  	return editor.on('change', function() {
	  		yesCKEditor(editor);
	  	});
	});

	if ($('body').hasClass('pages home')) {
		$('#moment_why').bind('keyup', function() {
			noCKEditor($(this));
		});
	}

	if (newOrEdit(['moments'])) {
		noCKEditor($('#strategy_description'));

		$('#strategy_description').bind('keyup', function() {
			noCKEditor($(this));
		});
	}

	if (isShow(['moments', 'strategies', 'meetings'])) {
		$('#comment_comment').bind('keyup', function() {
			noCKEditor($(this));
		});
	}
};

$(document).on("page:load ready", onReadyCharacterCount);
