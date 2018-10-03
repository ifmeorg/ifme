function getLocation() {
  const input = document.getElementById('user_location');
  new google.maps.places.SearchBox(input);
}

const initAutocomplete = function () {
  const googleMapsExists = typeof google !== 'undefined' && typeof google.maps !== 'undefined';
  if (googleMapsExists && $('#user_location').length > 0) {
    getLocation();
  }
};

loadPage(initAutocomplete);
