describe("Notifications", function() {
  beforeEach(function() {
    var elements = [];
    elements.push("<div id='notifications'></div>");
    elements.push("<div id='notifications_none'></div>");
    elements.push("<div id='notifications_text'></div>");
    elements.push("<div class='modal_text'></div>");
    elements.push("<div id='categories_moods'></div>");
    elements.push("<a class='notifications_button'></a>");
    elements.push("<div class='close_categories_moods'></div>");
    elements.push("<h1 id='close_notifications'></h1>");
    elements.push("<h1 id='clear_notifcations'></h1>");
    elements.push("<i id='notifications_none'></i>");
    for (var i = 0; i < elements.length; i++) {
      $(document.body).append(elements[i]);
    }
  });

  it("has called onReadyNotifications", function() {
      var onReadyNotifications = spyOn(window, 'onReadyNotifications');
      onReadyNotifications();
      expect(onReadyNotifications).toHaveBeenCalled();
    });

  it("test notifications show", function() {
    showNotifications();
    expect($('body').hasClass("show_backdrop")).toBe(true);
    expect($('#notifications').hasClass("display_block")).toBe(true);
  });

  it("show notifications none", function() {
    showNotificationsNone();
    expect($('body').hasClass("show_backdrop")).toBe(true);
    expect($('#notifications_none').hasClass("display_block")).toBe(true);
  });

  it("show notifications modal", function() {
    find('.notifications_button').click
    expect($('body').hasClass("show_backdrop")).toBe(true);
    expect($('#notifications').hasClass("display_block")).toBe(true);
  });

  it("close notifications modal", function() {
    find('h1#close_notifications').click
    expect($('body').hasClass("show_backdrop")).toBe(false);
    expect($('div#notifications').toBeHidden();
  });

  it("clear notifications modal", function() {
    find('#clear_notifcations').click
    expect($('body').hasClass("show_backdrop")).toBe(true);
    expect($('#notifications_none').hasClass("display_block")).toBe(true);
  });

  it("close categories moods", function() {
    hideCategoriesMoods();
    expect($('body').hasClass("show_backdrop")).toBe(true);
    expect($('#categories_moods').hasClass("display_none")).toBe(true);
  });
});
