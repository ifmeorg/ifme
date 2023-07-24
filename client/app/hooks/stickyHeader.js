// @flow
export const stickyHeader = () => {
  // Check when element gets position sticky
  var observer = new IntersectionObserver(
    function (entries) {
      // no intersection
      if (
        entries[0].intersectionRatio === 0 &&
        // Filter false positives due to page not rendered
        entries[0].rootBounds !== null
      ) {
        console.log(entries[0]);
        document
          .querySelector('#headerContainer')
          .classList.add('stickyHeader');
      }
      // fully intersects
      else if (entries[0].intersectionRatio === 1) {
        console.log(entries[0]);
        document
          .querySelector('#headerContainer')
          .classList.remove('stickyHeader');
      }
    },
    { threshold: [0, 1] }
  );
  observer.observe(document.querySelector('#headerContainerTop'));
};
