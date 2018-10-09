function getLocation() {
  const input = document.getElementById('user_location');
  /* eslint-disable no-new */
  new google.maps.places.SearchBox(input);
  /* eslint-enable no-new */
}

const initAutocomplete = function () {
  const googleMapsExists = typeof google !== 'undefined' && typeof google.maps !== 'undefined';
  if (googleMapsExists && $('#user_location').length > 0) {
    getLocation();
  }
};

loadPage(initAutocomplete);
