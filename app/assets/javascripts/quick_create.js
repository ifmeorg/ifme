function addToAutocomplete(json) {
  var source = JSON.parse($("#" + json.autocomplete_id).attr("data-autocomplete-source"));
  source.unshift(json.name)
  $("#" + json.autocomplete_id).attr("data-autocomplete-source", JSON.stringify(source));
  var sourceIds = JSON.parse($("#" + json.autocomplete_id).attr("data-autocomplete-source-ids"));
  sourceIds.unshift(json.id);
  $("#" + json.autocomplete_id).attr("data-autocomplete-source-ids", JSON.stringify(sourceIds));
  $("#" + json.autocomplete_id).autocomplete({ source: source });
}

function quickCreate(form, data_type) {
  var values = $(form).serialize();
  $.ajax({
      type: 'POST',
      url: $(form).attr('action'),
      data: values,
      dataType: 'json'
  }).success(function(json) {
      // Update moments/strategies form
      var wrapper = "<div id=\"" + json.wrapper_id + "\" class=\"display_block\">";
      var content = wrapper + json.checkbox + json.label + "</div>";
      if (data_type === 'category') {
        $('#categories_list').prepend(content);
      } else if (data_type === 'mood') {
        $('#moods_list').prepend(content);
      } else if (data_type === 'strategy') {
        $('#strategies_list').prepend(content);
      }

      // Checking the newly added checkbox.
      var id = $(json.checkbox).attr('id');
      $('#' + id).prop('checked', true);

      addToAutocomplete(json);

      $(form).trigger('reset');
      $('.quick_create_close').click();
  });
}

function closeQuickCreate() {
  var quickCreateId = $(this).closest('.quick_create').attr('id');
  if (quickCreateId === 'category_quick_create' || quickCreateId === 'mood_quick_create' || quickCreateId === 'strategy_quick_create') {
    if (!$('#' + quickCreateId).hasClass('display_none')) {
      $('#' + quickCreateId).toggleClass('display_none');
    }
  }
  hideBackdrop();
}

var onReadyQuickCreate = function() {
  $(".quick_create_close").click(function() {
    closeQuickCreate.call(this);
  });

  $(".titlebar").parent().scroll(function() {
    if ($(this).scrollTop() > 0) {
      titlebarBorderShow();
    }
    else {
      titlebarBorderHide();
    }
  });

  $(".quick_create").click(function() {
    closeQuickCreate.call(this);
  });

  $(".quick_create_text").click(function(event) {
    event.stopPropagation();
   });

  if (newOrEdit(["moments", "strategies"])) {
    $("#new_category").submit(function() {
      quickCreate(this, "category");
      return false;
    });
  }

  if (newOrEdit(["moments"])) {
    $("#new_mood").submit(function() {
      quickCreate(this, "mood");
      return false;
    });

    $("#new_strategy").submit(function() {
      quickCreate(this, "strategy");
      return false;
    });
  }
};

$(document).on("page:load ready", onReadyQuickCreate);
