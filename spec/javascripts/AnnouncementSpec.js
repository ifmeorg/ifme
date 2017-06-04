describe("announcement", function() {
  beforeEach(function() {
    loadFixtures("announcement.html");
  });

  describe("spanishTranslations", function () {
    beforeEach(function() {
      $(document.body).addClass("pages home");
    });

    afterEach(function() {
      $(document.body).removeClass("pages home");
      $("html").removeAttr("lang");
    });

    it("displays announcement", function() {
      $("html").attr("lang", "en");
      expect($("html").attr("lang")).toBe("en");
      onReadyAnnouncement();
      expect($("#announcement").hasClass("display_block")).toBe(true);
    });

    it("does not display announcement", function() {
      $("html").attr("lang", "es");
      expect($("html").attr("lang")).toBe("es");
      onReadyAnnouncement();
      expect($("#announcement").hasClass("display_none")).toBe(true);
    });
  });
});
