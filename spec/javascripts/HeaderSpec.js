describe("Header", function() {

  beforeEach(function() {
    var elements = [];
    elements.push("<div id='expand_moment'></div>");
    elements.push("<div id='title_expand'></div>");
    elements.push("<div id='moment'></div>");
    elements.push("<div id='header'></div>");
    elements.push("<div id='header_space'></div>");
    elements.push("<div id='me'></div>");
    elements.push("<div id='expand_me'></div>");
    elements.push("<div id='small_nav'></div>");
    elements.push("<div id='expand_nav'></div>");
    elements.push("<span class='expand_button'></span>");
    elements.push("<a class='expand_moment_button'></a>");
    for (var i = 0; i < elements.length; i++) {
      $(document.body).append(elements[i]);
    }
  });

  describe("onReadyHeader", function() {
     var setHeight;
     var hideSmallTopNav;
     var showExpandMe;
     var showSmallTopNav;
     var hideExpandMe;
     var showExpandMoment;
     var hideExpandMoment;
     var expandButton;
     var expandMomentMouseover;
     var headerMouseLeave;

    beforeEach(function() {
        setHeight = spyOn(window, 'setHeight');
        hideSmallTopNav = spyOn(window, 'hideSmallTopNav');
        showExpandMe = spyOn(window, 'showExpandMe');
        showSmallTopNav = spyOn(window, 'showSmallTopNav');
        hideExpandMe = spyOn(window, 'hideExpandMe');
        showExpandMoment = spyOn(window, 'showExpandMoment');
        hideExpandMoment = spyOn(window, 'hideExpandMoment');
        expandButton = spyOn(window, 'expandButton');
        expandMomentMouseover = spyOn(window, 'expandMomentMouseover');
        headerMouseLeave = spyOn(window, 'headerMouseLeave');
    });

    it("has called setHeight", function() {
      onReadyHeader();

      expect(setHeight).toHaveBeenCalled();
    });

    it("has called expandButton when clicked", function() {

      onReadyHeader();

      $('.expand_button').click();

      expect(expandButton).toHaveBeenCalled();
    });

    it("has called hideExpandMe when #expand_nav has been clicked", function() {
        onReadyHeader();
        $('#expand_nav').click();

        expect(hideExpandMe).toHaveBeenCalled();
    });

    it("has called showSmallTopNav when #expand_nav has been clicked", function() {
        $('#small_nav').addClass('display_none');

        onReadyHeader();
        $('#expand_nav').click();

        expect(showSmallTopNav).toHaveBeenCalled();
    });

    it("has called hideSmallTopNav when #expand_nav has been clicked", function() {
        onReadyHeader();
        $('#expand_nav').click();

        expect(hideSmallTopNav).toHaveBeenCalled();
    });

    it("has called expandMomentMouseover", function() {
        onReadyHeader();
        $('.expand_moment_button').mouseover();

        expect(expandMomentMouseover).toHaveBeenCalled();
    });

    it("has called headerMouseLeave", function() {
        onReadyHeader();
        $('#header').mouseleave();

        expect(headerMouseLeave).toHaveBeenCalled();
    });

    it("has called setHeight on window resize", function() {
      $(window).resize();

      expect(setHeight).toHaveBeenCalled();
    });
  });

  describe("hideSmallTopNav", function() {
    beforeEach(function() {
      $('#small_nav').addClass('display_block');
    });

    it("has removed display_block class from small_nav", function() {

        hideSmallTopNav();

        expect($('#small_nav').hasClass('display_block')).toBe(false);
    });

    it("has added display_none class to small_nav", function() {

        hideSmallTopNav();

        expect($('#small_nav').hasClass('display_none')).toBe(true);
    });

     it("has changed expand_nav opacity amount to 1", function() {

        hideSmallTopNav();

         expect($('#expand_nav').css('opacity')).toBe('1');
    });
  });


  describe("showSmallTopNav", function() {
    beforeEach(function() {
      $('#small_nav').addClass('display_none');
    });

    it("has removed display_none class from small_nav", function() {
        showSmallTopNav();

        expect($('#small_nav').hasClass('display_none')).toBe(false);
    });

     it("has added display_block class to small_nav", function() {
        showSmallTopNav();

        expect($('#small_nav').hasClass('display_block')).toBe(true);
    });

    it("has changed expand_nav opacity amount to 0.8", function() {
      showSmallTopNav();

      expect($('#expand_nav').css('opacity')).toBe('0.8');
    });
  });


  describe("hideExpandMe", function() {
    beforeEach(function () {
      $('#expand_me').addClass('display_block');
    });

     it("has removed display_block class from expand_me", function() {
        hideExpandMe();

        expect($('#expand_me').hasClass('display_block')).toBe(false);
    });

    it("has added display_none class to expand_me", function() {
      hideExpandMe();

      expect($('#expand_me').hasClass('display_none')).toBe(true);
    });

     it("has changed #me opacity amount to 1", function() {
      hideExpandMe();

      expect($('#me').css('opacity')).toBe('1');
    });

     it("has changed title_expand opacity amount to 1", function() {
      hideExpandMe();

      expect($('#title_expand').css('opacity')).toBe('1');
    });
  });

  describe("showExpandMe", function() {
    beforeEach(function () {
      $('#expand_me').addClass('display_none');
    });

    it("has removed display_none from expandMe", function() {
      showExpandMe();

      expect($('#expand_me').hasClass('display_none')).toBe(false);
    });

    it("has added display_block to expandMe", function() {
      showExpandMe();

      expect($('#expand_me').hasClass('display_block')).toBe(true);
    });

    it("has changed #me opacity amount to 0.8", function() {
      showExpandMe();

      expect($('#me').css('opacity')).toBe('0.8');
    });

    it("has changed #title_expand opacity amount to 0.8", function() {
      showExpandMe();

      expect($('#title_expand').css('opacity')).toBe('0.8');
    });
  });

  describe("showExpandMoment", function() {
    beforeEach(function (){
      $('#expand_moment').addClass('display_none');
    });

    it("has removed display_none from expand_moment", function() {
      showExpandMoment();

      expect($('#expand_moment').hasClass('display_none')).toBe(false);
    });

    it("has added display_block to expand_moment", function() {
      showExpandMoment();

      expect($('#expand_moment').hasClass('display_block')).toBe(true);
    });
  });

  describe("hideExpandMoment", function() {
    beforeEach(function() {
      $('#expand_moment').addClass('display_block');
    });

    it("has removed display_block from expand_moment", function() {
        hideExpandMoment();

        expect($('#expand_moment').hasClass('display_block')).toBe(false);
    });

    it("has added display_none to expand_moment", function() {
        hideExpandMoment();

        expect($('#expand_moment').hasClass('display_none')).toBe(true);
    });

    it("has changed moment opacity amount to 1", function() {
        hideExpandMoment();

        expect($('#moment').css('opacity')).toBe('1');
    });

     it("has changed title_expand opacity amount to 1", function() {
        hideExpandMoment();

        expect($('#title_expand').css('opacity')).toBe('1');
    });

  });

  describe("setHeight", function() {
    it("has set the height of header_space to 17", function() {
      $('#header').height(17);

      setHeight();

      expect($('#header_space').height()).toBe(17);

    });
  });

  describe("expandButton", function() {

    var click_flag;
    var hideSmallTopNav;
    var showExpandMe;
    var hideExpandMe;
    var setHeight;

    beforeEach(function() {
      click_flag = { value: 0 };
      hideSmallTopNav = spyOn(window, 'hideSmallTopNav');
      showExpandMe = spyOn(window, 'showExpandMe');
      hideExpandMe = spyOn(window, 'hideExpandMe');
      setHeight = spyOn(window, 'setHeight');
    });

    it("has called hideSmallTopNav", function() {
        expandButton({ data: click_flag});

        expect(hideSmallTopNav).toHaveBeenCalled();
    });

    it("has called showExpandMe when click_flag value is 0", function() {
       expandButton({ data: click_flag});

       expect(showExpandMe).toHaveBeenCalled();
    });

     it("has called hideExpandMe when click_flag value is not evenly divisble by 0", function() {
       click_flag = 3;

       expandButton({ data: click_flag});

       expect(hideExpandMe).toHaveBeenCalled();
    });

     it("has called setHeight", function() {
        expandButton({ data: click_flag});

        expect(setHeight).toHaveBeenCalled();
     });

     it("has increased click_flag value by 1", function() {
        expandButton({ data: click_flag});

        expect(click_flag.value).toBe(1);
     });
   });

  describe("headerMouseLeave", function() {
    var hideExpandMoment;

    beforeEach(function() {
      hideExpandMoment = spyOn(window, 'hideExpandMoment');
      setHeight = spyOn(window, 'setHeight');
    });

    it("has called hideExpandMoment", function() {
      $('#expand_moment').length = true;
      $('#expand_moment').addClass('display_block');

      headerMouseLeave();

      expect(hideExpandMoment).toHaveBeenCalled();
    });

    it("has called setHeight", function() {
      $('#expand_moment').length = true;
      $('#expand_moment').addClass('display_block');

      headerMouseLeave();

      expect(setHeight).toHaveBeenCalled();
    });
  });

   describe("expandMomentMouseover", function() {
        var showExpandMoment;
        var hideExpandMe;
        var setHeight;

        beforeEach(function() {
            showExpandMoment = spyOn(window, 'showExpandMoment');
            hideExpandMe = spyOn(window, 'hideExpandMe');
            setHeight = spyOn(window, 'setHeight');
        });

        it("has called showExpandMoment", function() {
            $('#expand_moment').addClass('display_none');
            expandMomentMouseover();

            expect(showExpandMoment).toHaveBeenCalled();
        });

        it("has increased the value of click_flag by one", function() {
            var click_flag = { value : 1 };
            $('#expand_moment').addClass('display_none');
            $('#expand_me').addClass('display_block');

            expandMomentMouseover(click_flag);

            expect(click_flag.value).toBe(2);

        });

        it("has called hideExpandMe", function() {
            $('#expand_moment').addClass('display_none');

            expandMomentMouseover();

            expect(hideExpandMe).toHaveBeenCalled();
        });

        it("has called setHeight", function() {
            $('#expand_moment').addClass('display_none');

            expandMomentMouseover();

            expect(setHeight).toHaveBeenCalled();
        });
   });

  afterEach(function (){
    $('#expand_moment').remove();
    $('#title_expand').remove();
    $('#moment').remove();
    $('#header').remove();
    $('#header_space').remove();
    $('#me').remove();
    $('#expand_me').remove();
    $('#small_nav').remove();
    $('#expand_nav').remove();
  });

});
