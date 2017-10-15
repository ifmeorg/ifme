function showEditorModal() {
  $("#editor_modal").removeClass("display_none");
  $("#editor_modal").addClass("display_block");
}

function hideEditorModal(focused_editor, modal_editor) {
  $("#editor_modal").removeClass("display_block");
  $("#editor_modal").addClass("display_none");
  if(focused_editor) focused_editor.setData(modal_editor.getData());
  if(modal_editor) modal_editor.focus();
  $("body").removeClass("no_scroll");
}

var onReadyModalEditor = function() {
  var MEDIUM_BREAKPOINT = 640;
  var ui, focused_editor;
  var modal_editor = CKEDITOR && CKEDITOR.instances && CKEDITOR.instances.modal_editor;

  $("#close_editor").click(function() {
    hideEditorModal(focused_editor, modal_editor);
  });

  function focusEditor(editor) {
    editor.on("focus", function(event) {
      if ($(window).width() <= MEDIUM_BREAKPOINT) {
        $("body").addClass("no_scroll");
        showEditorModal();
        focused_editor = this;
        ui = $(this);
        modal_editor.setData(this.getData());
      }
    });
  }

  for (var instance in CKEDITOR.instances) {
    if( CKEDITOR.instances.hasOwnProperty(instance) ) {
      var editor = CKEDITOR.instances[instance];
      if (editor.name !== "modal_editor") {
        focusEditor(editor);
      }
    }
  }
};

loadPage(onReadyModalEditor);
