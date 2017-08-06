describe("ExpandToggle", function() {
  beforeEach(function() {
    loadFixtures('expand_toggle.html');

    var newOrEdit = spyOn(window, 'newOrEdit');
    newOrEdit.and.returnValue(true);

    onReadyExpandToggle();
  });

  it("toggles expand_toggle",  function() {
    expect($(".fa-caret-down").length).toBe(1);
    expect($(".fa-caret-up").length).toBe(0);
    $("[data-toggle=\"#categories\"]").click();
    expect($(".fa-caret-down").length).toBe(0);
    expect($(".fa-caret-up").length).toBe(1);
  });
});
