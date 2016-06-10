describe("onReadyHeader", function() {

    xit("has called setHeight", function() {

      var spy = spyOn(window, 'setHeight');

      onReadyHeader();

      expect(spy).toHaveBeenCalled();

    });

    // doesn't work yet

    it("toggles expand_me visibility", function (){
      var click_flag = { value : 0 };

      onReadyHeader();

      var spy1 = spyOn(window, 'hideSmallTopNav');

      var spy2 = spyOn(window, 'showExpandMe');

      expandButton({ data: click_flag });

      expect(spy1).toHaveBeenCalled();

      expect(spy2).toHaveBeenCalled();

    });

    xit("toggles small_nav visibility", function (){

      onReadyHeader();

      var spy0 = spyOn(window, 'showSmallTopNav');

      var spy1 = spyOn(window, 'hideSmallTopNav');

      var spy2 = spyOn(window, 'hideExpandMe');

      $('#expand_nav').click();

      $('#small_nav').addClass('display_none');

      $('#expand_nav').click();

      expect(spy0).toHaveBeenCalled();

      expect(spy1).toHaveBeenCalled();

      expect(spy2).toHaveBeenCalled();

    });

  });
