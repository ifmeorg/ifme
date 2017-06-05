describe("ToggleLocale", function() {
  beforeEach(function() {
    loadFixtures("toggle_locale.html");
    spyOn($, "ajax").and.callFake(function() {
       return { done: function() {} };
     });
    onReadyToggleLocale();
  });

  afterEach(function() {
    document.cookie = "locale=; expires=Thu, 18 Dec 2013 12:00:00 UTC";
  });

  it("calls toggle_locale when value of #locale changes", function() {
    expect($("#locale").val()).toBe("en");
    expect(getCookie("locale")).toBe(null);
    $("#locale").val("es").change();
    expect($("#locale").val()).toBe("es");
    expect(getCookie("locale")).toBe("es");
    expect($.ajax).toHaveBeenCalled();
  });
});
