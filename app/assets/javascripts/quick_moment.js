function toggleCategoriesMoods(show) {
  categories_moods = $("#categories_moods");
  if (show) {
    categories_moods.removeClass("display_none");
    categories_moods.addClass("display_block");
    showBackdrop();
  } else {
    categories_moods.removeClass("display_block");
    categories_moods.addClass("display_none");
    hideBackdrop();
  }
}

function showCategoriesMoods() {
  toggleCategoriesMoods(true);
}

function hideCategoriesMoods() {
  toggleCategoriesMoods(false);
}

var onReadyQuickMoment = function() {
  $("#toggle_categories_moods").click(function() {
    if ($("#categories_moods")[0].classList.contains("display_none")) {
      showCategoriesMoods();
    } else {
      hideCategoriesMoods();
    }
  });

  $("#close_categories_moods").click(function() {
    hideCategoriesMoods();
  });

  $("#categories_moods").click(function() {
    hideCategoriesMoods();
  });

  $("#categories_moods_text").click(function(event) {
    event.stopPropagation();
  });
};

$(document).on("page:load ready", onReadyQuickMoment);
