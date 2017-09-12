function hitEnter(event, element, formType, inputType) {
  if (event.which === 13) {
    enterOnAutocomplete(element, formType, inputType);
    return false;
  }
}

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
  } else if ($(element).val().length > 0) {
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

var onReadyAutocompleteCheckboxes = function() {
  if (newOrEdit(["moments", "strategies"])) {
    $(document).on("click", '#categories_list :checkbox', function() {
      hideInputFieldIfUnchecked(this, "category");
    });

    $(document).on("click", '#moods_list :checkbox', function() {
      hideInputFieldIfUnchecked(this, "mood");
    });

    $(document).on("click", '#strategies_list :checkbox', function() {
      hideInputFieldIfUnchecked(this, "strategy");
    });

    // Strategy Category
    $("#strategy_category_name").keypress(function(event) {
      return hitEnter(event, this, "strategy", "category");
    });

    $("#strategy_category_name").autocomplete({
      source: $("#strategy_category_name").data("autocomplete-source")
    });

    // Moment Category
    $("#moment_category_name").keypress(function(event) {
      return hitEnter(event, this, "moment", "category");
    });

    $("#moment_category_name").autocomplete({
      source: $("#moment_category_name").data("autocomplete-source")
    });

    // Moment Mood
    $("#moment_mood_name").keypress(function(event) {
      return hitEnter(event, this, "moment", "mood");
    });

    $("#moment_mood_name").autocomplete({
      source: $("#moment_mood_name").data("autocomplete-source")
    });

    // Moment Strategies
    $("#moment_strategy_name").keypress(function(event) {
      return hitEnter(event, this, "moment", "strategy");
    });

    $("#moment_strategy_name").autocomplete({
      source: $("#moment_strategy_name").data("autocomplete-source")
    });
  }
};

loadPage(onReadyAutocompleteCheckboxes);
