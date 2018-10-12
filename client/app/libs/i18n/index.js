export const I18n = Object.assign({}, window.I18n, {
  lookup: (scope, options = {}) => {
    const result = window.I18n.lookup(scope, options);
    if (typeof result === 'undefined' || result.match(/%{.*}/g)) return result;
    // Generating client/app/libs/i18n/translations.js strips % from interpolation values
    // react_on_rails.rb does not provide functionality to change this
    return result.replace('{', '%{');
  },
});
