// @flow
import 'chart.js';
import React from 'react';
import { AreaChart, LineChart } from 'react-chartkick';

type chartShape = {
  xtitle: string,
  ytitle: string,
  data: {},
  chartType: "Line" | "Area",
};

// ifme themed chart colors
const colorSchemes = ['#6D0839', '#66118', '#7F503F', '#775577', '#CCAADD'];

/**
 * Renders a Chart Kick element.
 *
 * We wrap the element here in case we want to replace ChartKick with another library.
 */
// We keep the class otherwise our enzyme tests can't reference this component by name
export default class Chart extends React.Component<chartShape, {}> {
    props: chartShape;

    /**
     * @param props - Comes from your rails view.
     */
    render() {
      return (
        <div>
          {this.props.chartType === 'Line' ?
            <LineChart
              xtitle={this.props.xtitle}
              ytitle={this.props.ytitle}
              data={this.props.data}
              colors={colorSchemes}
            /> : <AreaChart
              xtitle={this.props.xtitle}
              ytitle={this.props.ytitle}
              data={this.props.data}
              colors={colorSchemes}
            />}

        </div>);
    }
}
