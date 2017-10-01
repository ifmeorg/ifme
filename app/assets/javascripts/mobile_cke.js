var onReadyMobileCke = function() {
  var MEDIUM_BREAKPOINT = 640;

  var ui = null;
  var focused_editor = null;
  var modal_editor = CKEDITOR.instances.modal_editor;

  $('#close_editor').click(function() {
    $('#editor_modal').removeClass('display_block');
    $('#editor_modal').addClass('display_none');
    focused_editor.setData(modal_editor.getData());
    modal_editor.focus();
    $('body').removeClass('no_scroll');
  });

  for (instance in CKEDITOR.instances) {
    var editor = CKEDITOR.instances[instance];
    if (editor.name != 'modal_editor') {
      editor.on('focus', function(event) {
        if ($(window).width() <= MEDIUM_BREAKPOINT) {
          $('body').addClass('no_scroll');
          showEditorModal();
          focused_editor = this;
          ui = jQuery(this.container.$);
          modal_editor.setData(this.getData());
        }
      });
    }
  }
};

function showEditorModal() {
  $('#editor_modal').removeClass('display_none');
  $('#editor_modal').addClass('display_block');
}

loadPage(onReadyMobileCke);
