function momentTagUsageClass(remove) {
  return remove ? 'display_none' : 'display_block';
}

function showTaggedMomentsClass(remove) {
  return remove ? 'display_inline_block' : 'display_none';
}

function showTaggedMoments(show) {
  $('#moment_tag_usage').removeClass(momentTagUsageClass(show)).addClass(momentTagUsageClass(!show));
  $('#showTaggedMoments').removeClass(showTaggedMomentsClass(show)).addClass(showTaggedMomentsClass(!show));
  $('#hideTaggedMoments').removeClass(showTaggedMomentsClass(!show)).addClass(showTaggedMomentsClass(show));
}

var onReadyStrategies = function() {
  if (isShow(['strategies'])) {
    $('#showTaggedMoments').click(function() {
      showTaggedMoments(true);
    });
    $('#hideTaggedMoments').click(function() {
      showTaggedMoments(false);
    });
  }
};

loadPage(onReadyStrategies);
