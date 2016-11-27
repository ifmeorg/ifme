describe("Header", function() {
  beforeEach(function() {
    loadFixtures('header.html');
  });

  describe("onReadyHeader", function() {
    var setHeight;
    var hideSmallTopNav;
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
      showSmallTopNav = spyOn(window, 'showSmallTopNav');
      hideExpandMe = spyOn(window, 'hideExpandMe');
      showExpandMoment = spyOn(window, 'showExpandMoment');
      hideExpandMoment = spyOn(window, 'hideExpandMoment');
      expandButton = spyOn(window, 'expandButton');
      expandMomentMouseover = spyOn(window, 'expandMomentMouseover');
      headerMouseLeave = spyOn(window, 'headerMouseLeave');
    });

    it("has called setHeight when onReadyHeader has executed", function() {
      onReadyHeader();
      expect(setHeight).toHaveBeenCalled();
    });

    it("has called expandButton when clicked", function() {
      onReadyHeader();
      $('.expand_button').click();
      expect(expandButton).toHaveBeenCalled();
    });


    it("has called showSmallTopNav when small_nav has display_none as a class", function() {
      $('#small_nav').addClass('display_none');
      onReadyHeader();
      $('#expand_nav').click();
      expect(showSmallTopNav).toHaveBeenCalled();
      expect(setHeight).toHaveBeenCalled();
    });

    it("has called hideSmallTopNav when display_none is not a class on small_nav", function() {
      onReadyHeader();
      $('#expand_nav').click();
      expect(hideSmallTopNav).toHaveBeenCalled();
      expect(setHeight).toHaveBeenCalled();
    });

    it("has called expandMomentMouseover when expand_moment_button is moused over", function() {
      onReadyHeader();
      $('.expand_moment_button').mouseover();
      expect(expandMomentMouseover).toHaveBeenCalled();
    });

    it("has called headerMouseLeave when header is moused over", function() {
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
      opacity = Math.round($('#expand_nav').css('opacity') * 10) / 10
      expect(opacity).toBe(0.8);
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
    var hideExpandMe;
    var setHeight;
    var opacity;

    beforeEach(function() {
      hideSmallTopNav = spyOn(window, 'hideSmallTopNav');
      $('#expand_me').addClass("display_block");
      setHeight = spyOn(window, 'setHeight');
    });

    it("has called hideSmallTopNav when expandButton is executed", function() {
      expandButton();
      expect(hideSmallTopNav).toHaveBeenCalled();
    });

    it("has added display_none to expand_me", function() {
      expandButton();
      expect($('#expand_me').hasClass('display_none')).toBe(true);
    });

    it("has changed #me opacity amount to 0.8", function() {
      expandButton();
      opacity = convert_opacity('me');
      expect(opacity).toBe(0.8);
    });

    it("has changed #title_expand opacity amount to 0.8", function() {
      expandButton();
      opacity = convert_opacity('title_expand');
      expect(opacity).toBe(0.8);
    });

    it("has called setHeight when expandButton is executed", function() {
      expandButton();
      expect(setHeight).toHaveBeenCalled();
    });
  });

  describe("headerMouseLeave", function() {
    var hideExpandMoment;
    var setHeight;

    beforeEach(function() {
      hideExpandMoment = spyOn(window, 'hideExpandMoment');
      setHeight = spyOn(window, 'setHeight');
      $('#expand_moment').length = true;
      $('#expand_moment').addClass('display_block');
    });

    it("has called hideExpandMoment when expand_moment has a length and display_block class", function() {
      headerMouseLeave();
      expect(hideExpandMoment).toHaveBeenCalled();
    });

    it("has called setHeight when expand_moment has a length and display_block class", function() {
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

    it("has called showExpandMoment when expand_moment has a display_none class", function() {
      $('#expand_moment').addClass('display_none');
      expandMomentMouseover();
      expect(showExpandMoment).toHaveBeenCalled();
    });

    it("has called hideExpandMe when expand_moment has a display_none class", function() {
      $('#expand_moment').addClass('display_none');
      expandMomentMouseover();
      expect(hideExpandMe).toHaveBeenCalled();
    });

    it("has called setHeight when expand_moment has a display_none class", function() {
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
