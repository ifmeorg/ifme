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
