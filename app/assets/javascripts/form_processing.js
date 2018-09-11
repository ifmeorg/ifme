// function toggleErrorText(error, label) {
//   if (error) {
//     label.addClass("alertText");
//   } else {
//     label.removeClass("alertText");
//   }
// }

// function complexCheck(dataType, emptyWhy) {
//   var name = dataType + '_name';
//   var nameLabel = $('label[for="' + name + '"]');
//   var nameError = $('#' + name).val().length === 0;
//   toggleErrorText(nameError, nameLabel);

//   var why;
//   if (dataType === 'moment') {
//     why = 'moment_why';
//   } else if (dataType === 'strategy' || dataType === 'group' || dataType === 'meeting') {
//     why = dataType + '_description';
//   }

//   var whyLabel = $('label[for="' + why + '"]');
//   toggleErrorText(emptyWhy, whyLabel);

//   if ($('#' + name).val().length === 0 || emptyWhy) {
//     return false;
//   }

//   return true;
// }

// function handleEmptyWhy(editor) {
//   return editor.getData().length === 0;
// }

// function simpleCheck(labels) {
//   var result = true;

//   _.each(labels, function(labelName) {
//     var error = $('#' + labelName).val().length === 0;
//     var label = $('label[for="' + labelName + '"]');
//     result = !error;
//     toggleErrorText(error, label);
//   });

//   return result;
// }

// var onReadyFormProcessing = function() {
//   var emptyWhy;

//   if (newOrEdit(['moods'])) {
//     $("#new_mood input[type='submit']").click(function() {
//       return simpleCheck(['mood_name']);
//     });
//   }

//   if (newOrEdit(['categories'])) {
//     $("#new_category input[type='submit']").click(function() {
//       return simpleCheck(['category_name']);
//     });
//   }

//   if (newOrEdit(['moments']) ||
//       newOrEdit(['strategies']) ||
//       newOrEdit(['groups']) ||
//       newOrEdit(['meetings'])) {
//     emptyWhy = false;

//     CKEDITOR.on("instanceReady", function(event) {
//       var editor = event.editor;
//       emptyWhy = handleEmptyWhy(editor);

//       return editor.on('change', function() {
//         emptyWhy = handleEmptyWhy(editor);
//       });
//     });

//     $("#new_moment input[type='submit']").click(function(event) {
//       return complexCheck('moment', emptyWhy);
//     });

//     $("#new_strategy input[type='submit']").click(function() {
//       if (newOrEdit(['strategies'])) {
//         return complexCheck('strategy', emptyWhy);
//       }
//     });

//     $("#new_meeting input[type='submit']").click(function() {
//       var simple = simpleCheck(['meeting_location', 'meeting_time', 'meeting_date', 'meeting_maxmembers']);
//       var complex = complexCheck('meeting', emptyWhy);

//       return simple && complex;
//     });
//   }

//   if (newOrEdit(['medications'])) {
//     $("#new_medication input[type='submit']").click(function() {
//       return simpleCheck(['medication_name', 'medication_strength', 'medication_total', 'medication_dosage', 'medication_refill']);
//     });
//   }
// };

// loadPage(onReadyFormProcessing);