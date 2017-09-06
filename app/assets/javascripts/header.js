(function() {
  var currentTab;
  var animationTimespan = 300; // in ms; this must match header.scss 'transition: max-height' value
  var smallNavSpacerHeight;

  function setHeight(override) {
    $('#header_space').css({
      height: _.isNumber(override) ? override : $('#header').height()
    });
  }

  function toggleArrow() {
    $('.header-logo .expand').toggleClass('fa-sort-desc').toggleClass('fa-sort-asc');
  }

  function toggleVisibility($el) {
    return $el.toggleClass('display_none').toggleClass('display_block');
  }

  function hide($el) {
    return $el.addClass('display_none').removeClass('display_block');
  }

  function show($el) {
    return $el.removeClass('display_none').addClass('display_block');
  }

  function getVisibleSecondaryNavs() {
    return $('.secondary-nav > ul.display_block');
  }

  /**
   * We add a delay so that the 'collapsed' CSS class can properly animate the transition
   * before we display:none the content (which causes the container to collapse immediately).
   */
  function hideVisibleSecondaryNavsWithTransition() {
    $('.secondary-nav')
      .addClass('collapsed')
      .delay(animationTimespan)
      .promise()
      .then(function () {
        toggleVisibility(getVisibleSecondaryNavs());
      });
  }

  function primaryNavMouseenterHandler(e) {
    var previousTab = currentTab;
    var newTab = e.currentTarget.dataset.navName;
    var tabChanged = previousTab !== newTab;

    if (tabChanged) {
      currentTab = newTab;

      if (newTab === 'me' || previousTab === 'me') {
        toggleArrow();
      }

      var $visibleSecondaryNavs = getVisibleSecondaryNavs();
      var $newSecondaryNav = $('ul[data-primary-parent=' + newTab + ']');
      if ($visibleSecondaryNavs.length) {
        if ($newSecondaryNav.length) {
          // Transition between two secondary navs
          toggleVisibility($newSecondaryNav);
          toggleVisibility($visibleSecondaryNavs);
        } else {
          // Transition from visible to no secondary navs
          hideVisibleSecondaryNavsWithTransition();
        }
      } else {
        // Transition from no secondary navs to potentially visible
        $('.secondary-nav').removeClass('collapsed');
        toggleVisibility($newSecondaryNav);
      }
    }
  }

  function primaryNavMouseleaveHandler() {
    currentTab = null;
    var $visibleSecondaryNavs = getVisibleSecondaryNavs();
    if ($visibleSecondaryNavs.is('[data-primary-parent=me]')) {
      toggleArrow();
    }
    hideVisibleSecondaryNavsWithTransition();
  }

  function resizeHandler() {
    var $smallNav = $('#small_nav');
    var smallNavIsVisible = $smallNav.is(':visible');
    if (smallNavIsVisible) {
      /*
       * If we're resizing while the smallNav is open, we need to force the spacer to retain the height
       * as though smallNav was closed. We'll cache the value in the smallNavSpacerHeight variable
       * when available, or determine its value by way of a quick close/measure/open process.
       */
      if (!_.isNumber(smallNavSpacerHeight)) {
        hide($smallNav);
        smallNavSpacerHeight = $('.small-screen').height();
        show($smallNav);
      }
      setHeight(smallNavSpacerHeight);

    } else {
      /*
       * Just in case smallNav is open, and the user resizes the window and triggers the
       * medium screen size breakpoint, we'll close the smallNav.
       */
      hide($smallNav);
      setHeight();
    }
  }

  loadPage(function() {
    setHeight();
    $('#header')
      .on('mouseenter', '.primary-nav a, [data-nav-name]', primaryNavMouseenterHandler)
      .on('mouseleave', primaryNavMouseleaveHandler);
    $(window).on('resize', _.debounce(resizeHandler, 100));

    // Mobile menu toggling
    $('#expand_nav').click(function() {
      toggleVisibility($('#small_nav'));
      if ($('#small_nav').is('.display_none')) {
        setHeight();
      }
    });
  });

}());
