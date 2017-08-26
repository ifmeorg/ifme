const keyPress = require('./helpers/key-press');

describe("QuickCreate", function() {
  beforeEach(function() {
    loadFixtures("quick_create.html");
    onReadyQuickCreate();
  });

  it("close quick create", function() {
    $(".quick_create_close").click();
    expect($("#category_quick_create").hasClass("display_none")).toBe(true);
  });

  it("keep quick create open on modal click", function() {
    $(".quick_create_text").click();
    expect($("#category_quick_create").hasClass("display_none")).toBe(false);
  });

  it("close quick create on backdrop click", function() {
    $("#category_quick_create").click();
    expect($("#category_quick_create").hasClass("display_none")).toBe(true);
  });

  it("close quick create on esc key press", function() {
    keyPress(27);
    expect($("#category_quick_create").hasClass("display_none")).toBe(true);
    expect($("#mood_quick_create").hasClass("display_none")).toBe(true);
    expect($("#strategy_quick_create").hasClass("display_none")).toBe(true);
  });
});
