function showCategoriesMoods() {
  $('#categories_moods').removeClass('display_none');
  $('#categories_moods').addClass('display_block');
  showBackdrop();
}

function hideCategoriesMoods() {
  $('#categories_moods').removeClass('display_block');
  $('#categories_moods').addClass('display_none');
  hideBackdrop();
}
