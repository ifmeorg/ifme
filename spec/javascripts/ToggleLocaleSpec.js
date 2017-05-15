describe("toggleLocale", function() {
  beforeEach(function() {
    loadFixtures("toggle_locale.html");
    spyOn($, "ajax").and.callFake(function() {
       return { done: function() {} };
     });
    onReadyToggleLocale();
  });

  it("calls toggle_locale when page loads", function() {
    expect($.ajax).toHaveBeenCalled();
  });

  it("calls toggle_locale when value of #locale changes", function() {
    $("#locale").val("es");
    expect($.ajax).toHaveBeenCalled();
  });
});
