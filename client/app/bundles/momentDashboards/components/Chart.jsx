// @flow
import 'chart.js';
import React from 'react';
import { AreaChart } from 'react-chartkick';

type chartShape = {
  xtitle: string,
  ytitle: string,
  data: {},
};

/**
 * Renders a Chart Kick element.
 *
 * We wrap the element here in case we want to replace ChartKick with another library.
 */
export default class Chart extends React.Component {
    props: chartShape;

    /**
     * @param props - Comes from your rails view.
     */

    render() {
      return (
        <div>
          <AreaChart
            xtitle={this.props.xtitle}
            ytitle={this.props.ytitle}
            id={'breakdown-chart'}
            data={this.props.data}
          />
        </div>);
    }
}
