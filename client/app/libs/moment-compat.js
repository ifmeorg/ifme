/* eslint-disable no-underscore-dangle */
// Dayjs-based drop-in for the moment.js API subset used by chart.js v2.
// chart.js requires moment for its time cartesian scale; this shim satisfies
// that API without pulling in the full 70 KB moment bundle.
const dayjs = require('dayjs');
const customParseFormat = require('dayjs/plugin/customParseFormat');
const localizedFormat = require('dayjs/plugin/localizedFormat');
const utc = require('dayjs/plugin/utc');

dayjs.extend(customParseFormat);
dayjs.extend(localizedFormat);
dayjs.extend(utc);

function wrap(d) {
  const m = {
    _m: d,
    valueOf() {
      return d.valueOf();
    },
    toDate() {
      return d.toDate();
    },
    unix() {
      return Math.floor(d.valueOf() / 1000);
    },
    isValid() {
      return d.isValid();
    },
    format(fmt) {
      return d.format(fmt);
    },
    diff(other, unit, float) {
      const o = other && other._m ? other._m : dayjs(other);
      return d.diff(o, unit, float);
    },
    add(amount, unit) {
      return wrap(d.add(amount, unit));
    },
    subtract(amount, unit) {
      return wrap(d.subtract(amount, unit));
    },
    startOf(unit) {
      return wrap(d.startOf(unit));
    },
    endOf(unit) {
      return wrap(d.endOf(unit));
    },
    clone() {
      return wrap(dayjs(d.toDate()));
    },
    isBefore(other, unit) {
      return d.isBefore(other && other._m ? other._m : dayjs(other), unit);
    },
    isAfter(other, unit) {
      return d.isAfter(other && other._m ? other._m : dayjs(other), unit);
    },
    isSame(other, unit) {
      return d.isSame(other && other._m ? other._m : dayjs(other), unit);
    },
    lang() {
      return m;
    },
    locale() {
      return m;
    },
    localeData() {
      return {
        firstDayOfWeek() {
          return 0;
        },
      };
    },
  };
  return m;
}

function momentCompat(input, format) {
  if (input && input._m) return input;
  return wrap(format ? dayjs(input, format) : dayjs(input));
}

momentCompat.isMoment = (obj) => !!(obj && obj._m);
momentCompat.unix = (val) => wrap(dayjs.unix(val));
momentCompat.utc = (val) => wrap(dayjs.utc ? dayjs.utc(val) : dayjs(val));
momentCompat.lang = () => {};
momentCompat.locale = () => 'en';
momentCompat.localeData = () => ({
  firstDayOfWeek() {
    return 0;
  },
});
momentCompat.normalizeUnits = (unit) => unit;
momentCompat.relativeTimeThreshold = () => false;

module.exports = momentCompat;
