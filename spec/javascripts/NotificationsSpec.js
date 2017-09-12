const keyPress = require("./helpers/key-press");

describe("Notifications", function() {
  beforeEach(function() {
    loadFixtures("notifications.html");
    onReadyNotifications();
  });

  it("test notifications show", function() {
    showNotifications();
    expect($("#notifications").hasClass("display_block")).toBe(true);
  });

  it("show notifications none", function() {
    showNotificationsNone();
    expect($("#notifications_none").hasClass("display_block")).toBe(true);
  });

  it("show notifications modal", function() {
    $(".notifications_button").click();
    expect($("#notifications").hasClass("display_block")).toBe(true);
  });

  it("close notifications modal", function() {
    $("#close_notifications").click();
    expect($("#notifications")).toBeHidden();
  });

  it("clear notifications modal", function() {
    $("#clear_notifications").click();
    expect($("#notifications_none").hasClass("display_block")).toBe(true);
  });

  it("close tips notifications modal", function() {
    $(".tip_close_notifications").click(function(e) {
      e.stopPropagation();
      expect($(".tip_notifications").hasClass("display_none")).toBe(true);
    });
  });

  it("keep tips modal open on modal click", function() {
    $(".tip_notifications_text").click();
    expect($(".tip_notifications").hasClass("display_none")).toBe(false);
  });

  it("close tips modal on backdrop click", function() {
    $(".tip_notifications").click();
    expect($(".tip_notifications").hasClass("display_none")).toBe(true);
  });

  it("close tips modal on esc key press", function() {
    keyPress(27);
    expect($(".tip_notifications").hasClass("display_none")).toBe(true);
  });

  it("has titlebar border", function() {
    titlebarBorderShow();
    expect($(".titlebar").hasClass("scrolling")).toBe(true);
  });

  it("does not have titlebar border", function() {
    titlebarBorderHide();
    expect($(".titlebar").hasClass("scrolling")).toBe(false);
  });
});
