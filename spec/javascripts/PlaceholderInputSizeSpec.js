describe("PlaceholderInputSize", function() {
  var setInputSize;

  beforeEach(function() {
    setInputSize = spyOn(window, "setInputSize");
  });

  it("does not call setInputSize() if not on valid page", function() {
    onReadyPlaceholderInputSize();
    expect(setInputSize).not.toHaveBeenCalled();
  });

  it("calls setInputSize() if on valid page", function() {
    loadFixtures("placeholder_input_size.html");
    $("body").addClass("allies index");
    onReadyPlaceholderInputSize();
    expect(setInputSize).toHaveBeenCalled();
  });
});
