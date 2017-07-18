describe("PageAnchor", function() {
  describe("page_anchor class unavailable on window load", function () {
    it("does not scroll to page_anchor", function() {
      onReadyPageAnchor();
      var scrollToPageAnchor = spyOn(window, "scrollToPageAnchor");
      expect(scrollToPageAnchor).not.toHaveBeenCalled();
    });
  });

  describe("page_anchor class available on window load", function () {
    var scrollToPageAnchor;
    beforeEach(function () {
      loadFixtures("page_anchor.html");
      scrollToPageAnchor = spyOn(window, "scrollToPageAnchor");
    });

    it("scrolls to page_anchor", function() {
      onReadyPageAnchor();
      expect(scrollToPageAnchor).toHaveBeenCalled();
    });
  });
});
