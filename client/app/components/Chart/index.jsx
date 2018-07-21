// @flow
import { Chart as ChartJS } from 'chart.js';
import React from 'react';
import { AreaChart, LineChart } from 'react-chartkick';

ChartJS.defaults.global.defaultFontFamily = 'Lato';

type chartShape = {
  xtitle?: string,
  ytitle?: string,
  data?: Object | any[],
  chartType: 'Line' | 'Area',
};

// ifme themed chart colors
const colorSchemes = ['#6D0839', '#66118', '#7F503F', '#775577', '#CCAADD'];

/**
 * Renders a Chart Kick element.
 *
 * We wrap the element here in case we want to replace ChartKick with another library.
 *
 * @param props - Comes from your rails view.
 */
export const Chart = ({ chartType, ...props }: chartShape) =>
  chartType === 'Line' ? (
    <LineChart {...props} colors={colorSchemes} />
  ) : (
    <AreaChart {...props} colors={colorSchemes} />
  );
Chart.displayname = 'Chart';
Chart.defaultProps = {
  xtitle: '',
  ytitle: '',
  data: {},
};
