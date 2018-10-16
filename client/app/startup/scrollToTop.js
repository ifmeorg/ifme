// @flow
export const scrollToTop = () => {
  window.addEventListener('beforeunload', () => {
    window.scrollTo(0, 0);
  });
};
