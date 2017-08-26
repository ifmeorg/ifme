modules.export = function(elem) {
  return Math.round(
    $(`#${elem}`).css('opacity') * 10
  ) / 10
};
