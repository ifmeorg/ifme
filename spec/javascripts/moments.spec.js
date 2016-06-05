describe("Moments", function() {
  var NO_ALLIES = "Unselect all";
  var ALL_ALLIES = "Select all";
  beforeAll(function() {
    $("body")
    .prepend(
      $("<div>")
      .attr("id", "test_body")
      .append(
        $('<label>')
        .attr("id", "viewers_label")
      )
    )
    onReadyStrategies();
  });
  afterAll(function() {
    $("#test_body").remove();
    $("body").removeClass("moments new");
  });
  it("test no functions called", function() {
    var spy = spyOn(window, "newOrEdit");
    expect(spy).not.toHaveBeenCalled();
  });
	it("test onReadyMoments to be called", function() {
    var spy = spyOn(window, "newOrEdit");
    onReadyMoments();
    expect(spy).toHaveBeenCalled();
    expect($('#viewers_label').text()).toBe("");
  });
  it("test onReadyMoments and newOrEdit to be called", function() {
    $("body").addClass("moments new");
    onReadyMoments();
    expect($('#viewers_label').text()).toBe(ALL_ALLIES);
    onReadyMoments();
  });
  it("test newOeEdit in onReadyMoments to be called", function() {
    var spy = spyOn(window, "newOrEdit");
    onReadyMoments();
    expect(spy).toHaveBeenCalled();
  });
});
