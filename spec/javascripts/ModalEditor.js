
describe("ModalEditor", function() {
  beforeEach(function() {
    loadFixtures("modal_editor.html");
    onReadyModalEditor();
  });

  it("close modal", function() {
    $("#close_editor").click();
    expect($("#editor_modal").hasClass("display_none")).toBe(true);
  });

  it("keep modal open on modal click", function() {
    $("#editor_modal").click();
    expect($("#editor_modal").hasClass("display_none")).toBe(false);
  });
});
