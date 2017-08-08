function getLocation() {
  var input = document.getElementById('user_location');
  new google.maps.places.SearchBox(input);
}

var initAutocomplete = function() {
  if (typeof google !== 'undefined' && $('#user_location').length > 0) {
    getLocation();
  }
}

$(document).on('turbolinks:load', initAutocomplete);
