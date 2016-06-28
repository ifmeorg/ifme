describe("Header", function() {

  beforeEach(function() {
    // mocking the DOM
    // "fresh" DOM will be created before
    //  calling each describe()
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

    beforeEach(function() {
        setHeight = spyOn(window, 'setHeight');
        hideSmallTopNav = spyOn(window, 'hideSmallTopNav');
        showExpandMe = spyOn(window, 'showExpandMe');
        showSmallTopNav = spyOn(window, 'showSmallTopNav');
        hideExpandMe = spyOn(window, 'hideExpandMe');
        showExpandMoment = spyOn(window, 'showExpandMoment');
        hideExpandMoment = spyOn(window, 'hideExpandMoment');
    });

    it("has called setHeight", function() {
      onReadyHeader();
      expect(setHeight).toHaveBeenCalled();
    });

    it("toggles expand_me visibility", function (){
      var click_flag = { value: 0 };
      onReadyHeader();
      expandButton({ data: click_flag });
      expect(hideSmallTopNav).toHaveBeenCalled();
      expect(showExpandMe).toHaveBeenCalled();
    });

    it("toggles small_nav visibility", function (){
      onReadyHeader();
      $('#expand_nav').click();
      $('#small_nav').addClass('display_none');
      $('#expand_nav').click();
      expect(showSmallTopNav).toHaveBeenCalled();
      expect(hideSmallTopNav).toHaveBeenCalled();
      expect(hideExpandMe).toHaveBeenCalled();
    });

    it("handles expand_moment_button mouseover event", function() {
      $("#expand_moment").addClass("display_none");
      expandMomentMouseover();
      expect(setHeight).toHaveBeenCalled();
      expect(hideExpandMe).toHaveBeenCalled();
      expect(showExpandMoment).toHaveBeenCalled();
    });

    it("calls hideExpandMoment() and setHeight() on $('#header').mouseleave", function() {
      $('#expand_moment').length = true;
      $('#expand_moment').addClass('display_block');
      headerMouseLeave();
      expect(setHeight).toHaveBeenCalled();
      expect(hideExpandMoment ).toHaveBeenCalled();
    });

    it("calls setHeight() on window resize", function() {
      $(window).resize();
      expect(setHeight).toHaveBeenCalled();
    });
  });



  describe("hideSmallTopNav", function() {
    beforeEach(function() {
      // adding the class to make sure shideSmallTopNav gets rid of it
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
      // adding the class to make sure showSmallTopNav gets rid of it
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
      // adding the class to make sure hideExpandMe gets rid of it
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
      // adding the class to make sure showExpandMe gets rid of it
      $('#expand_me').addClass('display_none');
    });

    it("has changed expand_me class", function() {
      showExpandMe();
      expect($('#expand_me').hasClass('display_none')).toBeFalsy();
      expect($('#expand_me').hasClass('display_block')).toBeTruthy();
    });

    it("has set me and title_expand opacity", function() {
      showExpandMe();
      var meOpacity = parseFloat($('#me').css('opacity')).toFixed(1);
      var titleExpandOpacity = parseFloat($('#title_expand').css('opacity')).toFixed(1);
      expect(meOpacity).toBe('0.8');
      expect(titleExpandOpacity).toBe('0.8');
    });
  });



  describe("showExpandMoment", function() {
    beforeEach(function (){
      // adding the class to make sure showExpandMoment gets rid of it
      $('#expand_moment').addClass('display_none');
    });

    it("has set the expand_moment class", function() {
      showExpandMoment();
      expect($('#expand_moment').hasClass('display_none')).toBeFalsy();
      expect($('#expand_moment').hasClass('display_block')).toBeTruthy();
    });
  });



  describe("hideExpandMoment", function() {
    beforeEach(function() {
      // adding the class to make sure hideExpandMe gets rid of it
      $('#expand_moment').addClass('display_block');
    });

    it("has changed expand_moment class", function() {
      hideExpandMoment();
      expect($('#expand_moment').hasClass('display_block')).toBeFalsy();
      expect($('#expand_moment').hasClass('display_none')).toBeTruthy();
    });

    it("has set moment and title_expand opacity", function() {
      expect($('#moment').css('opacity')).toBe('1');
      expect($('#title_expand').css('opacity')).toBe('1');
    });
  });



  describe("setHeight", function() {
    it("has set the height of header_space", function() {
      // testing for 2 arbitrarly chosen values
      $('#header').height(17);
      setHeight();
      expect($('#header_space').height()).toBe(17);

      $('#header').height(24);
      setHeight();
      expect($('#header_space').height()).toBe(24);
    });
  });


  // cleaning up mock DOM after each describe()
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
