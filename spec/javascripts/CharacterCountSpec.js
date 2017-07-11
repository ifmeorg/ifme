describe("CharacterCount", function() {
  describe("onReadyCharacterCount", function() {
    var noCKEditor, changeEditorCount;

    beforeEach(function() {
      changeEditorCount = spyOn(window, 'changeEditorCount').and.callThrough();
      noCKEditor = spyOn(window, 'noCKEditor').and.callThrough();
    });

    describe('noCKEditor', function() {
      describe('home page', function() {
        beforeEach(function() {
          $('body').addClass('pages home')
          loadFixtures('character_count.html');

          onReadyCharacterCount();
          $('#moment_why').keyup()
        });

        it("noCKEditor to be called", function() {
          expect(noCKEditor).toHaveBeenCalled()
        });
      })

      describe('character limit', function() {
        function charLimit(val) {
          loadFixtures('character_count.html');
          var editor = $('#moment_why');
          editor.val(val)
          noCKEditor(editor);
        }

        it("submit button should not be disabled", function() {
          charLimit('aaaaaaa')
          var input = $('input[type="submit"]');

          expect(input.attr('disabled')).toBeFalsy()
        });

        it("submit button should not be disabled", function() {
          var overLimit = new Array(2002).join('a')
          charLimit(overLimit)
          var input = $('input[type="submit"]');

          expect(input.attr('disabled')).toBeTruthy()
        });
      })
    });
  });
});
