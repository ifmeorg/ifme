/*
Copyright (c) 2003-2011, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

if (typeof(CKEDITOR) !== 'undefined') {
  CKEDITOR.editorConfig = function( config )
  {
    // Define changes to default configuration here. For example:
    // config.language = 'fr';
    config.uiColor = 'rgba(0, 0, 0, 0.2)';

    /* Filebrowser routes */
    // The location of an external file browser, that should be launched when "Browse Server" button is pressed.
    config.filebrowserBrowseUrl = "/ckeditor/attachment_files";

    // The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Flash dialog.
    config.filebrowserFlashBrowseUrl = "/ckeditor/attachment_files";

    // The location of a script that handles file uploads in the Flash dialog.
    config.filebrowserFlashUploadUrl = "/ckeditor/attachment_files";

    // The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Link tab of Image dialog.
    config.filebrowserImageBrowseLinkUrl = "/ckeditor/pictures";

    // The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Image dialog.
    config.filebrowserImageBrowseUrl = "/ckeditor/pictures";

    // The location of a script that handles file uploads in the Image dialog.
    config.filebrowserImageUploadUrl = "/ckeditor/pictures";

    // The location of a script that handles file uploads.
    config.filebrowserUploadUrl = "/ckeditor/attachment_files";

    config.allowedContent = true;

    config.enterMode = CKEDITOR.ENTER_BR;

    // Skin
    config.skin = 'minimalist,/assets/ckeditor/minimalist/';

    // Rails CSRF token
    config.filebrowserParams = function(){
      var csrf_token, csrf_param, meta,
          metas = document.getElementsByTagName('meta'),
          params = {};

      for ( var i = 0 ; i < metas.length ; i++ ){
        meta = metas[i];

        switch(meta.name) {
          case "csrf-token":
            csrf_token = meta.content;
            break;
          case "csrf-param":
            csrf_param = meta.content;
            break;
          default:
            continue;
        }
      }

      if (csrf_param !== undefined && csrf_token !== undefined) {
        params[csrf_param] = csrf_token;
      }

      return params;
    };

    config.addQueryString = function( url, params ){
      var queryString = [];

      if ( !params ) {
        return url;
      } else {
        for ( var i in params )
          if ({}.hasOwnProperty.call(params, i)) {
            queryString.push( i + "=" + encodeURIComponent( params[ i ] ) );
          }
      }

      return url + ( ( url.indexOf( "?" ) !== -1 ) ? "&" : "?" ) + queryString.join( "&" );
    };

    // Integrate Rails CSRF token into file upload dialogs (link, image, attachment and flash)
    CKEDITOR.on( 'dialogDefinition', function( ev ){
      // Take the dialog name and its definition from the event data.
      var dialogName = ev.data.name;
      var dialogDefinition = ev.data.definition;
      var content, upload;

      if (CKEDITOR.tools.indexOf(['link', 'image', 'attachment', 'flash'], dialogName) > -1) {
        content = (dialogDefinition.getContents('Upload') || dialogDefinition.getContents('upload'));
        upload = (content === null ? null : content.get('upload'));

        if (upload && upload.filebrowser && upload.filebrowser.params === undefined) {
          upload.filebrowser.params = config.filebrowserParams();
          upload.action = config.addQueryString(upload.action, upload.filebrowser.params);
        }
      }
    });

    // Toolbar groups configuration.
    config.toolbar = [
      { name: 'links', items: [ 'Link', 'Unlink'] },
      { name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align', 'bidi' ], items: [ 'NumberedList', 'BulletedList' ] },
      { name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ], items: [ 'Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', '-', 'RemoveFormat' ] }
    ];
    config.toolbar_mini = config.toolbar;
  };
}
