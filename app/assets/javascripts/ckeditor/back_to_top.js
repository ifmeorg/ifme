function scrollToBackToTop() {
  $("html, body").animate({ scrollTop: 0 }, 1000);
}

function onReadyBackToTop() {
  $(".back_to_top").click(function() {
    scrollToBackToTop();
  });
}

document.addEventListener("turbolinks:load", onReadyBackToTop);
