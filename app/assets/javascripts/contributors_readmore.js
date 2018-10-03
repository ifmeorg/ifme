const readMoreHideContent = function () {
  $('.read_more_content').addClass('hideContent');
  $('.readLessShow').addClass('hideContent');
  $('.readMoreShow').removeClass('hideContent');
};

const toggleProfileBlurb = function () {
  $(this).fadeOut(400, function () {
    $(this).siblings('.read_more_content').toggleClass('hideContent');
    // When [...] button is clicked to expand profile blurb
    if ($(this).attr('id') === 'moreContent') {
      $(this).siblings('.readLessShow').removeClass('hideContent').show();
    } else { // When [Less] button is clicked to collapse profile blurb
      $(this).siblings('.readMoreShow').removeClass('hideContent').show();
    }
    $(this).addClass('hideContent');
  });
};

const contributorReadMoreFeature = function () {
  let profileTextLength = 0;
  const maxProfileLength = 120;
  let visibleProfileText; let
    invisibleProfileText;
  const contributorProfile = $('.contributor_profile');

  contributorProfile.each(function () {
    profileTextLength = $(this).text().length;
    if (profileTextLength > maxProfileLength) {
      visibleProfileText = $(this).text().substr(0, maxProfileLength);
      invisibleProfileText = $(this).text()
        .substr(maxProfileLength, profileTextLength - maxProfileLength);

      const profileContent = `${visibleProfileText}<span class="readMoreShow hideContent toggle" id="moreContent">${I18n.t('ellipsis')}</span><span class="read_more_content">${invisibleProfileText}</span><span class="readLessShow toggle" id="lessContent">${I18n.t('less')}</span>`;

      $(this).html(profileContent);
      readMoreHideContent();
    }
  });
};

$(document).on('click', '.toggle', toggleProfileBlurb);
loadPage(contributorReadMoreFeature);
