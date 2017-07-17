describe("BackToTop", function() {
  describe("back_to_top class unavailable on window load", function () {
    it("does not scroll to the top of page", function() {
      onReadyBackToTop();
      var scrollToBackToTop = spyOn(window, "scrollToBackToTop");
      expect(scrollToBackToTop).not.toHaveBeenCalled();
    });
  });

  describe("back_to_top class available on window load", function () {
    var scrollToBackToTop;
    beforeEach(function () {
      loadFixtures("back_to_top.html");
      scrollToBackToTop = spyOn(window, "scrollToBackToTop");
    });

    it("scrolls to the top of the page", function() {
      onReadyBackToTop();
      $(".back_to_top").click();
      expect(scrollToBackToTop).toHaveBeenCalled();
    });
  });
});
