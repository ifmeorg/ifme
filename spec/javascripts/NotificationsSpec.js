describe("Notifications", function() {
  beforeEach(function() {
    loadFixtures('notifications.html');
    onReadyNotifications();
    keyPress = spyOn(window, "keyPress"); //???
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

  it("close tips notifications modal", function() { // ADDED
    $('.tip_close_notifications').click();
    expect($('.tip_notifications').hasClass("display_none")).toBe(true);
  })

  it("keep tips modal open on modal click", function() { // ADDED
    $('.tip_notifications_text').click();
    expect($('.tip_notifications').hasClass("display_none")).toBe(false);
  });

  it("close tips modal on backdrop click", function() { // ADDED
    $('.tip_notifications').click();
    expect($('.tip_notifications').hasClass("display_none")).toBe(true);
  });

  it("close tips modal on esc key press", function() { // ADDED
    // ADD HERE!!!
    expect($('.tip_notifications').hasClass("display_none")).toBe(true);
  });

  it("close categories moods", function() { // UPDATED
    $('#close_categories_moods').click();
    expect($('#categories_moods').hasClass("display_none")).toBe(true);
  });

  it("keep categories moods open on modal click", function() { // ADDED
    $('#categories_moods_text').click();
    expect($('#categories_moods').hasClass("display_none")).toBe(false);
  });

  it("close categories moods on backdrop click", function() { // ADDED
    $('#categories_moods').click();
    expect($('#categories_moods').hasClass("display_none")).toBe(true);
  });

  it("close categories moods on esc key press", function() { // ADDED
    // ADD HERE!!!
    expect($('#categories_moods').hasClass("display_none")).toBe(true);
  });

  it("close quick create", function() { // ADDED
    $('.quick_create_close').click();
    expect($('#category_quick_create').hasClass("display_none")).toBe(true);
  });

  it("keep quick create open on modal click", function() { // ADDED
    $('.quick_create_text').click();
    expect($('#category_quick_create').hasClass("display_none")).toBe(false);
  });

  it("close quick create on backdrop click", function() { // ADDED
    $('#category_quick_create').click();
    expect($('#category_quick_create').hasClass("display_none")).toBe(true);
  });

  it("close quick create on esc key press", function() { // ADDED
    // ADD HERE!!!
    expect($('#category_quick_create').hasClass("display_none")).toBe(true);
    expect($('#mood_quick_create').hasClass("display_none")).toBe(true);
    expect($('#strategy_quick_create').hasClass("display_none")).toBe(true);
  });
});
