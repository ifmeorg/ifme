function complexCheck(dataType, emptyWhy) {
	var name = dataType + '_name';

	if ($('#' + name).val().length === 0) {
		$('label[for="' + name + '"]').css('color', '#990019');
	} else {
		$('label[for="' + name + '"]').css('color', '#000');
	}

	var why;
	if (dataType === 'moment') {
		why = 'moment_why';
	} else if (dataType === 'strategy' || dataType === 'group' || dataType === 'meeting') {
		why = dataType + '_description';
	}
	if (emptyWhy) {
  		$('label[for="' + why + '"]').css('color', '#990019');
  	} else {
  		$('label[for="' + why + '"]').css('color', '#000');
  	}

	if ($('#' + name).val().length === 0 || emptyWhy) {
		return false;
	}

	return true;
}

function handleEmptyWhy(editor) {
	if (editor.getData().length === 0) {
  		return true;
  	} else {
  		return false;
  	}
}

function simpleCheck(labels) {
	var result = true;

	_.each(labels, function(label) {
		if ($('#' + label).val().length === 0) {
			$('label[for="' + label + '"]').css('color', '#990019');
			result = false;
		} else {
			$('label[for="' + label + '"]').css('color', '#000');
		}
	});

	return result;
}

var onReadyFormProcessing = function() {
	var emptyWhy;

	if (newOrEdit(['moods'])) {
		$('#new_mood').submit(function() {
			return simpleCheck(['mood_name']);
		});
	}

	if (newOrEdit(['categories'])) {
		$('#new_category').submit(function() {
			return simpleCheck(['category_name']);
		});
	}

	if (newOrEdit(['moments'])) {
		emptyWhy = false;

		CKEDITOR.on("instanceReady", function(event) {
		  	var editor = event.editor;
		  	emptyWhy = handleEmptyWhy(editor);

		  	return editor.on('change', function() {
		  		emptyWhy = handleEmptyWhy(editor);
		  	});
		});

		$('#new_moment').submit(function() {
			return complexCheck('moment', emptyWhy);
		});
	}

	if (newOrEdit(['strategies'])) {
		emptyWhy = false;

		CKEDITOR.on("instanceReady", function(event) {
		  	var editor = event.editor;
		  	emptyWhy = handleEmptyWhy(editor);

		  	return editor.on('change', function() {
		  		emptyWhy = handleEmptyWhy(editor);
		  	});
		});

		$('#new_strategy').submit(function() {
			return complexCheck('strategy', emptyWhy);
		});
	}

	if (newOrEdit(['medications'])) {
		$('#new_medication').submit(function() {
			return simpleCheck(['medication_name', 'medication_strength', 'medication_total', 'medication_dosage', 'medication_refill']);
		});
	}

	if (newOrEdit(['groups'])) {
		emptyWhy = false;

		CKEDITOR.on("instanceReady", function(event) {
		  	var editor = event.editor;
		  	emptyWhy = handleEmptyWhy(editor);

		  	return editor.on('change', function() {
		  		emptyWhy = handleEmptyWhy(editor);
		  	});
		});
	}

	if (newOrEdit(['meetings'])) {
		emptyWhy = false;

		CKEDITOR.on("instanceReady", function(event) {
		  	var editor = event.editor;
		  	emptyWhy = handleEmptyWhy(editor);

		  	return editor.on('change', function() {
		  		emptyWhy = handleEmptyWhy(editor);
		  	});
		});

		$('#new_meeting').submit(function() {
			var simple = simpleCheck(['meeting_location', 'meeting_time', 'meeting_date', 'meeting_maxmembers']);
			var complex = complexCheck('meeting', emptyWhy);

			return simple && complex;
		});
	}
};

$(document).on("page:load ready", onReadyFormProcessing);
