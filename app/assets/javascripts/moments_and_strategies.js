function openQuickCreate(input, inputType) {
  showBackdrop();
  $("#" + inputType + "_quick_create").toggleClass("display_none");
  $("#" + inputType + "_name").val(input);
}

function enterOnAutocomplete(element, formType, inputType) {
  var source = JSON.parse($(element).attr("data-autocomplete-source"));
  var sourceIds = JSON.parse($(element).attr("data-autocomplete-source-ids"));
  var sourceIndex = source.indexOf($(element).val());
  if (sourceIndex > -1) {
    var id = sourceIds[sourceIndex];
    var inputField = "#" + inputType + "_name_" + id;
    $("#" + formType + "_" + inputType + "_" + id).prop("checked", true);
    $(inputField).removeClass("display_none");
    $(inputField).addClass("display_block");
  } else {
    openQuickCreate($(element).val(), inputType);
  }
  $(element).val("");
}

function hideInputFieldIfUnchecked(element, inputType) {
  if (!$(element).is(":checked")) {
    var id = $(element).val();
    $("#" + inputType +"_name_" + id).removeClass("display_block");
    $("#" + inputType + "_name_" + id).addClass("display_none");
  }
}

var onReadyMomentsAndStrategies = function() {
  if (newOrEdit(["moments", "strategies"])) {
    $(".expand_toggle").click(function(event) {
  		var toggleID = $(this).data("toggle");
  		$(toggleID).toggle();
  		$(this).find(".toggle_button i").toggleClass("fa-caret-down");
  		$(this).find(".toggle_button i").toggleClass("fa-caret-up");
  		event.preventDefault();
  	});

  	$("#viewers_all").click(function() {
  		$("#viewers_list :checkbox").prop("checked", $(this).prop("checked"));
  	});

    $("#categories_list :checkbox").click(function() {
      hideInputFieldIfUnchecked(this, "category");
    });

    $("#moods_list :checkbox").click(function() {
      hideInputFieldIfUnchecked(this, "mood");
    });

    $("#strategies_list :checkbox").click(function() {
      hideInputFieldIfUnchecked(this, "strategy");
    });

    // Strategy Category
    $("#strategy_category_name").keypress(function(event) {
      if (event.which === 13) {
        enterOnAutocomplete(this, "strategy", "category");
        return false;
      }
    });
    $("#strategy_category_name").autocomplete({
      source: $("#strategy_category_name").data("autocomplete-source")
    });

    // Moment Category
    $("#moment_category_name").keypress(function(event) {
      if (event.which === 13) {
        enterOnAutocomplete(this, "moment", "category");
        return false;
      }
    });
    $("#moment_category_name").autocomplete({
      source: $("#moment_category_name").data("autocomplete-source")
    });

    // Moment Mood
    $("#moment_mood_name").keypress(function(event) {
      if (event.which === 13) {
        enterOnAutocomplete(this, "moment", "mood");
        return false;
      }
    });
    $("#moment_mood_name").autocomplete({
      source: $("#moment_mood_name").data("autocomplete-source")
    });

    // Moment Strategy
    $("#moment_strategy_name").keypress(function(event) {
      if (event.which === 13) {
        enterOnAutocomplete(this, "moment", "strategy");
        return false;
      }
    });
    $("#moment_strategy_name").autocomplete({
      source: $("#moment_strategy_name").data("autocomplete-source")
    });
	}
};

$(document).on("page:load ready", onReadyMomentsAndStrategies);
