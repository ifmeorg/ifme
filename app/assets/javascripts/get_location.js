function getLocation() {
  var input = document.getElementById('user_location');
  new google.maps.places.SearchBox(input);
}

var initAutocomplete = function() {
  var googleMapsExists = typeof google !== 'undefined' && typeof google.maps !== 'undefined';
  if (googleMapsExists && $('#user_location').length > 0) {
    getLocation();
  }
}

loadPage(initAutocomplete);
