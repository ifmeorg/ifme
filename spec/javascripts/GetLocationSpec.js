describe("GetLocation", function() {
  var getLocation;

  describe("initAutocomplete", function() {
    beforeEach(function() {
      getLocation = spyOn(window, 'getLocation');
    });

    it("does not call getLocation() if #user_location is not found", function() {
      initAutocomplete();
      expect(getLocation).not.toHaveBeenCalled();
    });

    it("calls getLocation() if #user_location is found", function() {
      google = true;
      loadFixtures('get_location.html');
      initAutocomplete();
      expect(getLocation).toHaveBeenCalled();
    });
  });
});
