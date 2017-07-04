function keyPress(key) {
  var e = jQuery.Event("keyup");
  e.which = key;
  e.keyCode = key;
  $('input').trigger(e);
}

describe("Notifications", function() {
  beforeEach(function() {
    loadFixtures('notifications.html');
    onReadyNotifications();
  });

  it("test notifications show", function() {
    showNotifications();
    expect($('#notifications').hasClass("display_block")).toBe(true);
  });

  it("show notifications none", function() {
    showNotificationsNone();
    expect($('#notifications_none').hasClass("display_block")).toBe(true);
  });

  it("show notifications modal", function() {
    $('.notifications_button').click();
    expect($('#notifications').hasClass("display_block")).toBe(true);
  });

  it("close notifications modal", function() {
    $('#close_notifications').click();
    expect($('#notifications')).toBeHidden();
  });

  it("clear notifications modal", function() {
    $('#clear_notifications').click();
    expect($('#notifications_none').hasClass("display_block")).toBe(true);
  });

  it("close tips notifications modal", function() { // This test is failing!!
    $('.tip_close_notifications').click();
    expect($('.tip_notifications').hasClass("display_none")).toBe(true);
  });

  it("keep tips modal open on modal click", function() {
    $('.tip_notifications_text').click();
    expect($('.tip_notifications').hasClass("display_none")).toBe(false);
  });

  it("close tips modal on backdrop click", function() {
    $('.tip_notifications').click();
    expect($('.tip_notifications').hasClass("display_none")).toBe(true);
  });

  it("close tips modal on esc key press", function() {
    keyPress(27);
    expect($('.tip_notifications').hasClass("display_none")).toBe(true);
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

  it("close quick create", function() {
    $('.quick_create_close').click();
    expect($('#category_quick_create').hasClass("display_none")).toBe(true);
  });

  it("keep quick create open on modal click", function() {
    $('.quick_create_text').click();
    expect($('#category_quick_create').hasClass("display_none")).toBe(false);
  });

  it("close quick create on backdrop click", function() {
    $('#category_quick_create').click();
    expect($('#category_quick_create').hasClass("display_none")).toBe(true);
  });

  it("close quick create on esc key press", function() {
    keyPress(27);
    expect($('#category_quick_create').hasClass("display_none")).toBe(true);
    expect($('#mood_quick_create').hasClass("display_none")).toBe(true);
    expect($('#strategy_quick_create').hasClass("display_none")).toBe(true);
  });
});
