function get_timezone() {
  var cityfqcn = $('#user_location').val();
  if (cityfqcn) {
    $.getJSON(
      'http://gd.geobytes.com/GetCityDetails?callback=?&fqcn=' + cityfqcn,
        function (data) {
          $('#user_timezone').val(data.geobytestimezone);
      }
    );
  }
}

var onReadyGetLocation = function() {
  if ($('body').hasClass('registrations new') || $('body').hasClass('registrations edit')) {
    $("#user_location").autocomplete({
      source: function (request, response) {
          $.getJSON(
            'http://gd.geobytes.com/AutoCompleteCity?callback=?&q=' + request.term,
            function (data) {
              response(data);
            }
          );
        },
        minLength: 3,
        select: function (event, ui) {
          var selectedObj = ui.item;
          $('#user_location').val(selectedObj.value);
          return false;
        },
        open: function () {
          $(this).removeClass('ui-corner-all').addClass('ui-corner-top');
        },
        close: function () {
          $(this).removeClass('ui-corner-top').addClass('ui-corner-all');
          if ($('body').hasClass('registrations new')) {
            get_timezone();
          }
        }
    });
    $('#user_location').autocomplete('option', 'delay', 100);
  }
};

$(document).on('page:load ready', onReadyGetLocation);
