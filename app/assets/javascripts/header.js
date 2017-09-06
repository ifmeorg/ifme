(function() {
  var currentTab;
  var smallNavSpacerHeight;

  function setHeight(override) {
    $('#header_space').css({
      height: _.isNumber(override) ? override : $('#header').height()
    });
  }

  function toggleArrow() {
    $('.header-logo .expand').toggleClass("fa-sort-desc").toggleClass("fa-sort-asc");
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

      var $visibleSecondaryNavs = $('.secondary-nav:not(.transition-hidden)');
      var $newSecondaryNav = $('ul[data-primary-parent=' + newTab + ']');
      if ($visibleSecondaryNavs.length) {
        if ($newSecondaryNav.length) {
          // Hacky way of skipping CSS transition animation
          $visibleSecondaryNavs.css('transition', 'none').toggleClass('transition-hidden');
          $newSecondaryNav.css('transition', 'none').toggleClass('transition-hidden');
          setTimeout(function() {
            $visibleSecondaryNavs.css('transition', '');
            $newSecondaryNav.css('transition', '');
          }, 0);
        } else {
          $visibleSecondaryNavs.toggleClass('transition-hidden');
        }
      } else {
        $newSecondaryNav.toggleClass('transition-hidden');
      }
    }
  }

  function primaryNavMouseleaveHandler() {
    currentTab = null;
    var $visibleSecondaryNavs = $('.secondary-nav:not(.transition-hidden)');
    $visibleSecondaryNavs.toggleClass('transition-hidden');
    if ($visibleSecondaryNavs.is('[data-primary-parent=me]')) {
      toggleArrow();
    }
  }

  function resizeHandler() {
    var smallNavIsVisible = $('#small_nav').is(':visible');
    if (smallNavIsVisible) {
      /*
       * If we're resizing while the smallNav is open, we need to force the spacer to retain the height
       * as though smallNav was closed. We'll cache the value in the smallNavSpacerHeight variable
       * when available, or determine its value by way of a quick close/measure/open process.
       */
      if (!_.isNumber(smallNavSpacerHeight)) {
        closeSmallNav();
        smallNavSpacerHeight = $('.small-screen').height();
        openSmallNav();
      }
      setHeight(smallNavSpacerHeight);

    } else {
      /*
       * Just in case it's open and the user resizes the window and triggers the medium screen size breakpoint
       * close the smallNav.
       */
      closeSmallNav();
      setHeight();
    }
  }

  function closeSmallNav() {
    $('#small_nav').addClass('display_none').removeClass('display_block');
  }

  function openSmallNav() {
    $('#small_nav').removeClass('display_none').addClass('display_block');
  }

  loadPage(function() {
    setHeight();
    $('#header')
      .on('mouseenter', '.primary-nav a, [data-nav-name]', primaryNavMouseenterHandler)
      .on('mouseleave', primaryNavMouseleaveHandler);
    $(window).on('resize', _.debounce(resizeHandler, 100));

    // Mobile menu toggling
    $('#expand_nav').click(function() {
      $('#small_nav').toggleClass('display_none').toggleClass('display_block');
      if ($('#small_nav').is('.display_none')) {
        setHeight();
      }
    });
  });

}());
