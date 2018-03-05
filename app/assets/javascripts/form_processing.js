function complexCheck(dataType, emptyWhy) {
  var name = dataType + '_name';
  var nameColor = $('#' + name).val().length === 0 ? '#990019' : '#000';
  $('label[for="' + name + '"]').css('color', nameColor);

  var why;
  if (dataType === 'moment') {
    why = 'moment_why';
  } else if (dataType === 'strategy' || dataType === 'group' || dataType === 'meeting') {
    why = dataType + '_description';
  }
  var whyColor = emptyWhy ? '#990019' : '#000';
  $('label[for="' + why + '"]').css('color', whyColor);

  if ($('#' + name).val().length === 0 || emptyWhy) {
    return false;
  }

  return true;
}

function handleEmptyWhy(editor) {
  return editor.getData().length === 0;
}

function simpleCheck(labels) {
  var result = true;

  _.each(labels, function(label) {
    var labelColor = '#000';
    if ($('#' + label).val().length === 0) {
      labelColor = '#990019';
      result = false;
    }
    $('label[for="' + label + '"]').css('color', labelColor);
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

  if (newOrEdit(['moments']) ||
      newOrEdit(['strategies']) ||
      newOrEdit(['groups']) ||
      newOrEdit(['meetings'])) {
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

    $('#new_strategy').submit(function() {
      return complexCheck('strategy', emptyWhy);
    });

    $('#new_meeting').submit(function() {
      var simple = simpleCheck(['meeting_location', 'meeting_time', 'meeting_date', 'meeting_maxmembers']);
      var complex = complexCheck('meeting', emptyWhy);

      return simple && complex;
    });
  }

  if (newOrEdit(['medications'])) {
    $('#new_medication').submit(function() {
      return simpleCheck(['medication_name', 'medication_strength', 'medication_total', 'medication_dosage', 'medication_refill']);
    });
  }
};

loadPage(onReadyFormProcessing);