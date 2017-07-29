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
    $('#clear_notifcations').click();
    expect($('#notifications_none').hasClass("display_block")).toBe(true);
  });

  it("close categories moods", function() {
    hideCategoriesMoods();
    expect($('#categories_moods').hasClass("display_none")).toBe(true);
  });

  it("has titlebar border", function() {
    $('.titlebar').parent().scroll();
    expect($('.titlebar').hasClass("scrolling")).toBe(true);
  });
});
