var readMoreHideContent = function() {
  $('.read_more_content').addClass('hide_content');
  $('.read_less_show').addClass('hide_content');
  $('.read_more_show').removeClass('hide_content');
};

var toggleProfileBlurb = function() {
  $(this).fadeOut(400, function() {
    $(this).siblings('.read_more_content').toggleClass('hide_content');
    // When [...] button is clicked to expand profile blurb
    if ($(this).attr('id') === 'moreContent') {
      $(this).siblings('.read_less_show').removeClass('hide_content').show();
    }
    // When [Less] button is clicked to collapse profile blurb
    else {
      $(this).siblings('.read_more_show').removeClass('hide_content').show();
    }
    $(this).addClass('hide_content');
  });
};

var contributorReadMoreFeature = function(){
  var profileTextLength = 0;
  const maxProfileLength = 120;
  var visibleProfileText, invisibleProfileText;
  var contributorProfile = $('.contributor_profile');

  contributorProfile.each(function() {
    profileTextLength = $(this).text().length;
    if (profileTextLength > maxProfileLength){
      visibleProfileText = $(this).text().substr(0, maxProfileLength);
      invisibleProfileText = $(this).text().substr(maxProfileLength, profileTextLength - maxProfileLength);

      var profileContent = visibleProfileText + '<span class="read_more_show hide_content toggle" id="moreContent">'+ I18n.t('ellipsis') +'</span><span class="read_more_content">' + invisibleProfileText + '</span><span class="read_less_show toggle" id="lessContent">'+ I18n.t('less')+'</span>';

      $(this).html(profileContent);
      readMoreHideContent();
    }
  });
};

$(document).on('click', '.toggle', toggleProfileBlurb);
$(document).on("page:load ready", contributorReadMoreFeature);