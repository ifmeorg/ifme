describe("GetLocation", function() {
var src = 'https://maps.googleapis.com/maps/api/js?libraries=places&callback=initAutocomplete';

describe("onReadyGetLocation", function() {
  it("does not load Google Maps autocomplete script to page", function() {
    onReadyGetLocation();
    expect($("script[src*='" + src + "']").length === 0).toBe(true);
  });

  it("loads Google Maps autocomplete script to page", function() {
    loadFixtures('get_location.html');
    onReadyGetLocation();
    expect($("script[src*='" + src + "']").length > 0).toBe(true);
    });
  });
});
