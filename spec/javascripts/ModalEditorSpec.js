describe("ModalEditor", function() {
  beforeEach(function() {
    loadFixtures("modal_editor.html");
    onReadyModalEditor();
  });

  it("should be shown", function() {
    showEditorModal();
    expect($("#editor_modal")).toBeVisible();
  });

  it("should be closed when x is clicked", function() {
    showEditorModal();
    $("#close_editor").click();
    expect($("#editor_modal")).toBeHidden();
    expect($("#modal_text")).toBeHidden();
  });

  it("should be kept open on modal click", function() {
      showEditorModal();
      $("#editor_modal").click();
      expect($("#editor_modal")).toBeVisible();
      expect($("#editor_modal")).toBeVisible();
  });
});
