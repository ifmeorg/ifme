describe("QuickMoment", function() {
  beforeEach(function() {
    loadFixtures('quick_moment.html');
    onReadyQuickMoment();
  });

  it("close categories moods", function() {
    $('#close_categories_moods').click();
    expect($('#categories_moods').hasClass("display_none")).toBe(true);
  });

  it("keep categories moods open on modal click", function() {
    $('#categories_moods_text').click();
    expect($('#categories_moods').hasClass("display_none")).toBe(false);
  });

  it("close categories moods on backdrop click", function() {
    $('#categories_moods').click();
    expect($('#categories_moods').hasClass("display_none")).toBe(true);
  });

  it("close categories moods on esc key press", function() {
    keyPress(27);
    expect($('#categories_moods').hasClass("display_none")).toBe(true);
  });
});
