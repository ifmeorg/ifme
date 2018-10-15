var readMoreHideContent = function() {
  $('.read_more_content').addClass('hideContent');
  $('.readLessShow').addClass('hideContent');
  $('.readMoreShow').removeClass('hideContent');
};

var toggleProfileBlurb = function() {
  $(this).fadeOut(400, function() {
    $(this).siblings('.read_more_content').toggleClass('hideContent');
    // When [...] button is clicked to expand profile blurb
    if ($(this).attr('id') === 'moreContent') {
      $(this).siblings('.readLessShow').removeClass('hideContent').show();
    }
    // When [Less] button is clicked to collapse profile blurb
    else {
      $(this).siblings('.readMoreShow').removeClass('hideContent').show();
    }
    $(this).addClass('hideContent');
  });
};

var contributorReadMoreFeature = function(){
  var profileTextLength = 0;
  var maxProfileLength = 120;
  var visibleProfileText, invisibleProfileText;
  var contributorProfile = $('.contributor_profile');

  contributorProfile.each(function() {
    profileTextLength = $(this).text().length;
    if (profileTextLength > maxProfileLength){
      visibleProfileText = $(this).text().substr(0, maxProfileLength);
      invisibleProfileText = $(this).text().substr(maxProfileLength, profileTextLength - maxProfileLength);

      var profileContent = visibleProfileText + '<span class="readMoreShow hideContent toggle" id="moreContent"> [...]</span><span class="read_more_content">' + invisibleProfileText + '</span><span class="readLessShow toggle" id="lessContent"> [-]</span>';

      $(this).html(profileContent);
      readMoreHideContent();
    }
  });
};

$(document).on('click', '.toggle', toggleProfileBlurb);
loadPage(contributorReadMoreFeature);
