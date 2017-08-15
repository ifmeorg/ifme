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
    state: chartShape;

    /**
     * @param props - Comes from your rails view.
     */
    constructor(props: chartShape) {
      super(props);
      console.log('ON CONSTRUCTION');

      this.state = {
        xtitle: this.props.xtitle,
        ytitle: this.props.ytitle,
        data: this.props.data,
      };
    }

    componentDidMount() {

    }

    updateTitle = (xtitle: string, ytitle: string) => {
      this.setState({ xtitle, ytitle });
    };

    render() {
      return (
        <div>
          <AreaChart
            xtitle={this.state.xtitle}
            ytitle={this.state.ytitle}
            id={'moments-chart'}
            data={this.state.data}
          />
        </div>);
    }
}
