// @flow
import React from 'react';
import _ from 'lodash';
import Chart from './Chart';

type chartControlState = {
  type: string;
  data: any;
}

type chartControlProp = {
  types: string[];
  initialParams: {
    type: string,
    data: {}
  };
}

const ChartControlButton =
  (index: number, type: string, onClick: (type: string) => void) => (
    <button
      className={'ui-button ui-widget ui-corner-all'}
      key={index}
      onClick={onClick}
    >
      {type}
    </button>);

/**
 * Control Panel for selecting different objects to graph.
 */
export default class ChartControl extends React.Component {
  props: chartControlProp;
  state: chartControlState;

  constructor(props: chartControlProp) {
    super(props);

    const { initialParams } = this.props;

    this.state = {
      type: initialParams.type,
      data: initialParams.data,
    };
  }

  onSelectType(value: string) {
    return () => {
      this.setState({type: value});
    };
  }

  render() {
    const {types} = this.props;
    const buttons: any[] = [];
    _.each(types, (value, index: number) => {
      buttons.push(new ChartControlButton(index, value, this.onSelectType(value)));
    });
    return (
      <div>
        {buttons}
        <Chart
          ytitle={`${this.state.type}`}
          xtitle="Date"
          data={this.state.data[this.state.type]}
          chartType="Area"
        />
      </div>
    );
  }
}
